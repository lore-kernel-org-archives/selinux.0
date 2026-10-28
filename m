Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793200387;
	b=RRjMwaREe09ITsVYoqCGuzRO9Va4bn6m7jWZ8L0YtKIDYCsH8Ono/vWfAA4u8jLj69/Z
	 b4Q6qwWfme3luc87ELCWWJF9xG3RtAlUPqdERz5Qcg4gWZNgooQ4/xOJVg5m2y7wucACb
	 KdEZ9DHquhGR5gfp10pHJUfaILlFXSzfATe11lznsF369vvP3x5r6p0PedC2Jd1Lc0CU+
	 5m+zMWDk8/uogVAdn4/Sd5+2HfbkIocytrLpCe9z/ABZH2Uz0X7kFjXRN+mdTzJAMWdLZ
	 T6PK72ZPpF6hMV4RFxZUW1wdh11tkwEiS11fSKxxGGNwvAtm7b2pNiQUO9tiaOy72wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=nZrK9I6e5DTBogcugykDR+b7Zc9E3oadn3mtR+uAzxs=;
	b=0AX2nDQGttYtih7k8ppdu1ZbBGMMUA5jyZLYvGBDemzvuRZnFDh/JXSlZRTKHy2vwo8p
	 khTUImncUj2ABMotaX8SP5Y7infpeOK8IdZcF+LF9SaxpHLUYStE6AUj4LTcLyv75Cae4
	 mdQgoWTeAVEyhJ7wpBvZud5xv6sDU6A44Nq3EehVpnydvZI/DwAlvtzmFHTqEj9ZKR7u7
	 zKzmUVRUOXSTFeEStID8zHJfpE2Wko+a/J5iD0cr+Rj89UJfiNoIXwpvISTWZ0Rsg4ZvZ
	 xFQeGIKdEkN+/pvaj5vIK+4624eRO4T+QrdRgW0VPMAC23AnCI7RVeWPYaOkFn7w7rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jzjapS0h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06183606A322
	for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 15:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06183606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jzjapS0h
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-679a2b5fe87so1112973d50.3
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 08:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793200386; cv=none;
        d=google.com; s=arc-20260327;
        b=TisRA1WvwFsy9TZLbBoQllr3DwX0pP9tovvS3a+54AO7uNf2raabnMmRrc9+6bp2oC
         8MTcMuptRbmc6oJVP6l4nKSW6l/vvNPSDpeaJuioEj7CSiLno/dEjCmHWt6qtl/nFM3G
         WmRpGJwpJ7820W/gQsWqztcgsYI7jgDhB11l6CRJaABuMgLPi6j9JOGA3594CHLPY3xU
         twI9Glm9qPNRfrImFR8mr6E6vEugmhhvz0czWeE7VyvBuxO0HHr4fBn7slxV/rpAw43x
         IoH1Mi++tX2RuDXnJsoWSNFN+fYCBRwAAsbKgOt6UIrS/PJ3gL0MHwGULDvmhgIX7wOG
         jcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nZrK9I6e5DTBogcugykDR+b7Zc9E3oadn3mtR+uAzxs=;
        fh=q08H+4X8i7EaC7BesAm/d8L4xwnPrnWz+43sBtlpBQc=;
        b=Ftl+szwTQV1egtGBcfAbs12mXF7XtFihJOElnplJDzmgBEUJjhbwlDZGmDyybv0BYa
         HrHnuCE3OxOysKn1Q54KyP38R8S4aDTOC1QVF0OG7W8DEjgkNz54FlRdXyduVu2OcwRN
         okBSHGbOj0azVECcKYQY21K+EhlsQrBSIKfAS/Tf9yTE+Pa+Ww/Gn/0xrrCjX7aoD/QX
         OjejsH73AxL7+9hCfJkOOr1Djg1/gpPl99gnO4APqd4v+PtqTeVbsSNs1KBDijK/csN9
         4frw9rGWgLoMFOmWJDUGkLHUYsIc219wFNraHbxlBEnfOTBq0GSKbXakHuUnqbeyvWRP
         SvjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793200386; x=1793805186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nZrK9I6e5DTBogcugykDR+b7Zc9E3oadn3mtR+uAzxs=;
        b=jzjapS0hxKG6aoiwOqFC3hSJ7SLdhITLEpl+Ge1/n+sNlviygRBs4+J9e0mAtXRN9E
         O0+fNkVScD6iu+yRUk1FB9IBZXmwMfAPTCRAErCdJ4LbhqdIXlvM8QVlvwPZx7VxiZ+o
         tXOCEyIJnzWzUZKtqT3s959luDNPeJ/E1tl4d3F+juNhVO83hL/FHuszGNYZ1H8SwpLg
         P9J1oyipnRNSUwFJbE6oiztrRwUxrP2EMhjgiYR9/5r9ezVNqYf4P690lzlp9xUfo8br
         uSeAfVa8qED29SdXV642YET7Ng3uz+c3Fcg0d6yrJuEsPBXHzvo77Rd/QXjBrab6JBuS
         bHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793200386; x=1793805186;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZrK9I6e5DTBogcugykDR+b7Zc9E3oadn3mtR+uAzxs=;
        b=WUSyrQkFmcGxLsbaiRbWHtNM2klE45WmeeYVuQEZo5tmqNwWFbQyKNij8y57eBFzmC
         oOJy9fz0Fnvf1FNTSwT4UMZLquRHRmqp8KPaQphyCI96DBLmQrDKO82m2kDypzmLog8y
         Xu8oQo4wUFK4UkNlcY9ttMUd3yYc2fZ/sjwk3gOE//B0jGos7HyqEZrCYAHT0FbrnW6w
         Yg15HWbv2D9QNkvLcpIgbweWhE9rBLbLkpnl30rdSbHRtmP8VEskQUA24D8QaeclGtGJ
         U4mgT4226Kp8FirlkPish8j5GTka1t4YrUxewFM44vG4/hfQqM9hu5rbH1zAg4hhmtI/
         NDXA==
