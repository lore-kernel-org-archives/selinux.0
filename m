Subject: Re: analysing optional policy
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4CF52A19.6070704@gmail.com>
References: <201011262055.01924.russell@coker.com.au>
	 <1291131374.1328.25.camel@moss-lions.epoch.ncsc.mil>
	 <4CF52A19.6070704@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Nov 2010 13:11:46 -0500
Message-ID: <1291140706.1328.47.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-11-30 at 17:45 +0100, Dominick Grift wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/30/2010 04:36 PM, James Carter wrote:
> > On Fri, 2010-11-26 at 20:55 +1100, Russell Coker wrote:
> >> I'm having a problem with optional policy not being used when I think it 
> >> should.
> >>
> >> Is it possible to use apol to get information on optional policy for .pp files 
> >> so I can try to work out why it doesn't get enabled?
> >>
> >>                 unconfined_run_to(depmod_t, depmod_exec_t)
> >>
> >> In the Debian policy I have the above in an optional section of base.pp but 
> >> for reasons that I don't understand it's not being loaded (both tests and 
> >> running apol on policy.24 show this).
> >>
> >> I've inspected the contents of base.conf and they appear to be OK.
> >>
> >> Any suggestions of other tools to analyse this will be appreciated.
> 
> This may not be applicable here but do double check the module. I have
> experienced similar issues where optional policy blocks were not loaded,
> without any errors shown.

Not being defined is not an error in an optional block, it just means
the optional block is not to be used.

It is expected that there will be a lot of unused optional blocks if
only some modules are being used.  Reporting everything not defined
would not be helpful in this case.

This behavior of silently removing optional blocks can, however, cause
real errors to be missed.

>  I remember once requiring a type that did not
> exist. Compiler did not complain but some particular policy was not loaded.
> 
> When this happens to me, i check syntax of all policy, check that all
> used types exist and that there are no typos in types and other policy
> in the particular module (in this case modutils and or unconfined). In
> my erperience it is usually due to a syntax error or some other error in
> the module.
> 
> Other issues i have had with optional policy is for example attributes
> not being within scope or incorrectly nesting of optional policy.
> 
> But, i believe in both latter cases, the compiler or installer will
> complain about duplicate declaration or not within scope.
> 
> So in my experience, i suspect there is an error in your policy that the
> compiler did not catch.
> 
> What may help troubleshoot your issue is to try compiling and loading
> the policy without the optional tags. In some cases that may expose
> things errors.
> 
> These issues suck and can take ages to track down. The compiler is often
> not very helpful in these instances either.
> 
> Basically all you can do is keep checking the involved modules for any
> errors i believe.
> 
> I have been fighting with optional policy for quite some time, and i
> have blamed optional policy for a lot of things. But since i figured out
> how it works and how to nest optional policy i found out that it
> actually makes sense. It can be complicated but usually not with
> confining the system layer. When confining the user space, then nesting
> optional policy becomes a big issue.
> 
> > 
> > Is this with the policy found in
> > selinux-policy-src_0.2.20100524-4_all.deb?  I don't see
> > unconfined_run_to being used in that policy.
> > 
> > It looks like modutils is part of base, so depmod_t and depmod_exec_t
> > should be defined.  But there is a requires statement at the top of
> > modutils for "bool secure_mode_insmod".  Is secure_mode_insmod in the
> > policy?
> > 
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.16 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAkz1KhkACgkQMlxVo39jgT/yBgCcC0kTlimf8OvIgOYGZgzJftWW
> 9DcAn3fUPqRPaMGrsrq+00EvJ9JZ8eSK
> =atLW
> -----END PGP SIGNATURE-----
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
