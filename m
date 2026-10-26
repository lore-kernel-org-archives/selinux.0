Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793022324;
	b=qcR1oiN3wrL1l32KTnuZRDJKC1pPLfF4ZFwsdFZ8aGLQ0dvjwkytjBzqGDlSTAGA/pO9
	 aRrMI91PphpST/SLVt+zKBf9NSV0ODu6kvP+0q6s6GAWMzILGBtUKDanwcIeL2qd9EHl/
	 VwcYf8IOxw/1Q2l+XC+QNDhAz0dPZCR4T9HwzDEQCnKwx+njyO5l4AjQOt+FXsNREtbtv
	 iXBxTZjWuHeEkSxgTrpA1cAwGy9rK1NVV4OraW2iYFaTLfzLKIT1Ug19pbUZ+7cPQ09Lu
	 6s56tUKh6cLoDJx/G7ce3wXOkFWJNejtcDjPXK6AYS1DyD8MqxSmOVpeXd4u/AnUc4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=boYaRaakD3uOQzdBZF/nw9GlvnqRJU3zpejMnxH+L6U=;
	b=2ykmXaw/a5zG/GxIgHEkUyPhq+3SsfOgVmTMd2+rjTZlZabv1OEox6ZyAC1+IzUUJebS
	 uDx++z1cZMjgnCd50ZZdWvsabx8M5n5USNuBCYqLhNB/1HmaBKgoUTTLL0rI42q8dtZx5
	 x+QjBa5Qwu5C8yLTLYYmbOvXciTQJxIzy+EQlh44jE+HAGkzqjhweu0Y/l7g9HX7IfAjC
	 jxLtCaYX8dX0PhpTFZtIqZvsDr4F1H3PN1wCcroMa85X8fC3rUce4YxDvP85himfKkLGw
	 yvH49e9VWZyqhP0OSMfabTIa2y6b02IKvRRUd8NY+bl54JT8bl+baGXe03GdOKHJwWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FTkMQAsm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC413606A31F
	for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 13:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC413606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FTkMQAsm
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66fca0709caso2377760d50.1
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 06:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793022323; cv=none;
        d=google.com; s=arc-20260327;
        b=YVN3akAABQnSEBmSWDKe+C4pVL6luv9avxiDAhqq0HRkv9qwZ2+0q8M0ne36iKf7O7
         JyIFTl569EAmt2eE/m87CnD6nomQGrvOmIkHffzXVrBIAz4zUb9kVHQqt+M0A4W8PXBW
         +Z9FVJAv+kiH/E5mUbmbJP+VC3JrzAjoZFAeaZGO3bWC0TvOTtOwiqiTA6ZdkyC1zk8q
         MXXxGPTmHSkKZgfzS3D8JDFECHSzS4XoRu0RH0Pc/gqrt2F7Buk4hENvFjLRcOIAOsJs
         2L1dxbhMAT7MXzQEnCzwdcPkBTMG14OP00ddGXlm7s6GlT9KlOZnFoaH+2GWFVzkQlaS
         QW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=boYaRaakD3uOQzdBZF/nw9GlvnqRJU3zpejMnxH+L6U=;
        fh=oY3YJwlQJe6qc1tfsT1YP2sL1SDhL9BUcCb87gGht54=;
        b=bZZ4frqjM5F2iQS1o0OOzvd1jSpe1FBSbjT81Ogg9baGXlTAHpuuiwRm5BAlyE+2Ee
         6UF8u4WvP6AFuWrxJoVe9Q7CanRSKMfe/DBeajbbeJwap/kLp3AMd57lHt+qFV451bJ6
         dI4lLeX3eH5Y/yR+gdOTVd/gFRb1tRQeOsUcnP+v+iBwK0p4oaj+WsM2t33IT5Gm6FPu
         oPZ/8Z8UOmaWnA72FKYme9cbxV4V5Py+tfPDbI76I/jq9wtkF1VRaaZV94KKZr/vijcy
         1k2/+dyPazbzmmD6TBfgmL6jwUJz3tiu2ktdKREldePWT+lLCdIx6ldC1HQjT8rgAXR/
         hX2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022323; x=1793627123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=boYaRaakD3uOQzdBZF/nw9GlvnqRJU3zpejMnxH+L6U=;
        b=FTkMQAsmeNpUfj7AAzO+a3+QDAlTPye2HDn41gnlyWac2x5K9OCOqgnqoXK2PyCYAl
         KjIInSW+/d5h7gln7jpuPjOhPsC94HOZ1DWCDdIbpC4TjMjhi3UllOPpSD6fKhVO7VA/
         hlRiNA+/pzfHyx99N1/tQjl0iYukP3s1knhUw+gNJM5JdtYxGpe6CBP8d1sH87Cwb9/e
         vKUMvNx4pnTB22wK8dIxwBQD/Rx7unL1eyL3KItAm3tAFMqhqGhGNLomwQqR6TwFNY01
         vMTQVS9lu/UHmPRp8GGtefcBL/LeN3OK3lattx2epVyW/sCWEDqks0Fiqm00wVTPQwMC
         Yvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022323; x=1793627123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=boYaRaakD3uOQzdBZF/nw9GlvnqRJU3zpejMnxH+L6U=;
        b=ISIM2N9ITSRdklQlzr0sO1TENdkwAgsaJAtNJyQZVjJ1DQkVpWVVX2eIRInNkj9fdo
         /Uez30Dxrl8jMSRLNIpOvT2+X9ySgENkUweNY/xzCNJvJ5jyf656S3svdVpb7gA+EOfA
         v5DOhNOf8pd82k+SoAMK7lFjV38wFqUCoHprmuX8EsjG8OlIs/lq+NP5/uCuJEOov6pj
         VgYYWX7KvQVu0OfeFCrQzv0zolkFBljmDApmpXUZjzVXGVE9yXu0Z9zv+bFPDFUUUryj
         hln/IXc4yf6vcYMv7839cbzCc38DlTwRKLFky43yF+6V3wSQo8np0MO1HuZWaZDXhYLq
         NCag==
