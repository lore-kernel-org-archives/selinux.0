Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q23DQfG2027360
	for <selinux@tycho.nsa.gov>; Sat, 3 Mar 2012 08:26:41 -0500
Message-ID: <4F521BD4.70104@redhat.com>
Date: Sat, 03 Mar 2012 08:25:40 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Kyle Moffett <kyle@moffetthome.net>
CC: selinux@tycho.nsa.gov
Subject: Re: Performance optimization of libsepol and the need for detailed
 policydb docs.
References: <CAGZ=bqKEXNiRp_4YZaTvYEm6JhhAdk0LunwYbgWtuMKWPPAiiA@mail.gmail.com>
In-Reply-To: <CAGZ=bqKEXNiRp_4YZaTvYEm6JhhAdk0LunwYbgWtuMKWPPAiiA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/03/2012 01:05 AM, Kyle Moffett wrote:
> Hello,
> 
> I'm dissatisfied with some of the performance characteristics of
> the current policydb code for linking policy modules into a
> composite binary policy, and I would like to try to make some
> improvements to that.  In particular, I would like to make it
> reasonably possible to frequently relink and reload the binary
> policy on a very granular basis.  Unfortunately the new policy
> language does not help with this right now because it still seems
> to be translated into the old policy language for compiling.
> 
> For example, I'm interested in the idea of shipping a policy
> module (including interfaces) in each Debian package, so that the
> policy is loaded as part of preinst before the package manager
> begins configuring the package or putting files onto the system and
> unloaded after the package has been purged.
> 
> Another possibility would be a "network policy" analogous to
> "Windows Domain Policy", where you have a base policy built as part
> of the OS packages and then it is automatically extended and
> configured (EG: with new policy or booleans) via a daemon
> communicating with a central policy server.  If integrated with
> PAM, NSS, cgroups, etc, you could allow centralized management and
> configuration of network-wide Mandatory Access Control.  A
> corporate network could easily enforce consistent global SELinux
> labeling of IPsec connections or similar.
> 
> In order for any of that to work, however, the incremental policy
> link time would need to be on the order of a few seconds instead of
> the current multiple-minute link-and-load time for a large
> reference policy.
> 
> In the past (with my previous employer), I participated in some 
> efforts to analyze the performance of libsepol and identified some 
> low-hanging fruit in the form of incorrectly sized hash tables (EG:
> A hash table with 2 entries has equivalent performance to a linked
> list except with a lot of extra code on the front end), but we
> never were able to polish up patches for merging.
> 
> I would like to potentially take on some of this work, but I'd
> really need to have some better documentation on the various binary
> policy formats (base policy, modules, and linked policy).  Is there
> any existing documentation or should I just start by writing some?
> 
> Cheers, Kyle Moffett
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 
Sounds great to me.  I would love it if we could fix our performance
problems and slowly get rid of booleans, and replace them with
enable/disable modules.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9SG9QACgkQrlYvE4MpobNnqgCcDnLFEI0OsJ67J41rPdYYwRdC
5YsAn1Fv+YRhdXaNXlvrFCt4ccOBkuA4
=p1w8
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
