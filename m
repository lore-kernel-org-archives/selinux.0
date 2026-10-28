Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793192778;
	b=GpKvmu78lPtV54zXuRf3u9J/GVbZCXHgDrVLhkxhj1LaTxpU1VoWUlFuZ5vItdYYVv5W
	 2n0HwFow0TiDucJT5vI7d/Zk159Nd/klRG1DeVQdS1Pqd12zc2/UyCpGHcyKpVd3gLUVR
	 dqAXISRGUjwVgNmgRJhjoI3ABPXj+aTWo6LiVz5PUZyJMvKHC862WUhqKn6FAB4rqAWLw
	 habVplvbm8C+Obj9/6gnaJlwV6pZraJAU0CJSLjjGybGLseZcVBHgJrpLoL/iXCXc0ugH
	 4VmHXsyCqboTJt11vKIXIV08wEpZGqjgTiunaKNrqDSdbEH7N8fkgwmdrYKHDR17rQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2obKUYrK85t4PdVu22FGmmiraACWNJO72lhy7JeIiKM=;
	b=PtWyonKT4K4BkFeSBGtwuheQoCgr9zssnqqifRMdmpcFgOOg2I28mBhV0bJ8nC+wU304
	 V8onvpiMlN5IDpvC9NjWgThZimEU+IktEFpkw/BQWdANTNEyONFJAhzEJvYaie48WNe9u
	 qcNic6p7jQjV6rngKP1k98Oq422tlCyFiGFwiZO5K6xUzSepGWXuWfKfx6TYIr+S534Jj
	 hgnsn+w1UnZe2owg+mGHxNVwE27r82nvhd0YqX5KbU2tttwTbYNo89oLU0xC4M7hvpQVm
	 xZ2DBNDrcknsaRTGhKKBzCO1ZHOVc5k8xC7xyMFTeXTjc+2WrTYsrTBsax6s0g34JtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9s7umSp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B12F606A31D
	for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 13:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B12F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9s7umSp
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-679965fb848so1048398d50.1
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 06:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793192777; cv=none;
        d=google.com; s=arc-20260327;
        b=A9hN0ren+QeGAzAVCJmL66os45G0mDJfcYamN1ojyB3kq309YmqtsQot80nhIUOEdW
         Dkq29Gii//ZnXx7cb6t8WwnuwpAiXs6vrt9azngc2lC462Qid0hYLjcG5ICj2sQLWzBs
         WM37wvZdMr/CuvAYGo2XOREqQ7mRWOozsUflo5fUCKtyrKJ9X+6l7SMzm9DiumRXW4fk
         HdBQ9izhe9GS17FotmmJsTF150d0/Hz7C1MNx5UseYNyqGdx1UspNab/W1mJ8qpkQT2b
         +lSfimiPonkA/wRL//1lKM1Sx0WJSi/k2nrnr2Q0Pl5hReGInaHb+3NAvK6NoTNWLRii
         RRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2obKUYrK85t4PdVu22FGmmiraACWNJO72lhy7JeIiKM=;
        fh=QFKa48eN4AZKFIyrSiZk3FCE4nUKAEfyzhRYxfFXB60=;
        b=FE5Hfcwv3fGXrqzaur9/ejzwqsqYFv1ILD5i4YtjRoB37AJbnM0dxbJPRqNu3q/+GR
         SqEXUpv360/yWcVUfcS15U5u6pRuwdQ7TvmKyBQXA/7gVBc8uAAobzN1VO6Bu3pIs1bt
         1cAnVwQ8oMwNSdRQGqOVUyKsyamO0XIWYphQpaerrEmlbrgwhqlzl9lrq9MzWDFl88Se
         mWdtC7yJG5Po50E6Y+xtpceTbz0SVWr4X5UsWdJ5UiMCrqa5aBFGIlBT6DqoVD4+7vIF
         wpttjmLI1fB2EaUUb5sa/LMEs2RCpR/NjerVmmKgm8Tk23pnEWEwAwaUxcKqf6V9Z+Nf
         7ksA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793192777; x=1793797577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2obKUYrK85t4PdVu22FGmmiraACWNJO72lhy7JeIiKM=;
        b=F9s7umSpKvPDKFeLCfRpFuyxJuQN1yQvlJjV7WqLOzU0Mbslu79OGy22PEYLTDvTHx
         sAFb4hd83e84dlh2BUfTP3VidGHYoJfMMg9arUMWN7LriNSi2wkLKJB1bUUe3L6QsxGU
         LtjT3SYexqjcy/AVDJ+IzTBLu8lwe33SZL5wUY2N6IPN2ZFDL2oSkfpxDdtcHSTbxjsK
         p/Qcai5MSTC6ml2sIhyt4Q5BmRhHeCG4B47qcsQNC6u42GtNZB2F1cKQLvBGb0cB2OuA
         F7jhUbFWctTfHbLrkiXwHMPVByKtJPrq/hKZ7CwRJNTFiU41D5/6k/WdSmV8x9seb3G+
         j76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793192777; x=1793797577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2obKUYrK85t4PdVu22FGmmiraACWNJO72lhy7JeIiKM=;
        b=jgL08CCWdN1UVwxiQFlFTOLKVj4kD8gq1GhLj2E7p6G0CLJ/wo+o2bMZ77zI91zq6L
         kAegmZRAX9Wm3IZNXpl3eBUR9WK3JjTNQ8XMj1I5z+8n6Ta87O+SrnVkbOwpsbBYFopG
         bTK4XzNAYrTt0IS0T/XpRIUFH5EJevuLtJbHoTIM3KrQjBcRryVnxBRguWJ01bZh0nTZ
         /oScVM/kpKcjXb8UEApKZpsizxjyL2uQGpkGPBqIUqCBRA6AyFAh37q0SroXEIUDbDiv
         u7TVdwqC/MDzYr/EZCXw0i5LDC7p95MeYVFwnSEssJbo8OGBiIdKxBw7+NE/pvDFhzpC
         EwBQ==
