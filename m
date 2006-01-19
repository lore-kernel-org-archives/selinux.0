Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0JNGkXf009112
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 18:16:46 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0JNGfh0011659
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 23:16:43 GMT
Subject: Re: Latest Diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43CFE58A.40909@redhat.com>
References: <43CFE58A.40909@redhat.com>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 18:18:19 -0500
Message-Id: <1137712699.29815.402.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged with a few notes:

On Thu, 2006-01-19 at 14:16 -0500, Daniel J Walsh wrote:
> Fixes for wine and mono apps to be able to handle no execheap/execstack

Added these, but if we get more apps like these, we might want to go to
unconfined_execheap and unconfined_execstack.

I haven't merged the users part, but I plan to.  I just want to make
sure this change is what we really want to do for the strict policy:

> -gen_user(user_u, user_r, s0, s0 - s15:c0.c255, c0.c255)
> +gen_user(user_u, user_r, s0, s0 - s0, c0)

The MLS change seems ok, but do we really want to give user_u one
arbitrary category (c0) for MCS?  It seems like it would be better for
the default to be no categories.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
