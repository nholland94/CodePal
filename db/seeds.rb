# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = []

ActiveRecord::Base.transaction do
  test = User.create!(username: "test", email: "test@test.test",
              password: "123456", password_confirmation: "123456")

  15.times do
    # password = Faker::Internet.password
    user = User.create!(username: Faker::Internet.user_name,
                 email: Faker::Internet.email,
                 password: "no_pass",
                 password_confirmation: "no_pass") # password needs to be random
    users.push(user)
  end

  Project.create!(title: "test", description: "this is a test", creator_id: test.id)

  project_data = [
    {
      title: "css3-family-tree",
      description: "An interactive family tree built with css3",
      files: {
        html: <<-HTMLFILE,
<!-- ORIGNAL FROM: http://codepen.io/marckregio/pen/ItyrA -->
<!--
We will create a family tree using just CSS(3)
The markup will be simple nested lists
-->
<div class="treeDiv">
<div class="tree">
  <ul>
    <li>
      <a href="#">Parent</a>
      <ul>
        <li>
          <a href="#">Child</a>
          <ul>
            <li>
              <a href="#">Grand Child</a>
            </li>
          </ul>
        </li>
        <li>
          <a href="#">Child</a>
          <ul>
            <li><a href="#">Grand Child</a></li>
            <li>
              <a href="#">Grand Child</a>
              <ul>
                <li>
                  <a href="#">Great Grand Child</a>
                </li>
                <li>
                  <a href="#">Great Grand Child</a>
                </li>
                <li>
                  <a href="#">Great Grand Child</a>
                </li>
              </ul>
            </li>
            <li><a href="#">Grand Child</a></li>
            <li><a href="#">Grand Child</a></li>
          </ul>
        </li>
        <li><a href="#">Grand Child</a></li>
      </ul>
    </li>
  </ul>
</div>
</div>
        HTMLFILE
        css: <<-CSSFILE,
/*Now the CSS*/
* {margin: 0; padding: 0;background-color:#000}
.treeDiv
{
  margin:0 auto;
  text-align:center;
  width:960px;
}
.tree ul {
  padding-top: 20px; position: relative;
  
  transition: all 0.5s;
  -webkit-transition: all 0.5s;
  -moz-transition: all 0.5s;
}

.tree li {
  float: left; text-align: center;
  list-style-type: none;
  position: relative;
  padding: 20px 5px 0 5px;
  
  transition: all 0.5s;
  -webkit-transition: all 0.5s;
  -moz-transition: all 0.5s;
}

/*We will use ::before and ::after to draw the connectors*/

.tree li::before, .tree li::after{
  content: '';
  position: absolute; top: 0; right: 50%;
  border-top: 1px solid #ccc;
  width: 50%; height: 20px;
}
.tree li::after{
  right: auto; left: 50%;
  border-left: 1px solid #ccc;
}

/*We need to remove left-right connectors from elements without 
any siblings*/
.tree li:only-child::after, .tree li:only-child::before {
  display: none;
}

/*Remove space from the top of single children*/
.tree li:only-child{ padding-top: 0;}

/*Remove left connector from first child and 
right connector from last child*/
.tree li:first-child::before, .tree li:last-child::after{
  border: 0 none;
}
/*Adding back the vertical connector to the last nodes*/
.tree li:last-child::before{
  border-right: 1px solid #ccc;
  border-radius: 0 5px 0 0;
  -webkit-border-radius: 0 5px 0 0;
  -moz-border-radius: 0 5px 0 0;
}
.tree li:first-child::after{
  border-radius: 5px 0 0 0;
  -webkit-border-radius: 5px 0 0 0;
  -moz-border-radius: 5px 0 0 0;
}

/*Time to add downward connectors from parents*/
.tree ul ul::before{
  content: '';
  position: absolute; top: 0; left: 50%;
  border-left: 1px solid #ccc;
  width: 0; height: 20px;
}

.tree li a{
  border: 1px solid #ccc;
  padding: 5px 10px;
  text-decoration: none;
  color: #666;
  font-family: arial, verdana, tahoma;
  font-size: 11px;
  display: inline-block;
  
  border-radius: 5px;
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  
  transition: all 0.5s;
  -webkit-transition: all 0.5s;
  -moz-transition: all 0.5s;
}

/*Time for some hover effects*/
/*We will apply the hover effect the the lineage of the element also*/
.tree li a:hover, .tree li a:hover+ul li a {
  background: #c8e4f8; color: #000; border: 1px solid #94a0b4;
}
/*Connector styles on hover*/
.tree li a:hover+ul li::after, 
.tree li a:hover+ul li::before, 
.tree li a:hover+ul::before, 
.tree li a:hover+ul ul::before{
  border-color:  #94a0b4;
}

/*Thats all. I hope you enjoyed it.
Thanks :)*/
        CSSFILE
        js: <<-JSFILE,
/*
from

http://thecodeplayer.com/walkthrough/css3-family-tree

*/
        JSFILE
      }
    },
    {
      title: "CSS Text filling with water",
      description: "An example of loading text that slowly fills up and then drains of liquid",
      files: {
        html: <<-HTMLFILE,
<!-- ORIGINAL FROM: http://codepen.io/lbebber/pen/xrwja -->
<link href='http://fonts.googleapis.com/css?family=Cabin+Condensed:700' rel='stylesheet' type='text/css'>

<div class="loading wave">
  Loading
</div>

<!-- For Firefox -->
<div class="loading loading-2 wave wave-2">
  <div class="ff">For browsers that don't support background-clip:text:</div>
  <div class="loading-2-text"></div>
</div>
        HTMLFILE
        css: <<-CSSFILE,
$background-color:#141414;
body{
 background:$background-color; 
  width:100%;
  height:100%;
}
.loading{
   text-transform:uppercase;
   font-family: 'Cabin Condensed', sans-serif;
  font-weight:bold;
  font-size:100pt;
  text-align:center;
  height:120px;
  line-height:110px;
  vertical-align:bottom;
  position:absolute;
  left:0;
  right:0;
  top:100px;
  bottom:0;
  display:block;
}

.loading-2{
  top:300px;
  width:473px;
  height:97px;
  font-size:0;
  background:rgba(255,255,255,0.06);
  margin:0 auto;
}
.ff{
  position:absolute;
  font-size:12pt;
  top:-20px;
  color:white;
  line-height:12pt;
  
}
.loading-2-text{
  background-image:url('http://i.imgur.com/cZc1otp.png');
  width:473px;
  height:97px;
  display:inline-block;
}
@keyframes wave-animation{
  0%{background-position:0 bottom};
  100%{background-position:200px bottom};
}
@keyframes loading-animation{
  0%{background-size:200px 0px};
  100%{background-size:200px 200px};
}
.wave{
   background-image:url('http://i.imgur.com/uFpLbYt.png');
  @include background-clip(text);
  color:rgba(0,0,0,0);
text-shadow:0px 0px rgba(255,255,255,0.06);
  animation:wave-animation 1s infinite linear, loading-animation 10s infinite linear alternate;
  background-size:200px 100px;
  background-repeat:repeat-x;
  opacity:1;
}
.wave-2{
  @include background-clip(initial);
  display:inline-block;
}
        CSSFILE
        js: ""
      }
    },
    {
      title: "Tear-able Cloth",
      description: "A javascript demo of tear-able cloth",
      files: {
        html: <<-HTMLFILE,
<!-- ORIGINAL FROM: http://codepen.io/stuffit/pen/KrAwx -->
<canvas id = "c" > </canvas>

<a target="_blank" href="http://codepen.io/stuffit/pen/fhjvk" id="p">Like playing with physics? Click here!</a>
  
<div id="info">
  <div id="top">
  <a target="_blank" id="site" href="javascript:alert('Currently down, sorry!');">my website</a>
  <a id="close" href="">close</a>
  </div>
  <p>
    <br>
    - Tear the cloth with your mouse.<br><br>
    - Right click and drag to cut the cloth<br><br>
    - Reduce physics_accuracy if it's laggy.<br><br>
  </p>
</div>
  
  
        HTMLFILE
        css: <<-CSSFILE,
* {
   margin: 0;
  overflow:hidden;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  -o-user-select: none;
  user-select: none;  
}

body {
  background:#333;
}

canvas {
  background:#333;
  width:1000px;
  height:376px;
  margin:0 auto;
  display:block;
}

#info {
  position:absolute;
  left:-1px;
  top:-1px;
  width:auto;
  max-width:380px;
  height:auto;
  background:#f2f2f2;
  border-bottom-right-radius:10px;
}

#top {
  background:#fff;
  width:100%;
  height:auto;
  position:relative;
  border-bottom:1px solid #eee;
}

p {
  font-family:Arial, sans-serif;
  color:#666;
  text-align:justify;
  font-size: 16px;
  margin:10px;
}

a {
  font-family:sans-serif;
  color:#444;
  text-decoration:none;
  font-size: 20px;
}

#site {
  float:left;
  margin: 10px;
  color: #38a;
  border-bottom:1px dashed #888;
}

#site:hover {
  color: #7af;
}