X-Gm-Message-State: AFq9FYIZKr9/GfU+PNqxwkKoe6HIbGPbyRJLoa0rsvtJU5eTsEMusutC
	4noycuuc+tA8jzxd9d0kkJV1JZwXitxnJh8NMEANDVH5B+b1NkK6ATpHRpIsR7ljhba5CLV8hQw
	yLf2kFQHFKChWFoQhFe07/HTE8ftSAif7UKNM
X-Gm-Gg: AYBFou0Jj0P65NvgtvEqaSm/weBz254FQAFMGWn5Whebiq9h2WjkI36BhqNATUBS20c
	2XUjOIroixD4ECZyeyRrWdxEU6XUTyd1+uyg41tmXGnmGYjCDAcn8HYB3hP8jJcV59OyfFkdAN6
	DWkShWDeAPDZg0c1h2y4r5GETgJlDX4PVUetGM+VDQ34F18YgHz3BzpqC7X5iCOSxxFfj21Zac/
	f4cJzVhqVy4nmpTHWiba4Xmcu7InNBREFu0Pq09OStaRy7eVLytR6+erXBmN8Pd3w/25khFh766
	qDHtWBFYH42pO36ibimpiqqTkUOT4VHwFe0mFk0KsCEqQmBxZg9/RVsjeydqDcyYrCxFPJaLMua
	J3KzdtC6mpG7fxUjY1u/jwamX/La/lYOrttLeScZ7bX1eI8W1/mOa5mJaw48ZaaoFHFDNY9SaXF
	MToDrSnzM3SfOnjVwszSiaxzm8aom6DL7UmUrWkkx25Sw=
X-Received: by 2002:a05:690e:1655:b0:677:d540:e046 with SMTP id
 956f58d0204a3-67a7bd22f1fmr1030451d50.90.1793192777034; Wed, 28 Oct 2026
 06:06:17 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027191327.91854-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261027191327.91854-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 28 Oct 2026 09:06:06 -0400
X-Gm-Features: AclHuK_3DvBIwclg6CRCwC6PeR-7CjUPat7XByv-SC_I9ENGXYRNkPP27Hzv9Cs
Message-ID: <CAEjxPJ6R53EhP2FU+6=P2AhBgiy1-mJPSRQVFYXbM1Xnctn_og@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: synchronize user join caches across transactions
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> A local user query before beginning a transaction can leave the join
> and its child databases cached at the same store serial. The join then
> skips the child cache synchronization when modified inn the
> transaction. Commit splits the updated records into the children, but
> the transaction state check subsequently drops those changes when
> merging local components.
>
> Track transaction state in the join cache and invalidate it before the
> serial fast path when that state changes. Rebuilding the join
> synchronizes the child caches before mutation, preserving the split
> records through commit.
>
> Fixes: fe595f540127 ("libsemanage: preserve read-only store overrides")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
