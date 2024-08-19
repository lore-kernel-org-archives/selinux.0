Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A03BE65
	for <selinux@vger.kernel.org>; Mon, 19 Aug 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060790; cv=none; b=Yy0PCSxNJSW1HXkuoY/h3M3IL6cb33z7RKM9Wg8Kr0Kzmm6KSk/aMP7+W552tbdZO9CkTb5CxTEKP6Pktn7qQFOa/BGyopg6oMAs0/YfylwJHjkT8EliejD8rImoyxHQDPKsc67/GPT06X5dDTtX3lydqqZTx6o2MHCiDMkzz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060790; c=relaxed/simple;
	bh=7kq4bLV7tAak3fBqNl9JDyXQRKEGfZsGufzo7fyiFUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4E86OuHk2ODX94uUrlzzgqs0qe0GZPKK2GolofoPKxueJyGMNFQbwUae9wmTzno946W+fJonO3eroGo8cg2EKfZ+/C0VTF6D8UWPDNa8lvfzQakFTX5AKEnHgcyGBc+URVyNx/LEpmjYs1Fs0P/MK+hVWy7VGoWobU5/THif2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0bYYQJZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0bYYQJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724060787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yJlfW+826MEVX+XTsSkJ6Zur1F9YvRJB4i/zBOkwSY=;
	b=h0bYYQJZNXJNi2MowMpEutiKy7WVvhehBZ5rcJ/Z/w2nB/sJtgqTDVDKx4aKRVTx5VveOC
	E0/o+1H+rKu0p/voiZz4YUrIMyPLUVb6+3v/ijGvGOL4Oq5SeWId35sD5f/s6VsVW31Dqs
	4q9qnLwyniANd/o6Dzvg9gr4IgQArjs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-C6nhIFyaNJKj1bjoekbb8Q-1; Mon, 19 Aug 2024 05:46:24 -0400
X-MC-Unique: C6nhIFyaNJKj1bjoekbb8Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3ba4390f4so3947285a91.0
        for <selinux@vger.kernel.org>; Mon, 19 Aug 2024 02:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724060783; x=1724665583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yJlfW+826MEVX+XTsSkJ6Zur1F9YvRJB4i/zBOkwSY=;
        b=ieyOoRrlzj2hYfUe0xozbj0X0QlJN5A/W/1eLhUCltCKskgtnkWp1CoS6zwSXdH4tI
         /RNXXLjR9yV6BLGv1QhD527r5esQfy2KBEFf3fEZMmnrYx6oibfodExtCbv3HaTiUXM2
         KA7lo1b8I976BN49k43Hp885qelLf13WraZYGgxJQbHlZHnvwN1/6jn9TX4e0MSSfb3F
         L5aTnrxkNR1feh/lEv6W6vmlO6AhWknc/UY9OLJ9W7p1ZaK/umCewhABbeRDGFWKBr0u
         vIMMQ8bgtqbx5yj7p4t1OSNiKZkpfu94jlkM/U1aJUTrj8V/WNu97P8ccBWO1l4/PTVZ
         yqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7dCqJ0E5/oTbJLjCJByK2DwxPs0TZj8TSzp5dbpxZfcqDT2fAysoePj1UvUFU/QOZ422C3wBj@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNKrrzlOnONxlP9qKiMDT7tKYTngfje0H+CBjcNO7Ae2aWmkv
	ki67pxRxE1wyx/lyCkycjYGjlwSQR7LTQ8PFeA4WHDwGwESzQ9/xhZTeg+qVgmdSi/8ztAy1jOv
	8YGbO0ddOovv6M0ZlFMIXjvQ44s6wOv4kovYYjqPh9GoQxs1YwVYQepIxIVXtXnDR4nyi0i0HI+
	a/SooFG3EBbmAvWiJpSMbtU277aAcpjw==
X-Received: by 2002:a17:90b:4d8f:b0:2c9:a3d4:f044 with SMTP id 98e67ed59e1d1-2d3dffc0f59mr8409782a91.11.1724060783405;
        Mon, 19 Aug 2024 02:46:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdsonGjoEw88ntGBhKWheJOEzKZg+GmVxxiP7CXrtAjUC7woF725y+VXQ7JON4uIe9wxWrA/vqIwfmq/mM9Ow=
X-Received: by 2002:a17:90b:4d8f:b0:2c9:a3d4:f044 with SMTP id
 98e67ed59e1d1-2d3dffc0f59mr8409767a91.11.1724060782998; Mon, 19 Aug 2024
 02:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com>
