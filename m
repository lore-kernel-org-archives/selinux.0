Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875EA314D37
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144110; cv=pass; b=frkKu2vEBxOyKctZ4YPQZNGDrzqxbYEaSN+J91L1X/j/8+bDfeyCO+LfVVPUNPp/EdToUpquQqdWJ2TBZYuDWv2RrcQIgw2xLrDva+iJbIUBN5ZZ0ouIm6GuvuN+4WckGVIzwVWuqYieIn9AkiakDi/UCngPXNtclYeKdhLbwTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144110; c=relaxed/simple;
	bh=DkT1OZVDHVfiPEVraaiNK8JHh6x7MI2LZ/KPPzwe4Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMejQ7pQS91FPqWzR4ooqED00sEdg7flqHFK+b05dgUklPUVLj/22xMc3ZVztSO07wW5RDTKIm756ptAxm00kjkel3TUUbjFcBxRxqIgvhNa0gZa7b2qqEb2Lxc8I5uSLW7odkMeuw4G9h1RIYEBfgEcQzMgi7dJ2yU/1qPxxFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJMKi9XT; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJMKi9XT"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b145e2ef51so56363eaf.0
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 05:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787144108; cv=none;
        d=google.com; s=arc-20260327;
        b=IUrFs9tKTIZYSrQFl6dZJNfiyboOcWNoXtrV/iZlnmTNHI4lHmdoYC9v4d1MX2ageZ
         0xZojPfW3bzcAbw2SM/2lMAstprigDAhb5tBCAlOOve6Z1LGpm9szD4Qw7DUqxqH8iWn
         L2JvV6sM9v/OXesjfa6bjsHb+daFdlsV6tJHcbefFj8WMEZP7U/K5NmxOInFS+/hx94m
         S3fodlpvTAg8xz3sD8GuvxSxzig+kF0pKd6V7Dcnub3yMcgoD5iN2fbxUv+rUjp9caH5
         U4r2HNWqhAmoZXDvRKDg8qScmJ7+YeXBFL61vRG71mJKpcm0Np9io441VLYUPvXnfmYj
         fL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DkT1OZVDHVfiPEVraaiNK8JHh6x7MI2LZ/KPPzwe4Ww=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=fJ7hrcCOUbM50h5K1azXF8AewI79uwT1Q9/9hslHZFmnAZadlJqN4jB+rNI/YMrWFW
         4f7MZIiGXMkUEm4XKgZcoa57rikX6c3MyiVJhLCEFrDhw5jC/Hd+dy3uwnvWGDYCTxuv
         YDQ54EeNnw5hr2nkADOVsI4M/JxIXCjb9UU4dj9mik1gj5rAoU4DBkP2XRObLL3r+U4N
         OCig6DFwyM4nIoehgzrvpLls/PvDvwHbvkp1FG+6WaXC6qJxichscx/AvU+d3eKYZAl3
         aT6geBSGaSIyOHnWTG/bUzKRdU1lv3fn1pEarm+3GS6o+quIGB9Y7IK1MXCB67grQ2ua
         /Z2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787144108; x=1787748908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DkT1OZVDHVfiPEVraaiNK8JHh6x7MI2LZ/KPPzwe4Ww=;
        b=FJMKi9XTcyfzDrAYTo8fIBm4jg6hJK19pJnaTPcGiunCKDUooT6Qx4v8pVSeJ4JkVe
         xVyPrIbOflcBv50g4Yk45bNf8ZVtZgbKLMgVngW5OnnaGFKu0/tsq+Itwyg+ehDbFeoF
         zMVq+vpMRM44/vhEtH1QIDBGjckUQgFTO9cNU2fCBJZSgkqwNhRmCd7mE7DN4Ly+/OAi
         QdFa6DCngcOdRz1AxdX8pEygKLs/1rkuhZEjNOujF1ufPF5OabwYivJ7wkXC+kzmqUuX
         +uOHqygl7CblrdQcwMhW60ZJueTVE12xpgssiGbhFDa60a+f5ObB89NFjYMCJ2/+Q31l
         txpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144108; x=1787748908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DkT1OZVDHVfiPEVraaiNK8JHh6x7MI2LZ/KPPzwe4Ww=;
        b=dAI1/alMWHSlj269Mt6EPVGplgfYPE2JPsz7utksSQq4Cboe0j29VxfX777VI/L4FW
         +IXClu7jXaeRvEhpOjW5WqmONvOPOQIToVBSfE++y/EwKTV1Zpih5h9RETzi0McQ0TWK
         wI3hgkodhWCZbTfrjDV/b60ePgCffQfN/4ioEZd+/UjcTJbE2FBCy6tHDI9uJRbm84XV
         QFs+3RDqF9KcdUCC+G9jgJNdu0Uddzc61AdIrI2soFy30ge+43rxkPgrr0S/lSIK85eo
         HPWeQBDvr0Jd1uLTJSfsmcWLlCGdITrPm/TxK6L7tvuDvsiT7n7t5RLNkgKIZoEVy4Wr
         LolQ==
X-Gm-Message-State: AOJu0Yz9/QlLOE5TahnMMbqrg4CJghEVCl4PicwktG8ouQPh4Umtn9Os
	F5EbQ/Cqg/gg0befpJjC8YxH/0h/MhE+aN01FtEnfHUyUYwPVhQvYBVu/DoxC90EgEc4NESGX5P
	zfkLH/NIdsv+XNX0QGjRI2rC2kiDGuqA=
X-Gm-Gg: AR+sD12GFp6l0Howd4L+OdpgN4nvAEkIZ2Cbq/+rbbam31vuVqoEuzh1sVu1bDbuX9V
	kTWm82mSqMJzVjX6SLHO0HtlbhdA9YHHQBQK/BQHBk979bKU6SXwLdlkxKxNWCA3rK/5CuWTTa6
	Wd00QYe2yJIj9kXqHdSBh0r5xUdP8hFdLhizbqcfa422Fh94L33dJdmZpnkNireZw1/9Tr02/SP
	Do87LP6xmpmx9CmIfq+dgLb3WffffTB6SW0RomHfrn6LR20hp936QvXP0YYPUMPLqfwk2Lx2NCq
	1+0efyt/icqIiAr6a1ilFW+R0Fg2nMji6IiM0nK/fvdl
X-Received: by 2002:a05:6820:4c01:b0:6b1:37e6:92ca with SMTP id
 006d021491bc7-6b13c2b8735mr3946605eaf.3.1787144108317; Wed, 19 Aug 2026
 05:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818194827.64744-1-jwcart2@gmail.com>
In-Reply-To: <20260818194827.64744-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Aug 2026 08:54:57 -0400
X-Gm-Features: AcwNN1VACqKQWf1xn0PrljCeSYYmrdUR_flWX2O5kDJ6-UJKxjhadtQR_-C-ttc
Message-ID: <CAEjxPJ4HtTpOai8=x_Oxa_Eqj4FV9PzUoVq7TBzV+FC=kHhtxg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use matching integer types in scope_write()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:48=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Since the variable "items" is used where a size_t is expected,
> just make it a size_t.
>
> Since the variable "i" is compared to an uint32_t, just make it a
> uint32_t.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