X-Gm-Message-State: AFq9FYIDb8ULuVXzAVnIWS0dfPVrSdTztqojR3Zo2fDuelGDCEaqsBsz
	6YLekf0Yhz5m+UxMalgrRh3jpau5B/x6PtcaEx1hRfWWYQDhEF/eryhfnnLgYrUpsWMG96xzgHs
	RPmZv5vvYli8IQzipxJgtlv0+TRYgJ8xbg2XtqcU=
X-Gm-Gg: AYBFou13fgdkk7nCG2rX50/iUIUTEb8I96f1leJP3ul/i060he1qTA0pq1XGR7hDDNb
	g929EpWjf+sd6sJ1s7n88MPAo1yOUYLpGN6tHD8F8yQB0M46l00z0Zz3SNvprRoYOQfDAR6SMJp
	kCp8EVPe3nLJ2CE82+Jk/9Ze7hohkMwHhqOqVEmeUSzbuZkfPxOEQufpfo7O0iPyPJLX+gCQQOd
	GYcJLd6937479EfbR7scVAd0BgE8L5nWuhVVUbZ02opBHjX+T7JWf0VQpfCnlAX2gXZDxi3KziY
	qF0dk9fISAnRPx6InDI7WX90WkyeWdfVlKinIFbqdeIoek7hHXgmRCxp52SwNdbbtFw3b1TGdv6
	qq/YHem7BLOGLtO3HUmJ3DfSGJTGfCEKePIdYxndNfaSak5JSJzYFJNybpc2q159jNXqc9iJ85q
	yKUydK/Zom1GkANJrHVlheew==
X-Received: by 2002:a05:690e:b84:b0:679:b48d:4adc with SMTP id
 956f58d0204a3-67a4e796a8fmr4340630d50.88.1793022322566; Mon, 26 Oct 2026
 06:45:22 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023192133.63279-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261023192133.63279-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 26 Oct 2026 09:45:11 -0400
X-Gm-Features: AclHuK9RoWqY-IPvR8vC96WmaKS2wrqrxwCz0SlsXaA8GIEG8u4AxWOeW-nThdw
Message-ID: <CAEjxPJ6ZgA4Req5HN6bpMs6FSn7fs9=VdONmrxofEKzvvAfrKg@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: handle module writer close and cleanup errors
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cathy.hu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 3:21=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The plain module writer ignores fclose(), so a buffered write to a
> full device can report success despite ENOSPC. Check final stream
> closure in both plain and bzip modes and propagate errors to callers.
>
> Also release bzip state when finalization fails. BZ2_bzWriteClose()
> returns early on ferror(), even with abandon set, so clear the stream
> error before abandon-close on both mid-write and finalization I/O
> failures. Preserve errno and return failure after cleanup. Without
> this, a failed compressed write leaks its compression allocations.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
