Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5F41D213
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814390; cv=pass; b=EI+DYGAvLplKITeJz5028sV9OZbpAuFwpz1u6gdSaN712SxqiDQfJeZD6shQ8FYBI61k3HvWZBtiiSk4aVHDNsYSTl/hQOGfbmDmKENT0UwvBLU/jhsU8O3vby8TuVm9choCSgIBOWwwhT9yExVrTgk1l00TWTUnA/FsTi8y49A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814390; c=relaxed/simple;
	bh=0U4W9pihCzv95NHWuOy54FNjSBtMI6VjiqRA9QfUn0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awbT08MbepLwg/kpj43+8LqM2e+7nOtuAXM0KChsgrHrx7i/Z240KSuAJm9uZvj8insQNBTJEK6VCRKi6SVTU582RYtHJ3f7XyHTJk3ZnFPfWOcWnkpptZ8U7T4rOF+4KTSH7XoJTE6PoUXecYBn5zTlz28XNiqXWDGY4x3tyrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6nOLNrG; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6nOLNrG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cca0c5799eso6794355ad.0
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 06:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784814388; cv=none;
        d=google.com; s=arc-20260327;
        b=eub9f7a1aHPU8bOOR8z2SgEMuaWhcHlJoNGJlpAfBIX6MI0oL14dNK//ct4pAT76J7
         6xbJMq/qngLxDucHPb/es87s4hHvvtRpN2XuWxRyzV4RbyAmgKsmvVlkBStioJb4J2l4
         +CQ+oTY5FDD+h+PpZFNwy44MzPyXLV0Fdk6ppHOQN4dCV6QoR1MPhPLY3gxdW2Fztyqv
         +uDDHi+FMCluprZ2pnME6Okk8SfOu9fWEkfhF+qOk19eqjH83cxdLoEH7TRm8V8TdJIB
         mzSnrurZkqE0P+w7W5J/o/CCTnfyIx8K0qeMGM8wEnveIpUTlTC/gZLRQVXVeUlsAH92
         WWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M/svyfQNNA4BhtmVZ322oJy67JoR8TJkgzma2xbHK1Y=;
        fh=sEXXZHHOaetdSxeivqdrIFtWFCVaxn+K18VHEkjIQmI=;
        b=GPtCZUFWNSi6zJDJvegFUi4AQ8sl1JFy9MJI8y4Kjx8lsAvmqq4z41Gur7vMEsTMRE
         FyrEcMLhJzKy+YwemGt+9NJa7qGxuzkG9E61CQuud3A3heELi9S3CEt6F8qbqKmtzQVo
         H2BlrL5AuOZo4pgJvJPHJ1gmT3r+wIvy/5yjl1hZ+xU89i3oJyPDW4j5gyEV3Lp8S60S
         gfaQZsQmJYfnyKB1d7N06r/7arS0NWziDDR14XB8GIKXJ2yBzPavGd9mIZkKYoM4W34w
         B/Btj7GYJgXgudpVby45vHaj2MUO/CAsgxUfyBtb2qLPSwLsSL/kpDVsNuLHjYXqyaBG
         oS9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784814388; x=1785419188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M/svyfQNNA4BhtmVZ322oJy67JoR8TJkgzma2xbHK1Y=;
        b=e6nOLNrGrrlKKJ4PBWEzNqBPyRbslj4IWsxxVIPBgfT2mAdYiPXI+azZETU4tTboHj
         crQyx4rZ/2KBlNN6jBMQ3uwlgHs9EnYU3M1cp9WyLXSulOLVBmbfJ+rGLgyJGHKrn9GI
         6Vxv6auu10CjfJ8X961BS6se64SWfVXv7GQWVwJj18qT/aEIO4IBtZJvQc8+YAKC3Qdc
         CiS1ZH/ZwbGr8z3UzS5nYM4cHRNnrBkMqrJ3Vp9G5g7n4okuryUDaQkc5E2obKZreeFD
         w4KsdG7LVXcV3wiznFyv20nvVbzmliKiDZFMUz+uOGSdMobf7TD/PFT/40H+TWx1eSt8
         Ts8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784814388; x=1785419188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/svyfQNNA4BhtmVZ322oJy67JoR8TJkgzma2xbHK1Y=;
        b=S02EVP7j6VE+1LSdIqOCjrDp7nbyLhmQL6/eO9CoEueSZEGYmGUyjvVsXfhACeYbrX
         8vjR/Pd5pgTngcUoA7RHTCj1NU4220sV9nDnKZ3JNe2+wrbIPT3b4Iu0HEtVbUmfTSXu
         mD5AhHEMuBWHuF7BfUWb524Z0wGIhQbFHkjvf+zXxWrIftNJTbJiATf6mS1F4stZ1fTL
         dYBxmus1IHaI101jYoTAd69ZIjdMz4n8+pf+UnhcFfBdbNNnUBqHMq89TEGCrN9mLrQ+
         efIKKWCixuiBVoRAXAU2VOlXlj0rMP/fgslnsjgd3FApKRCWt6pgWhDT5W9bit5oNi6v
         3Uqg==
