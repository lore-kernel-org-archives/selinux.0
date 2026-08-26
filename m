Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5A3F86F2
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747156; cv=pass; b=Glw2rUcrDzf/rT7N6is0AqapQ8XCzoccv3GCjmYYOKyRiszj2sKjJswpvsACFrcy2pYCyZfxGgmKXMhcSE2c56U8QaoW5vVvw7J6JSNHMEm7oI4Rlz90KFASBUmnuzFJkaCQn9uHCyBrBrFchBJz8QeyrzbFSqeQxosu/0qVZFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747156; c=relaxed/simple;
	bh=ot59uJ5XGO1b1RgchPG9LiYMykKaBIibhVvx5bD4+eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjgUGvbjixqWOo1t7o8mRWBAJu6vIwaFgeJRvE+5anXC6mUDQhmvOwbQKzAXPw3MJKJAjP2PvO79/HIkgzznMC+Z+KUHcc7O+soaxmk0CC9uipsvi/ze901LlyUOv/HzmkvvkK020H7ECeCBtMTdJYIKoROxahdpOtgU56nyIPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djniAgRI; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djniAgRI"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44cd237446cso1094471fac.1
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 05:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787747154; cv=none;
        d=google.com; s=arc-20260327;
        b=OP4mKrfYXSvnFbocSLRwDBPtDYP2gQEmWvbQNCauWq1NwjdutwgX7eGlu+Decz8y4p
         hMjSdgK5HEsekn28yjDV4twR3Qh31AV7U3uQ1P+FIz8lQavMYrB6VKwyMfLgMtd/BarP
         Tpg5DN+XQi8ggeWHRA4jgQWCTkKpM9+rGbNcjRTC8K2Wx3T+JjdlqE67LHvO3bo8qnkW
         TULPkUWV9MfcuL19d4DwNZVnXSXDvNlOEqsPhgCMiSB+NzrS7wLnuPrt6PyuqYgBkrfF
         /HAZMigja2NzNNCybzzFIabrNorKaP56DnGgmJwwkGFbmgGwYfYQWfWr/xbKe/lsLTwe
         IR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ot59uJ5XGO1b1RgchPG9LiYMykKaBIibhVvx5bD4+eo=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=STr0HaVgskW/3lJS4ajvEmGGqAFkjBRfsy2lEEqtZQOJnzYHawmFJgy2tIjuaTF02v
         rZpboPCkz63THpaQqfML0sE93n69bJoEOk2nLmk1ziVx1uD4cC5rN6nBdJK19ne4vw06
         DHrUNGBCUgBaSIsvPzqJicjkYWzod9JOxrTbSVTriQ78xozf+CDKLilAmKrEGDW7U6tU
         s82S29LXUTr/QZi43K4MWr1qs+DggQtmNhnMW9qxSH+lgfXmHPMK20G0fCUkdmWtOJ5v
         1KfeZKHNoqdSTgfUPYxUt7xtHW3+tA8TF7yJ1pL72/b3P4T08jkQBGREtNQ5hl4CO3YB
         vPkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787747154; x=1788351954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ot59uJ5XGO1b1RgchPG9LiYMykKaBIibhVvx5bD4+eo=;
        b=djniAgRIvqmVsVbtpKPWpOrMb/VYe3jvvs2uDVJzryuKB44OEh2HBQC0afUxsGmb5N
         xCTa1iZB75yYwdWDNdx6NCrNW0QRPoYTWSRMC+rzl6mMW4ZkpwmBHVQ7hlz21ejQaod5
         qJkxsH54FkkF7VlIk2aZIETuo4BCq2sewIOvcQHQUBx4qJWVY/LnnZeW5Rh4TI944yC6
         zkH4iRT1XAWj+U9Iu5J1uVAFbC/f2jN6qhHKVHd+2VJtz+31RmZmgQ622sjFgxSTMI4W
         Oawjpalh/MFz3KBFlRVfkxXfcd0ShcaoFupgKuQ7szXzlz7llP1mkLniyd5bSZE9D3Oo
         EYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747154; x=1788351954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ot59uJ5XGO1b1RgchPG9LiYMykKaBIibhVvx5bD4+eo=;
        b=GlEuu93IKpd/18HVq1tI6stCTx02Txf1BQkyeV8Ehl1IrYgJ0qIGam47rc1mDwqMQx
         PZdY/N2xzAbYkGsaBhF4fs1JPm01WRxENH1k5hEC5UKmLr3NTqK0/Es/abUaMHOxJIO8
         OgwkZYWMoHPdsHJLhwmpsYU++KK5QK8qtMY34t/0rJoGdKMEZ6xbjbwG1FDENhW19aa6
         fyldreumFKcmc1o16z5erZTSsOtVyXgSnD57kIH64DvJpLm6aNoCcmzkJeyUgKhdJF0W
         xL7uwtP8lGclrIKlwBDqXFeRWAX8GR1w0Cdx2rCwjaXWiaEyqLm+q5MP5u3iwJyILFQ+
         Ybog==
X-Gm-Message-State: AFuF++nTN0RFfoN9LA6Bw6JNUlPv++Y9NF6FxYUpYJaSjKYam5oGH2Ue
	BSqQSvgpl3no9nos9cXy3Er3kw22lz0XCj+YIr6Tt/1w8n8zZpE8rN+ZDfB2oEDX9o8t0jZZ9zA
	Rorl4M2jWGmI7Mi1DOAUO5oLLdgiE+0U=
X-Gm-Gg: AR+sD11KYs3p7lS+2NUralPfan+9X501rV9CGo8ilQd+yW/Gc06oCyRcs+Mowlpt8eL
	05+QclYpvqkFgKj9X12m+PMoEBcJH3LTJyA2Xs8C9D/5UNL32ZHTTXvCK3dwRN3e8l4UbFE966G
	R0oICbjRxv04Dnm37DNTn+qTZgiL0mJ0RyaebURsFwpwa5CdbOvvinYpVMZYbUWCAnmGoTjIQu6
	jZC8lreiJO4Uyr+pkscijvv8BChqg/oZ+KM6U4jxmXd2Q/X/HIPh6UZAfsck4A9o1aud6/tx+zU
	EOimHPqVbC+LaWrTeGUGK/eFEyjfvLHm13tKcKX4TZg3
X-Received: by 2002:a05:6870:5b9e:b0:452:2f:49b0 with SMTP id
 586e51a60fabf-46597c39c75mr6050473fac.4.1787747154162; Wed, 26 Aug 2026
 05:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825194111.75602-1-jwcart2@gmail.com> <CAEjxPJ7Sn26wH_QqhXTSVj1vDLAuRJZ7-CJo5=G-vxZpULyewQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Sn26wH_QqhXTSVj1vDLAuRJZ7-CJo5=G-vxZpULyewQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 26 Aug 2026 08:25:43 -0400
X-Gm-Features: AcwNN1UKNlwLhMM9krlT1eUJZJzhLuaBQaGWU0TMAfw-hFYesQyeX5NsHVDKd-E
Message-ID: <CAEjxPJ7w75sbrUO=Tkeyf8X58K_8=1CXWrNB5qBC9dVHXTvYjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: Move the PERMISSION_MASK macro to private.h
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 4:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 25, 2026 at 3:41=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > Move the PERMISSION_MASK macro from policydb_validate.c to
> > private.h so that it can be used in other places.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Both merged.
