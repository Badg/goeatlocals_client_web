async function awaitSleep(ms) {
  return new Promise(resolve => {
    setTimeout(resolve, ms);
  });
}


export { awaitSleep };
