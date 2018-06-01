Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w51NKiGe029471
 for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2018 19:20:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 40yL022W4jz2Sj5F
 for <selinux@tycho.nsa.gov>; Fri,  1 Jun 2018 23:20:02 +0000 (UTC)
Received: from UPDC3CPA11_EEMSG_MP27.eemsg.mil (unknown [192.168.18.22])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 40yL010m4Cz2Sj57
 for <selinux@tycho.nsa.gov>; Fri,  1 Jun 2018 23:20:01 +0000 (UTC)
From: NeilBrown <neilb@suse.com>
To: Doug Oucharek <doucharek@cray.com>, Andreas Dilger <adilger@dilger.ca>
Date: Sat, 02 Jun 2018 09:19:40 +1000
Cc: "devel\@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "selinux\@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 fsdevel <linux-fsdevel@vger.kernel.org>,
 lustre-devel <lustre-devel@lists.lustre.org>
In-Reply-To: <29ACF5A8-7608-46BB-8191-E3FEB77D0F24@cray.com>
References: <20180601091133.GA27521@kroah.com>
 <20180601114151.GA25225@infradead.org>
 <E5BF8501-35EB-4DDF-ADBE-6016CF31A502@dilger.ca>
 <29ACF5A8-7608-46BB-8191-E3FEB77D0F24@cray.com>
Message-ID: <87h8mmrt6b.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Subject: Re: [lustre-devel] [PATCH] staging: lustre: delete the
 filesystem from the tree.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-=-=
Content-Type: text/plain

On Fri, Jun 01 2018, Doug Oucharek wrote:

> Would it makes sense to land LNet and LNDs on their own first?  Get
> the networking house in order first before layering on the file
> system?

I'd like to turn that question on it's head:
  Do we need LNet and LNDs?  What value do they provide?
(this is a genuine question, not being sarcastic).

It is a while since I tried to understand LNet, and then it was a
fairly superficial look, but I think it is an abstraction layer
that provides packet-based send/receive with some numa-awareness
and routing functionality.  It sits over sockets (TCP) and IB and
provides a uniform interface.

That is almost a description of the xprt layer in sunrpc.  sunrpc
doesn't have routing, but it does have some numa awareness (for the
server side at least) and it definitely provides packet-based
send/receive over various transports - tcp, udp, local (unix domain),
and IB.
So: can we use sunrpc/xprt in place of LNet?  How much would we need to
enhance sunrpc/xprt for this to work?  What hooks would be needed to
implement the routing as a separate layer.

If LNet is, in some way, much better than sunrpc, then can we share that
superior functionality with our NFS friends by adding it to sunrpc?

Maybe the answer to this is "no", but I think LNet would be hard to sell
without a clear statement of why that was the answer.

One reason that I would like to see lustre stay in drivers/staging (so I
do not support Greg's patch) is that this sort of transition of Lustre
to using an improved sunrpc/xprt would be much easier if both were in
the same tree.  Certainly it would be easier for a larger community to
be participating in the work.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsR1IwACgkQOeye3VZi
gbmuWxAAmeiHWBGFeXsoL5nX2bx2Vw0CRQKDJIa8bLndEDRpjMxjisBXCuQ3vcTk
eTdKbk5c0LNZ5TwKtn/sPLIGQRCleq+6yCW/8TKb98q95BxoAEudJAW8ra2oxRUQ
qDxfGKr/ytQkkDswxITsxYGNb1JThX0ajvS0DHzlwzzlrMgA7Ebwj9PJqRsCks8C
QDfLN4q+wee5DMbpYlfkEcZsbUl2FS6igq92W4+QO0HhdTatpV0+17gXKLHey5pL
os/PF7oD2rX8AXvu03GCjVp56jzxIUKiXZrAT1woSxqW/q4a/1v6o1PlgCQjaal0
ehVso1dZB2ZaU+VCI+x68sK+Fi3Kb3zPahhS43ot2zmZAypzMWhB2DYuPvby+r5J
HbDbx1gun+tAMqahv8Bhd755NbskKqif30GXDqj16cPXJIN4NEM3Eb+1b+C6YCkN
5gQWAy1i2/PXyeMVUpt+fp98JN30mAVtdaeCmsn6V7mYDw3riAcbIFFs0jrij6aZ
hMqDwySAksuad4+cJpE6K7WnYk4Af7ffa5jSPU4+nbdPZR3ogOqzqqmQKn928JuZ
Ihp2Xu7RXddZ/+2lr5AOP9qe09K8T8iF7cB2aG/SZgHdwQJuaNPr4FISTyP5UjLc
oR/pGNb6su9yRph6NBMjS0SgOb67LmMWCA1447RrbAHLM01d+hA=
=VwDY
-----END PGP SIGNATURE-----
--=-=-=--
