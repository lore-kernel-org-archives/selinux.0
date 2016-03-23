Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2NHwLbc008485
 for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2016 13:58:21 -0400
Received: by mail-wm0-f48.google.com with SMTP id l68so244205134wml.0
 for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2016 10:58:19 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id fv6sm3696171wjc.12.2016.03.23.10.58.17
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 23 Mar 2016 10:58:17 -0700 (PDT)
To: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Subject: strange pam_selinux behavior
Message-ID: <56F2D938.8030909@gmail.com>
Date: Wed, 23 Mar 2016 18:58:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


With DSSP (the mcs policy model) in Fedora i have to modify
/etc/pam.d/sshd to allow users to login with SSHD

Fedora ships with:

session    required     pam_selinux.so open env_params

I suspect that this "env_params" option is used to allow users to
specify the role/level to login with (ssh joe/bla.role/s0:c232@localhost
)

However the env_param option confuses pam_selinux with DSSP, and does
not allow the user to login (if i remove "env_params" then users login
just fine):

> ssh kcinimod@localhost Unable to get valid context for kcinimod

> Mar 23 18:52:38 void sshd[19512]: pam_selinux(sshd:session): Open
> Session Mar 23 18:52:38 void sshd[19512]:
> pam_selinux(sshd:session): Username= kcinimod SELinux User=
> wheel.id Level= s0-s0:c0.c1023 Mar 23 18:52:38 void sshd[19512]:
> pam_selinux(sshd:session): Selected Security Context
> wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 Mar 23 18:52:38 void
> audit[19512]: USER_ROLE_CHANGE pid=19512 uid=0 auid=1000 ses=14
> subj=sys.id:sys.role:sshd.sshd.subj:s0 msg='pam:
> default-context=wheel.id:wheel.role: wheel.subj:s0-s0:c0.c1023
> selected-context=wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023
> exe="/usr/sbin/sshd" hostname=::1 addr=::1 terminal=ssh
> res=failed' Mar 23 18:52:38 void sshd[19512]:
> pam_selinux(sshd:session): Failed to translate security class
> context. Invalid argument Mar 23 18:52:38 void sshd[19512]:
> pam_selinux(sshd:session): Security context
> wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 is not allowed for
> wheel.id:wheel.role:wheel.s ubj:s0-s0:c0.c1023 Mar 23 18:52:38 void
> sshd[19512]: pam_selinux(sshd:session): Unable to get valid context
> for kcinimod


This seems to be the code:

> /* we have to check that this user is allowed to go into the range
> they have specified ... role is tied to an seuser, so that'll be
> checked at setexeccon time */ if (mls_enabled &&
> !mls_range_allowed(pamh, defaultcon, newcon, debug)) { 
> pam_syslog(pamh, LOG_NOTICE, "Security context %s is not allowed
> for %s", defaultcon, newcon);
> 
> goto fail_set;

So what is going on here? What breaks "env_params". Without
"env_params" i can login just fine

Also note this line:

> pam_selinux(sshd:session): Security context
> wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 is not allowed for
> wheel.id:wheel.role:wheel.s ubj:s0-s0:c0.c1023

That does not make sense to me

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW8tk0AAoJECV0jlU3+Udp+wgL/2inFtBIsQ/Wb0cIeID8lo4a
TQPRtfYeLShDbSWn7Bf2dERrk3xRmI0W7ER83OXazduroTIpHi4o5L1ORhSbAc0z
13DVCzxR+8OfuVywmiqftJpthuJ+Gwh9xXmiy0BGwCBngHVeoBRS4UDTKoe2/VkZ
ZiDewHNMAwsw5bR5c5wbUQxW+VGn1JWjxasJPSC8MfXZTXfPZbD1/4/wyyT76u79
KnooJGtiUX0fiAODmV9rHDfuGXPJxqQkwrG3Abxf0utGuJhLxrHCDxKWAFKioVf4
lRnMU3sA5PFbq+MliSbhg693CTIyjMr6Np+8ezHsbkBFMxiSKBb7hDv+E8bTKG6e
hfVkdFSwmy7Gwv/tC6dBb6DIzexESRofORQmws8jrOdKfTI4LNFK6RLMEJJeBzox
0PNoD8eqKayXiPwGQwwWfBSfP7x3Q8giDglBQZeNNg94GyGHVlCDC4WHB6MXGm3/
Zuz7tFktBA8mjKVWi/Wzh+630KL5WERMd9VfJL/ZMw==
=ddJD
-----END PGP SIGNATURE-----
