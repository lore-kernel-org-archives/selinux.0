From: Paul Moore <paul.moore@hp.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
Date: Mon, 4 Jun 2007 15:28:16 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov
References: <C32347D4-3E32-4741-B847-6826EED3BB7A@nall.com> <4661ACEF.3000801@kaigai.gr.jp> <1180966620.14220.57.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1180966620.14220.57.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706041528.16505.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, June 4 2007 10:17:00 am Stephen Smalley wrote:
> On Sun, 2007-06-03 at 02:46 +0900, KaiGai Kohei wrote:
> > Stephen Smalley wrote:
> > > On Thu, 2007-05-31 at 10:58 -0500, Joe Nall wrote:
> > >> I would like to label an ethernet interface so that all of the
> > >> inbound connections are labeled with a range.
> > >>
> > >> semanage interface -a -t netif_t --range S-S eth1
> > >>
> > >> succeeds, but getpeercon fails with "Protocol not available"
> > >>
> > >> Is there any way to do this with what is in evaluation?
> > >
> > > getpeercon() only returns a context if a labeled networking mechanism
> > > was used; we don't implicitly convey the netif label or secmark label
> > > to it.  So if you want a default labeling behavior, that has to be done
> > > in your application, e.g. the application would fall back to some
> > > default if getpeercon() failed.
> >
> > Stephen,
> >
> > How do you think necessity for generic fall back behavior in the case
> > when getpeercon() failed?
>
> I think it would be useful.  There was some discussion of it during the
> labeled networking discussions, but directly returning the secmark label
> or the netif/netmsg labels was viewed as problematic because they aren't
> peer/process contexts.

Just a heads-up, I hope to start working some patches for this in a few weeks 
time.  The basic idea is to assign fallback contexts to interfaces and/or 
network addresses that would be used as the external packet label when one 
was not present.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
