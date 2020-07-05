const _noop = () => {};
const longTouchMillis = 500;


class TouchHoverState {
    /* SOME NOTES ON USING THIS:

    This doesn't mess up dblclick events, as the click event is still
    propagated; HOWEVER, on double touches, BOTH the overCallback AND
    outCallback will be called before doubleclick is handled.

    The outCallback is NOT GUARANTEED TO RUN! In particular, it will not run
    for touch events if there isn't a follow-up touch, so be sure that the
    overCallback doesn't have memory leaks!

    The metaphor breaks down in some (common) clickCallback edge cases.
    Ex: with a mouse, you can't click marker B without first mouseouting
    marker A. So if you touch marker A, highlighting it, then long-touch
    marker B, pinning it, then it's as if you somehow clicked marker B
    while keeping your mouse on marker A -- and therefore, only the
    highlight is displayed. The solution is to have the pin handler
    aware of that, and unhighlight the highlighted place if it doesn't
    match the pinned one.
    */
    constructor() {
        this.activeTouchEvent = null;
        this.longTouchTimer = null;
        this.touchHoverState = null;
        this.longTouchState = null;

        this.overCallback = _noop;
        this.outCallback = _noop;
        this.clickCallback = _noop;

        this.clearState = this.clearState.bind(this);
        this.clearLongTouchTimer = this.clearLongTouchTimer.bind(this);
        this.longTouchHit = this.longTouchHit.bind(this);
        this.addHitEvent = this.addHitEvent.bind(this);
        this.setOverCallback = this.setOverCallback.bind(this);
        this.setOutCallback = this.setOutCallback.bind(this);
        this.setClickCallback = this.setClickCallback.bind(this);
    }

    clearState() {
        this.clearLongTouchTimer();
        this.touchHoverState = null;
    }

    clearLongTouchTimer() {
        if (this.longTouchTimer !== null){
            clearTimeout(this.longTouchTimer);
            this.longTouchTimer = null;
        }
    }

    longTouchHit() {
        this.longTouchTimer = null;
        this.longTouchState = true;
        this.clickCallback();
    }

    addHitEvent(hitEvent) {
        // This is the first hit in the chain. Anything goes here.
        // Note the event order must always have touchstart (and any
        // touchmove) before click:
        //      touchstart
        //      Zero or more touchmove events
        //      touchend
        //      mousemove
        //      mousedown
        //      mouseup
        //      click
        if (hitEvent.type === 'touchstart') {
            // Check to see if the timer is already there to make sure that a
            // multitouch on the same timer doesn't clear the longest touch.
            // I suspect there's a way to track a specific touch chain to keep
            // the timers separate that way, but I'm writing this with markers
            // in mind which are too small for deliberate multitouch
            if (this.longTouchTimer === null) {
                // This is to be defensive in case we had a race condition
                // between our timer and the touchend event that was supposed
                // to clear it
                this.longTouchState = null;
                this.longTouchTimer = setTimeout(
                    this.longTouchHit, longTouchMillis);

            // For now simply suppress multitouch
            } else {
                hitEvent.preventDefault();
                return;
            }

            // NOTE: We ONLY do this for touchstart, because click is
            // a complete hit event unto itself
            this.activeTouchEvent = true;

            if (this.touchHoverState === null) {
                this.touchHoverState = 'pending';
            }

        } else if (hitEvent.type === 'touchmove') {
            this.clearLongTouchTimer();

            // Only clear if pending -- if we're already true we don't want to
            // clear it due to a drag
            if (this.touchHoverState === 'pending'){
                this.touchHoverState = null;
            }

        } else if (
            hitEvent.type === 'touchend' || hitEvent.type === 'touchcancel'
        ) {
            // Do nothing here. We had a touchmove event, so the pending status
            // was cleared; OR, we had a long-awaited long touch, but that was
            // handled in the timer callback
            if (
                this.touchHoverState === null || this.longTouchState !== null
            ){
                // Well, nothing except enforce the touchHoverState being null
                // for long touches
                this.touchHoverState = null;

            // New hover: finalize it. Touchstart -> (stuff) -> touchend
            } else if (this.touchHoverState === 'pending') {
                this.overCallback();
                this.touchHoverState = true;

            // Existing hover: clear it. Touchstart -> (stuff) -> touchend
            } else if (this.touchHoverState === true) {
                this.outCallback();
                this.touchHoverState = null;

            // This happens if we somehow corrupted our touchHoverState. It's
            // purely here defensively
            } else {
                console.warn('Unexpected marker touch hover state!');
            }

            // Always clear the longtouchstate at the end of the touch. This is
            // redundant with the above but good for defense with negligible
            // performance impact
            this.longTouchState = null;
            this.clearLongTouchTimer();

        // Note: in this case we may or may not want the click event to
        // call the click callback, depending on if this is a non-emulated
        // mouseclick following a separate touch event
        } else if (hitEvent.type === 'click'){
            if (this.activeTouchEvent === null) {
                this.clickCallback();
            // This is an emulated click, but 'click' is the last link in the
            // event chain, so the event isn't active anymore
            } else {
                this.activeTouchEvent = null;
            }

        // These two are as expected but with the additional housekeeping on
        // touchhoverstate. This is important for devices with both touch and
        // mouse: it lets you, for example, un-hover with the mouse something
        // that was previously hovered by touch, and vice versa, without
        // forgetting state nor repeating transitions
        } else if (hitEvent.type === 'mouseover') {
            if (this.touchHoverState === null) {
                this.overCallback();
                this.touchHoverState = true;
            }
        } else if (hitEvent.type === 'mouseout') {
            if (this.touchHoverState !== null) {
                this.outCallback();
                this.touchHoverState = null;
            }

        // This happens when someone registered an event handler to us that we
        // don't know how to handle
        } else {
            console.warn('Unexpected marker hit event!');
        }
    }

    setOverCallback(callback) {
        this.overCallback = callback;
    }

    setOutCallback(callback) {
        this.outCallback = callback;
    }

    setClickCallback(callback) {
        this.clickCallback = callback;
    }
}


export default TouchHoverState;
export { TouchHoverState };
