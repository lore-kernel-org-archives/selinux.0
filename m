Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3OIwwI4009919
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 14:59:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3OIwv7R000012
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 18:58:57 GMT
Received: from hoss.orcus.priv.at (chello080110242202.117.11.tuwien.teleweb.at [80.110.242.202])
        by jazzband.ncsc.mil  with ESMTP id h3OIwtKP029999 for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 18:58:56 GMT
To: selinux@tycho.nsa.gov
Subject: role orthogonality
From: Robert Bihlmeyer <robbe@orcus.priv.at>
Date: 20 Apr 2003 10:51:14 +0200
Message-ID: <87ist9eem5.fsf@orcus.priv.at>
MIME-Version: 1.0
content-Type: multipart/signed; boundary="----------=_1051210641-1305-0"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
It has been signed conforming to RFC3156.
You need GPG or PGP to check the signature.

------------=_1051210641-1305-0
Content-Type: text/plain; charset=us-ascii

One thing that I still poorly understand is the interaction between
types and roles.

Am I right that roles are only relevant when transitioning, and not
during normal type enforcement?

It seems to me that we often want to break that orthogonality, so we
encode the role in the type (e.g. sysadm_tty_device_t vs
user_tty_device_t). I find this ugly, boring and repetitive -- exactly
the kind of thing that computers should shield us from. Wouldn't it be
possible to make the policy language grok these desires? Out of my
hat:

    rtype foo_t, domain;
    type foo_etc_t, file_type;
    rtype foo_files_t, file_type;

    allow foo_t self:process signal;
    allow foo_t foo_etc_t:file r_file_perms;
    allow foo_t foo_files_t:file rw_file_perms;

This is supposed to mean that foo_t and foo_files_t exist seperately
for every role, while there is only one foo_etc_t. Or you can think of
foo_t and foo_files_t having "hard" boundaries between roles.

So in this scenario user_r:foo_t may signal user_r:foo_t, but not
sysadm_r:foo_t; user_r:foo_files_t [1] may only be read/written by
user_r:foo_t, not sysadm_r:foo_t; but foo_etc_t can be read by foo_t
under any role.

It's probably desirable to allow more detailed specification as well:
    allow sysadm_r:foo_t user_r:foo_files_t:file rw_file_perms;
meaning that sysadm_r can access user_r's foo_files as well. (Yes we
run into colon overload problems here.)

Now, what's wrong with this naive proposal?


[1] Files would need to be able to hold roles, then.

-- 
Robbe

------------=_1051210641-1305-0
Content-Type: application/pgp-signature
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+qDPj8g21h7wYWrMRAmPcAJ9oUvDAOn/3y0cXCEgOv1aOpy8E3gCePYmk
sT/CZ7qa5ZiftR3wl3dizC4=
=Iwje
-----END PGP SIGNATURE-----

------------=_1051210641-1305-0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