#close {
  float:right;
  margin: 10px;
}

#p {
  font-family: Verdana, sans-serif;
  position:absolute;
  right:10px;
  bottom:10px;
  color:#adf;
  border: 1px dashed #555;
  padding:4px 8px;
}
        CSSFILE
        js: <<-JSFILE,
/*
Copyright (c) 2013 lonely-pixel.com, Stuffit at codepen.io (http://codepen.io/stuffit)

View this and others at http://lonely-pixel.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
*/

document.getElementById('close').onmousedown = function(e) {
  e.preventDefault();
  document.getElementById('info').style.display = 'none';
  return false;
};
 
// settings

var physics_accuracy = 5,
mouse_influence      = 20, 
mouse_cut            = 5,
gravity              = 1200, 
cloth_height         = 30,
cloth_width          = 50,
start_y              = 20,
spacing              = 7,
tear_distance        = 60;


window.requestAnimFrame =
window.requestAnimationFrame       ||
window.webkitRequestAnimationFrame ||
window.mozRequestAnimationFrame    ||
window.oRequestAnimationFrame      ||
window.msRequestAnimationFrame     ||
function(callback) {
    window.setTimeout(callback, 1000 / 60);
};

var canvas,
  ctx,
  cloth,
  boundsx,
  boundsy,
  mouse = {
    down: false,
    button: 1,
    x: 0,
    y: 0,
    px: 0,
    py: 0
  };

