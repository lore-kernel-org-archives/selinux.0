Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8NLCJTU004251
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 17:12:21 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8NLCKJp002414
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 21:12:20 GMT
Message-ID: <1316812338.2487.77.camel@vortex>
Subject: Re: [refpolicy] pam_selinux(gdm-password:session): Security Context
 justin:staff_r:insmod_t:s0 Assigned
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@parisplace.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Date: Fri, 23 Sep 2011 23:12:18 +0200
In-Reply-To: <CACLa4pvtTeTq3LdY7vgFexDXXxk8ZYU5yBQRQexTyghkoL7B1w@mail.gmail.com>
References: <1316144432.85313.YahooMailNeo@web114304.mail.gq1.yahoo.com>
	 <4E736453.8000506@redhat.com> <4E7369AF.3000709@yahoo.com>
	 <4E737223.1060601@redhat.com> <1316795427.12007.110.camel@vortex>
	 <4E7CC41E.5040004@redhat.com> <1316804960.2487.62.camel@vortex>
	 <CACLa4pvtTeTq3LdY7vgFexDXXxk8ZYU5yBQRQexTyghkoL7B1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-09-23 at 16:45 -0400, Eric Paris wrote:
> On Fri, Sep 23, 2011 at 3:09 PM, Guido Trentalancia
> <guido@trentalancia.com> wrote:
> > On Fri, 2011-09-23 at 13:38 -0400, Daniel J Walsh wrote:
> 
> > Yes, very good. At the end, a very polite message is not the first
> > priority in such as situation...
> >
> > But unfortunately this is not the case for the upstream bits.
> >
> > Ideally should be tackled in the SELinux kernel code. Did RHEL and
> > Fedora patch the kernel then to achieve that ?
> 
> No we consider init to be part of the trusted base required to load
> policy.  The Fedora init (systemd not, but it's been old init, some
> scripts in the initramfs, and who know what else) tries to load policy
> and if it can't and it was supposed to be enforcing will either print
> and error and halt for a really long time and then exit, or exit
> directly.  init exiting is enough to make the kernel panic and thus
> shut down the box.
> 
> The tool that is trusted to load the policy is what needs to make this check.

What really confuses me at this point is the fact that within this
specific thread, Justin said that he was using Fedora (F15 as far as I
remember).

Anyway, apart from the specific case, it remains the fact that the
upstream SELinux + reference policy combo does allow the system to keep
running (in the wrong context, i.e. kernel_t or insmod_t) despite init
has not transitioned to its context after initial stage. I am not
particularly keen on this behavior.

You seem to suggest that load_policy -i (and not the kernel) should make
sure that init has transitioned to its designated context... So then,
getting back to the specific case at hand, my question becomes: "did
Fedora and RHEL patch the upstream load_policy tool to achieve this
halt-on-init-failure behavior ?". In any case, how comes this check
didn't work on Justin's system ?

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
