Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358F43A7E7
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919736; cv=pass; b=lS7q+La61AjiY41HKYkfujNqrSqZi/S354xWtgB1MPHL29Yyn8NsRzELt7Ccm3VFhn8zcmtz4ZofyfxBGIxzeKRTbJaQGditHd0j8HQUb31b/aWCV5jyrX63HFoB67Dx/ga85mbwABGVsdaI9WbzXUkv+j0WLxTG+BULfuIJjA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919736; c=relaxed/simple;
	bh=GUho3u2rHkjDTxZF2TfTsxQQ+jGpXCd7B+6fsUvAYko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzdMgXM+Adl1W9VCQueKD3NXi7SjnIqGjaBD/FwXBM6QJaQC8OdYYZYW084uQbbBT94Eo/cTX5WawcJ1mAWBLEeJh9yZJ8FJW3pyosH+I2HWPdtkMRtFkiTF0cjOUjSKgQZy0wv3zG/89k/nCw5nDLV+Xi5HvSd+a+DIwLd6vFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+EF6UxW; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+EF6UxW"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-45eb2e6402aso886156fac.0
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 05:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787919721; cv=none;
        d=google.com; s=arc-20260327;
        b=joUSvBaqdMQrcvGJgxceRONZgvPK8qfVzdlqIvcjUM7guR8K1+5oCNS4HNpFwJNjOu
         eqzZPjw//OnChoOJGM9WPM32cbKeVT63ELelVrpWtCWTGahaAs2hW0WJnpW2hm91uHKQ
         9Egx3rqapEbhtP+V8PPnlgVDrfRCt3sxmd+LBUfXXRpYbsAbyU3NjQKi3ZnmyZzAGwRr
         xyZpVCwycDeTngwQiKBaRjFgSzdd8gPQGmc8D6pW4HskzuXJFQoyAovD0QuLGhDFFNTj
         AsX/6Ifm2P2AUYsfSujU2iafQuXU5RVpn9PtIy4NBqgJH+yUTo9aY3IpwCuBjfhGUJit
         hAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GUho3u2rHkjDTxZF2TfTsxQQ+jGpXCd7B+6fsUvAYko=;
        fh=6Z9A42VeYxdo9nuAnOQLwJQj0nLbodXiSQCtXYE+CZU=;
        b=UZKTFRIsBFIeUJlWxgopj/CBRWV9Fm1bsPEH0NlL5H/x7+5Ts6WJhLLiogQjSKXE+n
         CAns8SrM6kEKF7TA0O07k0FucJce9v71s7ksXltQv7ADCEauV2znk7joe/gf5Qyccjea
         8AvYrJRchM6faErXdlDws93YcIFSKLTbw9A0/B0mwxPGT+zFix60JR9CSDZcha9hIUUv
         GP33uVzOzeJYPGBdzV6+pdcfxUbKRlA5bpzol6/Fq6uD+ZSFwNZUwisnE/XkGR/4jnV4
         AgREbsHWJRpNOPIIvXaqRB9WBoSd2IQOgDKdUUW7GNkRN4Lwvqhf64107j72xmnMnJlj
         Z7nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787919721; x=1788524521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GUho3u2rHkjDTxZF2TfTsxQQ+jGpXCd7B+6fsUvAYko=;
        b=H+EF6UxWUJm5A3iygWOsxKqwUDcilV/T3Z6LJccQZKBpr/VykCaGgc4YWtJpCM2em/
         Yc4MJIs5lcIHCi8qrwnF8mTqByi5JPlVD5iwuJla7589a5A+F8WFl4OItv1aRfZzRYY7
         FdB+k1Ja6XfsPDwAVMc78zD42ywfOAqC3RRbrVGNGKcl7Q+NZda/Ls6cAq4k4oy5+FYo
         XrpL8zUS1Z20esay14idfP6VsDXLn95EkcLCzISryv/dyP3f6OmtcC8abVca6TAwsus/
         jzosfe9PAzIAhkrmqOCSUZf1hvNr6vIuM/rxUpGOa8VOLzEs34grS5Nvw6HAzi8g1Cuc
         HVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919721; x=1788524521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GUho3u2rHkjDTxZF2TfTsxQQ+jGpXCd7B+6fsUvAYko=;
        b=dofeuMZdCGgi0NTOKa9f06wx96lKZGQy/C9gou8TlwBSGolKIQfSPBHIJspfwf5Qeo
         D2rkHfAQM+5yyKXijdESGxMOzTL59cgv3NCIIGURRVi3sd98zvtcMAB6YgxNfzz1yu5R
         R/6CXurIDvMzz8DkBCuddFjUAFjPosASfVJ3KjF7Y42BVDfuv5gC3Hp8DEMBAFKWKlXy
         Em2ESQXb/Q5QD8kA9SShBDf9rr9dMxo6pWEgQxksf2zZ69DD7crp6MzWx2KJPp6DSYub
         z16apY9VNuIf/LXLnJFBdYh0p2Gc92Yl2+2/i9wNkcf8VWOwPj9sJjF4y6prrCxL1oA6
         xh/Q==
X-Gm-Message-State: AFuF++loNzJhhKrDT5l8W+EufTVRWtfexoCEdpNbWz5Hfe3j9RkbX4Nc
	UWbUaUW7ctNGx1vTgQFizLgVkurpj95rXzFkHtg15ekuClc4mMmCyeMVk9HQ3OJQT/CKSEyuX8P
	FPtQxg9R85sSmiQ3UtxHrL1wvsAyKsuIQLg==
X-Gm-Gg: AR+sD11sZhZSpC+nMvldUVMCmkrFLt0xLO7okhIlz2YrHC8q6XLeSnL0iKFDxd996Af
	ipsNpu60UqmtwtpLzYspfap849+sGmgZJHalRoF2FFrFNvlqYPcAu7TXBPstEHTZKgZRRYYSRQh
	8K8C8NoWgQui6fmil3aSCSEWNs0W2rEWNblKkdNFlPjKG7cJwjPa1aNObxKiifMdYCw0s88bLnu
	Lr7L4VF52rRhMtGCV7df6UkRj0/xRXAmaxsCF13TvOjltKzDUthk+LxO8QLqJHt3wEXK1JYLvIn
	zSuYdb7615D32K1mHY2/nJ6Ubif3nS38rWHhGT1QPDlsynIggC/ymmA=
X-Received: by 2002:a05:6870:c1d0:b0:455:9a0a:f40f with SMTP id
 586e51a60fabf-46836af1e30mr6820856fac.12.1787919721451; Fri, 28 Aug 2026
 05:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827185151.21459-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260827185151.21459-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 28 Aug 2026 08:21:50 -0400
X-Gm-Features: AcwNN1Upp1wFz5BzsJnzsu3stTtPmxZtYrq_eMzGYJEKGUwg8N5qL8yx9ZSqnWk
Message-ID: <CAEjxPJ58q9vDwTs8g6hMpwKhPirT60O6ZK+1gwjGgH5NDONmGg@mail.gmail.com>
Subject: Re: [PATCH] scripts/oss-fuzz.sh: revert building PCRE2
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, p.matyas13@gmail.com, pmatyas@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 2:52=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This reverts commit dd3d5dfbde4d ("scripts/oss-fuzz: build PCRE2 from
> source with sanitizer instrumentation"). This is no longer needed
> since PCRE2 JIT is no longer default-enabled and was breaking some
> builds [1].
>
> Link: https://oss-fuzz-build-logs.storage.googleapis.com/log-2ce3e78c-3e5=
3-41ac-8009-41d836af8130.txt
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
