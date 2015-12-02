Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB2AI8B6013180
 for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2015 05:18:08 -0500
Received: by wmec201 with SMTP id c201so245631379wme.0
 for <selinux@tycho.nsa.gov>; Wed, 02 Dec 2015 02:18:04 -0800 (PST)
Received: from x250 ([84.245.63.179])
 by smtp.gmail.com with ESMTPSA id c13sm29940244wmd.14.2015.12.02.02.18.03
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 02 Dec 2015 02:18:03 -0800 (PST)
Date: Wed, 2 Dec 2015 11:18:01 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: continuation of systemd/SELinux discussion from Github
Message-ID: <20151202101801.GA1028@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Let's continue the discussion here.

The last answered questionnaire is below, any further questions or
comments?:

- ----------------------------------------

        "systemd --user" concept is broken as we can see/read from this
        thread from SELinux point of view.

It was working fine except that it was trying to log to the audit system
which unprivileged processes arent allowed to do.

        Are we able truly explain the enforcement here?

I think i was able to at least identify some of it, but i probably have
overlooked other compelling arguments:

Any processes that needs to be able to "control" any system-wide systemd
user unit, will be able to "control" all system-wide systemd user units.

In practice that means that a process may be able to for example start a
application even though it does not have access to execute that
application by telling systemd --user do start that applications on its
behalf

A process may, for example, be able to use this to stop a sensitive
process bypassing SELinux access control

        And the point is if we have big benefits of this level of
        isolation?

With access control the benefits often depend on the requirements. but
in general since selinux touts flexibility and one of the big benefits
here is that we can contain access of processes to units actions.

without this processes are potentially able to bypass selinux by telling
systemd --user to do stuff on their behalf

        Do we have real examples how it prevents possible security
        flaws?

No, and why should we? SELinux does not prevent possible security
flaws. SELinux is Linux access control extension
It enforces integrity and optional confidentiality or
comparmentalization.

        Do we talk about confined desktop here?

No we are talking about a set of components that without SELinux access
control extension potentionally allows processes
to bypass SELinux access control restrictions in some cases

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWXsVVAAoJENAR6kfG5xmcDvAMAMlHsXmvuSY3o9PTzoM51xek
TLlg8dGB6jtlj6Yz7bqVacObaHRf7OF6meO3+/58Khq1xLVx0dUxR9HrX+ZqbIpd
eI6NSJ+waSKm1dqRI6BFg4QOMNXoTXQcmijWNHoiduT2OXY0LpKuZtC1u0DJddx/
rl6auNwCD7+sqpQMXTYlnutNzBCJ9wVhq8p4rsP0gs5VoSMjTW+PphRkfpIkPGFA
cRO55BhTXXk2wp85ONhjJIvHjNP9Tky3tpH7ULPlqeyyG8BM+sKWtOdDdF1kqNjN
MmuvA9F+fBEl2sOvBxBKVgtfTEPzeaqFmn4o0Su/A9ckM90ic2VFNHHXXqIdQJ8e
Sqi30bG1G7avQf2ZbDCMhUBwE9uyigg99EXVyV/X6NDhYvURZa90vC9UizXhnbLz
6oBkELyk1wt7/Qhqh4XH7nUD7i+G0my4rcgslFE1Qa1aGy8Xrj19xBvD53Z0de3l
QFkDsKDQQelb5McEMPiGvpNIjgGTnt/H5opwqWMnKA==
=/yJI
-----END PGP SIGNATURE-----
