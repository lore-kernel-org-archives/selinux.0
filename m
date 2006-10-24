From: James Antill <james.antill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, "GeorgeC.Wilson" <ltcgcw@us.ibm.com>,
        selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <1161620097.667.10.camel@code.and.org>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <1161620097.667.10.camel@code.and.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BB9tmM824+UZ7u/+HhJF"
Date: Tue, 24 Oct 2006 16:37:16 -0400
Message-Id: <1161722236.667.20.camel@code.and.org>
Mime-Version: 1.0
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BB9tmM824+UZ7u/+HhJF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-23 at 12:14 -0400, James Antill wrote:
> On Thu, 2006-10-19 at 09:30 -0400, Stephen Smalley wrote:
> > pam_selinux used to have support to let the user pick from the list of
> > reachable contexts for the user.  So you could just restore that
> > support.
>
>  So, in summary of the discussion, having pam_selinux let the user pick
> the TE and Sensitivity separately (much as it does now if
> get_ordered_context_list_with_level() fails) is the valid approach?

 Ok, I've done a patch to PAM which which adds a config_role option to
the pam_selinux module ... which if turned on takes the users default
context and allows them to change the role and/or level (if mls is
enabled). Entering a blank line sticks with the default.

 It's available from:

http://people.redhat.com/jantill/pam-config_role/

...the rpms there have been built on FC5.

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-BB9tmM824+UZ7u/+HhJF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPnl811eXTEMrxtQRAkaIAJ9M+r0kD8Ap607BzKb/jp92H5DP1gCfVkV+
7/sbOx4Cbpcsq0Lgd/aLSII=
=Cpaq
-----END PGP SIGNATURE-----

--=-BB9tmM824+UZ7u/+HhJF--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
