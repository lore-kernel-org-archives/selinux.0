Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0BDQcRb008438
	for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 08:26:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0BDQbiV026937
	for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 13:26:37 GMT
Received: from maja.beep.pl (smtp.sys.beep.pl [195.245.198.13])
        by jazzband.ncsc.mil  with ESMTP id i0BDQb06026934 for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 13:26:37 GMT
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
To: selinux@tycho.nsa.gov
Subject: Re: Questions about install SELinux in Fedora Core
Date: Sun, 11 Jan 2004 14:26:08 +0100
References: <20040111024703.62855.qmail@web15208.mail.bjs.yahoo.com> <200401112231.54137.russell@coker.com.au>
In-Reply-To: <200401112231.54137.russell@coker.com.au>
Cc: Park Lee <parklee_2004@yahoo.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200401111426.08881.arekm@pld-linux.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 11 of January 2004 12:31, Russell Coker wrote:
> > > quotas? For xfsprogs, last I heard XFS support for SE Linux wasn't
> > > >quite ready.
[...]
> XFS isn't something I've had a need to learn about, and quota-tools isn't
> something I've used recently.  I don't know what the issues of upgrading
> them may be.

Labeling works with xfs on 2.6.1 patched using for example these patches
http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/linux-2.6-xfs-cvs-20040102.patch?rev=1.2.2.1
http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/linux-2.6-xfs-secure-attr.patch?rev=1.1

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
