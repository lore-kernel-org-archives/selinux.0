Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4KGSOk5026173
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 12:28:24 -0400
Received: by wicmx19 with SMTP id mx19so155148330wic.0
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 09:28:21 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id df1sm4276371wib.12.2015.05.20.09.28.21
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 May 2015 09:28:21 -0700 (PDT)
Date: Wed, 20 May 2015 18:28:19 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: enable per-file labeling for debugfs files.
Message-ID: <20150520162817.GD30612@x131e>
References: <1432064766-30354-1-git-send-email-sds@tycho.nsa.gov>
 <20150520155135.GA30612@x131e> <555CAF66.7070004@tycho.nsa.gov>
 <20150520160422.GB30612@x131e> <555CB29E.30904@tycho.nsa.gov>
 <20150520162023.GC30612@x131e> <555CB552.5040305@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
In-Reply-To: <555CB552.5040305@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 12:24:50PM -0400, Stephen Smalley wrote:
> On 05/20/2015 12:20 PM, Dominick Grift wrote:
> > On Wed, May 20, 2015 at 12:13:18PM -0400, Stephen Smalley wrote:
> >> On 05/20/2015 12:04 PM, Dominick Grift wrote:
> >>> On Wed, May 20, 2015 at 11:59:34AM -0400, Stephen Smalley wrote:
> >>>> On 05/20/2015 11:51 AM, Dominick Grift wrote:
> >>>>> On Tue, May 19, 2015 at 03:46:06PM -0400, Stephen Smalley wrote:
> >=20
> >>>> The original motivating use case for per-file labeling for sysfs was
> >>>> libvirt labeling of specific sysfs nodes to make them accessible to
> >>>> specific virtual machines (qemu instances).  In that scenario, we ne=
eded
> >>>> userspace to be able to drive the labeling based on more than just t=
he
> >>>> pathname and so genfs_contexts wasn't suitable.
> >=20
> > I do not think that is applicable anymore (although i may be wrong)
>=20
> Not sure what you mean, but to clarify, I mean that libvirt has to set
> the context (at least the categories for MCS and possibly the type as
> well) on any sysfs node that needs to be accessible by the qemu
> instance.  At least that used to be the case.
>=20

That is what i mean. I am not aware of any such scenario's today. Again, I =
might be overlooking it.

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVXLYdAAoJENAR6kfG5xmc8isL/3EemDSEupGXyr3qN6ZKyzk0
XW4DbrDqzcikMt0n1LkV2mAvelpPbZdSLZuRcb+IhpBUNTAe/lFk93rXfOUocaa6
jcUdXqa9JnPppjWvUh0Rs4RQ2S4ljjCtYvGh4Q8I3JRBCEevV7FeHoK9xSDLoi6H
v5sAPsc/3B7AtSEWsgOh4zUxpr8oH+KE5rsUQ063hHTjQd7QkLz9Ktm3w1K97wjQ
yUEt9nr2a84w0DvXzsBJh4K7dQFSq58VjgNc4UxhmbXM8Tm5qh8ADFWQ/B4uHxBN
+q6SUnQ1p0YIArwn+POKY2vXIAUUaSlKwTLDiG/Y9VF2BoAYNCtG2F6OnTHZocmZ
SgNFIZDExUIorwtI6VtWQssJ4EcG7E96JQ799f7YYXWYGzjlgEkrCYkNDRf70EuB
SHIxe3v6A+E6+svc4Cj1Ky9z/siGTRfQlyj87802Ec4EgG1F3LGxCA/dQWSgL+T7
LiF/NWV6fe400etK4t7fKvZ+dKcFOwq5k+WRHan+DQ==
=c5Ks
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
