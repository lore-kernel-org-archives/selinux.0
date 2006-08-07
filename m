Subject: Re: [PATCH 0/2] new and improved range_transition statements
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Valdis.Kletnieks@vt.edu, James Morris <jmorris@namei.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1154697573.3919.18.camel@moss-spartans.epoch.ncsc.mil>
References: <44CA2919.4010708@trustedcs.com>
	 <1154351236.26550.14.camel@localhost.localdomain>
	 <1154354184.1447.23.camel@moss-spartans.epoch.ncsc.mil>
	 <200607311428.k6VESR6m004599@turing-police.cc.vt.edu>
	 <1154356995.1447.64.camel@moss-spartans.epoch.ncsc.mil>
	 <200607311510.k6VFAhrw006155@turing-police.cc.vt.edu>
	 <1154697573.3919.18.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 10:34:26 -0400
Message-Id: <1154961267.31522.237.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-08-04 at 09:19 -0400, Stephen Smalley wrote:
> On Mon, 2006-07-31 at 11:10 -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Mon, 31 Jul 2006 10:43:15 EDT, Stephen Smalley said:
> > 
> > > I agree that it is too late for 2.6.18, but just to clarify - the kernel
> > > patch preserves backward compatibility for older binary policy
> > > formats.  
> > > 
> > > As far as compatibility is concerned, FC4 will need some kind of
> > > userland update when it updates to a kernel with the new policy format;
> > > otherwise, init will give up when it cannot find policy.21 or policy.20
> > > (older sysvinit selinux patch only tried n and (n-1)), and the policy in
> > > FC4 was version 19.

> After a bit of discussion (see bug 201242 in the redhat bugzilla) about
> updating FC4 userland, it seems that we should try to address this
> compatibility concern for legacy userland in the kernel.  We could first
> upstream the patch below, then re-base the range_transition kernel patch
> against it.  This patch makes the maximum policy version a kernel config
> option so that it can be adjusted down to accommodate legacy userland,
> with instructions and examples in the help text of the config option on
> how to determine what value to use.  The range_transition kernel patch
> would then adjust the "range" and "default" attributes of this new
> config option to reflect the new version support, while users could
> still build kernels to an older version.  Thoughts?

My feeling is that this is optimized for the wrong case.  Since the
current userland has known how to auto downgrade for a while, no one
will actually need this option unless they're building a kernel for for
FC3 or 4, so the common case would be not to override the max version,
especially as time progresses and FC3 and 4 become no longer maintained.
Also, people that compile their kernel, and use `make oldconfig` won't
know they need to update their max version in their config when the
policydb version increases.  My suggestion is to have this as an option,
so that if needed the max version can be overridden.  Then if the option
is off, it uses the actual max version.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
