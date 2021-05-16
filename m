Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E1C433ED
	for <selinux@archiver.kernel.org>; Sun, 16 May 2021 17:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24FE61151
	for <selinux@archiver.kernel.org>; Sun, 16 May 2021 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhEPRLr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 16 May 2021 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhEPRLp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 16 May 2021 13:11:45 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81687C061573
        for <selinux@vger.kernel.org>; Sun, 16 May 2021 10:10:27 -0700 (PDT)
Message-ID: <a2816d49-ab77-7bbc-a6fc-d7e5fe55ffcb@billdietrich.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=billdietrich.me;
        s=key1; t=1621185024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
        to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
        bh=RJ+8rkok/CxFO/8pQ3Xd5HF2nr883kN/SYx7r2WzL1k=;
        b=b5ep8D3EyZCU3LYJZDxu/dPCe7p5z/I/UhGXoebKbExc6LcNEya+jBpG0+U7tDjZCH3PgV
        P3HDuRIVwy5OxRHivFWh6MG8y2+EDmGfOj7BiSWit/K9NlkLW5Xr/f/JEtqM25UqLIXNTL
        qOggS7/hLG2s1yWn7gE4Xi3OG+DmH+h8jOhgEHOHzhukpoTL8qbbexuTLAulriFWpJAZcC
        v+zPdMJJgoyZjrCyv3bqHH13TJIGBqGawilNkgxbdybvL/Xnam+ZAs8+HfWK++6t8EedeX
        IBKBb85zUY+cdiCrTDAc9oOkFz8ysl6qYX62xhHgSDIKip4ELMEr+zbnQ08lOg==
Date:   Sun, 16 May 2021 19:10:23 +0200
MIME-Version: 1.0
Content-Language: en-US
To:     selinux@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Bill Dietrich <bill@billdietrich.me>
Subject: Relative filename in semanage args ?
Autocrypt: addr=bill@billdietrich.me; keydata=
 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
 YzSgk+ywHGgZ8Ns=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VvegBXcZYGR7utpQXP9AzSJgxji2kE6fB"
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: bill@billdietrich.me
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VvegBXcZYGR7utpQXP9AzSJgxji2kE6fB
Content-Type: multipart/mixed; boundary="zvH1CO6nNxzrBA65QesIoBmCGLgqctlXo";
 protected-headers="v1"
From: Bill Dietrich <bill@billdietrich.me>
To: selinux@vger.kernel.org
Message-ID: <a2816d49-ab77-7bbc-a6fc-d7e5fe55ffcb@billdietrich.me>
Subject: Relative filename in semanage args ?

--zvH1CO6nNxzrBA65QesIoBmCGLgqctlXo
Content-Type: multipart/mixed; boundary="------------maBc6dDkkmSWpIsJpPUq3ByR"

--------------maBc6dDkkmSWpIsJpPUq3ByR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

