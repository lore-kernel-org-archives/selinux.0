From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, casey@schaufler-ca.com,
        russell@coker.com.au, selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cRF9ZLuZ04ixFCSFZ6zo"
Date: Mon, 23 Oct 2006 12:14:57 -0400
Message-Id: <1161620097.667.10.camel@code.and.org>
Mime-Version: 1.0
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-cRF9ZLuZ04ixFCSFZ6zo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-10-19 at 09:30 -0400, Stephen Smalley wrote:

> pam_selinux used to have support to let the user pick from the list of
> reachable contexts for the user.  So you could just restore that
> support.

 So, in summary of the discussion, having pam_selinux let the user pick
the TE and Sensitivity separately (much as it does now if
get_ordered_context_list_with_level() fails) is the valid approach?

> That doesn't address sshd though.  Or gdm.  sshd shouldn't be too
> difficult.

 Combined with adding similar code to sshd.

>   There were some externally developed gdm patches for selinux
> that enabled context selection long ago, but nothing recent
> (pre-Fedora).

 But, from the "gdm/trsuted-X needs lots more work" discussion, gdm
should just stay with the default Sensitivity and people can use a
terminal+ssh to change levels?

--=20
James Antill <jantill@redhat.com>

--=-cRF9ZLuZ04ixFCSFZ6zo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPOqB11eXTEMrxtQRAg85AJ0ZRioSsObJoXBUTyw15VDTmEXerACfUvwS
0+zX9ZYWcsDx6R83fZAnBQI=
=glN5
-----END PGP SIGNATURE-----

--=-cRF9ZLuZ04ixFCSFZ6zo--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
