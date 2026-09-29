Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7C3AE6FC
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699034; cv=pass; b=riAq3EeRElsxNyY8Fmr5Ns3e0KKSf3B/fgxsjpms7D+cMIfOHNoZtopJe+7Qdcdt+VaQjRuXybMpW6HuOSv9zOGg1DcFN5FGc4uaSao1S/clPbFRht4kmU1W/PJBb7yni+VcnM85ceoaqBO5V07YXqeZ8kXErNbvqkPDpP2l2EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699034; c=relaxed/simple;
	bh=g/ewBucx11iB61ZTycrLfTZWTSIGC94d/M+pGbUmWGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuWTWSCMgvsO3mUV7hwI3dQtIuIFNNbFPjDah65BeJ+PRpoZokKA9Ld/DLcAS1ED1IrQIkxjDed8rm4HZCNKt++w+fgWghLG1abrcVZ00Fn/Z9ko2id7zChzkbamvxZLIABkM++5+ypNsXLRFRIHfrdtdbQosLPY0n8Lmgznh7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrTM9Ncy; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrTM9Ncy"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505824so38436317b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699032; cv=none;
        d=google.com; s=arc-20260327;
        b=oehHCz7Hr3xTfzzZDdxaxAhRQjkymasg5+sXK1DCOvtb1sRyiERfce6MSj2kQ+E/qr
         rIVAc2qXPtCtrLgCI4fEJdA31DrAwEV21KU9sICULvqgQ+fBClmbKbD5t2qCM26ocjn9
         o1+gI5FIcYARCyLYaEstikTNGuW4hJJxdg/NEdC3HpueVspd2R4gXqco5IoFuMUyNpTI
         AcmJasT9Ny++0sfskgfXQQHef8wfAf+m8ugXnL+8Dn2ioWS2Hxm9SxoNfy02N+QH2ppy
         y888lOiN0nzX9LwpTBp1fOSQQvGuM6phhKBtT8QwX7fi+BwiLNrI8aq0wNLoG3oxvbGW
         TfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g/ewBucx11iB61ZTycrLfTZWTSIGC94d/M+pGbUmWGk=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=s0y+XXu+XOkQHPhJC6/RdwpUi51CEZDIbt+XsjXp13Je4Vf4ff5r8jKCiMm9T7cZL3
         gKPHLLOT5vutytj/apOO4nHlITSi2zETqaHbY8NH9593biK7Yeilyxqa+d3UkhTqcPkl
         n541l+/4bRQjavW7ndb3Fh2+mEnhepC0CTScdXYabylbsKnRl+rRLxg8oeg1szUtxGqQ
         4gKo4utKzDM+A0VIyFKeNfuS1G+7lIzwrblkzxuSU8ZNoY3xLP21VJeo5Q8Z3Rac4mRV
         hv3Uv+VVwqhqICyxNnwZtinkIVXuD2Q0d5TISErH93caG/FVmIdknfDUjs5QhwjkCToT
         bncA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699032; x=1791303832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g/ewBucx11iB61ZTycrLfTZWTSIGC94d/M+pGbUmWGk=;
        b=RrTM9NcyTCV2xsSk2gSl7lfpIpBK7/bI6bu0UvYxbHR9hRA8xfsHH1WGc0o4nZNVdg
         tRbudfEhFws1dIXyPeNjoRUwyUPcXO6/faZj0SxNnRg9PhrRZ8gLaZmeivezcDjyR4j6
         zwGPnPND8O3x9uiS3MFgypau4E82c465GoBpEBEjRr26pNXCW1/SCdCPgrNA9kqw9H6D
         2ORtjRNP9riCHrFUM7m+r7IEcj/1TTRwoTOIti//6omLrLD8CZrgpc1pHn9AT45cNOiq
         4i7OrC33hS82ZIU3oktYP1uOrlRGSpy6r56mp4Skgn7ab20xVFGHkZHIcdVVE6GWjbi1
         NHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699032; x=1791303832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/ewBucx11iB61ZTycrLfTZWTSIGC94d/M+pGbUmWGk=;
        b=okmnOg7plFyC3uFPUBrcH9Kzvh6u+l4vtRm2Kg27f1nnwphBKpxcfzHYyerHBCAd/D
         cwJZAZEorspKhzu+UhkofvXC4M7V/yRKlvg9oNVxe2bxTy7HZCDWT0n4NjvviyQyuRL/
         s1GVN3RLJ4oHJ0um6WHVsY9lMMawAsbLIvvAv3KdIA6UD14LeeuGOZy6hQ2wpiyIxnUO
         Da8gg1lbL/FKI+CuftEmg8+PdAZKtjr7PkIYLvvyDvN4fmvGJl7T5UrAqeegLoVRzOAp
         EBUVQcbTXz026gOklH6DqOhDnqavlZBrvFDY/iXbrUR6HYsdr6mahN0U3Xr6ZJnaz1vg
         bzTQ==
X-Gm-Message-State: AFq9FYJsDEah9uI95nENqZq74yZ/K8Q9s/ZwlaCiHMstKkwfbc8TwQYO
	dtv+4MHCybD0VcOKQdYgvFPh+Ii6I5EI/TospmydyyqilDc0zAZSH8gV5QBLLG4UljK0SH26199
	/NDEUlYZMVMlh5zczOcF4Jb7CxUa52+A=
X-Gm-Gg: AYBFou1ReSqle5NJg4uLgfdMEv92Q26o63OxvlQBKHjoP5OsJZTJ/DbiDfShz1zErIb
	TFumh6eenet04FxAscSpjejB/7b/0OvKu8PYhJGI3HJAfsXBEsjJERQQMzrYOM7ELUKemXrf3JI
	wGhZlXp9rl6g8XCNdNdwSdILDT6b/wpJ9kQF8f5qPKBkJfaQ2jYars0WNFOryr7iXb4K+PIPijv
	Mv7Vuakz2+FO72sykm8qvEMMUEmDzPNjdeXNb5U3jCRuDxnXouwT8NLBe1Hj9SOQDMnOlqcAU64
	0FhW3lR647f4VmsxLeNsZnUjTYhtQa6R1DUOGvu4xqjA7O3cRGLzwwsNbSSshjoM9w==
X-Received: by 2002:a05:690c:6112:b0:8ab:41a5:65b with SMTP id
 00721157ae682-8ab41a51829mr9404387b3.9.1790699031686; Tue, 29 Sep 2026
 09:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-7-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-7-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:23:40 -0400
X-Gm-Features: AclHuK86nTQHE_LGdIJd59Y5mlwEASzI9UuYd5Hgn30lxp6vfOX00DAiklDn5H0
Message-ID: <CAEjxPJ6xKJoLN9cgvL+odUDSSD6w1LU+NJUQadZHR=deusThMg@mail.gmail.com>
Subject: Re: [PATCH v2 08/21] Makefile: use $(MAKE) to pass options
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:58=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Pass make options, e.g. number of jobs, which allows to build multiple
> test executables in a single sub-directory in parallel.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
