Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0KEprXf016703
	for <selinux@tycho.nsa.gov>; Fri, 20 Jan 2006 09:51:53 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0KEodTl029261
	for <selinux@tycho.nsa.gov>; Fri, 20 Jan 2006 14:50:41 GMT
Subject: Re: Latest Diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43D0EC08.1000700@redhat.com>
References: <43CFE58A.40909@redhat.com> <1137712699.29815.402.camel@sgc>
	 <43D0EC08.1000700@redhat.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 09:53:18 -0500
Message-Id: <1137768798.21016.2.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-20 at 08:56 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:

> >> -gen_user(user_u, user_r, s0, s0 - s15:c0.c255, c0.c255)
> >> +gen_user(user_u, user_r, s0, s0 - s0, c0)
> >
> > The MLS change seems ok, but do we really want to give user_u one
> > arbitrary category (c0) for MCS?  It seems like it would be better for
> > the default to be no categories.
> >   
> Yes I agree.  Never noticed that.  It should be s0.

Merged.  I also changed the MLS range to just s0, since it is the same
as s0 - s0.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
