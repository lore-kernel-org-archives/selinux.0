From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v1] selinux: Fix security_compute_av() to not return unknown class errors when in permissive mode
Date: Mon, 14 Dec 2009 10:45:37 -0500
Cc: selinux@tycho.nsa.gov, russell@coker.com.au, amworsley@gmail.com
References: <20091211214213.5420.59860.stgit@flek.lan> <1260568759.26597.163.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1260568759.26597.163.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200912141045.37293.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 11 December 2009 04:59:19 pm Stephen Smalley wrote:
> On Fri, 2009-12-11 at 16:42 -0500, Paul Moore wrote:
> > It is possible security_compute_av() to return -EINVAL, even when in
> > permissive mode, due to unknown object classes.  This patch fixes this by
> > first checking to see if SELinux is in permissive mode or if the subject
> > is a permissive domain, if either of these are true then
> > security_compute_av() ignores the unknown class error and allows the
> > operation to proceed.
> >
> > Andrew: I've tested this patch to ensure it boots and does not regress my
> > Fedora/Rawhide system but since I don't have a Debian system handy I'm
> > not able to verify that this fixes your problem; could you please test
> > this patch and report back?
> >
> > Reported-by: Andrew Worsley <amworsley@gmail.com>
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
> > ---
> >  security/selinux/ss/services.c |   21 +++++++++++++++------
> >  1 files changed, 15 insertions(+), 6 deletions(-)

...

> Can we simplify this at all?  For example, I don't really think
> sidtab_search() can ever fail anymore (it falls back to the unlabeled
> SID, which has to be defined by the initial policy load).  I also think
> we could just clear avd->allowed and return 0 rather than returning
> -EINVAL in this case so that the existing avc_has_perm() logic would
> proceed and check permissive mode on its own.  We likely should also
> move the permissive map test earlier so that it always get applied
> unconditionally.

Sure, I just wanted to get something out sooner rather than later in case this 
turned out to be something which affected a large number of users and we 
needed a quick patch for -stable.  I'll admit it ain't pretty but it should at 
least work in a pinch.

Give me a bit and let me see if I can make it less ugly.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
