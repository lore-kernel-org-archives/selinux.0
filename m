Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2UCb0fX014441
 for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2015 08:37:11 -0400
Received: by wgbdm7 with SMTP id dm7so66797861wgb.1
 for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2015 05:37:08 -0700 (PDT)
Received: from localhost.localdomain (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id r14sm15538135wiv.13.2015.03.30.05.37.08
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2015 05:37:08 -0700 (PDT)
Date: Mon, 30 Mar 2015 14:37:06 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Policy Constraints
Message-ID: <20150330123706.GA9321@localhost.localdomain>
References: <1427230458-23667-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhSLgS4pDE3488A7Xm1eqDXnX0R3wFsVSjfxB04ynQzEVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CAHC9VhSLgS4pDE3488A7Xm1eqDXnX0R3wFsVSjfxB04ynQzEVA@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I vaguely recall me touching on the following before. I forgot what, if any, outcome there was. Consider the following:

I have a constraint like this:

        (constrain (process (sigchld sigkill sigstop signull signal ptrace
            getsched setsched getsession getpgid setpgid getcap setcap
            share getattr setrlimit))
            (or (or (or (or (or (eq u1 u2)
                (eq u1 system_u))
                (eq u1 staff_u))
                (eq u1 sysadm_u))
                (eq u2 system_u))
                (neq t1 ubac_constrained_subject_type)))

The sysadm_u and staff_u identities are supposed to be optional and so I change the above to this:

        (constrain (process (sigchld sigkill sigstop signull signal ptrace
            getsched setsched getsession getpgid setpgid getcap setcap
            share getattr setrlimit))
            (or (or (or (eq u1 u2)
                (eq u1 system_u))
                (eq u2 system_u))
                (neq t1 ubac_constrained_subject_type)))

        (optional staff
            (constrain (process (sigchld sigkill sigstop signull signal ptrace
                getsched setsched getsession getpgid setpgid getcap setcap
                share getattr setrlimit))
                    (eq u1 staff_u)))

        (optional sysadm
            (constrain (process (sigchld sigkill sigstop signull signal ptrace
                getsched setsched getsession getpgid setpgid getcap setcap
                share getattr setrlimit))
                    (eq u1 sysadm_u)))

The above builds and seinfo shows the three blocks, but for some reason it is not honored. Eg. The First example works but the latter does not.

Is this a known issue , or known limitation? Should this work?

We have roleattributes, typeattributes but not identityattributes. Identityattributes would help with this requirement.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVGUNuAAoJENAR6kfG5xmcfxEL/3mgmy0hi8adTQWy2UCe7X56
zSSXevDMeLD0uFPYH8hi0K74eKEKsp8MlzwT/zHq7w/h47vzLKmc5Ywt8FEttsLu
9Huc8/78ByiK4k2TA9iC6k6F7lYUYUBzoEdE3+qjXKTmQCrN5PelriOVyMXJycKA
Hy3iR1ytoVPFIYz+gxBGEojjr2FXvCyWypU+byoyeZ6qiJatYtSSl0IpGC4MRSOQ
xx3gIUxf7kpS+yHCdvhPX5GgCnl1orosdV0RfAJMyb7XtlEufO4g/PCUqY2wv7Ei
hRA4mJeG698mmkqtDo+O7+mfDDwWyxlYIa5m2S1NjtnHOXk8KLmb6iL9V9hcRFDB
Iz4oN32EJu0WVNgbQUze41uR5bKpVLu8KqVAF0DKLnzmQGdq5O0RYbDAjkDaqV02
twarkO4v+JH0AOvjE1mWluDyjkOwWHxn1aLPUVS3BkPwgNof9e8zrA5BBwZWbVRV
LKJQ2ZjFGQfk6fMH4fjVQ0iixwvxKDWNeLeyQ4AoXg==
=Dfox
-----END PGP SIGNATURE-----
