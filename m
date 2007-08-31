Message-ID: <46D82877.3070302@redhat.com>
Date: Fri, 31 Aug 2007 07:40:55 -0700
From: Ulrich Drepper <drepper@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE-Linux <selinux@tycho.nsa.gov>, Ulrich Drepper <drepper@gmail.com>
Subject: Re: use the OS functionality for reading
References: <46D495A1.20505@redhat.com> <1188506154.26572.378.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1188506154.26572.378.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> get_len is less of a concern, as it doesn't appear to be in use outside
> the library.

Good to hear but lots of hand-waving.


> The fact that set_mem can fail after this change and leave the fp NULL
> seems more troubling, as a subsequent call may use that in a call to
> next_entry and seg fault.
> 
> I'm not certain of the benefit of the change is for the input side; on
> the output side, letting the implementation handle the allocation is
> nice.

Especially the input side is susceptible to security-relevant bugs.
Maybe in the moment the code is correct.  But who knows, perhaps a
little innocent change in future might change the picture.  The best way
to handle these things is to let the runtime perform the allocation.
Also, this way the code should be faster, it doesn't have to "emit" the
policy twice.

If you're OK with removing the old interfaces since you know nobody uses
them the resulting change can lead to a nice and clean and easy to use
interface.


> The patch wasn't relative to your first one, so the private.h diff has
> to be manually applied to services.c.

RIght, I didn't write them in necessarily this sequence and I didn't
know what you will apply.  With next_entry reduced to a single fread
call the function should be inlined again.  It'll indeed be faster.  And
we don't need the next_entry macro for bound checking anymore since (at
least in very recent glibcs) fread can handle the bound checking by
itself.  Inlining is a prerequisite, though.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG2Ch32ijCOnn/RHQRAtSJAKDDjtuEZbBGrTPU0eKlYVpWur0m8QCgvs7d
QCXbi6fbBv9/DXc/6q+QefQ=
=J1yt
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
