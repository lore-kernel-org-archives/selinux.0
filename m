Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h983dZWt016503
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 23:39:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h983dY7d006714
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 03:39:34 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h983dWRn006700 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 03:39:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>, Tom <tom@lemuria.org>
Subject: Re: 2.6.0-test6 boot process failures
Date: Wed, 8 Oct 2003 13:39:14 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20031007230348.E11325@lemuria.org> <1065567176.2083.12.camel@chris.pebenito.net>
In-Reply-To: <1065567176.2083.12.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310081339.14251.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Oct 2003 08:52, Chris PeBenito wrote:
> > Is it possible - I'm not familiar with the details of the boot process
> > - that somewhere inbetween it loses access to the initrd /usr/lib but
> > before it has mounted all the other partitions?
>
> Actually a Gentoo user reported this to me a couple days ago.  Yeah, its
> because /usr/ is a separate partition.  I'm not familiar with the debian
> initrd-tools, but I would assume that it pivot_root's at the end of the
> initrd script, and then it does an exec /sbin/init.  After the

Yes, this is a bug, and your analysis is correct.

Programs in /sbin or /bin must NEVER be linked against shared objects in
/usr/lib .  As /bin/ps, /bin/ls, and /lib/security/pam_selinux.so are linked 
against libselinux.so, libselinux.so should go into /lib.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
