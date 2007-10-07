Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8SGLB0D020959
	for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2009 12:21:11 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8SGKPjm007414
	for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2009 16:20:25 GMT
Message-ID: <4708CC8D.5030803@redhat.com>
Date: Sun, 07 Oct 2007 08:09:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Meyering <jim@meyering.net>
CC: selinux@tycho.nsa.gov
Subject: Re: is any use of runcon by arbitrary users valid when enforcing?
References: <87fy0n9zn3.fsf@rho.meyering.net>
In-Reply-To: <87fy0n9zn3.fsf@rho.meyering.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jim Meyering wrote:
> In a simple test of runcon for coreutils test suite, I used the following,
> but see that it's failing in an enforcing F8t3 environment:
> [from coreutils/tests/misc/runcon]
> 
>     ...
>     cat <<\EOF > exp || framework_failure
>     runcon: runcon may be used only on a SELinux kernel
>     EOF
> 
>     fail=0
> 
>     # This test works even on systems without SELinux.
>     # On such a system it fails with the above diagnostic, which is fine.
>     # Before the no-reorder change, it would have failed with a diagnostic
>     # about -j being an invalid option.
>     runcon -t unconfined_t true -j 2> out && : > exp
> 
>     compare out exp || fail=1
> 
>     (exit $fail); exit $fail
> 
> Is there any similar use of runcon that can be expected to succeed?
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
This would only work on a system that allowed the running domain to
transition to unconfined_t.  If this is an automated test, then it is
probably running in initrc_t.  So for your test environment I would load
a policy module that would allow the transition from initrc_t to
unconfined_t or any other transitions that you need.  This is what the
internel test suites at Red Hat do, to eliminate avc's caused by the
test environment.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHCMyNrlYvE4MpobMRAis2AKCXrQq5c2bi1qUlRezIKKTL5F/vtwCdGaAi
88T9O+oAHVsW0dOnnI1KT0A=
=yqe9
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
