Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l97728kr002654
	for <selinux@tycho.nsa.gov>; Sun, 7 Oct 2007 03:02:08 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l97727HW002413
	for <selinux@tycho.nsa.gov>; Sun, 7 Oct 2007 07:02:07 GMT
From: Jim Meyering <jim@meyering.net>
To: selinux@tycho.nsa.gov
Subject: is any use of runcon by arbitrary users valid when enforcing?
Date: Sun, 07 Oct 2007 09:01:36 +0200
Message-ID: <87fy0n9zn3.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In a simple test of runcon for coreutils test suite, I used the following,
but see that it's failing in an enforcing F8t3 environment:
[from coreutils/tests/misc/runcon]

    ...
    cat <<\EOF > exp || framework_failure
    runcon: runcon may be used only on a SELinux kernel
    EOF

    fail=0

    # This test works even on systems without SELinux.
    # On such a system it fails with the above diagnostic, which is fine.
    # Before the no-reorder change, it would have failed with a diagnostic
    # about -j being an invalid option.
    runcon -t unconfined_t true -j 2> out && : > exp

    compare out exp || fail=1

    (exit $fail); exit $fail

Is there any similar use of runcon that can be expected to succeed?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
