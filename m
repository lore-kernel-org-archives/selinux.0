Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0BIZmRb009225
	for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 13:35:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0BIYgxr001186
	for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 18:34:42 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
	by jazzswing.ncsc.mil  with ESMTP id i0BIYfYc001183
	for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 18:34:41 GMT
Message-ID: <40019781.80802@diyab.net>
Date: Sun, 11 Jan 2004 13:35:45 -0500
From: Timothy Wood <timothy@diyab.net>
MIME-Version: 1.0
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
CC: selinux@tycho.nsa.gov, Park Lee <parklee_2004@yahoo.com.cn>
Subject: Re: Questions about install SELinux in Fedora Core
References: <20040111024703.62855.qmail@web15208.mail.bjs.yahoo.com> <200401112231.54137.russell@coker.com.au> <200401111426.08881.arekm@pld-linux.org>
In-Reply-To: <200401111426.08881.arekm@pld-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've actually been working on this recently. I spent some time tracking 
the problem down and it looks like a attribute namespace difference so 
I'm talking to some people on the XFS mailing list. It should be working 
before long, i hope.

Timothy,

Arkadiusz Miskiewicz wrote:

> On Sunday 11 of January 2004 12:31, Russell Coker wrote:
> 
>>>>quotas? For xfsprogs, last I heard XFS support for SE Linux wasn't
>>>>
>>>>>quite ready.
> 
> [...]
> 
>>XFS isn't something I've had a need to learn about, and quota-tools isn't
>>something I've used recently.  I don't know what the issues of upgrading
>>them may be.
> 
> 
> Labeling works with xfs on 2.6.1 patched using for example these patches
> http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/linux-2.6-xfs-cvs-20040102.patch?rev=1.2.2.1
> http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/linux-2.6-xfs-secure-attr.patch?rev=1.1
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
