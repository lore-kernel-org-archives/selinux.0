Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1L0mudW015374
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 19:48:56 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1L0iali010685
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 00:44:36 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j1L0ksEA028531
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 19:46:56 -0500 (EST)
Subject: PT_GNU_STACK RWE
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sun, 20 Feb 2005 19:49:12 -0500
Message-Id: <1108946955.9501.7.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Some of those are causing trouble, just like java.
They produce the same kind of denials as a legacy domain
where you say READ implies EXEC for backwards compatibility. 

In particular mplayer, lame, inkscape and gpg don't work anymore.
What needs to be done? 

[root@cobra ~]#  for DIR in `echo $PATH|tr ':' ' '`; do for FILE in
$DIR/*; do if [ ! -z "`readelf -l $FILE 2>/dev/null |grep GNU_STACK|grep
RWE`" ]; then echo "$FILE"; fi; done;done;
/sbin/netplugd
/usr/bin/eu-nm
/usr/bin/gmplayer
/usr/bin/gnatbind
/usr/bin/gnatls
/usr/bin/gnatmake
/usr/bin/gpg
/usr/bin/gpgv
/usr/bin/inkscape
/usr/bin/inkview
/usr/bin/lame
/usr/bin/mencoder
/usr/bin/mp3rtp
/usr/bin/mp3x
/usr/bin/mplayer
/usr/bin/ocamlc.opt
/usr/bin/ocamldep.opt
/usr/bin/ocamldoc.opt
/usr/bin/ocamllex.opt
/usr/bin/ocamlopt.opt

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
