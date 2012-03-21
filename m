Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2LD5Bxl015198
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2012 09:05:11 -0400
Received: from csgsmtp201l.Princeton.EDU (csgsmtp201l.Princeton.EDU [128.112.134.60])
	by ppa01.Princeton.EDU (8.14.4/8.14.4) with ESMTP id q2LD59bS027864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2012 09:05:09 -0400
Received: from [140.180.2.217] (dynamic-oit-vapornet-c-167.Princeton.EDU [140.180.2.217])
	(authenticated bits=0)
	by csgsmtp201l.Princeton.EDU (8.13.8/8.12.9) with ESMTP id q2LD58Il012604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2012 09:05:09 -0400
Message-ID: <4F69D204.9070609@princeton.edu>
Date: Wed, 21 Mar 2012 09:05:08 -0400
From: Mark Dalton <mdalton@princeton.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: VirtualGL and selinux
Content-Type: multipart/alternative;
 boundary="------------090105050601010202090403"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090105050601010202090403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Thank you for selinux.   I have been trying to run it on our machines
especially any public facing and servers.  We use audit2allow and
generate mods.

I did not find a 'dumb users forum'.   Could you point me to a place
to find this or suggest how to fix this?   I worked with our local expert
on selinux.   (I can repeat this if that helps).

I was not able to get VirtualGL and selinux to work together.
It is something during boot time it seems.  I have tried generating
rules based on audit/audit.log.

The VirtualGL web http://www.virtualgl.org/Documentation/RHEL6
states they don't know how to make it work either.

I have tried in permissive mode after boot and that did not work either,
which is why I think it is something during boot time.  Like the device
setup. My guess is related to: /dev/dri as it sets up these and then
access to the /dev/nvidia0 and /dev/nvidiactl are restricted to vglusers
group (in my case it can be configured with/without group restriction).

 From VirtualGL website they also have:


      vglgenkey Issues

Currently, the only known way to make|vglgenkey|work (|vglgenkey|is used 
to grant 3D X Server access to members of the|vglusers|group) is to 
disable SELinux. With SELinux enabled, the*//usr/bin/xauth/*file is 
hidden within the context of the GDM startup scripts, so|vglgenkey|has 
no way of generating or importing an xauth key 
to*//etc/opt/VirtualGL/vgl_xauth_key/*(and, for that matter, access is 
denied to*//etc/opt/VirtualGL/*as well.)

Perhaps someone with a greater knowledge of SELinux can explain how to 
disable enforcement only for GDM and not the whole system.



--------------090105050601010202090403
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    Thank you for selinux.&nbsp;&nbsp; I have been trying to run it on our
    machines<br>
    especially any public facing and servers.&nbsp; We use audit2allow and<br>
    generate mods.<br>
    <br>
    I did not find a 'dumb users forum'.&nbsp;&nbsp; Could you point me to a place<br>
    to find this or suggest how to fix this?&nbsp;&nbsp; I worked with our local
    expert<br>
    on selinux.&nbsp;&nbsp; (I can repeat this if that helps).<br>
    <br>
    I was not able to get VirtualGL and selinux to work together.<br>
    It is something during boot time it seems.&nbsp; I have tried generating<br>
    rules based on audit/audit.log.<br>
    <br>
    The VirtualGL web
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    <a href="http://www.virtualgl.org/Documentation/RHEL6">http://www.virtualgl.org/Documentation/RHEL6</a><br>
    states they don't know how to make it work either.<br>
    <br>
    I have tried in permissive mode after boot and that did not work
    either,<br>
    which is why I think it is something during boot time.&nbsp; Like the
    device<br>
    setup. My guess is related to: /dev/dri as it sets up these and then<br>
    access to the /dev/nvidia0 and /dev/nvidiactl are restricted to
    vglusers<br>
    group (in my case it can be configured with/without group
    restriction).<br>
    <br>
    From VirtualGL website they also have:<br>
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    <span class="Apple-style-span" style="color: rgb(0, 0, 0);
      font-family: Arial, Helvetica, sans-serif; font-size: 15px;
      font-style: normal; font-variant: normal; font-weight: normal;
      letter-spacing: normal; line-height: 19px; orphans: 2; text-align:
      -webkit-auto; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px;
      -webkit-text-decorations-in-effect: none;
      -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;
      background-color: rgb(250, 250, 250); ">
      <h3 style="margin-top: 1em; margin-bottom: 0.6em; font-weight:
        bold; font-size: 1.22em; text-decoration: underline; ">vglgenkey
        Issues</h3>
      <p style="margin-top: 0px; margin-bottom: 0px; ">Currently, the
        only known way to make<span class="Apple-converted-space">&nbsp;</span><code
          style="font-size: 0.9em; font-family: 'Lucida Console',
          'Andale Mono', 'Courier New', Courier; color: rgb(0, 120, 20);
          ">vglgenkey</code><span class="Apple-converted-space">&nbsp;</span>work
        (<code style="font-size: 0.9em; font-family: 'Lucida Console',
          'Andale Mono', 'Courier New', Courier; color: rgb(0, 120, 20);
          ">vglgenkey</code><span class="Apple-converted-space">&nbsp;</span>is
        used to grant 3D X Server access to members of the<span
          class="Apple-converted-space">&nbsp;</span><code style="font-size:
          0.9em; font-family: 'Lucida Console', 'Andale Mono', 'Courier
          New', Courier; color: rgb(0, 120, 20); ">vglusers</code><span
          class="Apple-converted-space">&nbsp;</span>group) is to disable
        SELinux. With SELinux enabled, the<span
          class="Apple-converted-space">&nbsp;</span><strong><em>/usr/bin/xauth</em></strong><span
          class="Apple-converted-space">&nbsp;</span>file is hidden within
        the context of the GDM startup scripts, so<span
          class="Apple-converted-space">&nbsp;</span><code style="font-size:
          0.9em; font-family: 'Lucida Console', 'Andale Mono', 'Courier
          New', Courier; color: rgb(0, 120, 20); ">vglgenkey</code><span
          class="Apple-converted-space">&nbsp;</span>has no way of generating
        or importing an xauth key to<span class="Apple-converted-space">&nbsp;</span><strong><em>/etc/opt/VirtualGL/vgl_xauth_key</em></strong><span
          class="Apple-converted-space">&nbsp;</span>(and, for that matter,
        access is denied to<span class="Apple-converted-space">&nbsp;</span><strong><em>/etc/opt/VirtualGL</em></strong><span
          class="Apple-converted-space">&nbsp;</span>as well.)</p>
      <p class="vspace" style="margin-top: 1.33em; margin-bottom: 0px; ">Perhaps
        someone with a greater knowledge of SELinux can explain how to
        disable enforcement only for GDM and not the whole system.</p>
    </span><br>
  </body>
</html>

--------------090105050601010202090403--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
