require "bitstring"
require "json"

local losc = require'losc'
local plugin = require'losc.plugins.udp-socket'

local udp = plugin.new {sendAddr = 'localhost', sendPort = 7897}
local osc = losc.new {plugin = udp}


precise_zones = {
  function (x, y) return (x > 0 and x <= 112) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 0 and y <= 96) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 0 and y <= 96) end,
  
  
  function (x, y) return (x > 0 and x <= 112) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 96 and y <= 192) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 96 and y <= 192) end,

  function (x, y) return (x > 0 and x <= 112) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 192 and y <= 288) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 192 and y <= 288) end,

  function (x, y) return (x > 0 and x <= 112) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 288 and y <= 384) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 288 and y <= 384) end,

  function (x, y) return (x > 0 and x <= 112) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 384 and y <= 480) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 384 and y <= 480) end,

  function (x, y) return (x > 0 and x <= 112) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 480 and y <= 576) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 480 and y <= 576) end,

  function (x, y) return (x > 0 and x <= 112) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 576 and y <= 672) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 576 and y <= 672) end,

  function (x, y) return (x > 0 and x <= 112) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 672 and y <= 768) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 672 and y <= 768) end,

  function (x, y) return (x > 0 and x <= 112) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 768 and y <= 864) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 768 and y <= 864) end,

  function (x, y) return (x > 0 and x <= 112) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 864 and y <= 960) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 864 and y <= 960) end,

  function (x, y) return (x > 0 and x <= 112) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 960 and y <= 1056) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 960 and y <= 1056) end,

  function (x, y) return (x > 0 and x <= 112) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 112 and x <= 224) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 224 and x <= 336) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 336 and x <= 448) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 448 and x <= 560) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 560 and x <= 672) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 672 and x <= 784) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 784 and x <= 896) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 896 and x <= 1008) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 1008 and x <= 1120) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 1120 and x <= 1232) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 1232 and x <= 1344) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 1344 and x <= 1456) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 1456 and x <= 1568) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 1568 and x <= 1680) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 1680 and x <= 1792) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 1792 and x <= 1904) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 1904 and x <= 2016) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 2016 and x <= 2128) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 2128 and x <= 2240) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 2240 and x <= 2352) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 2352 and x <= 2464) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 2464 and x <= 2576) and (y > 1056 and y <= 1152) end,
  function (x, y) return (x > 2576 and x <= 2688) and (y > 1056 and y <= 1152) end

--[[  function (x, y) return (x > 0 and x <= 192) and (y > 1152 and y <= 1344) end, -- 7,1 
  function (x, y) return (x > 384 and x <= 576) and (y > 1152 and y <= 1344) end, -- 7,3 
  function (x, y) return (x > 768 and x <= 960) and (y > 1152 and y <= 1344) end, -- 7,5 
  function (x, y) return (x > 1152 and x <= 1344) and (y > 1152 and y <= 1344) end, -- 7,7 
  function (x, y) return (x > 1536 and x <= 1728) and (y > 1152 and y <= 1344) end, -- 7,9 

  function (x, y) return (x > 192 and x <= 384) and (y > 1344 and y <= 1536) end, -- 8,2 
  function (x, y) return (x > 576 and x <= 768) and (y > 1344 and y <= 1536) end, -- 8,4 
  function (x, y) return (x > 960 and x <= 1152) and (y > 1344 and y <= 1536) end, -- 8,6
  function (x, y) return (x > 1344 and x <= 1536) and (y > 1344 and y <= 1536) end, -- 8,8 
  function (x, y) return (x > 1728 and x <= 1920) and (y > 1344 and y <= 1536) end, -- 8,10

  function (x, y) return (x > 0 and x <= 192) and (y > 1536 and y <= 1728) end, -- 9,1 
  function (x, y) return (x > 384 and x <= 576) and (y > 1536 and y <= 1728) end, -- 9,3 
  function (x, y) return (x > 768 and x <= 960) and (y > 1536 and y <= 1728) end, -- 9,5 
  function (x, y) return (x > 1152 and x <= 1344) and (y > 1536 and y <= 1728) end, -- 9,7 
  function (x, y) return (x > 1536 and x <= 1728) and (y > 1536 and y <= 1728) end, -- 9,9 

  function (x, y) return (x > 192 and x <= 384) and (y > 1728 and y <= 1920) end, -- 10,2 
  function (x, y) return (x > 576 and x <= 768) and (y > 1728 and y <= 1920) end, -- 10,4 
  function (x, y) return (x > 960 and x <= 1152) and (y > 1728 and y <= 1920) end, -- 10,6
  function (x, y) return (x > 1344 and x <= 1536) and (y > 1728 and y <= 1920) end, -- 10,8 
  function (x, y) return (x > 1728 and x <= 1920) and (y > 1728 and y <= 1920) end, -- 10,10]]
} 

