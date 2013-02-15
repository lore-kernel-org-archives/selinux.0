Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r1FE75IX023779
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2013 09:07:05 -0500
Date: Fri, 15 Feb 2013 15:06:49 +0100
From: Luis Ressel <aranea@aixah.de>
To: selinux@tycho.nsa.gov
Subject: Re: Mount of cgroup filesystems fails when booting in SELinux
 enforcing mode
Message-ID: <20130215150649.22c20d5c@gentp.lnet>
In-Reply-To: <511E38E7.4040609@tycho.nsa.gov>
References: <20130214222502.2f7d657c@gentp.lnet>
	<511E38E7.4040609@tycho.nsa.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA512;
 boundary="Sig_/3qTMNtIuJQ6je2JNg_iJf68"; protocol="application/pgp-signature"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Sig_/3qTMNtIuJQ6je2JNg_iJf68
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Feb 2013 08:32:23 -0500
Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Try stripping dontaudit rules from your policy and re-testing.
> semodule -DB
> <re-test>
> semodule -B

Thanks for your tip, but I already did that before contacting this ML.
There are no denial messages during that time of boot, and all denials
which happen earlier or later don't look related.

Some minutes ago, I managed to find the exact calls to
avc_has_perm_noaudit which are involved here by excessive use of printk,
but I haven't figured out yet how to interpret its arguments.


Regards,
Luis Ressel

--Sig_/3qTMNtIuJQ6je2JNg_iJf68
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJRHkEFAAoJEOBVC/zizycOMAIP/3JZsYpDSRurFcxn6gz/lVhQ
QLk0pxGH/kHzbDiAokQR18xckBqczVRTYyOFfnZiZS+1xc3FKiMH/RnReetvaCVS
tspcQKHXZ3GddulN/oisD3AZGTu865hHXbRU1kA45A8f8LIyeBg2FcTLpMjyf9RI
bMUn2pzf6dT6FjA5OEAlRZLAWqYhLza2OlWAO+UZ73XJcBXXHCR+TncfVTXFNpzL
rj9st/k6smdiKcYob+rAwg8Of/n2PkVXOS+CS1yFyN89rGmID5wxOXYU2Dqx/a7j
05Fijc/4pxd2GdaFy7bANlGT/K+6B4wX6HHLwgmeElWZpnygLD3PgENWB6PlEgjh
3it05KM1BX/ZmRnfNtuYpVhWm7Apzep1Xf6ZEkhL+RImXghl2YvjQCBRjn/6zVBp
0F4kOOY1ID3gXpa61ia0kRe8COy8vIzluDKVL5FBjKxCHG5DpHV20VgsGmPTsSYp
T4BsTqRQemSnQsI06zTZ1fANEDsAs0IHfZoAxHUgMDT44YZ7IH5DAeLnSlAyV6db
wypB+W+MDmJQxs/nWmLXAm/h1dgj7TkNccGyGfeDUEfeBN6oA1heFpCyqIDQnrjT
5i4IKqy591ADrk60Pv9I0LCIifKbZhgM/WpZb7kc6cE1eE9krtDlT29qpiGdahC/
MmmYyUr2ZAprrs7lInr+
=Wukw
-----END PGP SIGNATURE-----

--Sig_/3qTMNtIuJQ6je2JNg_iJf68--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
