Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2KFPUvR027124
	for <selinux@tycho.nsa.gov>; Mon, 20 Mar 2006 10:25:30 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2KFPPpF025130
	for <selinux@tycho.nsa.gov>; Mon, 20 Mar 2006 15:25:27 GMT
Subject: Re: How can modular policy ever have worked? [patch]
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1142691657.4017.23.camel@wintermute.xmldesign.de>
References: <1142691657.4017.23.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 10:25:38 -0500
Message-Id: <1142868338.20739.39.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-03-18 at 15:20 +0100, Erich Schubert wrote:
> Fact (look at the source):
> optional(`whatever',`...')
> gets reduced to nothing when building base.pp and whatever as module.
> That way base.pp doesn't contain any optional statements, because the
> compiler used to not support that yet. (Method says he added this
> support)
> When building a module, it is expanded to a proper optional {}
> statement.
> 
> I discovered this after investigating why building mta into base and
> policy as module didn't work right - the optional(`postfix',`...') part
> gets lost, so /usr/lib/sendmail can't transition into postdrop_t, so it
> can't write mails to the postfix queues.
> When I build mta as module this worked just fine.

Yes, this type of thing is what prompted the patch that allowed
optionals in base module which Joshua was referring to.

> Attached patch will write appropriate optional {} statements to the base
> policy.

The base module check is not needed.  Since optionals are now allowed in
the base module they also work in monolithic policies (a base module is
basically an unexpanded monolithic policy).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
