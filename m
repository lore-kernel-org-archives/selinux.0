Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h77Jf9Ha002458
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2003 15:41:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h77JERTZ004871
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2003 19:41:03 GMT
Received: from zok.sgi.com (zok.sgi.com [204.94.215.101])
        by jazzband.ncsc.mil  with ESMTP id h77HqweN000959 for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2003 17:52:59 GMT
Date: Thu, 7 Aug 2003 10:51:47 -0700 (PDT)
From: Casey Schaufler <casey@anchovy.engr.sgi.com>
Message-Id: <200308071751.h77HplDV009169@anchovy.engr>
To: russell@coker.com.au, Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Fwd: [JS] Suse on IBM eServer achieves EAL2+ security
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200308061046.16095.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> ... that is, no ACLs on anything ...

Believe it or not, ACLs are a very minor feature.
They provide descretionary access control, a
facility for which mode bits are (close to)
sufficent. The big thing required by all relevent
protection profiles is the security audit trail.


Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				650.933.1634

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
