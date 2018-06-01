Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w51IKlgo008045
 for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2018 14:20:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID07.oob.disa.mil (Postfix) with SMTP id 40yCLj4sNYz17xpx
 for <selinux@tycho.nsa.gov>; Fri,  1 Jun 2018 18:20:45 +0000 (UTC)
Received: from USFB19PA01.eesmg.mil (unknown [192.168.16.8])
 by USFBF3ID07.oob.disa.mil (Postfix) with ESMTP id 40yCLh0ypWz17xpn
 for <selinux@tycho.nsa.gov>; Fri,  1 Jun 2018 18:20:44 +0000 (UTC)
Received: by mail-it0-f66.google.com with SMTP id c3-v6so2904996itj.4
 for <selinux@tycho.nsa.gov>; Fri, 01 Jun 2018 11:20:41 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <E5BF8501-35EB-4DDF-ADBE-6016CF31A502@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E9FA591B-599E-43C3-BEEE-EAB3888D87CB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Fri, 1 Jun 2018 14:20:27 -0400
In-Reply-To: <20180601114151.GA25225@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 lustre-devel <lustre-devel@lists.lustre.org>,
 fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org,
 devel@driverdev.osuosl.org, selinux@tycho.nsa.gov
To: Christoph Hellwig <hch@infradead.org>
References: <20180601091133.GA27521@kroah.com>
 <20180601114151.GA25225@infradead.org>
Subject: Re: [PATCH] staging: lustre: delete the filesystem from the
 tree.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Apple-Mail=_E9FA591B-599E-43C3-BEEE-EAB3888D87CB
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 1, 2018, at 7:41 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> Thanks,
> 
> all that churn without much visible progress to a mergeable codebase
> was really ennoying.
> 
> I'd recommend if people want to merge lustre they start with a managable
> subset first, e.g. the fs client code with simple IP-only networking.

Adding or removing the IB networking makes basically no difference to the
code size.  This would also make the client much less useful, since a large
number of sites use Lustre with IB networks.

Cheers, Andreas






--Apple-Mail=_E9FA591B-599E-43C3-BEEE-EAB3888D87CB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlsRjmwACgkQcqXauRfM
H+BSaQ//YlKfRYCoaSC/AHdrPBNjFFX9kUo03fvLusPL3K534Y8SZcvAibkHj7Fz
cJ3TxQdB1f80T03e79BK1PiW5YUlC7UPYvBTPo4NsUqcFqsDt4LE7fInA4bZ7Oi8
hHWO444AZeIGkwDK+xzcHWn28t2qr0GGOncR55u1rO1GCcgf3shvpiFeX7tnEuGN
92P29IwO5UGrxAulJgE2HULNqstBD1qVeUe3T8hw3OLqQdDkqmtTOKsZfma8Aoj0
ESEjjXQ56g9RED0R0RDUSWcNTFZ+m9CPpaG54F7a5pb2eQotStvs6pw0mCMdzD65
smWk8TfdUzNPLm0LHnQYIQe8OhIoRARSjSXSNTpLJNkw2B3aQcbGQ97VjAHg9pJQ
Aw2vaTWxMw94W9atK1kP+8ZwJR3hUqVMoiWOAN1tXyo4MQh3VwdLaH8u9t2YTYrX
LEPg+fHHRbIhjRg36hgLYHSPVsuZo6O8ux0nuMiXLq2txYMCe7TjUQz65n4KxUIb
VbgSjy8G0vYgFIBTT0qLMdJ5NYT/AmtsanKTJ0dKmg7fRLYqA0YJ3pT9jRxoI1ac
g52VkYmj5U51dv+6nu25kj55M6VfOQEnHATYN6SSMXlkfEzI+2jQIXJyYhqtjEgP
P8/TxNdyaPXNMfjdvHD/Lxk/58VQUbWRRZxwCvjNFPeYiwbwylI=
=o3XY
-----END PGP SIGNATURE-----

--Apple-Mail=_E9FA591B-599E-43C3-BEEE-EAB3888D87CB--
