Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB6HHARb010982
	for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 12:17:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB6HGSlU025297
	for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 17:16:28 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hB6HGRSX025294
	for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 17:16:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bastian Blank <bastian@waldi.eu.org>, selinux@tycho.nsa.gov
Subject: Re: setfiles - should not fail on ro fs
Date: Sun, 7 Dec 2003 04:16:59 +1100
References: <20031206155012.GA19852@wavehammer.waldi.eu.org>
In-Reply-To: <20031206155012.GA19852@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312070416.59347.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 7 Dec 2003 02:50, Bastian Blank <bastian@waldi.eu.org> wrote:
> hi folks
>
> setfiles should not fail on r/o filesystems:
> | /usr/sbin/setfiles:  labeling files under /boot301
> | /boot301: Read-only file system
> | /usr/sbin/setfiles:  unable to relabel /boot301 to
> | system_u:object_r:file_t /usr/sbin/setfiles:  error while labeling files
> | under /boot301
> | make: *** [relabel] Error 1

relabel:  $(FC) $(SETFILES)
        $(SETFILES) $(FC) `mount | awk '/ext[23].*rw/{print $$3}'`

In my tree I've changed the relabel rule to the above.  Please try it out and 
let me know how it goes.  It should cause "make relabel" to not attempt to 
relabel ro mounted file systems.

Having setfiles return an error if it can't relabel is correct behavior.  
Determining which file systems to label is the job of the Makefile.


Also I removed the reset target as it seems obsolete.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
