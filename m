Message-ID: <41A82372.9040308@gentoo.org>
Date: Sat, 27 Nov 2004 08:49:22 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
CC: Valdis.Kletnieks@vt.edu
Subject: Re: Still getting random execute permissions on shared libraries.
References: <41A3EC21.1090200@comcast.net> <1101303008.22014.47.camel@moss-spartans.epoch.ncsc.mil>            <41A788C2.9060609@gentoo.org> <200411262244.iAQMiLvE007647@turing-police.cc.vt.edu>
In-Reply-To: <200411262244.iAQMiLvE007647@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig13C8FDA4FA1A790924B32ADD"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig13C8FDA4FA1A790924B32ADD
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Valdis.Kletnieks@vt.edu wrote:
> On Fri, 26 Nov 2004 21:49:22 +0200, petre rodan said:
>>I made a patch to the kernel that reverts to the old behaviour. no more execs on random files.
>>I find that changing the policy to allow those execs is not a valid solution.
> 
> Why is fixing the policy not a valid solution?

I happen to use some proprietary software (think antiviruses, file integrity checkers, audit programs) that would have needed massive changes in the policy because of those execs.
it might take some time until those will be recompiled with a newer toolchain.

>>would it be feasible to send upstream a patch that would remove the 'exec on 
>>read' behaviour if the kernel has selinux capabilities?
> A Very Bad Idea.  Basically, you're disabling a good and reasonable security
> measure entirely, just because you can't get it to work with a *legacy* binary
> and another security measure..

those security measures were added somewhere in the rc stage of 2.6.9, a kernel that was badly needed because of the flaws it was fixing.
I needed a way to replicate the behavior of older kernels in order to keep the sanity of the system, so that patch seemed a quick solution (call it as you wish).
I agree now that it shouldn't be sent upstream, but if someone feels the need to solve <subj>, then it patching time :)

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enig13C8FDA4FA1A790924B32ADD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBqCN8GSBEIeh4AEYRAuXNAJ4r+3y0ocW6vbWcEYDqdZhNif+RUQCeLswA
lYW9kVQ0f7uHC2gFAMkjAAc=
=kWAk
-----END PGP SIGNATURE-----

--------------enig13C8FDA4FA1A790924B32ADD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