window.onload = function() {

  canvas = document.getElementById('c');
  ctx    = canvas.getContext('2d');

  canvas.width = canvas.clientWidth;
  canvas.height = 376;

  canvas.onmousedown = function(e) {
    mouse.button = e.which;
    mouse.px = mouse.x;
    mouse.py = mouse.y;
  var rect = canvas.getBoundingClientRect();
  mouse.x = e.clientX - rect.left,
  mouse.y = e.clientY - rect.top,
    mouse.down = true;
    e.preventDefault();
  };

  canvas.onmouseup = function(e) {
    mouse.down = false;
    e.preventDefault();
  };

  canvas.onmousemove = function(e) {
    mouse.px = mouse.x;
    mouse.py = mouse.y;
    var rect = canvas.getBoundingClientRect();
  mouse.x = e.clientX - rect.left,
  mouse.y = e.clientY - rect.top,
    e.preventDefault();
  };

  canvas.oncontextmenu = function(e) {
    e.preventDefault(); 
  };

  boundsx = canvas.width - 1;
  boundsy = canvas.height - 1;

  ctx.strokeStyle = 'rgba(222,222,222,0.6)';
  cloth = new Cloth();
  update();
};

var Point = function(x, y) {

  this.x = x;
  this.y = y;
  this.px = x;
  this.py = y;
  this.vx = 0;
  this.vy = 0;
  this.pin_x = null;
  this.pin_y = null;
  this.constraints = [];
};

Point.prototype.update = function(delta) {

  if (mouse.down) {

    var diff_x = this.x - mouse.x,
      diff_y = this.y - mouse.y,
      dist   = Math.sqrt(diff_x * diff_x + diff_y * diff_y);

    if (mouse.button == 1) {

      if(dist < mouse_influence) {
        this.px = this.x - (mouse.x - mouse.px) * 1.8;
        this.py = this.y - (mouse.y - mouse.py) * 1.8;
      }

    } else if (dist < mouse_cut) this.constraints = [];
  }

  this.add_force(0, gravity);

  delta *= delta;
  nx = this.x + ((this.x - this.px) * .99) + ((this.vx / 2) * delta);
  ny = this.y + ((this.y - this.py) * .99) + ((this.vy / 2) * delta);

  this.px = this.x;
  this.py = this.y;

  this.x = nx;
  this.y = ny;

  this.vy = this.vx = 0
};

Point.prototype.draw = function() {

  if (this.constraints.length <= 0) return;
  
  var i = this.constraints.length;
  while(i--) this.constraints[i].draw();
};

Point.prototype.resolve_constraints = function() {

  if (this.pin_x != null && this.pin_y != null) {
  
    this.x = this.pin_x;
    this.y = this.pin_y;
    return;
  }

  var i = this.constraints.length;
  while(i--) this.constraints[i].resolve();

  this.x > boundsx ? this.x = 2 * boundsx - this.x : 1 > this.x && (this.x = 2 - this.x);
  this.y < 1 ? this.y = 2 - this.y : this.y > boundsy && (this.y = 2 * boundsy - this.y);
};

Point.prototype.attach = function(point) {

  this.constraints.push(
    new Constraint(this, point)
  );
};

Point.prototype.remove_constraint = function(lnk) {

  var i = this.constraints.length;
  while(i--) if(this.constraints[i] == lnk) this.constraints.splice(i, 1);
};

Point.prototype.add_force = function(x, y )  {

  this.vx += x;
  this.vy += y;
};

Point.prototype.pin = function(pinx, piny) {
  this.pin_x = pinx;
  this.pin_y = piny;
};

var Constraint = function(p1, p2) {

  this.p1 = p1;
  this.p2 = p2;
  this.length = spacing;
};

