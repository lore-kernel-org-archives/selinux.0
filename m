Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA28010
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 04:12:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA01511
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 08:11:25 GMT
Received: from mf1.bredband.net (pop01.lab.bredband.com [195.54.122.119])
	by jazzswing.ncsc.mil  with ESMTP id IAA01507
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 08:11:24 GMT
Received: from galadriel ([213.112.12.161]) by mf1.bredband.net with ESMTP
          id <20020921081230.YOKS5133.mf1@galadriel>
          for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 10:12:30 +0200
Date: Sat, 21 Sep 2002 10:12:29 +0200
From: Anton Emmerfors <anton@vegasys.com>
To: selinux@tycho.nsa.gov
Subject: Re: SE-Linux packages
References: <20020920022148.GA12250@snoopy.apana.org.au> <200209201747.53722.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209201747.53722.russell@coker.com.au>
Message-Id: <20020921081229.9CE3D4128@galadriel>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 20, 2002 at 05:47:53PM +0200, Russell Coker wrote:
> 
> > [3] If installing packages after the SE-Linux version of dpkg has
> > been installed, but a SE-Linux kernel is not yet booted,
> > /etc/dpkg/postinst.d/selinux broke badly, and I had to disable it.
> 
> Yes, you could have just removed the "-e" in that script though...
> 
> Probably should make the script check for a running SE kernel and only try to 
> do anything if it's running.

I encountered the same problem and hacked the script as follows. Not
sure if it is the best test but it works for me...


	/Anton

-8<--8=--

#!/bin/sh -e

SELINUX=$(avc_enforcing 2>&1)
if [ "x$SELINUX" = "xpermissive" -o "x$SELINUX" = "xenforcing" ]; then
  if [ -e /etc/selinux ]; then
    make -s -C /etc/selinux file_contexts/file_contexts
    SETFILES=/usr/sbin/setfiles
    if [ -x /usr/sbin/setfiles.old ]; then
      SETFILES=/usr/sbin/setfiles.old
    fi
    dpkg -L $1 | grep ^/.. | $SETFILES -q -s /etc/selinux/file_contexts/file_contexts
    if [ -x /usr/sbin/setfiles.old -a "$1" = "selinux" ]; then
      rm /usr/sbin/setfiles.old
    fi
  fi
else
  echo "Not running on SELinux-enabled kernel, files not relabeled."
  echo "Run 'make -C /etc/selinux/ relabel' manually to relabel."
fi

-8<--8=--
						

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
