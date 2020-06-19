const bits64 = Math.pow(2, 64);


class Place {
    constructor(name, placeID, placeLong, placeLat, info) {
        this.name = name;
        // Note: currently ignoring placeID and generating it randomly here
        this.placeID = Math.floor(Math.random() * bits64);
        this.placeLong = placeLong;
        this.placeLat = placeLat;
        this.info = info;
    }
}


export default Place;
export { Place };
