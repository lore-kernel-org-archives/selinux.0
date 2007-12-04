From: Paul Moore <paul.moore@hp.com>
To: "Todd C. Miller" <tmiller@tresys.com>
Subject: Re: PATCH: peersid capability support
Date: Tue, 4 Dec 2007 14:26:09 -0500
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com, sds@tycho.nsa.gov
References: <200712031941.lB3Jf7PK008934@cadmus.columbia.tresys.com>
In-Reply-To: <200712031941.lB3Jf7PK008934@cadmus.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712041426.09866.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 03 December 2007 2:41:07 pm Todd C. Miller wrote:
> > Stephen Smalley wrote:
> > Looks like the libsepol patch puts the policycaps ebitmap at a different
> > location in the policy image than the kernel patch expects.
>
> I had initially changed the ebitmap reading/writing location from
> where Josh had it to work around an issue with semodule.  This version
> preserves the location in the final policy binary without confusing
> sepol_module_package_info().

Okay, well that at least loaded my simple test policy but it didn't appear to 
have any effect on /selinux/policy_capabilities/network_peer_controls.  This 
may be a problem with the kernel patch but before I started digging around I 
thought I would first check with you on the correct policy syntax.

I'm using a Rawhide targeted policy and I'm loading a simple policy module 
with the following statements:

 policy_module(peer_test,0.0.1)
 policycap network_peer_controls;
 type peer_test_t;

It compiles (using /usr/share/selinux/devel/Makefile) and loads (semodule -i 
peer_test.pp) but I'm not certain I haven't messed something up.  Thoughts?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
