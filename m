To: SELinux@tycho.nsa.gov
Date: Thu, 25 Apr 2002 02:29:53 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
Message-Id: <20020424182953.75A6C812DB@coffeesaur2.evoserve.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> 
> On Wed, 24 Apr 2002, Debian User wrote:
> 
> > Im getting lots of error messages when i use my pc after installing
> > selinux. How do I fix the configs? Where should i start? Are the error
> > messages enough to be able to fix my configuration?
> 
> Are you using Russell Coker's Debian selinux package or the upstream
> distribution?  If the latter, I'd suggest using the former, since the
> upstream distribution isn't set up for Debian.
> 
> There is a contributed script in the distribution, scripts/newrules.pl,
> that filters your dmesg output and generates the allow rules that would
> need to be added to your policy configuration to avoid these denials.
> However, you will typically need to review these rules carefully to
> determine whether they are truly acceptable.  In many cases, you will need
> to add new domains and/or types rather than simply adding the allow rule
> that corresponds to the audit message.  These issues are discussed briefly
> in a new report that will hopefully be available soon.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 

I just used the prel script. Now im working on the syntax. I have the two 
white papers with me. I think I need to define new types and domains.
What would possibly be the criteria for the decision? A rule of thumb if
i may say so.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8xvktT5WfhZieiQoRAicVAJ9mt8IhesuTE+Iv0mEMY17vf8Zg2ACdEeXR
USG5L3KFDPbfNAcJEVgKPkE=
=KrLp
-----END PGP SIGNATURE-----

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
