Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LDjkE6011610
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 09:45:46 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8LDimSR006834
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 13:44:49 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45116881.3060406@redhat.com>
References: <45116881.3060406@redhat.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 09:45:52 -0400
Message-Id: <1158846352.3920.33.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-20 at 12:12 -0400, Daniel J Walsh wrote:

I haven't looked at the patch but I have some initial reactions from
your description:

> http://people.redhat.com/dwalsh/SELinux/policy.diff
> 
> Changed to allow 1024 categories.

Why do we need this many?  This isn't even an incremental change up to
something like 384 or 512.

> +corecmd_etc_runtime_alias(firstboot_rw_t)
> Adding a new alias is a pain in reference policy.  We need a better way of doing this.

No.  We don't want aliases that cross module boundaries.  Otherwise it
turns into a way to access other module's types directly instead of
through an interface.  The ones that cross modules in the policy right
now are for compatibility in targeted policy.

> ntp needs to talk to unconfined_t for setting date from gnome.

Thats weird, it seems like it would be the other way around.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
