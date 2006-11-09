Subject: Re: [PATCH] cron changes needed for MLS range checking (requires
	at least the libselinux patches)
From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1163087868.12241.327.camel@moss-spartans.epoch.ncsc.mil>
References: <1162936978.26574.20.camel@code.and.org>
	 <1162994668.3009.82.camel@moss-spartans.epoch.ncsc.mil>
	 <1163017959.29854.12.camel@code.and.org>
	 <1163019227.12241.178.camel@moss-spartans.epoch.ncsc.mil>
	 <1163023021.29854.15.camel@code.and.org>
	 <1163023990.12241.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1163029645.29854.20.camel@code.and.org>
	 <1163084834.12241.293.camel@moss-spartans.epoch.ncsc.mil>
	 <1163086850.29854.26.camel@code.and.org>
	 <1163087868.12241.327.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XLgDjXpOvpZvMMursPnm"
Date: Thu, 09 Nov 2006 11:28:00 -0500
Message-Id: <1163089680.29854.35.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XLgDjXpOvpZvMMursPnm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-09 at 10:57 -0500, Stephen Smalley wrote:
> On Thu, 2006-11-09 at 10:40 -0500, James Antill wrote:
> >  Because without enforcing mode we just ignore the problem and continue=
,
> > with it we error out. I think this is more of a theoretical assert type
> > problem anyway, but still.
>=20
> That's my point - it seems like it is a bug regardless of whether we are
> permissive or enforcing, and should thus always return -1.  I'd only
> expect security_getenforce() to make a difference for error handling on
> permission checks.

 Well get_security_context() does the same thing if fgetfilecon(),
getseuserbyname()/get_default_context_with_level() or
cron_authorize_context() fail (which would lead to u->scontext being
NULL, AIUI), so I really wouldn't want to change it unless all those
changed in some way.

> Anyway, the patch looks sane at this point, although I'm not completely
> clear how it integrates into the existing pile of selinux-related
> patches in vixie-cron (it would help to consolidate them).

 I can't really do that, easily.

> What is your plan on the client (crontab program) side?  The old patch
> instrumented it to automatically insert a SELINUX_ROLE_TYPE=3D definition
> with the caller's context if a certain option was used to crontab; will
> you replace that with your new MLS_LEVEL=3D definition and the caller's
> current range or just drop it altogether and require the user to
> manually specify it in the crontab file?

 Atm. I've got a patch which changes the crontab command to only add the
level when -s is specified.

>   Am I correct in understanding
> that there can only be one MLS_LEVEL=3D definition per crontab file (for
> all cron jobs in that crontab)?

 Yes.

>   Can it go anywhere in the crontab file?

 Yes.

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-XLgDjXpOvpZvMMursPnm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFU1cQ11eXTEMrxtQRAj5yAJ0ZR+PSC4vNigZtBG4zii0OohXSVACfUn57
WwSEywB0S/OjjI2YU+cAhmg=
=Pl22
-----END PGP SIGNATURE-----

--=-XLgDjXpOvpZvMMursPnm--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
