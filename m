Subject: Re: Announce: SELinux conditional policy extensions
From: Colin Walters <walters@verbum.org>
To: "Joshua D. Guttman" <guttman@mitre.org>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>,
   "Stephen D. Smalley" <sds@epoch.ncsc.mil>,
   "Amy L. Herzog" <aherzog@mitre.org>,
   "John D. Ramsdell" <ramsdell@mitre.org>,
   "Galen B. Williamson" <gwilliam@mitre.org>,
   "Grant M. Wagner" <gmw@tycho.ncsc.mil>
In-Reply-To: <nhawu6r93im.fsf@malabar.mitre.org>
References: <1072133247.3032.22.camel@colossus.columbia.tresys.com>
	 <nhawu6r93im.fsf@malabar.mitre.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OZgfEyencGNE0ahJrWpG"
Message-Id: <1076649558.17927.14.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Fri, 13 Feb 2004 00:19:19 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-OZgfEyencGNE0ahJrWpG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-02-12 at 20:22, Joshua D. Guttman wrote:

> The idea of dynamic changes to the policy makes me nervous.  It seems
> to make the job of understanding the meaning and consequences of  a
> policy -- already hard -- even more daunting.  And I don't really see
> important security goals that cannot be achieved the old way. =20

I am interested in doing some policy analysis work too, and I share your
sentiment here.

> Giving conditional access to a few specific services could
> alternatively be arranged by having some (trusted, non-kernel) gateway
> demons that either respond to requests when desired or don't, when the
> flag is set the other way.

A different approach that comes to mind is binary policy "patches".  So
say you have a base policy which includes the unmodified ping.te.  But
as described in README-COND, you also want to sometimes allow users to
execute ping.  So you create a separate file ping-user.te, which
contains the necessary added permissions.  This would be compiled
specially by checkpolicy to a binary policy "patch" relative to the base
policy, which could be loaded and also unloaded at runtime by the
kernel.

Implementing unloading would require implementing negation, but that
seems useful enough on its own too that it would be worthwhile.


--=-OZgfEyencGNE0ahJrWpG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBALF5WOIkJWWp2WGURAksMAJ97zx0uiLf3mZL4F+eO/ecFl2WZAQCfUGGc
4vgIxR2njZNL0aNFYfeIjO4=
=ofum
-----END PGP SIGNATURE-----

--=-OZgfEyencGNE0ahJrWpG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