zones = {
    function (x, y) return (x > 0 and x <= 500) and (y > 0 and y <= 1920) end, -- 1,1 
    function (x, y) return (x > 600 and x <= 1000) and (y > 0 and y <= 1920) end, -- 1,1 
    function (x, y) return (x > 1100 and x <= 1500) and (y > 0 and y <= 1920) end, -- 1,3 
    function (x, y) return (x > 1600 and x <= 2000) and (y > 0 and y <= 1920) end, -- 1,5 
    function (x, y) return (x > 2100 and x <= 2688) and (y > 0 and y <= 1920) end -- 1,7 
}

function updateLEDs(x, y)
    for i, zone in ipairs(zones) do
        if zone(x, y) then
            message = osc.new_message {
                address = '/pos',
                types = 'i',
                i
                }
            --print(i)
            
            osc:send(message)
                    

        end
    end
    for j, zone in ipairs(precise_zones) do
      if zone(x,y) then
        precise_message = osc.new_message {
          address = '/exactPos',
          types = 'i',
          j
        }
        print(j)
        osc:send(precise_message)
      end
    end
end

function parseData(data)
  
    local touchArray = {} -- overwrite with active touch data each packet 
  
    local startChars = bitstring.hexstream(data,1,3) -- extract first 3 bytes, should always be 555500
    if startChars == '555500' then -- check packet 
  
      local highByte = bitstring.hexstream(data,4,4) -- high byte for packet length (used to determine number of touch points in packet)
      local lowByte = bitstring.hexstream(data,5,5) -- low byte for packet length (used to determine number of touch points in packet)
      local numTouches = (tonumber(highByte, 16) * 256) + tonumber(lowByte, 16) / 4 -- calculate number of touches

      if numTouches <= 2 then -- number of simultaneous touches allowd 
        for i = 1, numTouches do               
             -- for each touch extract co-ordinates 
          touchArray[i] = {
          ['X'] = getX (data, i), -- populate active touch array 
          ['Y'] = getY (data, i),} -- populate active touch array 
        end 
      end 


    end   
  
    for i, touch in ipairs (touchArray) do 
      
      updateLEDs(touch.X, touch.Y)

    end 
  
end 

  
  getX = function (data, inputNum)
    -- calculate postion of bytes in string 
    local highByteLoc = 6 + (inputNum - 1) * 4 -- 6 (start byte) + index - 1 * 4 (number of bytes between start bytes)
    local lowByteLoc = 6 + (inputNum - 1) * 4 + 1 -- 6 (start byte) + index - 1 * 4 (number of bytes between start bytes) + 1 (end byte for co-ordinate)
    -- extract data 
    local highByte = bitstring.hexstream(data,highByteLoc,highByteLoc)
    local lowByte = bitstring.hexstream(data,lowByteLoc,lowByteLoc)
    --print ('X Value:', inputNum, (tonumber(highByte, 16) * 256) + tonumber(lowByte, 16) ) 
    return (tonumber(highByte, 16) * 256) + tonumber(lowByte, 16) -- return result of X co-ordinate 
  end 
  
  getY = function (data, inputNum)
    -- calculate postion of bytes in string 
    local highByteLoc = 8 + (inputNum - 1) * 4 -- 6 (start byte) + index - 1 * 4 (number of bytes between start bytes)
    local lowByteLoc = 8 + (inputNum - 1) * 4 + 1 -- 6 (start byte) + index - 1 * 4 (number of bytes between start bytes) + 1 (end byte for co-ordinate)
    -- extract data
    local highByte = bitstring.hexstream(data,highByteLoc,highByteLoc)
    local lowByte = bitstring.hexstream(data,lowByteLoc,lowByteLoc)
    --print ('Y Value:', inputNum, (tonumber(highByte, 16) * 256) + tonumber(lowByte, 16) ) 
    return (tonumber(highByte, 16) * 256) + tonumber(lowByte, 16) -- return result of Y co-ordinate
  end 
  

local socket = require("socket")

-- Create a UDP socket
udp = socket.udp()

-- Set the callback function for data received
udp:settimeout(0)  -- non-blocking mode
udp:setsockname("*", 20001)  -- bind to all available interfaces

-- Function to parse and handle received data
--[[nction parseAndHandleData(data, ip, port)
    print("Received data from " .. ip .. ":" .. port)
    
    if ip == '10.10.10.220' then
        parseData(data)
        Controls.lastPacket.String = bitstring.hexstream(data)
        print(bitstring.hexstream(data))
        -- You can add your additional logic here, like relaying the message to another IP and port
        -- udp:sendto(packet.Data, "10.10.10.249", 20002)
    end
end ]]

-- Main loop
while true do
    local data, ip, port = udp:receivefrom()
    
    if data then
      if ip == '10.10.10.221' then
        
        parseData(data)
      end
      
        
    elseif data == nil and ip == "timeout" then
        -- No data received, do other things or sleep if necessary
       -- socket.sleep(1)  -- sleep for 100 milliseconds
    else
        print("Error receiving data: " .. tostring(error))
        --break
    end
end

