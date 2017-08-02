Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v72J62Ak005021
 for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2017 15:06:02 -0400
Received: by mail-wm0-f48.google.com with SMTP id m85so286883wma.1
 for <selinux@tycho.nsa.gov>; Wed, 02 Aug 2017 12:01:41 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id 5sm11339eds.62.2017.08.02.12.01.39
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Aug 2017 12:01:39 -0700 (PDT)
Date: Wed, 2 Aug 2017 21:01:37 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170802190137.GA10043@julius.enp8s0.d30>
References: <CAENH-vA_rbUf8UyDcGmCto3-R9zNPy1jMMoH+XKwRqx7c4P-qQ@mail.gmail.com>
 <20170802163500.GA16782@julius.enp8s0.d30>
 <1501700374.3000.15.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
In-Reply-To: <1501700374.3000.15.camel@tycho.nsa.gov>
Subject: Re: httpd_graceful_shutdown makes httpd_can_network_connect
 mostly mute
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 02:59:34PM -0400, Stephen Smalley wrote:
> On Wed, 2017-08-02 at 18:35 +0200, Dominick Grift wrote:
> > On Wed, Aug 02, 2017 at 04:41:00PM +0100, Carlos Rodrigues wrote:
> > > Hi,
> > >=20
> > > I don't know if this a too basic question to ask here, or the
> > > proper
> > > place, but here it goes:
> > >=20
> > > I've been chasing some weird (to me) behavior with the targeted
> > > policy
> > > on a VM running nginx as a reverse proxy. What happens is that the
> > > "httpd_can_network_connect" boolean needs to be enabled for nginx
> > > to
> > > be able to reach its upstream servers. So far, so good.
> > >=20
> > > However, if the upsteam server happens to be listening in one of
> > > the
> > > "http_port_t" ports, "httpd_can_network_connect" isn't needed
> > > because
> > > the "httpd_graceful_shutdown" (default enabled) provides the
> > > required
> > > allow rule ("name_connect").
> > >=20
> > > This seems strange to me. Is this supposed to be like this? I would
> > > expect nginx to be totally unable to establish outbound connections
> > > by
> > > default.
> > >=20
> > > Best regards,
> > >=20
> > > Carlos Rodrigues
> > >=20
> > > PS: I just spent a few hours on this, wondering why one machine
> > > needed
> > > "httpd_can_network_connect" and another did not. I guess I've
> > > mostly
> > > been setting up reverse proxies for "http_port_t" upstreams on
> > > CentOS
> > > all this time...
> >=20
> > I think the "httpd_graceful_shutdown" is an apache thing (probably
> > for "apachectl graceful-stop"). However I cannot reproduce this
> > behavior with httpd-2.4.27-4.fc27.
>=20
> Hmm...neither can I; seemingly apachectl graceful-stop works without
> requiring this boolean anymore.  So maybe it can be disabled by default
> and removed at some point in Fedora policy?
>=20

Would be nice if we would be able to confirm this with the apache maintaine=
r before jumping to conclusions.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlmCIY0ACgkQJXSOVTf5
R2k9lQwApyWTajiHtLJD5OW/EJ6D0Tv49IYv8O5eoJ72OweX88mE9NqWm2LPXowK
/tGMpvmWa/Q/wUUKV07qGTL9D3T4ZatK8f5tUCphn/Ha/yVhGuswEjwUOeA4S+I+
o25U2kai9o+Iel+b3UoH8Dh7EMVgnYFslte7sBKBQIatUESEOSfhdMC9oYZ1P0oG
MPFokhqNUPI022UkVYrA7K0BuYyXKoeNqWGcHzQqHXqzrDwRTymhvJcrKNaedbyf
p4BNu5LxY8QptfXGNWsGvGxajMDcrNZD0LQdqg5Ukmr5pNJigZTBMQN2CDplCjZr
vvjBtKVj2oLDpJEjkasrqyHQ0/9CZHfm12/uOEoIB3WAtHBRV7qOCSPQgQ0Zrmvn
UKqF24rd38O0lhxdF9pwo5O/5CGrRqi3NTA5BM8wAoiuX5NolUwEJwlm0RDIFjCo
86wV+Or4SaSCXwQGP0CaO0u8VqtmXtXOCdRnfpy/ffRQTblTpAsQtSc+kTAi0YJv
IoMbmvDk
=0qE6
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
