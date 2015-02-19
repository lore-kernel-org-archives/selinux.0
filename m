Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1JLEZRF029723
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 16:14:35 -0500
Received: by mail-wg0-f43.google.com with SMTP id z12so9762751wgg.2
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 13:14:32 -0800 (PST)
Received: from linksys-wireless-usb.network2 (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id kr5sm34127677wjc.1.2015.02.19.13.14.30
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 19 Feb 2015 13:14:31 -0800 (PST)
Date: Thu, 19 Feb 2015 22:14:29 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: MCS error
Message-ID: <20150219211428.GB1649@linksys-wireless-usb.network2>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <54E63D8A.3040600@tycho.nsa.gov>
 <20150219201720.GE12937@tracyreed.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
In-Reply-To: <20150219201720.GE12937@tracyreed.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 12:17:21PM -0800, Tracy Reed wrote:
> On Thu, Feb 19, 2015 at 11:46:18AM PST, Stephen Smalley spake thusly:
> > Domains with those attributes can override the corresponding MCS
> > constraint.  Depending on version, seinfo --constrain will dump the
> > actual constraints for you.  In any event, I suspect you need to assign
> > the mcsuntrustedproc attribute to your web application domains if you
> > want them to be constrained by MCS at all, plus you'd need to run them
> > with specific category sets.
>=20
> How do I assign mcsuntrustedproc attribute to my web application domain? =
I know
> how to set booleans, categories, etc. but have not yet encountered needin=
g to
> set an attribute for a domain. Google for "set selinux attribute" turns up
> stuff about setting user, role, type etc. as attributes but nothing about
> setting attributes such as mcsuntrustedproc.


I actually have it documented in a set of youtube video's on my "domg4721" =
channel extensively (like many other SELinux topics)

I encountered it both with mod_selinux, as well as just manually associatin=
g compartments with webapps by just using runcon in a web script that runs =
other scripts (not something i would ever do in a production environment bu=
t just a proof of concept).

In my view mcs is generally overkill unless you have many process to compar=
tmentalize. In theory you can also use existing security attributes like fo=
r example the identity security attribute, it's there so might as well use =
that. Or if you have just a few processes to compartmentalize then just use=
 type enforcement.

No need to have a mls policy for that. When things get big though with tens=
 or hundreds of compartmentalized processes then MCS comes in handy.

>=20
> --=20
> Tracy Reed



> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.


--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJU5lIvAAoJENAR6kfG5xmcFb8L/1Vg9JTsXzlnRhiyQLu/hASy
7sseE5nY488V8tXzCdK1VE8HjFvcjqQ2s9u0hz2nB19FAtr1QSpSDoKS55jvjZqa
+24dCPURxFSFCs3jpZkrgp7jFFvcAU+Iqe+r51UPAo/jCD9GubihSw/2kucI3+pp
lBHAHR9DnnIHWY+xBNKnf3iY3JANZESOwA+NGHjLUUnSLX0pA+VzyayN8/OjTLKD
0jFnEIie2BjK+4hUKfhIsA5B42JwEY5pPB64NVxPgwqYBmysLr/jEdRgoZNDjL0T
MVJQT8pmcfpsfpvdckV9PG9GY1lEsJ7ye+pJXlTn3k16deQm0gKQqcEoJdouHgkT
zTKOJXv1OrykTQI4ZtGVLqFSnPn2x+Qai1xuuiv/jQ7xJu+MHfBVB50UCLF38ujo
HiOaN67N5rqLpDw4ZU4Crrw7TkeR9lzeYMdLkgaNsg5rMRJhqMb44w4HyP+hHngE
X/rWxGYloXyhKsTy+XpB3O+qP2OXBLrwcGqCEKz7pA==
=PhaY
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