Constraint.prototype.resolve = function() {

  var diff_x = this.p1.x - this.p2.x,
    diff_y = this.p1.y - this.p2.y,
    dist = Math.sqrt(diff_x * diff_x + diff_y * diff_y),
    diff = (this.length - dist) / dist;

  if (dist > tear_distance) this.p1.remove_constraint(this);

  var px = diff_x * diff * 0.5;
  var py = diff_y * diff * 0.5;

  this.p1.x += px;
  this.p1.y += py;
  this.p2.x -= px;
  this.p2.y -= py;
};

Constraint.prototype.draw = function() {

  ctx.moveTo(this.p1.x, this.p1.y);
  ctx.lineTo(this.p2.x, this.p2.y);
};

var Cloth = function() {

  this.points = [];

  var start_x = canvas.width / 2 - cloth_width * spacing / 2;

  for(var y = 0; y <= cloth_height; y++) {

    for(var x = 0; x <= cloth_width; x++) {

      var p = new Point(start_x + x * spacing, start_y + y * spacing);

   x != 0 && p.attach(this.points[this.points.length - 1]);
      y == 0 && p.pin(p.x, p.y);
      y != 0 && p.attach(this.points[x + (y - 1) * (cloth_width + 1)])

      this.points.push(p);
    }
  }
};

Cloth.prototype.update = function() {

  var i = physics_accuracy;

  while(i--) {
    var p = this.points.length;
    while(p--) this.points[p].resolve_constraints();
  }

  i = this.points.length;
  while(i--) this.points[i].update(.016);
};

Cloth.prototype.draw = function() {

  ctx.beginPath();

  var i = cloth.points.length;
  while(i--) cloth.points[i].draw();

  ctx.stroke();
};

function update() {

  ctx.clearRect(0, 0, canvas.width, canvas.height);

  cloth.update();
  cloth.draw();

  requestAnimFrame(update);
}
        JSFILE
      }
    },
    {
      title: "3D Cubes",
      description: "A 3D Cube displaying app in which you can rotate and create cubes",
      files: {
        html: <<-HTMLFILE,
<!-- ORIGINAL FROM: http://codepen.io/jonathan/pen/zAFIp -->
<div id="screen"> 
<canvas id="canvas">HTML5 CANVAS</canvas> 
<div id="info"> 
  <div class="background"></div> 
    <div class="content"> 
      <h1>3D Cubes</h1> 
      <table> 
        <tr><td class="w">drag</td><td>-> rotate X,Y axis</td></tr> 
        <tr><td class="w">wheel</td><td>-> rotate Z axis</td></tr> 
        <tr><td class="w">click</td><td>-> create cube</td></tr> 
      </table> 
      <hr> 
      <input type="checkbox" id="white"><label for="white"> white background</label><br> 
      <input type="checkbox" id="alpha"><label for="alpha"> transparency</label><br> 
      <input type="checkbox" id="autor"><label for="autor"> auto rotation</label><br> 
      <input type="checkbox" id="destroy"><label for="destroy"> destroy cubes</label><br> 
      <hr> 
      - <span id="fps" class="w">00</span> FPS<br> 
      - <span id="npoly" class="w">00</span> Faces<br> 
      <p align="center"><input type="button" value="RESET" id="reset" class="button"></input><input type="button" value="STOP" id="stopgo" class="button"></input></p> 
    </div> 
  </div> 
</div> 
        HTMLFILE
        css: <<-CSSFILE,
html { 
    overflow: hidden; 
  } 
  body { 
    position: absolute; 
    margin: 0px; 
    padding: 0px; 
    background: #000; 
    width: 100%; 
    height: 100%; 
  } 
  #screen { 
    position: absolute; 
    width: 100%; 
    height: 100%; 
    background: #000; 
    overflow: hidden; 
    font-family: Segoe UI, Verdana, Arial, Sans-Serif; 
    color: #fff; 
    font-size: 13px; 
  } 
  #screen canvas { 
    position: absolute; 
    width: 100%; 
    height: 100%; 
    background: #000; 
  } 
  #info { 
        position: absolute; 
        text-align: left; 
        top: 19%; 
        left: 2%; 
    width: 180px; 
    height: 340px; 
        color: #666; 
        font-size: 1em; 
  } 
  #info .background { 
    position: absolute; 
    width: 100%; 
    height: 100%; 
    background: #000; 
    opacity: 0.3; 
  } 
  #info .content { 
    position: absolute; 
    padding: 3px; 
    width: 100%; 
    height: 100%; 
  } 
  #info .w { 
    color: #fff; 
  } 
  #info hr { 
    width: 90%; 
    border: none; 
    background-color: #666; 
    height: 1px; 
  } 
  #info h1 { 
    color: #fff; 
    text-align: center; 
  } 

