Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B254F30CE
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534897; cv=pass; b=il7bIiR+rKvvjGMAPbsNy+SdghvSt1D4Y8rGHup5nhULHy1GSCdaE0O6521LD/Z/XoOw0ZEXcBP9gdX1CNUdjdgvjphxmOdByy56Oz/3rtuydvn4uEUfcko/m7kskDl2gNLJP3UtZ6fpF5VtZwwVi2TR3S2P9oY+tWtLHeKs6zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534897; c=relaxed/simple;
	bh=zpivI897UGntLDFCzmg6kkqSBsy4nZjSma+RP2JsY9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeTgxRZ+WFWm8I9xLOFwG7nUWwiu6PNzI8POdDTeFuTaXizWtoojAPhWyIkhMB9l8rFJcoymcNGbR3KBbX7IBGxxV9gCL+RyarAholxs6TDlFzvS4CyX1yl2SKo/GMz5tPpFB8AIzhYU/a2ymQeqY2vKoI4mHsyRyF8hwePlqXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D84DZ+Xm; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D84DZ+Xm"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f4ea388ba6so1175642a34.0
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 08:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788534894; cv=none;
        d=google.com; s=arc-20260327;
        b=NJdmLQ9NNRQkO1mlap/DuW8vBYQ65zerQnNZyVpgaOdlM4ExljMXVj9UJk5BWPHZJl
         wbwEW+OknL1tsJnGlWHzuX65EazUNrvhkHnRixC2nVF4Z6+s3EgDa5IprHhydaOA5Fgc
         9r3pNd25BK5xw+GEo09ljqcUMI6uioBRzE8q3PxSnIH9Z24qeXjFS3+a7Ryrb3W1ONxN
         YXreWP0hn10Cippap53aG5y5QFBu9YrhLcy7b6wJViFtVDaB3q4b0t8DjOyMtze1D8+S
         z5t/td2KXnHPak2LYpPWiT4uiyL4lfB5PAGSE0XNg1NzEpIa8kga9yhP5EzucNTQHDxA
         pHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zpivI897UGntLDFCzmg6kkqSBsy4nZjSma+RP2JsY9I=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=TnbCW6i9GtKRO8vprxZ8WuO3bfUkuTb1WcGlCm149RqaD2dLK9RBzLZzC4dCWJ+GaC
         qD3sSHyqtG4WY64+m3lNsMSuU5zTs5D7onQFP2fR3xVhisYhyoP/IS88T2x4/WbOPPY6
         1funhd/SnscudgCmNw7UzAXU975P7xWtWKQjy+eNywhI6FTRxergRKrxaQOSOW9jaF5G
         RB1MYnS41sIPC77b+vQQU591djWdJR6DLv5D4WSHZpniqlXriYrxnUr1bdoMXT+OPnkH
         T5S3xIcaeWJrsjH3H+mP8bSocPI0tfzh3Vo/eelyjByDFACaRFGzfuqL8xZ6Y8+rIb5a
         WdFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788534894; x=1789139694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zpivI897UGntLDFCzmg6kkqSBsy4nZjSma+RP2JsY9I=;
        b=D84DZ+XmUu+jhMJt6DBdFt0eCuvnNq0kOEkYAApz/BQoFfgPfbwn4xADV16sPaJCsJ
         bDJxxVIo5mY/L8PIDMQ5SWhMPwJfxRCNUjv0/B1BOdoEJ7C2Iod+jYKnSScdzGrTikEE
         d5FSu5ASC/UAaddduc6B2wkZfHRp0q2BVpFISMGc6ESdlr6YRODA6ZTmsFeEDD+38+ur
         IHy3hiJ1gCUjJOIvDHwLaHYUAV9D/Y6El0Eick4LqWk11fh2icdnTVTOoy7BKRUy7pfp
         dTI/BSTi0ulQJEXmXyRx0eQeH6gaUfrO93NuKPCZ9tISLtNgruFBQCRVT1VN3si0iRZx
         G2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534894; x=1789139694;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zpivI897UGntLDFCzmg6kkqSBsy4nZjSma+RP2JsY9I=;
        b=LksVdA8w7WdQGqjRnEUVrcAsJeaKqloW/VvlD7Nm/owNf7jMLRa3a4iP60Z+fI3EG7
         L1IPsOsYLZQpQDLxLLxUaDwkTLxfDLhd1zfUFlPbfwJOBr4Cdn55unLZTlyapq3zyhFv
         3gcUwaGOkgzhh7fhQzrtPDPoxzR96hxWehOv8eC6GF6amXn5u29GDqaNQV93oo9D1wky
         gShGgB0HlylF6kuIhkb5GRR22AoWmCzDHAWmKybWwGTHfm2vK7CqrQ8TdfuRnG2TLE4Z
         JVU2w7yPMm3k55+iaYls4A6U9/1NqaUadg3O5Gk8ZKz/bAb7/M49fgaZ2S6IyS03/dkQ
         0lig==
X-Gm-Message-State: AFuF++nnDPowSCNt6oDzUFimkvefxc3+iOhwo2tCDauJXFgpBIJgvu0C
	ahj7V4dwrhVme22OfWr2rdrJco+jXREfz210Bzye0gICTKq1MfdlLOZiv09pAMG1XbQ9xAIVVVI
	i7M4sV2siQJTW1WWCYizS47aymmALmXvbJw==
X-Gm-Gg: AYBFou2iYCWgrcIid21WD6rNCSecjOS0cEnf4kXVhluWFdQwj9ERtBvE3DaHFVN95M5
	K67sVJcklqLfSqSFckPpiX+0ZD//TQcMVB/+GWATdSYQleyW2wLqRSem2n7JUsf2b5wjlbJSuhr
	4G3gMkffn5+bUw6QBYBiboELzL088dqpSboD99BoCOM2470Yn98U14ZVD5xVGbztjikRvo+/9xX
	v72+1pWne0HpdIAVFMpwhrLn65M+bOUHyE9C7pIrgQ/hzeLoTjTkqK/Lo85jtrYJ0QRhyezZbG6
	vTr3qgVXjkGBqkxwN2D07M+le2Mh7c86QRfxQo79dmry
X-Received: by 2002:a05:6830:3106:b0:7e9:c102:333d with SMTP id
 46e09a7af769-7fa1f41f108mr4574159a34.9.1788534894089; Fri, 04 Sep 2026
 08:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902182803.9789-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260902182803.9789-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 11:14:43 -0400
X-Gm-Features: AcwNN1XE4Eu4t-RmtMWAyGaIwxO8iCXk78IpbLwFokT3huh8lGCZ78fZrLIsmNg
Message-ID: <CAEjxPJ6Hu61p9g--E2GkEna5Bdb_sjYk-X9wLxUCP94C_72ErQ@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol,checkpolicy: validate devicetree paths
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 2:29=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> devicetreecon paths have their own validity rules specified by:
> https://devicetree-specification.readthedocs.io/en/latest/index.html
>
> libsepol was (correctly) preventing them from embedding control
> characters but checkpolicy was not. Provide helpers for validating
> devicetree paths according to the specification and use them in
> checkpolicy and libsepol to reject invalid devicetree paths.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 makes the helper functions inline to avoid creating duplicates
> for source files that include the header, adds one more validity
> check to the helper, and fixes a memory leak on the error path.

This is now merged.
