Message-ID: <46FBEFEF.9090803@redhat.com>
Date: Thu, 27 Sep 2007 14:01:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Todd Miller <Tmiller@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: I am concerned about putting genhomedircon	changesinlibsemanage
 into Fedora 8.
References: <200709262001.l8QK1Skx029939@tex.courtesan.com>	 <1190836803.15779.159.camel@moss-spartans.epoch.ncsc.mil>	 <1190838018.15779.170.camel@moss-spartans.epoch.ncsc.mil>	 <6FE441CD9F0C0C479F2D88F959B01588010FFA00@exchange.columbia.tresys.com> <1190891982.27038.1.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190891982.27038.1.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Wed, 2007-09-26 at 17:41 -0400, Todd Miller wrote:
>> Stephen Smalley wrote:
>>> - A diff of file_contexts.homedirs generated via libsemanage vs. the
>>> old /usr/sbin/genhomedircon script shows differences on rawhide.  Not
>>> sure who is right.  Diff below.
>> It looks like the new genhomedircon is being overzealous in its
>> replacemen
>> of system_u.
> 
> The python script sets the default user from the __default_ entry in
> seusers and the default prefix from the default user's prefix.  I don't
> see corresponding support in the C implementation; it seems to use a
> fixed value of user_u (which I think the python script did too at one
> point, but later changed to check __default__).  In rawhide, __default__
> is set to system_u rather than user_u for some reason.
> 
I fixed this last night.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG++/vrlYvE4MpobMRAh/VAKDNQ5TDb3C80W0pOcQSbNwfH2CZqQCgiJk4
V1aCXdmVETy13gbH5/D/Q8k=
=xPPk
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
