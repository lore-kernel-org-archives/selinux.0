Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBK0rLW6019236
 for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2014 19:53:21 -0500
To: Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH] audit: use supplied gfp_mask from audit_buffer in
 kauditd_send_multicast_skb
In-Reply-To: Your message of "Thu, 18 Dec 2014 23:09:27 -0500."
 <d261c547d8018a18f2092e1907b06e190162b088.1418947557.git.rgb@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <d261c547d8018a18f2092e1907b06e190162b088.1418947557.git.rgb@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1419036779_71557P";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 19 Dec 2014 19:52:59 -0500
Message-ID: <74385.1419036779@turing-police.cc.vt.edu>
Cc: linux-kernel@vger.kernel.org, linux-audit@redhat.com, selinux@tycho.nsa.gov,
 sgrubb@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--==_Exmh_1419036779_71557P
Content-Type: text/plain; charset=us-ascii

On Thu, 18 Dec 2014 23:09:27 -0500, Richard Guy Briggs said:
> Eric Paris explains: Since kauditd_send_multicast_skb() gets called in
> audit_log_end(), which can come from any context (aka even a sleeping context)
> GFP_KERNEL can't be used.  Since the audit_buffer knows what context it should
> use, pass that down and use that.
>
> See: https://lkml.org/lkml/2014/12/16/542

> Reported-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 7b83c55..ce484fb 100644

I was reliably triggering 3-4 BUGs an hour, and with this patch applied I've
gone 9 hours without seeing one.

So feel free to add a Tested-By:  when it goes out.

--==_Exmh_1419036779_71557P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVJTIawdmEQWDXROgAQIDJA/+Pv0vIe0ZSKyOPJQunXcryqefTBW5K/HB
nS21Vo73VxO2h5Kg7JI9JUQJz0FvFDvKX9sgAlpTnjTSciiUQ9U2aqI/mCGDXHuO
6+CVRf+cvqPkU68caW8h8pq230R/z0rm+oaozvh8RWQpX/+p2IhVHAXVW1grNB4O
Uv5JvOmj2fY03o0Z3k3NV+5FMuTXjDJiZE3n6ZF3NboZaeTZ20F+jfcma6+wzTaL
KSNTOa7BfcCUb/PgtXuYYDrTru1uFSfBffKfHthxSOP7/nYwxZcicSCyxY22Z7h0
gZoWUX8WTwE/SF+IEbjGMjzXCV1eJYFIP2qreSdeiCLv2nmsgNzuGlaLo96TtuO1
SkXTWU7DGf2/u87eQqi/xq9YasEudwkzhOOHfEjBH41lbBqv/w7DvDnG98hJVdEg
HcuewU+dfhyG81lRTR5ojClxlg8PbudtbzvEx24emdtPeu/qTdXf9BGncJ9A3CBt
UINxjLLH70qrqUHW6ZMS8uOvtci9ahKh/C2PK3ph1jPbO010pwdvfm1Y+KPx/k/z
JA5nunkwjTWxolUU17GKG5qN/FhM/NM9SSoI3WRvMTBhD+755F8YckvrL4NvwI6v
q7Q2kh1wDqZ5JGAY87w/1up0ObLMOkc3UeVTgppRcuWYUSnNSUBUEYKeHZx9FCMX
Of6pTdG9h6M=
=CK1Y
-----END PGP SIGNATURE-----

--==_Exmh_1419036779_71557P--
