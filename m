Subject: Re: does mv need a --context=CTX (-Z) option, too?
From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Jim Meyering <jim@meyering.net>, selinux@tycho.nsa.gov
In-Reply-To: <1155218058.1123.301.camel@moss-spartans.epoch.ncsc.mil>
References: <87hd0kc308.fsf@rho.meyering.net>
	 <1155218058.1123.301.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eNCAvf8eNsBGIqSswBw/"
Date: Thu, 10 Aug 2006 12:18:46 -0400
Message-Id: <1155226726.2496.14.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-eNCAvf8eNsBGIqSswBw/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-08-10 at 09:54 -0400, Stephen Smalley wrote:

> Now, as far as preserving fscreate across execve goes, doing that in the
> case where there is no change in the current context of the task is
> conceivable (so no implications for letting the caller influence the
> program), although it would be a change in behavior that has been
> present for quite some time (and seems rather late to make it into e.g.
> RHEL5 or FC6).  I have no strong opinion on that, but it could introduce
> unexpected behaviors; some programs today might be setting fscreate and
> exec'ing helpers while not expecting the helpers to pick up that
> fscreate context.

 What about dynamic domain transitions? Eg.

task_A =3D *:foo_t
task_A calls setfscreatecon(*:bad_t)
fork() =3D task_B
  task_B =3D *:foo_t
  task_B calls setcon(*:bar_t)
  task_B creates file

--=20
James Antill <jantill@redhat.com>

--=-eNCAvf8eNsBGIqSswBw/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE21xm11eXTEMrxtQRApKTAKCQtmIJDF3edZwAIk6WLYJKnnDCMgCcCkX3
cTr6CwmP4V0QSVi83FXfiO4=
=5IIM
-----END PGP SIGNATURE-----

--=-eNCAvf8eNsBGIqSswBw/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
