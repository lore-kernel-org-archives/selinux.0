Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QID5jf018071
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 14:13:05 -0400
Date: Mon, 26 Mar 2012 20:12:55 +0200
From: Laurent Bigonville <bigon@debian.org>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/4] policycoreutils -- Only run setfiles if we found
 read-write filesystems to run it on
Message-ID: <20120326201255.41befb27@fornost.bigon.be>
In-Reply-To: <CACLa4ps73sqV-O+aLKkFEoDtbp05heymjoz=LRrHWbq4YKD-5g@mail.gmail.com>
References: <20120326173317.25d0ed1c@eldamar.bigon.be>
	<CACLa4ps73sqV-O+aLKkFEoDtbp05heymjoz=LRrHWbq4YKD-5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Le Mon, 26 Mar 2012 13:55:56 -0400,
Eric Paris <eparis@parisplace.org> a écrit :

> This patch doesn't apply.  I don't see a "SYSLOGFLAG" in the upstream
> tree.  Is that something debian specific?

This is weird, it applies fine here on git master HEAD

[git: master]$ git grep SYSLOGFLAG
scripts/fixfiles:SYSLOGFLAG="-l"
scripts/fixfiles:${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 | cat >> $LOGFILE

Cheers

Laurent Bigonville


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
