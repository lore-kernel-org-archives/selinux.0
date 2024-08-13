Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397318C3D
	for <selinux@vger.kernel.org>; Tue, 13 Aug 2024 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570768; cv=none; b=Yp5/7uIlKwOILOTXbz5vwDKEp2YLWCnb18dCO7t6WRwOoYQPR4V0HxY900pT4mN7HPX++WQU+anPhHPFXgkS5S9vpRYjIT6tVZNZN6CJFidOupoB6GwE4Piba/MPYNq4W7Asd0plQWOqC1594p7o3Nor5Zw8Q0wknRUFSPZ7cJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570768; c=relaxed/simple;
	bh=CvH29C7ydp2e4d+0WR8fh7aJ5uymIV9N21nZ3IGD4Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3eCgXE7suHZ89Xbpf8rP8dK4wexC5tqBMaHbVyHG8FRHgAQqbRKqn+M0qIFIQ7ES6tRAMEYNL9ZNtS7RhcXgwbu+7BpG7Es8ntd46QvDyirzLbci90k2YgqlbKaA5+7TV/hTE3FnBVOhEw27arqMuijziuI9rcKy+ZuGg1FZLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDxn0YXa; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDxn0YXa"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-495d1a6db75so1665636137.1
        for <selinux@vger.kernel.org>; Tue, 13 Aug 2024 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723570766; x=1724175566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkNIc9KvFCwKSX+XqXbqOr0LzAwOTnMHOxpM5KC/Xhg=;
        b=WDxn0YXazilTIVkn3OpmO65RoatLNPdk37WhJEfL+k5m9l4Xm+JGTMJzwF2mscwdka
         nl71S7KcrqOOTEas/FKwbS03iplqUSYqdTBEl94ymoAXAB138iocdn5yBGL1aqKYkWSS
         OL79yPLs+qfqZmEsTtBtFMx3z8p5NMd0Wwj89gsr674tvjg5CA2p+piENK3z1PzwCuqh
         9Haa1goJE1aRkIyE+5PQYG/V+hdYxYhfNaBRA0pdMolwPCPeMI/Ywi1sUXLXeDpFDQJ/
         CLEJVat6fi6yXN2oIYxxH/b580stVARq92PhnLG4JAwhciACRbHsLgSX94hgkwUZvrwq
         SHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570766; x=1724175566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkNIc9KvFCwKSX+XqXbqOr0LzAwOTnMHOxpM5KC/Xhg=;
        b=T/nlAQT9cSjC7PWK7BfgdPPVnoaIVOs78l6FtXS2Ug33jIQfRYSdyKZCWQIhTcyjR8
         i9tdsIQviKE/1EXwT/W3ObaTbwNXyus6cxBJGQb0YQYVSl7i7VeieKOVp9+RlAF90xPz
         SkYMfYV05FLKnNDP4I4v/hwJhWaiKRtojgr9rOCRcwxCpCXYxihfHTNCD5/ZVRJl6PAU
         u3W7jkVu+jygL08O0K4Z1/GHzpb7L0k4VqXyiWoMe5+zaMhG+iRtDdA7Dd70cGD/uk4p
         2KB3JC0edvUJZ6ZmPEeb0/VOtzq9vAu/2zkvGgtMUxu3nJY17KIVL5MjgxhOw4QqqK/5
         uZfQ==
X-Gm-Message-State: AOJu0YzQxFJYpsMSQyj8eSpD/iGjL27Y3z/5ZC0rOo8DJmQF+FNjJ7+z
	UOkoENPql3TQCgI2bCK/Fv9KMoTaE9cxbGyXjGOv0p+2b33aZeN5OrKwypELDUlMQVQFXYwPCp5
	syPmdw7gEUskluFNHaEcPdfGQbM9BqnPc
X-Google-Smtp-Source: AGHT+IG3mAtGAUBhyhuZco9q70iRZoYzSKTO+w9hI28V4z548jQPGQBxjEqbcSPDFUyB/Elen4hGbx7W4sRMws4T19g=
X-Received: by 2002:a05:6102:442b:b0:48f:3f9a:7609 with SMTP id
 ada2fe7eead31-497598b5305mr585012137.5.1723570766064; Tue, 13 Aug 2024
 10:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801193241.1627605-1-dmitry.sharshakov@siderolabs.com>
In-Reply-To: <20240801193241.1627605-1-dmitry.sharshakov@siderolabs.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Aug 2024 13:42:25 -0400
Message-ID: <CAP+JOzTSHd5uwVLfjH9e7cACCkFcm92=F1HhAET+V=byLiV+4A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] sepolgen: initialize gen_cil
To: dmitry.sharshakov@siderolabs.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 3:35=E2=80=AFPM <dmitry.sharshakov@siderolabs.com> w=
rote:
>
> From: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
>
> Avoid errors when adding comments to CIL output like in audit2allow
>
> Signed-off-by: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolgen/src/sepolgen/refpolicy.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/=
src/sepolgen/refpolicy.py
> index 2ec75fba..32278896 100644
> --- a/python/sepolgen/src/sepolgen/refpolicy.py
> +++ b/python/sepolgen/src/sepolgen/refpolicy.py
> @@ -1217,6 +1217,7 @@ class Comment:
>              self.lines =3D l
>          else:
>              self.lines =3D []
> +        self.gen_cil =3D False
>
>      def to_string(self):
>          # If there are no lines, treat this as a spacer between
> --
> 2.45.2
>
>