.button {
  font-family: Arial, Helvetica, sans-serif;
  font-size: 10px;
  color: #ffffff;
  padding: 10px 20px;
  background: -moz-linear-gradient(
    top,
    #333333 0%,
    #000000);
  background: -webkit-gradient(
    linear, left top, left bottom, 
    from(#333333),
    to(#000000));
  -moz-border-radius: 1px;
  -webkit-border-radius: 1px;
  border-radius: 1px;
  border: 1px solid #000000;
  -moz-box-shadow:
    0px 1px 1px rgba(000,000,000,0.5),
    inset 0px 0px 1px rgba(255,255,255,1);
  -webkit-box-shadow:
    0px 1px 1px rgba(000,000,000,0.5),
    inset 0px 0px 1px rgba(255,255,255,1);
  box-shadow:
    0px 1px 1px rgba(000,000,000,0.5),
    inset 0px 0px 1px rgba(255,255,255,1);
  text-shadow:
    0px -1px 0px rgba(000,000,000,0.7),
    0px 1px 0px rgba(255,255,255,0.3);
}
        CSSFILE
        js: <<-JSFILE,
// ============================================================= 
//           ===== CANVAS 3D experiment ===== 
//     ===== simple 3D cubes HTML5 engine ==== 
// script written by Gerard Ferrandez - January 2, 2012 
// http://www.dhteumeuleu.com 
// ============================================================= 
 
"use strict"; 
 
(function () { 
  // ======== private vars ======== 
  var scr, canvas, cubes, faces, nx, ny, nw, nh, xm = 0, ym = 0, cx = 50, cy = 50, cz = 0, cxb = 0, cyb = 0; 
  var white, alpha, fps = 0, ncube, npoly, faceOver, drag, moved, startX = 0, startY = 0; 
  var cosY, sinY, cosX, sinX, cosZ, sinZ, minZ, angleY = 0, angleX = 0, angleZ = 0; 
  var bkgColor1 = "rgba(0,0,0,0.1)"; 
  var bkgColor2 = "rgba(32,32,32,1)"; 
  var autorotate = false, destroy = false, running = true; 
  // ---- fov ---- 
  var fl = 250; 
  var zoom = 0; 
  // ======== canvas constructor ======== 
  var Canvas = function (id) { 
    this.container = document.getElementById(id); 
    this.ctx = this.container.getContext("2d"); 
    this.resize = function (w, h) { 
      this.container.width = w; 
      this.container.height = h; 
    } 
  }; 
  // ======== vertex constructor ======== 
  var Point = function (parent, xyz, project) { 
    this.project = project; 
    this.xo = xyz[0]; 
    this.yo = xyz[1]; 
    this.zo = xyz[2]; 
    this.cube = parent; 
  }; 
  Point.prototype.projection = function () { 
    // ---- 3D rotation ---- 
    var x = cosY * (sinZ * this.yo + cosZ * this.xo) - sinY * this.zo; 
    var y = sinX * (cosY * this.zo + sinY * (sinZ * this.yo + cosZ * this.xo)) + cosX * (cosZ * this.yo - sinZ * this.xo); 
    var z = cosX * (cosY * this.zo + sinY * (sinZ * this.yo + cosZ * this.xo)) - sinX * (cosZ * this.yo - sinZ * this.xo); 
    this.x = x; 
    this.y = y; 
    this.z = z; 
    if (this.project) { 
      // ---- point visible ---- 
      if (z < minZ) minZ = z; 
      this.visible = (zoom + z > 0); 
      // ---- 3D to 2D projection ---- 
      this.X = (nw * 0.5) + x * (fl / (z + zoom)); 
      this.Y = (nh * 0.5) + y * (fl / (z + zoom)); 
    } 
  }; 
  // ======= polygon constructor ======== 
  var Face = function (cube, index, normalVector) { 
    // ---- parent cube ---- 
    this.cube = cube; 
    // ---- coordinates ---- 
    this.p0 = cube.points[index[0]]; 
    this.p1 = cube.points[index[1]]; 
    this.p2 = cube.points[index[2]]; 
    this.p3 = cube.points[index[3]]; 
    // ---- normal vector ---- 
    this.normal = new Point(this, normalVector, false) 
    // ---- # faces ---- 
    npoly++; 
    document.getElementById('npoly').innerHTML = npoly; 
  }; 
  Face.prototype.pointerInside = function () { 
    // ---- Is Point Inside Triangle? ---- 
    // http://2000clicks.com/mathhelp/GeometryPointAndTriangle2.aspx 
    var fAB = function (p1, p2, p3) { return (ym - p1.Y) * (p2.X - p1.X) - (xm - p1.X) * (p2.Y - p1.Y); }; 
    var fCA = function (p1, p2, p3) { return (ym - p3.Y) * (p1.X - p3.X) - (xm - p3.X) * (p1.Y - p3.Y); }; 
    var fBC = function (p1, p2, p3) { return (ym - p2.Y) * (p3.X - p2.X) - (xm - p2.X) * (p3.Y - p2.Y); }; 
    if ( 
      fAB(this.p0, this.p1, this.p3) * fBC(this.p0, this.p1, this.p3) > 0 && 
      fBC(this.p0, this.p1, this.p3) * fCA(this.p0, this.p1, this.p3) > 0 
    ) return true; 
    if ( 
      fAB(this.p1, this.p2, this.p3) * fBC(this.p1, this.p2, this.p3) > 0 && 
      fBC(this.p1, this.p2, this.p3) * fCA(this.p1, this.p2, this.p3) > 0 
    ) return true; 
    // ---- 
    return false; 
  }; 
  Face.prototype.faceVisible = function () { 
    // ---- points visible ---- 
    if (this.p0.visible && this.p1.visible && this.p2.visible && this.p3.visible) { 
      // ---- back face culling ---- 
      if ((this.p1.Y - this.p0.Y) / (this.p1.X - this.p0.X) < (this.p2.Y - this.p0.Y) / (this.p2.X - this.p0.X) ^ this.p0.X < this.p1.X == this.p0.X > this.p2.X) { 
        // ---- face visible ---- 
        this.visible = true; 
        return true; 
      } 
    } 
    // ---- face hidden ---- 
    this.visible = false; 
    this.distance = -99999; 
    return false; 
  }; 
  Face.prototype.distanceToCamera = function () { 
    // ---- distance to camera ---- 
    var dx = (this.p0.x + this.p1.x + this.p2.x + this.p3.x ) * 0.25; 
    var dy = (this.p0.y + this.p1.y + this.p2.y + this.p3.y ) * 0.25; 
    var dz = (zoom + fl) + (this.p0.z + this.p1.z + this.p2.z + this.p3.z ) * 0.25; 
    this.distance = Math.sqrt(dx * dx + dy * dy + dz * dz); 
  }; 
  Face.prototype.draw = function () { 
    // ---- shape face ---- 
    canvas.ctx.beginPath(); 
    canvas.ctx.moveTo(this.p0.X, this.p0.Y); 
    canvas.ctx.lineTo(this.p1.X, this.p1.Y); 
    canvas.ctx.lineTo(this.p2.X, this.p2.Y); 
    canvas.ctx.lineTo(this.p3.X, this.p3.Y); 
    canvas.ctx.closePath(); 
    // ---- light ---- 
    if (this == faceOver) { 
      var r = 256; 
      var g = 0; 
      var b = 0; 
    } else { 
      // ---- flat (lambert) shading ---- 
      this.normal.projection(); 
      var light = ( 
        white ? 
        this.normal.y + this.normal.z * 0.5 : 
        this.normal.z 
      ) * 256; 
      var r = g = b = light; 
    } 
    // ---- fill ---- 
    canvas.ctx.fillStyle = "rgba(" + 
              Math.round(r) + "," + 
              Math.round(g) + "," + 
              Math.round(b) + "," + this.cube.alpha + ")"; 
    canvas.ctx.fill(); 
  }; 
  // ======== Cube constructor ======== 
  var Cube = function(parent, nx, ny, nz, x, y, z, w) { 
    if (parent) { 
      // ---- translate parent points ---- 
      this.w = parent.w; 
      this.points = []; 
      var i = 0, p; 
      while (p = parent.points[i++]) { 
        this.points.push( 
          new Point( 
            parent, 
            [p.xo + nx, p.yo + ny, p.zo + nz], 
            true 
          ) 
        ); 
      } 
    } else { 
      // ---- create points ---- 
      this.w = w; 
      this.points = []; 
      var p = [ 
        [x-w, y-w, z-w], 
        [x+w, y-w, z-w], 
        [x+w, y+w, z-w], 
        [x-w, y+w, z-w], 
        [x-w, y-w, z+w], 
        [x+w, y-w, z+w], 
        [x+w, y+w, z+w], 
        [x-w, y+w, z+w] 
      ]; 
      for (var i in p) this.points.push( 
        new Point(this, p[i], true) 
      ); 
    } 
    // ---- faces coordinates ---- 
    var f  = [ 
      [0,1,2,3], 
      [0,4,5,1], 
      [3,2,6,7], 
      [0,3,7,4], 
      [1,5,6,2], 
      [5,4,7,6] 
    ]; 
    // ---- faces normals ---- 
    var nv = [ 
      [0,0,1], 
      [0,1,0], 
      [0,-1,0], 
      [1,0,0], 
      [-1,0,0], 
      [0,0,-1] 
    ]; 
    // ---- cube transparency ---- 
    this.alpha = alpha ? 0.5 : 1; 
    // ---- push faces ---- 
    for (var i in f) { 
      faces.push( 
        new Face(this, f[i], nv[i]) 
      ); 
    } 
    ncube++; 
  }; 
  //////////////////////////////////////////////////////////////////////////// 
  var resize = function () { 
    // ---- screen resize ---- 
    nw = scr.offsetWidth; 
    nh = scr.offsetHeight; 
    var o = scr; 
    for (nx = 0, ny = 0; o != null; o = o.offsetParent) { 
      nx += o.offsetLeft; 
      ny += o.offsetTop; 
    } 
    canvas.resize(nw, nh); 
  }; 
  var reset = function () { 
    // ---- create first cube ---- 
    cubes = []; 
    faces = []; 
    ncube = 0; 
    npoly = 0; 
    cubes.push( 
      new Cube(false,0,0,0,0,0,0,50) 
    ); 
  }; 
  var detectFaceOver = function () { 
    // ---- detect pointer over face ---- 
    var j = 0, f; 
    faceOver = false; 
    while ( f = faces[j++] ) { 
      if (f.visible) { 
        if ( f.pointerInside() ) { 
          faceOver = f; 
        } 
      } else break; 
    } 
  }; 
  var click = function () { 
    // ---- click cube ---- 
    detectFaceOver(); 
    if (faceOver) { 
      if (destroy) { 
        if (ncube > 1) { 
          var c = faceOver.cube; 
          faceOver.clicked = false; 
          // ---- destroy faces ---- 
          var i = 0, f; 
          while ( f = faces[i++] ) { 
            if (f.cube == c) { 
              faces.splice(--i, 1); 
              npoly--; 
            } 
          } 
          document.getElementById('npoly').innerHTML = npoly; 
          // ---- destroy cube ---- 
          var i = 0, o; 
          while ( o = cubes[i++] ) { 
            if (o == c) { 
              cubes.splice(--i, 1); 
              ncube--; 
              break; 
            } 
          } 
        } 
      } else { 
        if (!faceOver.clicked) { 
          // ---- create new cube ---- 
          faceOver.clicked = true; 
          var w = -2.25 * faceOver.cube.w; 
          cubes.push( 
            new Cube( 
              faceOver.cube, 
              w * faceOver.normal.xo, 
              w * faceOver.normal.yo, 
              w * faceOver.normal.zo 
            ) 
          ); 
          detectFaceOver(); 
        } 
      } 
    } 
  }; 
  //////////////////////////////////////////////////////////////////////////// 
  var init = function () { 
    // ---- init script ---- 
    scr = document.getElementById("screen"); 
    canvas  = new Canvas("canvas"); 
    // ======== unified touch/mouse events handler ======== 
    scr.ontouchstart = scr.onmousedown = function (e) { 
      if (!running) return true; 
      // ---- touchstart ---- 
      if (e.target !== canvas.container) return; 
      e.preventDefault(); // prevents scrolling 
      if (scr.setCapture) scr.setCapture(); 
      moved = false; 
      drag = true; 
      startX = (e.clientX !== undefined ? e.clientX : e.touches[0].clientX) - nx; 
      startY = (e.clientY !== undefined ? e.clientY : e.touches[0].clientY) - ny; 
    }; 
    scr.ontouchmove = scr.onmousemove = function(e) { 
      if (!running) return true; 
      // ---- touchmove ---- 
      e.preventDefault(); 
      xm = (e.clientX !== undefined ? e.clientX : e.touches[0].clientX) - nx; 
      ym = (e.clientY !== undefined ? e.clientY : e.touches[0].clientY) - ny; 
      detectFaceOver(); 
      if (drag) { 
        cx = cxb + (xm - startX); 
        cy = cyb - (ym - startY); 
      } 
      if (Math.abs(xm - startX) > 10 || Math.abs(ym - startY) > 10) { 
        // ---- if pointer moves then cancel the tap/click ---- 
        moved = true; 
      } 
    }; 
    scr.ontouchend = scr.onmouseup = function(e) { 
      if (!running) return true; 
      // ---- touchend ---- 
      e.preventDefault(); 
      if (scr.releaseCapture) scr.releaseCapture(); 
      drag = false; 
      cxb = cx; 
      cyb = cy; 
      if (!moved) { 
        // ---- click/tap ---- 
        xm = startX; 
        ym = startY; 
        click(); 
      } 
    }; 
    scr.ontouchcancel = function(e) { 
      if (!running) return true; 
      // ---- reset ---- 
      if (scr.releaseCapture) scr.releaseCapture(); 
      moved = false; 
      drag = false; 
      cxb = cx; 
      cyb = cy; 
      startX = 0; 
      startY = 0; 
    }; 
    // ---- Z axis rotation (mouse wheel) ---- 
    scr.addEventListener('DOMMouseScroll', function(e) { 
      if (!running) return true; 
      cz += e.detail * 12; 
      return false; 
    }, false); 
    scr.onmousewheel = function () { 
      if (!running) return true; 
      cz += event.wheelDelta / 5; 
      return false; 
    } 
    // ---- multi-touch gestures ---- 
    document.addEventListener('gesturechange', function(e) { 
      if (!running) return true; 
      e.preventDefault(); 
      // ---- Z axis rotation ---- 
      cz = event.rotation; 
    }, false); 
    // ---- screen size ---- 
    resize(); 
    window.addEventListener('resize', resize, false); 
    // ---- fps count ---- 
    setInterval(function () { 
      document.getElementById('fps').innerHTML = fps * 2; 
      fps = 0; 
    }, 500); // update every 1/2 seconds 
    // ---- some UI options ---- 
    document.getElementById("white").onchange = function () { 
      white = this.checked; 
      if (white) { 
        bkgColor1 = "rgba(256,256,256,0.1)"; 
        bkgColor2 = "rgba(192,192,192,1)"; 
      } else { 
        bkgColor1 = "rgba(0,0,0,0.1)"; 
        bkgColor2 = "rgba(32,32,32,1)"; 
      } 
    } 
    document.getElementById("alpha").onchange = function () { 
      alpha = this.checked; 
    } 
    document.getElementById("autor").onchange = function () { 
      autorotate = this.checked; 
    } 
    document.getElementById("destroy").onchange = function () { 
      destroy = this.checked; 
    } 
    document.getElementById("stopgo").onclick = function () { 
      running = !running; 
      document.getElementById("stopgo").value = running ? "STOP" : "GO!"; 
      if (running) run(); 
    } 
    document.getElementById("reset").onclick = function () { 
      reset(); 
    } 
    // ---- engine start ---- 
    reset(); 
    run(); 
  } 
  //////////////////////////////////////////////////////////////////////////// 
  // ======== main loop ======== 
  var run = function () { 
    // ---- screen background ---- 
    canvas.ctx.fillStyle = bkgColor1; 
    canvas.ctx.fillRect(0, Math.floor(nh * 0.15), nw, Math.ceil(nh * 0.7)); 
    canvas.ctx.fillStyle = bkgColor2; 
    canvas.ctx.fillRect(0, 0, nw, Math.ceil(nh * 0.15)); 
    canvas.ctx.fillStyle = bkgColor2; 
    canvas.ctx.fillRect(0, Math.floor(nh * 0.85), nw, Math.ceil(nh * 0.15)); 
    // ---- easing rotations ---- 
    angleX += ((cy - angleX) * 0.05); 
    angleY += ((cx - angleY) * 0.05); 
    angleZ += ((cz - angleZ) * 0.05); 
    if (autorotate) cz += 1; 
    // ---- pre-calculating trigo ---- 
    cosY = Math.cos(angleY * 0.01); 
    sinY = Math.sin(angleY * 0.01); 
    cosX = Math.cos(angleX * 0.01); 
    sinX = Math.sin(angleX * 0.01); 
    cosZ = Math.cos(angleZ * 0.01); 
    sinZ = Math.sin(angleZ * 0.01); 
    // ---- points projection ---- 
    minZ = 0; 
    var i = 0, c; 
    while ( c = cubes[i++] ) { 
      var j = 0, p; 
      while ( p = c.points[j++] ) { 
        p.projection(); 
      } 
    } 
    // ---- adapt zoom ---- 
    var d = -minZ + 100 - zoom; 
    zoom += (d * ((d > 0) ? 0.05 : 0.01)); 
    // ---- faces light ---- 
    var j = 0, f; 
    while ( f = faces[j++] ) { 
      if ( f.faceVisible() ) { 
        f.distanceToCamera(); 
      } 
    } 
    // ---- faces depth sorting ---- 
    faces.sort(function (p0, p1) { 
      return p1.distance - p0.distance; 
    }); 
    // ---- painting faces ---- 
    j = 0; 
    while ( f = faces[j++] ) { 
        if (f.visible) { 
          f.draw(); 
        } else break; 
    } 
    // ---- animation loop ---- 
    fps++; 
    if (running) setTimeout(run, 16); 
  } 
  return { 
    //////////////////////////////////////////////////////////////////////////// 
    // ---- onload event ---- 
    load : function () { 
      window.addEventListener('load', function () { 
        init(); 
      }, false); 
    } 
  } 
})().load(); 
        JSFILE
      }
    }
  ]

=begin
{
  title: "",
  description: "",
  files: {
    html: <<-HTMLFILE,

    HTMLFILE
    css: <<-CSSFILE,

    CSSFILE
    js: <<-JSFILE,

    JSFILE
  }
}
=end

  project_data.each do |data|
    p = Project.create!(title: data[:title], description: data[:description], creator_id: users.sample.id)
    ["html", "css", "js"].each do |type|
      p.send("#{type}_file").first.update_attributes(body: data[:files][type.to_sym])
    end
  end
end