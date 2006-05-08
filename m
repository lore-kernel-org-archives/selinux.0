Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k48Kirb2030815
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 16:44:53 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k48Kiqtw003474
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 20:44:53 GMT
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by mail.and.org with esmtp (Exim 4.61)
	(envelope-from <jantill@redhat.com>)
	id 1FdCb6-0008Pa-Gh
	for selinux@tycho.nsa.gov; Mon, 08 May 2006 16:44:52 -0400
Subject: Re: secon (Was: Policycoreutils patch)
From: James Antill <jantill@redhat.com>
Reply-To: james.antill@redhat.com
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jzDwNAX1wj+x2Kc1S4QV"
Date: Mon, 08 May 2006 16:44:52 -0400
Message-Id: <1147121092.3469.24.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-jzDwNAX1wj+x2Kc1S4QV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-08 at 10:54 -0400, Stephen Smalley wrote:
> What is the purpose of the secon utility added by this patch?
> Assuming that it is useful, a few quick comments on the implementation:
> - The my_getXcon_raw functions should be moved into libselinux (without
> the my_ prefix, of course) so that we don't need any code outside of
> libselinux directly reading /proc/pid/attr files.

 Yes, I'd known about that ... I'll be providing changes for libselinux
in the next day or so.
 The initial version with my_ functions was simply to make it easier for
others to be able to compile the code.


> - Falling back to the current context when the exec or fscreate context
> is not set is not correct.  Absence of exec or fscreate context just
> means that the default policy behavior (e.g. type_transition or default
> inheritance) will be applied.  While default inheritance would mean that
> the current context is applied for exec, there could be a
> type_transition, and it makes no sense at all for fscreate (where
> default inheritance combines information from the current context with
> the parent directory context).  I think you just want to report NULL /
> none or similar to the user.

 I was wary of reporting just a blank, but it's a simple change to fix
that.


> - The call to selinux_trans_to_raw_context() doesn't make sense since
> you are already calling the _raw functions.  If opt->disp_raw is set,
> then no further processing should be required, right?

 If the context comes from the user (Ie. stdin or argument), we don't
know if the context is raw or translated. So we always convert. This
allows:

id -Z | secon -R -

...to output the right thing.
 The other thing we are looking at is what the default should be, Steve
Grubb suggested that reading from stdin should be it ... but I don't
like that from a UI POV and that most cases are better handled otherwise
(Ie. ls -Z is never going to be parsable, IMO, so secon -f is much
better).

--=20
James Antill
<james.antill@redhat.com>

--=20
James Antill
<james.antill@redhat.com>


--=-jzDwNAX1wj+x2Kc1S4QV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEX63E11eXTEMrxtQRAlT3AJwIS7a7k3iRdV+BeJgt7FxqhXL8DgCgllOQ
rp46533pttLtQpu6t3PO/zI=
=BvxE
-----END PGP SIGNATURE-----

--=-jzDwNAX1wj+x2Kc1S4QV--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
