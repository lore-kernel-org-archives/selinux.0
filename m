Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBP9tJXf025643
	for <selinux@tycho.nsa.gov>; Sun, 25 Dec 2005 04:55:19 -0500 (EST)
Received: from nproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBP9sM3T016366
	for <selinux@tycho.nsa.gov>; Sun, 25 Dec 2005 09:54:23 GMT
Received: by nproxy.gmail.com with SMTP id b2so328370nfe
        for <selinux@tycho.nsa.gov>; Sun, 25 Dec 2005 01:55:18 -0800 (PST)
Message-ID: <4c2efa540512250155p3789d9eeg87e1241ed33d2b32@mail.gmail.com>
Date: Sun, 25 Dec 2005 03:55:18 -0600
From: L L <her.drinne@gmail.com>
To: selinux@tycho.nsa.gov
Subject: errors compiling policycoreutils-1.28
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5101_28442192.1135504518269"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_5101_28442192.1135504518269
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm in the process of a source SELinux install, and have compiled and
installed libsepol, libselinux and checkpolicy successflly, but when I try
to compile policycoreutils, it complains that semanage/modules.h can not be
found. and the build fails.  I cannot find a "module.h" within the tree I
have all my SELinux files in, but I do have a modules.h as part of
libsepol.  Not sure if these are related, but I do recall seeing a post in
the archives about  the read/write for the module sbeing moved from semanag=
e
to sepol, but I do not know if this is related or not.

Any help would be greatly appreciated.  Thanks

Lee

------=_Part_5101_28442192.1135504518269
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm in the process of a source SELinux install, and have compiled and
installed libsepol, libselinux and checkpolicy successflly, but when I
try to compile policycoreutils, it complains that semanage/modules.h
can not be found. and the build fails.&nbsp; I cannot find a &quot;module.h=
&quot;
within the tree I have all my SELinux files in, but I do have a
modules.h as part of libsepol.&nbsp; Not sure if these are related, but
I do recall seeing a post in the archives about&nbsp; the read/write
for the module sbeing moved from semanage to sepol, but I do not know
if this is related or not.<br>
<br>
Any help would be greatly appreciated.&nbsp; Thanks<br>
<br>
Lee<br>

------=_Part_5101_28442192.1135504518269--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
