Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5OAKuXt013749
 for <selinux@tycho.nsa.gov>; Sat, 24 Jun 2017 06:20:56 -0400
To: selinux <selinux@tycho.nsa.gov>
Cc: 863187-forwarded@bugs.debian.org
From: Laurent Bigonville <bigon@debian.org>
Subject: run_init messes up terminal settings
Message-ID: <f19a1c21-5c15-cb56-9e55-08df2f66429a@debian.org>
Date: Sat, 24 Jun 2017 12:20:45 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------61C2D6A51E9473A961A04A10"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------61C2D6A51E9473A961A04A10
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Russell opened the following bug regarding run_init in the debian bts:

====

[...]
It turns out that the problem was not running $(arch), but running run_init in
the shell it spawned.  Below is an example of reproducing this, the first time
run_init performs as expected.  The second time is fails without me even
typing a password or pressing ENTER.  The result is the same with any command,
but ls is just a good example.  This happens no matter what shell is spawned
(whether it's ssh, su, or just an Xterm), run_init seems generally broken with
the 4.9.0-2-amd64/4.9.13-1 kernel at least.

NB I can't rule out the possibility of a kernel bug at this stage.  But at
this time it seems best to assume it's a run_init bug until proven otherwise.

Sorry for the inconvenience Andreas.

# run_init ls /boot
Authenticating root.
Password:
config-4.9.0-2-amd64      lost+found                System.map-4.9.0-3-amd64
config-4.9.0-3-amd64      memtest86+.bin            vmlinuz-4.9.0-2-amd64
grub                      memtest86+_multiboot.bin  vmlinuz-4.9.0-3-amd64
initrd.img-4.9.0-2-amd64  real
initrd.img-4.9.0-3-amd64  System.map-4.9.0-2-amd64
# run_init ls /boot
Authenticating root.
Password:
run_init: incorrect password for root
authentication failed.
#

====

I can reproduce this with 2.7-rc3, run_init is compiled with pam and 
audit support.

An idea what could happen here?

Regards,

Laurent Bigonville

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863187


--------------61C2D6A51E9473A961A04A10
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hello,</p>
    <p>Russell opened the following bug regarding run_init in the debian
      bts:</p>
    <p>====</p>
    <pre class="message">[...]
It turns out that the problem was not running $(arch), but running run_init in 
the shell it spawned.  Below is an example of reproducing this, the first time 
run_init performs as expected.  The second time is fails without me even 
typing a password or pressing ENTER.  The result is the same with any command, 
but ls is just a good example.  This happens no matter what shell is spawned 
(whether it's ssh, su, or just an Xterm), run_init seems generally broken with 
the 4.9.0-2-amd64/4.9.13-1 kernel at least.

NB I can't rule out the possibility of a kernel bug at this stage.  But at 
this time it seems best to assume it's a run_init bug until proven otherwise.

Sorry for the inconvenience Andreas.

# run_init ls /boot
Authenticating root.
Password: 
config-4.9.0-2-amd64      lost+found                System.map-4.9.0-3-amd64
config-4.9.0-3-amd64      memtest86+.bin            vmlinuz-4.9.0-2-amd64
grub                      memtest86+_multiboot.bin  vmlinuz-4.9.0-3-amd64
initrd.img-4.9.0-2-amd64  real
initrd.img-4.9.0-3-amd64  System.map-4.9.0-2-amd64
# run_init ls /boot
Authenticating root.
Password: 
run_init: incorrect password for root
authentication failed.
# </pre>
    <p>====<br>
    </p>
    <p>I can reproduce this with 2.7-rc3, run_init is compiled with pam
      and audit support.<br>
    </p>
    <p>An idea what could happen here?</p>
    <p>Regards,</p>
    <p>Laurent Bigonville<br>
    </p>
    <p><a class="moz-txt-link-freetext" href="https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863187">https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863187</a><br>
    </p>
  </body>
</html>

--------------61C2D6A51E9473A961A04A10--
