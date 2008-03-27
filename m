Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2RDPdfp004997
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 09:25:39 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2RDPcCe010904
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 13:25:38 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] SE-PostgreSQL Security Policy (try #3)
Date: Thu, 27 Mar 2008 09:23:53 -0400
Message-ID: <1206624233.16113.291.camel@gorn>
In-Reply-To: <47EB6E41.9040309@ak.jp.nec.com>
References: <47B2B885.4070300@ak.jp.nec.com> <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com> <47C5189B.9070500@ak.jp.nec.com> <1204817238.3994.59.camel@gorn.columbia.tresys.com> <47D09FEB.3030005@ak.jp.nec.com> <1204922912.20251.58.camel@gorn.columbia.tresys.com> <47D3F33B.5010209@kaigai.gr.jp> <1205240234.25555.55.camel@gorn> <47DE3A66.602@ak.jp.nec.com> <1205937929.16113.78.camel@gorn> <47E33A66.6030705@ak.jp.nec.com> <1206384282.16113.205.camel@gorn.columbia.tresys.com> <47E8D58B.5040707@ak.jp.nec.com> <1206451493.16113.217.camel@gorn.columbia.tresys.com> <47EB6E41.9040309@ak.jp.nec.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "KaiGai Kohei" <kaigai@ak.jp.nec.com>
Cc: "KaiGai Kohei" <kaigai@kaigai.gr.jp>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-03-27 at 18:52 +0900, KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
> > On Tue, 2008-03-25 at 19:35 +0900, KaiGai Kohei wrote:
> >> Christopher J. PeBenito wrote:

> >>> I finally realized what the problem with the type_transitions.  You have
> >>> many of them to set up the default type for tables, procedures, blobs,
> >>> etc.  Shouldn't the default labels just be settings in a config file?
> >>> Then all of the complex type transitioning behavior isn't needed.
> >> I dislike thie option.
> >> It can make harder to find out the cause of trouble came from labeling behavior,
> >> if end users put incorrect configuration. Especially, I don't want to require
> >> database folks additional configuration, because they are not SELinux specialist.
> >> It can be configured in the security policy enough simply, so the default behavior
> >> should be also described in.
> > 
> > I think I was a little unclear.  I'm suggesting they go in a file
> > like /etc/selinux/refpolicy/contexts/postgresql_contexts, not in a
> > primary config file for postgresql.
> 
> Yes, I have same implementation image as you suggested.
> 
> However, I don't want to add this kind of stuff although it can be described
> within the security policy, because it provides us uncertainties on SE-PostgreSQL
> behavior. It shall make harder to find out the cause of trouble came from labeling
> matter as I said before.

I'm not very compelled by this argument because its well understood that
these *_contexts files should match the policy otherwise you get unknown
behavior.

> Do you consider they are really complex type_transition rules now?
> They are not conditional, not set operations.

Sounds like they are ok, but I'd have to see the policy to make sure.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
