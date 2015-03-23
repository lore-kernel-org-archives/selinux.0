Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2NAu6ai030499
 for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2015 06:56:06 -0400
Received: by lbbsy1 with SMTP id sy1so115431060lbb.1
 for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2015 03:55:43 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 23 Mar 2015 12:55:43 +0200
Message-ID: <CA+g23Tsk7Lfh0eQ+FfayCT-pox7Y5FC9n_GNpTVvE83DttRbYw@mail.gmail.com>
Subject: Reset SELinux booleans
From: Aleksey Chudov <aleksey.chudov@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11c22626f5b28d0511f281a3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c22626f5b28d0511f281a3
Content-Type: text/plain; charset=UTF-8

Hi,

After some experiments I'm trying to reset booleans to the boot-time
defaults. Just deleting /etc/selinux/targeted/modules/active/booleans.local
and executing semodule -B does not help.

According to man booleans(8) the load_policy program can reset booleans to
the boot-time defaults via the -b option. But executing load_policy -b
produces the following warning on CentOS 7:

# load_policy -b
load_policy:  Warning! The -b option is no longer supported, booleans are
always preserved across reloads.  Continuing...

Currently I'm setting up servers including SELinux policy using
configuration management system. File
/etc/selinux/targeted/modules/active/booleans.local is managed
automatically. But if someone manually executes setsebool to set some
boolean this boolean becomes unmanageable till the next reboot and it could
be a very long time in the case of a production server.

Is there some way to reset booleans to the boot-time defaults?


Regards,
Aleksey

--001a11c22626f5b28d0511f281a3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>After some experiments I&#39;m trying to reset =
booleans to the boot-time defaults. Just deleting /etc/selinux/targeted/mod=
ules/active/booleans.local and executing semodule -B does not help.<br><br>=
According
 to man booleans(8) the load_policy program can reset booleans to the=20
boot-time defaults via the -b option. But executing load_policy -b=20
produces the following warning on CentOS 7:<br><br># load_policy -b<br>load=
_policy:=C2=A0 Warning! The -b option is no longer supported, booleans are =
always preserved across reloads.=C2=A0 Continuing...<br><span lang=3D"en"><=
span><br></span></span>Currently
 I&#39;m setting up servers including SELinux policy using configuration=20
management system. File /etc/selinux/targeted/modules/active/booleans.local
 is managed automatically. But if someone manually executes setsebool to
 set some boolean this boolean becomes unmanageable till the next reboot
 and it<span lang=3D"en"><span> could be</span> <span>a very long time</spa=
n> <span>in the case of</span> <span>a production server</span></span>.<br>=
<div><br><span lang=3D"en"><span>Is there</span> <span>some</span> <span>wa=
y to </span></span>reset booleans to the boot-time defaults?<br><br></div><=
div><br></div>Regards,<br>Aleksey<br></div>

--001a11c22626f5b28d0511f281a3--
