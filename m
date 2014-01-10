Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0AGNOgQ012823
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 11:23:25 -0500
Received: by mail-qe0-f51.google.com with SMTP id 1so4672985qee.24
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 08:23:23 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
Date: Fri, 10 Jan 2014 11:23:20 -0500
Message-ID: <2155090.3LV9Wham8T@sifl>
In-Reply-To: <52D01C2F.9060005@tycho.nsa.gov>
References: <52CF1A53.9080501@redhat.com> <52D00A39.5020100@tycho.nsa.gov>
 <52D01C2F.9060005@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, January 10, 2014 11:13:35 AM Stephen Smalley wrote:
> On 01/10/2014 09:56 AM, Stephen Smalley wrote:
> > On 01/10/2014 09:49 AM, Paul Moore wrote:
> >> On Friday, January 10, 2014 09:42:42 AM Stephen Smalley wrote:
> >>> On 01/09/2014 06:07 PM, Eric Paris wrote:
> >>>> I believe we need a new initial sid.  SECINITSID_INVALID_LABEL....
> >>> 
> >>> Difficult (impossible?) to do in a fully backward compatible manner (to
> >>> include the case of loading new policy on old kernel, whether initially
> >>> or update/reload on an already running kernel with an older policy).
> >> 
> >> Do we really need to worry about being able to load new policy into a old
> >> kernel?  In general I thought the backward compatible issue was that
> >> newer
> >> kernels needed to support older userspace, not the other way around.
> > 
> > Well, you'll at least need code in the kernel to handle the case where
> > the policy does not define any new initial SIDs that you introduce in
> > the policy, remapping them to e.g. unlabeled or something.

Yep.

> > And you likely want to ensure that people don't accidentally load new
> > policy into old kernel and break things, whether by tying the new
> > initial SIDS to a policy capability or policy version.

Yep.  I imagine this would be a new policy version, but that is just a gut 
feeling not backed up by any actual inspection or serious thought.

> But reusing one of the dead initial SIDs might be easier - I think you
> have done that previously for some of the networking ones.

Yep, we reused the netmsg initial SID for NetLabel traffic that is missing 
user/role/type information.

For the record, I'm in no hurry to rework the initial SID bits, I just think 
that ultimately they could use some improvement similar to what was done with 
the dynamic class/permissions code.

-- 
paul moore
www.paul-moore.com