In-Reply-To: <20240815083229.42778-1-aha310510@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 19 Aug 2024 11:46:11 +0200
Message-ID: <CAFqZXNvXJY4Bh5k6DZ3yoLFuHo2bQRk3Q5Lv25ms6oOGyN5ZAA@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Jeongjun Park <aha310510@gmail.com>
Cc: paul@paul-moore.com, stephen.smalley.work@gmail.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008aec5c0620062eb0"

--0000000000008aec5c0620062eb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 10:32=E2=80=AFAM Jeongjun Park <aha310510@gmail.com=
> wrote:
>
> IPPROTO_SMC feature has been added to net/smc. It is now possible to
> create smc sockets in the following way:
>
>   /* create v4 smc sock */
>   v4 =3D socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>
>   /* create v6 smc sock */
>   v6 =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>
> Therefore, we need to add code to support IPPROTO_SMC in
> socket_type_to_security_class().
>
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index bfa61e005aac..36f951f0c574 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1176,6 +1176,8 @@ static inline u16 socket_type_to_security_class(int=
 family, int type, int protoc
>                                 return SECCLASS_TCP_SOCKET;
>                         else if (extsockclass && protocol =3D=3D IPPROTO_=
SCTP)
>                                 return SECCLASS_SCTP_SOCKET;
> +                       else if (extsockclass && protocol =3D=3D IPPROTO_=
SMC)
> +                               return SECCLASS_SMC_SOCKET;
>                         else
>                                 return SECCLASS_RAWIP_SOCKET;
>                 case SOCK_DGRAM:
> --
>

I'm not sure if this is the solution we want to go with... Consider
the following from af_smc(7):

>   Usage modes
>      Two usage modes are possible:
>
>      AF_SMC native usage
>             uses the socket domain AF_SMC instead of AF_INET and AF_INET6=
.  Specify SMCPROTO_SMC for AF_INET compatible socket semantics, and SMC_PR=
OTO_SMC6 for AF_INET6 respectively.
>
>      Usage of AF_INET socket applications with SMC preload library
>             converts AF_INET and AF_INET6 sockets to AF_SMC sockets.  The=
 SMC preload library is part of the SMC tools package.
>
>      SMC socket capabilities are negotiated at connection setup. If one p=
eer is not SMC capable, further socket processing falls back to TCP usage a=
utomatically.

This means that the SMC sockets are intended to be used (also) as a
drop-in compatible replacement for normal TCP sockets in applications
and they even fall back to TCP when the endpoints fail to negotiate
communication via SMC. That's a situation similar to MPTCP, where we
just mapped MPTCP sockets to the tcp_socket SELinux class, so that
MPTCP can be swapped in place of TCP transparently without having to
do extensive policy changes. We may want to consider the same/similar
approach here.

I briefly played with this idea a couple of months ago, when I was
asked by someone at Red Hat about SMC sockets and their integration
with SELinux. IIRC, when I tried to implement the MPTCP approach and
adjusted the selinux-testsuite to test SMC similarly as TCP and MPTCP,
I saw that the netlabel-related tests (may have been more, I don't
remember) weren't passing out of the box like with MPTCP. However, the
person then didn't follow up on my questions, so I didn't look into it
further...

I'm attaching the WIP patches I worked with, in case someone would
like to continue the experiments.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

--0000000000008aec5c0620062eb0
Content-Type: text/x-patch; charset="US-ASCII"; name="kernel-smc-as-tcp.patch"
Content-Disposition: attachment; filename="kernel-smc-as-tcp.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m00sselb0>
X-Attachment-Id: f_m00sselb0

Y29tbWl0IGU2ZGNhMWZkM2M3MTNlYWY2OWZmMTZmYjIzYzZkYzY4MzA4MmEyZjgKQXV0aG9yOiBP
bmRyZWogTW9zbmFjZWsgPG9tb3NuYWNlQHJlZGhhdC5jb20+CkRhdGU6ICAgVHVlIEZlYiA2IDE1
OjM5OjIxIDIwMjQgKzAxMDAKCiAgICBURVNUCgpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvc2VsaW51
eC9ob29rcy5jIGIvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jCmluZGV4IDU1Yzc4YzMxOGNjZC4u
YTVkYjYyMTMwZDQxIDEwMDY0NAotLS0gYS9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMKKysrIGIv
c2VjdXJpdHkvc2VsaW51eC9ob29rcy5jCkBAIC0xMjkyLDcgKzEyOTIsNyBAQCBzdGF0aWMgaW5s
aW5lIHUxNiBzb2NrZXRfdHlwZV90b19zZWN1cml0eV9jbGFzcyhpbnQgZmFtaWx5LCBpbnQgdHlw
ZSwgaW50IHByb3RvYwogCQljYXNlIFBGX1FJUENSVFI6CiAJCQlyZXR1cm4gU0VDQ0xBU1NfUUlQ
Q1JUUl9TT0NLRVQ7CiAJCWNhc2UgUEZfU01DOgotCQkJcmV0dXJuIFNFQ0NMQVNTX1NNQ19TT0NL
RVQ7CisJCQlyZXR1cm4gU0VDQ0xBU1NfVENQX1NPQ0tFVDsKIAkJY2FzZSBQRl9YRFA6CiAJCQly
ZXR1cm4gU0VDQ0xBU1NfWERQX1NPQ0tFVDsKIAkJY2FzZSBQRl9NQ1RQOgpAQCAtNDc3Miw2ICs0
NzcyLDcgQEAgc3RhdGljIGludCBzZWxpbnV4X3NvY2tldF9iaW5kKHN0cnVjdCBzb2NrZXQgKnNv
Y2ssIHN0cnVjdCBzb2NrYWRkciAqYWRkcmVzcywgaW4KIAkJCX0KIAkJfQogCisJCS8vIEZJWE1F
OiBkbyB0aGUgc2FtZSBoZXJlCiAJCXN3aXRjaCAoc2tzZWMtPnNjbGFzcykgewogCQljYXNlIFNF
Q0NMQVNTX1RDUF9TT0NLRVQ6CiAJCQlub2RlX3Blcm0gPSBUQ1BfU09DS0VUX19OT0RFX0JJTkQ7
CkBAIC00ODUyLDYgKzQ4NTMsNyBAQCBzdGF0aWMgaW50IHNlbGludXhfc29ja2V0X2Nvbm5lY3Rf
aGVscGVyKHN0cnVjdCBzb2NrZXQgKnNvY2ssCiAJCXN0cnVjdCBzb2NrYWRkcl9pbjYgKmFkZHI2
ID0gTlVMTDsKIAkJdW5zaWduZWQgc2hvcnQgc251bTsKIAkJdTMyIHNpZCwgcGVybTsKKwkJdTgg
cHJvdG9jb2w7CiAKIAkJLyogc2N0cF9jb25uZWN0eCgzKSBjYWxscyB2aWEgc2VsaW51eF9zY3Rw
X2JpbmRfY29ubmVjdCgpCiAJCSAqIHRoYXQgdmFsaWRhdGVzIG11bHRpcGxlIGNvbm5lY3QgYWRk
cmVzc2VzLiBCZWNhdXNlIG9mIHRoaXMKQEAgLTQ4ODEsMjIgKzQ4ODMsMjUgQEAgc3RhdGljIGlu
dCBzZWxpbnV4X3NvY2tldF9jb25uZWN0X2hlbHBlcihzdHJ1Y3Qgc29ja2V0ICpzb2NrLAogCQkJ
CXJldHVybiAtRUFGTk9TVVBQT1JUOwogCQl9CiAKLQkJZXJyID0gc2VsX25ldHBvcnRfc2lkKHNr
LT5za19wcm90b2NvbCwgc251bSwgJnNpZCk7Ci0JCWlmIChlcnIpCi0JCQlyZXR1cm4gZXJyOwot
CiAJCXN3aXRjaCAoc2tzZWMtPnNjbGFzcykgewogCQljYXNlIFNFQ0NMQVNTX1RDUF9TT0NLRVQ6
CisJCQlwcm90b2NvbCA9IElQUFJPVE9fVENQOwogCQkJcGVybSA9IFRDUF9TT0NLRVRfX05BTUVf
Q09OTkVDVDsKIAkJCWJyZWFrOwogCQljYXNlIFNFQ0NMQVNTX0RDQ1BfU09DS0VUOgorCQkJcHJv
dG9jb2wgPSBJUFBST1RPX0RDQ1A7CiAJCQlwZXJtID0gRENDUF9TT0NLRVRfX05BTUVfQ09OTkVD
VDsKIAkJCWJyZWFrOwogCQljYXNlIFNFQ0NMQVNTX1NDVFBfU09DS0VUOgorCQkJcHJvdG9jb2wg
PSBJUFBST1RPX1NDVFA7CiAJCQlwZXJtID0gU0NUUF9TT0NLRVRfX05BTUVfQ09OTkVDVDsKIAkJ
CWJyZWFrOwogCQl9CiAKKwkJZXJyID0gc2VsX25ldHBvcnRfc2lkKHByb3RvY29sLCBzbnVtLCAm
c2lkKTsKKwkJaWYgKGVycikKKwkJCXJldHVybiBlcnI7CisKIAkJYWQudHlwZSA9IExTTV9BVURJ
VF9EQVRBX05FVDsKIAkJYWQudS5uZXQgPSAmbmV0OwogCQlhZC51Lm5ldC0+ZHBvcnQgPSBodG9u
cyhzbnVtKTsK
--0000000000008aec5c0620062eb0
Content-Type: text/x-patch; charset="US-ASCII"; name="testsuite-smc-as-tcp.patch"
Content-Disposition: attachment; filename="testsuite-smc-as-tcp.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m00sskwd1>
X-Attachment-Id: f_m00sskwd1

Y29tbWl0IDIzZmQ5MWZmZjZiNDAwNGEzZTBlNWU3YTBiNmNhNWE5N2JlM2QyMGIKQXV0aG9yOiBP
bmRyZWogTW9zbmFjZWsgPG9tb3NuYWNlQHJlZGhhdC5jb20+CkRhdGU6ICAgVHVlIEZlYiA2IDE1
OjEyOjM5IDIwMjQgKzAxMDAKCiAgICBXSVAKCmRpZmYgLS1naXQgYS90ZXN0cy9pbmV0X3NvY2tl
dC9jbGllbnQuYyBiL3Rlc3RzL2luZXRfc29ja2V0L2NsaWVudC5jCmluZGV4IGQzZmVkZjQuLjE4
OGQ4Y2UgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2luZXRfc29ja2V0L2NsaWVudC5jCisrKyBiL3Rlc3Rz
L2luZXRfc29ja2V0L2NsaWVudC5jCkBAIC02NCw2ICs2NCw5IEBAIGludCBtYWluKGludCBhcmdj
LCBjaGFyICoqYXJndikKIAkJaGludHMuYWlfc29ja3R5cGUgPSBTT0NLX1NUUkVBTTsKIAkJaGlu
dHMuYWlfcHJvdG9jb2wgPSBJUFBST1RPX1RDUDsKIAkJc29ja3Byb3RvY29sICAgICAgPSBJUFBS
T1RPX01QVENQOworCX0gZWxzZSBpZiAoIXN0cmNtcChhcmd2W29wdGluZF0sICJzbWMiKSkgewor
CQloaW50cy5haV9zb2NrdHlwZSA9IFNPQ0tfU1RSRUFNOworCQloaW50cy5haV9wcm90b2NvbCA9
IElQUFJPVE9fVENQOwogCX0gZWxzZSBpZiAoIXN0cmNtcChhcmd2W29wdGluZF0sICJ1ZHAiKSkg
ewogCQloaW50cy5haV9zb2NrdHlwZSA9IFNPQ0tfREdSQU07CiAJCWhpbnRzLmFpX3Byb3RvY29s
ID0gSVBQUk9UT19VRFA7CkBAIC03OSw2ICs4MiwyMCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqKmFyZ3YpCiAJCWV4aXQoMik7CiAJfQogCisJaWYgKCFzdHJjbXAoYXJndltvcHRpbmRdLCAi
c21jIikpIHsKKwkJc3dpdGNoIChzZXJ2ZXJpbmZvLT5haV9mYW1pbHkpIHsKKwkJY2FzZSBBRl9J
TkVUOgorCQkJc29ja3Byb3RvY29sID0gMDsgLyogU01DX1BST1RPX1NNQyAqLworCQkJYnJlYWs7
CisJCWNhc2UgQUZfSU5FVDY6CisJCQlzb2NrcHJvdG9jb2wgPSAxOyAvKiBTTUNfUFJPVE9fU01D
NiAqLworCQkJYnJlYWs7CisJCWRlZmF1bHQ6CisJCQl1c2FnZShhcmd2WzBdKTsKKwkJfQorCQlz
ZXJ2ZXJpbmZvLT5haV9mYW1pbHkgPSBBRl9TTUM7CisJfQorCiAJc29jayA9IHNvY2tldChzZXJ2
ZXJpbmZvLT5haV9mYW1pbHksIHNlcnZlcmluZm8tPmFpX3NvY2t0eXBlLAogCQkgICAgICBzb2Nr
cHJvdG9jb2wpOwogCWlmIChzb2NrIDwgMCkgewpkaWZmIC0tZ2l0IGEvdGVzdHMvaW5ldF9zb2Nr
ZXQvc2VydmVyLmMgYi90ZXN0cy9pbmV0X3NvY2tldC9zZXJ2ZXIuYwppbmRleCA2M2I2ODQ5Li5i
YWEzYzkzIDEwMDY0NAotLS0gYS90ZXN0cy9pbmV0X3NvY2tldC9zZXJ2ZXIuYworKysgYi90ZXN0
cy9pbmV0X3NvY2tldC9zZXJ2ZXIuYwpAQCAtNzQsNiArNzQsMTAgQEAgaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQogCQloaW50cy5haV9zb2NrdHlwZSA9IFNPQ0tfU1RSRUFNOwogCQlo
aW50cy5haV9wcm90b2NvbCA9IElQUFJPVE9fVENQOwogCQlzb2NrcHJvdG9jb2wgICAgICA9IElQ
UFJPVE9fTVBUQ1A7CisJfSBlbHNlIGlmICghc3RyY21wKGFyZ3Zbb3B0aW5kXSwgInNtYyIpKSB7
CisJCWhpbnRzLmFpX3NvY2t0eXBlID0gU09DS19TVFJFQU07CisJCWhpbnRzLmFpX3Byb3RvY29s
ID0gSVBQUk9UT19UQ1A7CisJCXNvY2twcm90b2NvbCAgICAgID0gMTsgLyogU01DX1BST1RPX1NN
QzYgKi8KIAl9IGVsc2UgaWYgKCFzdHJjbXAoYXJndltvcHRpbmRdLCAidWRwIikpIHsKIAkJaGlu
dHMuYWlfc29ja3R5cGUgPSBTT0NLX0RHUkFNOwogCQloaW50cy5haV9wcm90b2NvbCA9IElQUFJP
VE9fVURQOwpAQCAtODgsNiArOTIsOSBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
CiAJCWV4aXQoMSk7CiAJfQogCisJaWYgKCFzdHJjbXAoYXJndltvcHRpbmRdLCAic21jIikpCisJ
CXJlcy0+YWlfZmFtaWx5ID0gQUZfU01DOworCiAJc29jayA9IHNvY2tldChyZXMtPmFpX2ZhbWls
eSwgcmVzLT5haV9zb2NrdHlwZSwgc29ja3Byb3RvY29sKTsKIAlpZiAoc29jayA8IDApIHsKIAkJ
cGVycm9yKCJzb2NrZXQiKTsKZGlmZiAtLWdpdCBhL3Rlc3RzL2luZXRfc29ja2V0L3NtYyBiL3Rl
c3RzL2luZXRfc29ja2V0L3NtYwpuZXcgZmlsZSBtb2RlIDEyMDAwMAppbmRleCAwMDAwMDAwLi45
NDVjOWI0Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvaW5ldF9zb2NrZXQvc21jCkBAIC0wLDAg
KzEgQEAKKy4KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCmRpZmYgLS1naXQgYS90ZXN0cy9p
bmV0X3NvY2tldC90ZXN0IGIvdGVzdHMvaW5ldF9zb2NrZXQvdGVzdAppbmRleCAwOGM3YjFkLi41
NDU5ODhhIDEwMDc1NQotLS0gYS90ZXN0cy9pbmV0X3NvY2tldC90ZXN0CisrKyBiL3Rlc3RzL2lu
ZXRfc29ja2V0L3Rlc3QKQEAgLTgsNyArOCwxMiBAQCBCRUdJTiB7CiAgICAgY2hvbXAoJGJhc2Vk
aXIpOwogICAgICRwcm90byA9IGJhc2VuYW1lKCRiYXNlZGlyKTsKIAotICAgIGlmICggJHByb3Rv
IGVxICJ0Y3AiIG9yICRwcm90byBlcSAibXB0Y3AiICkgeworICAgICMgY2hlY2sgaWYgU01DIGlz
IGVuYWJsZWQKKyAgICBpZiAoICRwcm90byBlcSAic21jIiBhbmQgc3lzdGVtKCJtb2Rwcm9iZSBz
bWMgMj4vZGV2L251bGwiKSAhPSAwICkgeworICAgICAgICBwbGFuIHNraXBfYWxsID0+ICJTTUMg
cHJvdG9jb2wgbm90IHN1cHBvcnRlZCI7CisgICAgfQorCisgICAgaWYgKCAkcHJvdG8gZXEgInRj
cCIgb3IgJHByb3RvIGVxICJtcHRjcCIgb3IgJHByb3RvIGVxICJzbWMiICkgewogICAgICAgICAk
aXNfc3RyZWFtICAgPSAxOwogICAgICAgICAkZmFpbF92YWx1ZTEgPSA1OwogICAgICAgICAkZmFp
bF92YWx1ZTIgPSA1Owo=
--0000000000008aec5c0620062eb0--