X-Gm-Message-State: AFq9FYK3xXSgN0IExyoK6fG/TNA0+YBQCqYcuJxc5eI+m2wg3BPlnAGq
	JbiXV4bWEWDdOUDwAkzie7Bj3KLO5iZK3rFkrCeFKt/lPIAQuaHQc2Ao5vTMfe9VfGU8QDo2e6h
	jpEaQOu3nMLU848MAS1OjEJ1UKnXrXuM5tAflNLA=
X-Gm-Gg: AYBFou0PdPB+yN/2S6Cz5IaEjTfkUdOxs0voe+1HtD7oFv/UB/PZPwogDUvoMk9CXa2
	9Ou2XV6O/62t6dhS4Sls0pRoJNExU3oJB2AzxKrXFZJTPOJuXXDcoIzCV8CcDqR9nmaWOO8wwDz
	2oDpSNOS+vdVRSWUyfrrL5wmw0X+Gi/6oUz17dw5kjDCm5LV65ltnRyNV6Ka9/3s7mnuaRpcC8u
	ynH2hzzzzGFPygWL6D7/4FE4a6mhC43q9ArOmOiUfHOQbFSoNch6Gsxs0BuZ5RYPrrX+x3w4+cs
	0FVk8neOEmw1qxVNdvvTpTnQLQIPB/6bvNS307cY2SqMLHqmvZQug7KE4en3/WlZTtaZP7iNPqy
	t4vt26jiZHBFeuP52tsMWv9GDZB0AE6G87Qfb4xywZDKCD8lSAPW1EdERg+m4HVnZghU3ZHuglC
	xJXp/g+SMP048i/YP31V+eudEnf9w3Rz2Cg2+rvnNQnRhTwRUuxkjiIrAahg==
X-Received: by 2002:a53:c909:0:b0:674:981:a937 with SMTP id
 956f58d0204a3-67a7bd1958amr1173029d50.121.1793200385840; Wed, 28 Oct 2026
 08:13:05 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028142843.130002-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261028142843.130002-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 28 Oct 2026 11:12:54 -0400
X-Gm-Features: AclHuK8I90tryrUZ_bsOO0V6VrrjVRpF-B9KgyY2XOcHADdaKcDqr3l_zC3gKZY
Message-ID: <CAEjxPJ4OSmAAsK7OeefDa-miYKq0TRiK2L12Uo=-bWm12tCbfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsemanage: add path substitution helpers
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com, 
	Eugenij Safonov <ja.safonau@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:28=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Eugenij Safonov <ja.safonau@protonmail.com>
>
> Add an internal module for handling path substitution rules from
> file_contexts.subs(5), mirroring the selabel_file backend of
> libselinux:
>
> - semanage_path_subs_load() parses a substitution file ("alias
>   original" per line, '#' comments); a missing file is not an error,
>   and wildcard rules are skipped with a warning
> - semanage_path_subs_apply() rewrites a path according to the first
>   matching rule, matching on whole path components only
> - semanage_path_subs_canonicalize() applies the local rules first and
>   passes the result through the distribution rules, like the
>   selabel_file backend does when looking up file contexts
>
> No functional change yet; a follow-up commit uses these helpers in
> genhomedircon.
>
> The module is covered by CUnit tests (libsemanage/tests/test_path_subs.c)=
.
>
> Signed-off-by: Eugenij Safonov <ja.safonau@protonmail.com>

I have requested changes to these patches on the GitHub pull request
by which they were originally submitted:
https://github.com/SELinuxProject/selinux/pull/548