X-Gm-Message-State: AOJu0YzJpIDdx7ZZmcdjSXwue5pwxyBvRmoNHUJKf19fdofvVpZ/8ERa
	bQbgs/12PZ3fuBMnkU6x4Z0SuRVhNfdAgesiCu4NP6tVt91n9ejS57jarVek//0EU+Xmp6n3gzE
	gMCQZhfBGHTCSKICoi3KTwLqt0ykOSPCVcg==
X-Gm-Gg: AR+sD11lubdUzNqT6D6Okoe4jp+SNQtlM6N1jwHHrgkXjZ3leuRnlQ62OgIT4WOOURP
	/b02tJzUyy4CHHl9CJt96jjODPVQQmGSNOCsPA4Win73wrrE+amta+VwzIoX9U0i1uDgiawnAqp
	QIGCTg/ADUzw+wfSoxDdxewTSE2XXk4INi11psy+3BCkf7cAIamSrsDUN3SWDNq4N2smhPEMCx5
	pP6VDrvbVtLuo0oAtlL04uWob2niMLZ9ZqS4ByZXbNkon5GtPJyC5MqC0ByXg==
X-Received: by 2002:a05:6a21:3390:b0:3c3:daa2:2b7 with SMTP id
 adf61e73a8af0-3c44b14e8ecmr3440709637.44.1784814387933; Thu, 23 Jul 2026
 06:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723062355.3096648-1-jason@perfinion.com> <20260723062355.3096648-2-jason@perfinion.com>
In-Reply-To: <20260723062355.3096648-2-jason@perfinion.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 09:46:15 -0400
X-Gm-Features: AUfX_mxne4zOw-UB9Rt__OXFuv_s1SgxYXQChRhB4giCNP0a43xuLovFMkQjxI0
Message-ID: <CAEjxPJ5cdX3vZZmE3tLfY7Bk_YapnVU3erzeXUtGsy3wbK2BLw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ci: Drop circleci config
To: Jason Zaman <jason@perfinion.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:25=E2=80=AFAM Jason Zaman <jason@perfinion.com> w=
rote:
>
> We have not used circleci in many years, the configs are very out of
> date compared to the github actions so need to get cleaned up.
>
> Signed-off-by: Jason Zaman <jason@perfinion.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  .circleci/config.yml | 41 -----------------------------------------
>  1 file changed, 41 deletions(-)
>  delete mode 100644 .circleci/config.yml
>
> diff --git a/.circleci/config.yml b/.circleci/config.yml
> deleted file mode 100644
> index a75d34c2..00000000
> --- a/.circleci/config.yml
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -# Configuration file for https://circleci.com/
> -
> -version: 2
> -
> -jobs:
> -  build:
> -    docker:
> -      # Use a Python image from https://hub.docker.com/r/circleci/python=
/tags/
> -      - image: circleci/python:3.6
> -
> -    steps:
> -    - checkout
> -
> -    # Install dependencies
> -    - run: sudo apt-get update -qq
> -    - run: sudo apt-get install -qq bison clang clang-tools flex gawk ge=
ttext libaudit-dev libcap-dev libcap-ng-dev libcunit1-dev libdbus-glib-1-de=
v libpcre2-dev python3-dev python-dev ruby-dev swig xmlto
> -
> -    - run:
> -        name: Setup environment variables
> -        command: |
> -          echo 'export DESTDIR=3D$HOME/destdir' >> "$BASH_ENV"
> -          echo 'export IS_CIRCLE_CI=3D1' >> "$BASH_ENV"
> -
> -    # Download and install refpolicy headers for sepolgen tests
> -    - run:
> -        name: Download refpolicy Makefile
> -        command: |
> -          curl --location --retry 10 -o refpolicy.tar.bz2 https://github=
.com/SELinuxProject/refpolicy/releases/download/RELEASE_2_20180701/refpolic=
y-2.20180701.tar.bz2
> -          tar -xvjf refpolicy.tar.bz2
> -          sed -e "s,^PREFIX :=3D.*,PREFIX :=3D $DESTDIR/usr," -i refpoli=
cy/support/Makefile.devel
> -          sudo make -C refpolicy install-headers
> -          sudo mkdir -p /etc/selinux
> -          echo 'SELINUXTYPE=3Drefpolicy' | sudo tee /etc/selinux/config
> -          echo 'SELINUX_DEVEL_PATH =3D /usr/share/selinux/refpolicy' | s=
udo tee /etc/selinux/sepolgen.conf
> -          sed -e "s,\"\(/usr/bin/[cs]\),\"$DESTDIR\1," -i python/sepolge=
n/src/sepolgen/module.py
> -
> -    # Run clang's scan-build and store the result as artifacts
> -    - run: ./scripts/run-scan-build
> -    - store_artifacts:
> -        path: scripts/output-scan-build
> -        destination: output-scan-build
> --
> 2.54.0
>
>
