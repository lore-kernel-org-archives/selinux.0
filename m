Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MJCTdW025143
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 14:12:29 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MJ7nMK027671
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 19:07:49 GMT
Subject: Re: [RFC][PATCH] Pass requested protection to
	security_file_mmap/mprotect hooks
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Daniel J Walsh <dwalsh@redhat.com>,
   lsm <linux-security-module@wirex.com>, Chris Wright <chrisw@osdl.org>,
   selinux@tycho.nsa.gov
In-Reply-To: <1109097979.15893.52.camel@moss-spartans.epoch.ncsc.mil>
References: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil>
	 <1109097647.3858.14.camel@nexus.verbum.private>
	 <1109097979.15893.52.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BjZRY9Wphy4wbNTFfjPb"
Date: Tue, 22 Feb 2005 14:10:09 -0500
Message-Id: <1109099410.3858.23.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BjZRY9Wphy4wbNTFfjPb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-02-22 at 13:46 -0500, Stephen Smalley wrote:
>On Tue, 2005-02-22 at 13:40 -0500, Colin Walters wrote:
>> One thing I wonder is if there's any other issues tied to legacy
>> binaries that would possibly make sense to control via this interface.
>> checkreqprot is a fairly specific name; You had suggested legacycompat
>> earlier?
>
>As is, the patch won't affect any execute-related checking that is
>requested by the application, and that includes anything requested by
>ld.so.  Hence, for example, running gpg on a FC3 system still triggers
>an execmod check against the gpg binary but no longer triggers various
>other execute-related checks that were being caused by the read-implies-
>exec logic in the kernel.=20

But we have already worked around the gpg (and other) issues by enabling
the unconfined_t execmod/execmem booleans by default, no?

>As is, the patch allows you to set /selinux/checkreqprot (if you have
>appropriate permission), so /sbin/init or an init script could easily
>initialize it to some default.  But I was wondering whether the original
>compiled-in value should be a kernel config option, similar to the
>bootparam default, so that a vendor can set the initial value as desired
>depending on their preference, without requiring any customization by
>init or an init script at all.

=46rom your patch, it looks like the default is to have it disabled.  I do
feel that for Fedora we will want it enabled by default, so providing a
kernel build option for it is useful; the fewer magic things are in the
init scripts, the better.



--=-BjZRY9Wphy4wbNTFfjPb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCG4OROIkJWWp2WGURAss3AJ98wmQUkPtz1qDmfg13nBOldg1YJwCfaSG0
ldd9Ru5VJ2a6XKjMwygu9tc=
=Giq+
-----END PGP SIGNATURE-----

--=-BjZRY9Wphy4wbNTFfjPb--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
