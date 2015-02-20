Date: Fri, 20 Feb 2015 14:10:56 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: MCS error
Message-ID: <20150220221056.GL12937@tracyreed.org>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <20150219204841.GA1649@linksys-wireless-usb.network2>
 <20150220003425.GF12937@tracyreed.org>
 <54E738EF.8070601@tycho.nsa.gov>
 <20150220165628.GI12937@tracyreed.org>
 <54E769FA.8010801@tycho.nsa.gov> <54E76FD5.1080905@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kY0AMSsGPnDJoAXR"
In-Reply-To: <54E76FD5.1080905@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--kY0AMSsGPnDJoAXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2015 at 09:33:09AM PST, Stephen Smalley spake thusly:
> Also, can you confirm that the system is enforcing?  getenforce?

I should have clarified that the system is in permissive mode but no denials
were logged in /var/log/audit/audit.log

[mcstest:/home/users/tracy.reed]# /usr/sbin/sestatus=20
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 24
Policy from config file:        targeted


--=20
Tracy Reed

--kY0AMSsGPnDJoAXR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFU57DwBhSTPg0d/nQRAqXpAKCoXjGAvjDUkAHh43FyGdOWjrRPbACZAT4U
/i7xTQl81LjtDZF5rURj6So=
=/rAX
-----END PGP SIGNATURE-----

--kY0AMSsGPnDJoAXR--
