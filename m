Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LEYI25013334
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 10:34:20 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8LEXmRL009560
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 14:33:48 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45129C7F.6090801@redhat.com>
References: <45116881.3060406@redhat.com>
	 <1158846352.3920.33.camel@sgc.columbia.tresys.com>
	 <45129C7F.6090801@redhat.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 10:34:23 -0400
Message-Id: <1158849263.3920.63.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-21 at 10:06 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Wed, 2006-09-20 at 12:12 -0400, Daniel J Walsh wrote:
> >
> > I haven't looked at the patch but I have some initial reactions from
> > your description:
> >
> >   
> >> http://people.redhat.com/dwalsh/SELinux/policy.diff
> >>
> >> Changed to allow 1024 categories.
> >>     
> >
> > Why do we need this many?  This isn't even an incremental change up to
> > something like 384 or 512.
> >
> >   
> MLS People have past 256 and wanted a big jump to prevent hitting this 
> problem again.  I put it in for both to prevent confusion between MCS/MLS

Ok, we'll go with 1024, but that's where I draw the line; I consider any
higher to be a corner case.  Anyone that needs more than that will have
to build their own custom policy.

> >> +corecmd_etc_runtime_alias(firstboot_rw_t)
> >> Adding a new alias is a pain in reference policy.  We need a better way of doing this.
> >>     
> >
> > No.  We don't want aliases that cross module boundaries.  Otherwise it
> > turns into a way to access other module's types directly instead of
> > through an interface.  The ones that cross modules in the policy right
> > now are for compatibility in targeted policy.
> >   
> So how do I get rid of firstboot_rw_t which should be etc_runtime_t?

Since this is a compat thing due to a type removal, and will eventually
be dropped, just put it in files.te.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
