Subject: Re: [PATCH 0/2] new and improved range_transition statements
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <200607311428.k6VESR6m004599@turing-police.cc.vt.edu>
References: <44CA2919.4010708@trustedcs.com>
	 <1154351236.26550.14.camel@localhost.localdomain>
	 <1154354184.1447.23.camel@moss-spartans.epoch.ncsc.mil>
	 <200607311428.k6VESR6m004599@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 10:43:15 -0400
Message-Id: <1154356995.1447.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-31 at 10:28 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 31 Jul 2006 09:56:24 EDT, Stephen Smalley said:
> > On Mon, 2006-07-31 at 09:07 -0400, Karl MacMillan wrote:
> > > My biggest question is how to handle the format change. There are some
> > > other bug fixes awaiting a module format change (not certain about
> > > kernel format change) and it would be nice to include those in this
> > > format bump. Unfortunately there are not patches for those fixes at the
> > > moment.
> > > 
> > > Could we branch the code for a month or so for the other changes can be
> > > introduced or is the fix more critical? Do you think that this must go
> > > into RHEL 5 / FC6? Is it possible for the kernel changes to make it in
> > > time for 2.6.18 and if they don't will this be included in RHEL 5 / FC6?
> > 
> > It doesn't necessarily have to be in 2.6.18 to make RHEL5; consider the
> > MLSXFRM and NetLabel patches, which are being queued for 2.6.19 but IIUC
> > will be back ported and included in RHEL5.
> 
> 2.6.18-rc3 just came out - I suspect that a patch that modifies an
> external module format won't be looked upon kindly for inclusion in .18.
> Looks like "submit for the .19 merge window and backport for RHEL5" will
> be the way to go. (Looks like FC6 will be in the same category, AFAICT).

I agree that it is too late for 2.6.18, but just to clarify - the kernel
patch preserves backward compatibility for older binary policy
formats.  

As far as compatibility is concerned, FC4 will need some kind of
userland update when it updates to a kernel with the new policy format;
otherwise, init will give up when it cannot find policy.21 or policy.20
(older sysvinit selinux patch only tried n and (n-1)), and the policy in
FC4 was version 19.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
