var assert = require('assert');
// Assume add.wasm file exists that contains a single function adding 2 provided arguments
const fs = require('node:fs');
// Use the readFileSync function to read the contents of the "add.wasm" file

it('test positive', function (done) {
  const wasmBuffer = fs.readFileSync('abs.wasm');
  WebAssembly.instantiate(wasmBuffer)
    .then(obj => {
      const { abs } = obj.instance.exports;
      assert.equal(abs(22), 22);
      done();
    }).catch(done);
});

it('test negative', function (done) {
  const wasmBuffer = fs.readFileSync('abs.wasm');
  WebAssembly.instantiate(wasmBuffer)
    .then(obj => {
      const { abs } = obj.instance.exports;
      assert.equal(abs(-22), 22);
      done();
    }).catch(done);
});


it('test sum', function (done) {
  const wasmBuffer = fs.readFileSync('sum.wasm');
  WebAssembly.instantiate(wasmBuffer)
    .then(obj => {
      const { sum } = obj.instance.exports;
      assert.equal(sum(3), 6);
      done();
    }).catch(done);
});

it('test memcpy', function (done) {
  const wasmBuffer = fs.readFileSync('memcpy.wasm');
  const memory = new WebAssembly.Memory({
    initial: 1
  });
  WebAssembly.instantiate(wasmBuffer, {
    js: { mem: memory },
  })
    .then(obj => {
      const buffer = new DataView(memory.buffer); // buffer= array[65536]
      const srcPtr = 0;
      const length = 5;
      for (let i = 0; i < length; ++i) {
        buffer.setInt32(srcPtr + i * 4, i + 1, true);
      }
      const dstPtr = 200;
      obj.instance.exports.memcpy(srcPtr, dstPtr, length * 4);
      assert.equal(buffer.getInt32(200, true), 1);
      assert.equal(buffer.getInt32(204, true), 2);
      assert.equal(buffer.getInt32(208, true), 3);
      done();
    }).catch(done);
});

it('test quicksort', function (done) {
  const wasmBuffer = fs.readFileSync('quicksort.wasm');
  const memory = new WebAssembly.Memory({
    initial: 1
  });
  WebAssembly.instantiate(wasmBuffer, {
    js: { mem: memory },
  })
    .then(obj => {
      const buffer = new DataView(memory.buffer); // buffer= array[65536]
      const srcPtr = 0;
      const length = 6;
      for (let i = 0; i < length; ++i) {
        buffer.setInt32(srcPtr + i * 4, 10 - i, true);
      }
      obj.instance.exports.quicksort(srcPtr, 0, length - 1);
      assert.equal(buffer.getInt32(0, true), 5);
      assert.equal(buffer.getInt32(4, true), 6);
      assert.equal(buffer.getInt32(8, true), 7);
      done();
    }).catch(done);
});