U29ycnksIEknbSBhIG5ld2JpZSwgbWF5YmUgSSdtIHdyb25nLiAgQnV0IGlzIHRoaXMgYSBi
dWcgPw0KDQogICAgIHRvdWNoIC4uL3h4eA0KICAgICBzdWRvIHNlbWFuYWdlIGZjb250ZXh0
IC1hIC10IHNvbWV0aGluZ190IC4uL3h4eA0KICAgICBzdWRvIHNlbWFuYWdlIGZjb250ZXh0
IC0tbGlzdCB8IGdyZXAgeHh4DQogICAgICMgc2VlICIuLi94eHgiIGFzIGZpbGVuYW1lIGlu
IGxpc3QNCg0KSSBkb24ndCB0aGluayByZWxhdGl2ZSBmaWxlbmFtZXMgc2hvdWxkIGJlIHB1
dCBpbiB0aGF0DQpsaXN0LCBzaG91bGQgdGhleSA/ICBTYW1lIHJlbGF0aXZlIGZpbGVuYW1l
IGFwcGVhcnMgaWYNCkkgY2QgdG8gc29tZXdoZXJlIGVsc2UgYW5kIGRvIHRoZSAtLWxpc3Qg
Y29tbWFuZCBhZ2Fpbi4NCg0KVGhhbmtzLA0KDQpCaWxsIERpZXRyaWNoDQpiaWxsQGJpbGxk
aWV0cmljaC5tZQ0K
--------------maBc6dDkkmSWpIsJpPUq3ByR
Content-Type: application/pgp-keys; name="OpenPGP_0xF790D4D71624804B.asc"
Content-Disposition: attachment; filename="OpenPGP_0xF790D4D71624804B.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsDNBF8Yii8BDAC639t0VMAHf2YSJbOlWI37iE3T/AtYX7iyaxrPPRJ7Q4LU6j8DhNfStUJul=
Zx5
kqBFaqUPJVvFArWywpm6aM9/vuT64yZde1s0hJoODRSillj3bpd47HwyF0syR1sl+nmm74FR3=
K1x
MV6qFbv1M0yjMvLZHQbKfUtjFUOuSnBYWW4MLqhhV1Vj5goOM0Et9nHgrG+wSlnXcDFop2yKb=
LvR
ZJvJUGvIdWdU190PfLYTurxH3r6pAHRinKzZHaJBiipwcB/AEii70OHPXDNqrido9m1dLxHi0=
aW7
UnI7rAyfuTI4PbRbBuk9OE7ZDFqm/yXsnXCkfHkzBvYKUqiMWqaDVN6Qxc7AB7oPEzxkPWaUK=
W/d
Z5m0sSBp64LZJTHZ8fPxpkIwrjx8TOUHI5JTqPouIpBAzP2kB2GsSzcvTPpyGTwiPVuHZptY3=
mFS
gmNSqNBRg39norhT8aFyec8L2lvNb/PbA0X7MbQP2m+GgkkS0zcUl/gi8gZC/uvXKtJgqOcAE=
QEA
Ac0kQmlsbCBEaWV0cmljaCA8YmlsbEBiaWxsZGlldHJpY2gubWU+wsEJBBMBCAAzFiEEJaTUr=
pB9
dqxv81B595DU1xYkgEsFAl8YijACGwMFCwkIBwIGFQgJCgsCBRYCAwEAAAoJEPeQ1NcWJIBL+=
7IM
AKsnMlC1sp7wg0WVcVFcMjhJyYzbkN3y6fFlnANsIHpUROXWXMIfslMSYeXMRieT7EJhh/r9Y=
Nwv
+T52E/92DnmPdzHdsALZ+4GFwvX14Ai72/bZRJOYegHDcXsAXAXOp2cCProQmUnGi+i4UJT25=
vsu
0K5T/sQhh6KwsxF+bKW4abjl74qacq194o3Gx1eqUb98Xbkfma14R8OLxV5gxdhCYKpQsIgBO=
VNz
sGHk5JtAwXWAPb/bwgS0OgGSvDOELOOm84bsFrHBI4XNmZ7V93CqSvXzCxUyfihdeWOuI2NcZ=
DOE
q2C9YnFk0966puMT6yqo4JPcgn608McvaGV36r5vPspF+u1cEEcvikMbKd+6DwUKZGCsLxvK3=
PJj
JHsByt8mGlib+7sn64Nue4gKWGf70g7IIKGRWQhdeWjLXHfaPFUF5TxWKgRAWM2tmSjyaC0EV=
UFM
q5Jpp7vH0zql80YpIogHj2ihNp7h6urs5y8I9yfOmml2UCmYGbUg6HmDpc7AzQRfGIoxAQwAn=
9Ek
w/rbE2qz1rsYPDRJ6+gycKYe8kDRI02UI/boh9SA+A9W0YJr38/n7dPDtYs4H1SYQPWUm2MOV=
mIt
koE75bYqxCBTSa2iE1fbBFqT1vKChK5xzD+Fs4Zhmi+ZlpPD0aDOrv9JnllQNRIJUNtBM3jsC=
KS+
LaguTahsn1HGjbOE0WA/vSywCtiQwaP/mq6g7tBVxn4IOdbxKHDuXSIyongSXT00z3NHqlgS1=
yPz
LPwRVX3V9O6lI6DA88pZG+yv1sONpxS/c7iHQDoQ+19s1WImp/J/wfiuvyLaeq+hAyktBaKEI=
c9F
gF+elD3QEYmEJHXCbMg6OdPrUZWFGZY8ZidI92U1D7xs5fSNb23N6NdDL5ayy+Pl9ho+eljBF=
fAd
bh5uLnWXcvzJQS2ftI6vVOIrHjteLc2VLF+BvXVBjGazH5vc+vu5W2cloihyUGKl9z3KRehtv=
4NQ
u2+/jTZFDNsN0F5R6PyS2yPBYlWuuFb6GZRxKSn30Jw7jQkTfiwRABEBAAHCwPYEGAEIACAWI=
QQl
pNSukH12rG/zUHn3kNTXFiSASwUCXxiKMwIbDAAKCRD3kNTXFiSAS36FC/4yparVyGwyW8Gji=
B+z
FrZ1mQY/LRn8m5+EH03WCp4Ajy4Pde2qgEiWus1/beQcLi/SD7Ro2tQyJYv4mJfuhroxCYSZc=
VBx
t12rIKdJLLd47ZQnyJdemQI+Dnk0NIM/6xT7OYpJ3X6nLTT9VHrcqdlnSVt6Nsy/F9ehk4PNq=
u7e
5Exe9F1Q176eUT/mrC/Y4m6qnV0X8y8m+QavFA7qnrdByhbLmyuExPbtV2B46h4qZsLucHQu3=
L14
24KSC7UVJA2Xo0CF/a7z6ggyyAns7tMk8/1e5ambr/uYz09uU/7u9W8OwQP22bHJqd3Cytb4T=
1Ev
FN3S2AnfIslAJ/KGInLpyKMKaLWd5x4HgOZ0SiCwl86X41QEisAbp5yY7gOsxSXKiuh24LxXG=
gXO
/k7hH7eEE8dvj9QvSLEDN35/Ju6+j8PjSajgaNJOiDcql6ByrBiUUiKPATQdaLQjYwxxt4WXs=
tt/
B/fXmhXUFNo0gfwVQYJAAIf0YzSgk+ywHGgZ8Ns=3D
=3DQ3fd
-----END PGP PUBLIC KEY BLOCK-----
--------------maBc6dDkkmSWpIsJpPUq3ByR--


