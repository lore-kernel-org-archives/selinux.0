Subject: Re: PATCH: peersid capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: "Todd C. Miller" <tmiller@tresys.com>, selinux@tycho.nsa.gov,
        jbrindle@tresys.com
In-Reply-To: <200712041426.09866.paul.moore@hp.com>
References: <200712031941.lB3Jf7PK008934@cadmus.columbia.tresys.com>
	 <200712041426.09866.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 15:18:43 -0500
Message-Id: <1196799523.7491.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-04 at 14:26 -0500, Paul Moore wrote:
> On Monday 03 December 2007 2:41:07 pm Todd C. Miller wrote:
> > > Stephen Smalley wrote:
> > > Looks like the libsepol patch puts the policycaps ebitmap at a different
> > > location in the policy image than the kernel patch expects.
> >
> > I had initially changed the ebitmap reading/writing location from
> > where Josh had it to work around an issue with semodule.  This version
> > preserves the location in the final policy binary without confusing
> > sepol_module_package_info().
> 
> Okay, well that at least loaded my simple test policy but it didn't appear to 
> have any effect on /selinux/policy_capabilities/network_peer_controls.  This 
> may be a problem with the kernel patch but before I started digging around I 
> thought I would first check with you on the correct policy syntax.
> 
> I'm using a Rawhide targeted policy and I'm loading a simple policy module 
> with the following statements:
> 
>  policy_module(peer_test,0.0.1)
>  policycap network_peer_controls;
>  type peer_test_t;
> 
> It compiles (using /usr/share/selinux/devel/Makefile) and loads (semodule -i 
> peer_test.pp) but I'm not certain I haven't messed something up.  Thoughts?

It would be nice if dismod/dispol could display the capabilities of a
given module / kernel policy file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
