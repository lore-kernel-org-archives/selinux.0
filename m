Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11614
	for <selinux@tycho.nsa.gov>; Sat, 23 Nov 2002 12:37:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA28822
	for <selinux@tycho.nsa.gov>; Sat, 23 Nov 2002 17:34:55 GMT
Received: from pandora.snu.edu ([204.126.2.1])
	by jazzswing.ncsc.mil  with SMTP id RAA28818
	for <selinux@tycho.nsa.gov>; Sat, 23 Nov 2002 17:34:55 GMT
Message-Id: <sddf6838.049@atlas.snu.edu>
Date: Sat, 23 Nov 2002 11:36:21 -0600
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <bam@snoopy.apana.org.au>
Cc: <russell@coker.com.au>, <selinux@tycho.nsa.gov>, <jabiru_croc@yahoo.com>
Subject: Re: SELinux distro building
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ok, here is a list of places that need $(MODDIR)/include added to
INCLUDES in Makefile
libsecure/test
setfiles/
utils/newrole
utils/run_init
utils/spasswd
devfsd/

after adding all these it compiled cleanly on a completely virgin
system. excellent.. Thanks

Joshua Brindle
UNIX Administrator
Southern Nazarene University

>>> Brian May <bam@snoopy.apana.org.au> 11/20/02 04:48PM >>>
On Wed, Nov 20, 2002 at 02:54:18PM -0600, Joshua Brindle wrote:
> much closer
> i used --with-lsm=/usr/src/linux-2.4.19-selinux because it was
looking
> in ../../.. for lsm-2.4, instead of just ../ (i dunno)
> anyway, it compiled almost everything then i got this error
> (if you prefer i can pipe the entire compile to a file and attach..
> Thanks

Looks like another directory that needs to include LSM directories.

What directories need these include files?

So far it seems to be:

libsecure/src
libsecure/test
modules/checkpolicy

Is that all? Are there any others I might have missed?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing
list.
If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
