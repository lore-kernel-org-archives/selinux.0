Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA27095
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 16:20:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA00280
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 21:19:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzband.ncsc.mil  with ESMTP id VAA00276
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 21:19:42 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1424A926EF
	for <selinux@tycho.nsa.gov>; Wed, 28 Nov 2001 08:20:18 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 257D725E
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 22:20:06 +0100 (CET)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils, fileutils, and [xkg]dm
Date: Tue, 27 Nov 2001 22:20:05 +0100
MIME-Version: 1.0
Message-Id: <20011127212006.257D725E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is a message I just posted to the debian Developers list about my 
latest test packages (not uploaded to Debian and not official packages).

What is probably of more interest to you is the locations that I've put 
header files in, here's what I'm currently installing:
/usr/include
/usr/include/linux
/usr/include/linux/flask
/usr/include/linux/flask/class_to_string.h
/usr/include/linux/flask/initial_sid_to_string.h
/usr/include/linux/flask/avc.h
/usr/include/linux/flask/avc_ss.h
/usr/include/linux/flask/av_perm_to_string.h
/usr/include/linux/flask/flask.h
/usr/include/linux/flask/security.h
/usr/include/linux/flask/psid.h
/usr/include/linux/flask/common_perm_to_string.h
/usr/include/linux/flask/syscalls.h
/usr/include/linux/flask/flask_types.h
/usr/include/linux/flask/av_permissions.h
/usr/include/linux/flask/av_inherit.h
/usr/include/selinux
/usr/include/selinux/ss.h
/usr/include/selinux/lsm.h
/usr/include/selinux/ipc_secure.h
/usr/include/selinux/proc_secure.h
/usr/include/selinux/context.h
/usr/include/selinux/get_sid_list.h
/usr/include/selinux/fs_secure.h
/usr/include/selinux/get_default_type.h
/usr/include/selinux/socket_secure.h
/usr/include/selinux/flask_util.h
/usr/include/selinux/get_user_sid.h

I would like some feedback from the authors of what they think about these 
locations.  I will not put the include files in /usr/local, but I am open to 
suggestions of other ways of arranging them under /usr/include.

Also it would be conveniant for people who are develping distributions if 
there was a suggested location for header files that worked with the LSB 
directory scheme...


Subject: Re: SE Linux packages of login, sshd, tar, stat, findutils, 
fileutils, and [xkg]dm
Date: Tue, 27 Nov 2001 20:44:23 +0100
From: Russell Coker <russell@coker.com.au>
To: Giacomo Catenazzi <cate@debian.org>, debian-devel@lists.debian.org

On Tue, 27 Nov 2001 17:41, Giacomo Catenazzi wrote:
> > PS  I hope to have some test packages of SE-Linux enabled utilities on
> > http://www.coker.com.au/selinux/ within 24 hours, and a complete set of
> > SE-Linux Debian packages (apart from [xkg]dm) within a week.
>
> do you need some help?

Yes!

Firstly check out http://www.coker.com.au/selinux/ .

Please test compiling all the source first.  First compile the kernel-patch
package (it's a build depdendency for libselinux-dev which everything else
build-depends on).  After installing it build the libselinux-dev and then
build the stat package.

Then of course you can't do anything without having a kernel to boot (which
is easily done) and a login package to allow you to login (which I haven't
packaged yet).

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