--zvH1CO6nNxzrBA65QesIoBmCGLgqctlXo--

--VvegBXcZYGR7utpQXP9AzSJgxji2kE6fB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEJaTUrpB9dqxv81B595DU1xYkgEsFAmChUf8FAwAAAAAACgkQ95DU1xYkgEtD
fwv/TItPNAP+MYWjBmDBq2k7dsalTMVUTNoYxSMZHMUDjsYyZxFrbGUYwiPGQMjAsI51GHohoqDt
VDe5R7oSEgUztY1JcBdKBvtE8JldLyg7M3IfkttxT0X7o90cNLpMEzXhTk78U2VIGcRn7zB4Kikr
srteWJ9eGVtr8PZCyN/q3of1G+Ra/yB+lLT1K6gp5su3DnHxhnxuNpeaMmIHSH/K99e+6RMuDcET
m2Oi+1l3cQaPQzi20m61/yhizxe4Dwa0vqorCEwlrq6v//yzBlUyZfe3w8PWyMjDVrwtUqD1AzSm
WyDP9V+5rNUBBx2zFgAVN1uuqkhCIZ3yzqTF0t8UBhlkyyChZvlnuXsOMVtbXyhRjTnmEQuTUTeC
1PDDVZrZhxuY/5GRvMDwk3uctlUJwbCyBHz3iLIEtcg2ihjRuoSDUSMRKnnsDqkz4acDu4cumaQG
TyuDKlCuIFSOyePGB9oEfp6qI/LM+oI+JGDHaxAWxq0V0aJ7x5m6SgF9vHYt
=CmX4
-----END PGP SIGNATURE-----

--VvegBXcZYGR7utpQXP9AzSJgxji2kE6fB--
