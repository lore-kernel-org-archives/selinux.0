Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51C2FE071
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660706; cv=pass; b=AJ2Asg9ih3zGyNVcBSLA6Flrax1e8oLbMsUFlGgB4SWikg0ZBSb+mJdv/82PKfhlY9X3ZfoCDJaFf2NESFizG/ZzbzgOFLJ2wBiN0jxbnnxyk6DXM+tzmoFnmgE2qu7peMrVXI01A/SGApywgwTGUdAkK7j9YoNrNK1mTRpkVf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660706; c=relaxed/simple;
	bh=4ydKg/CLRRAR8euOkCaLM1ZK6rS7+91NnkBaQ/HEUPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGHUv0k5E+7chuc6KgcnTSiXlrGofKw5xEFWXuL2LWtcx9kERO+C5YUm6WsTeJSNw147G9O+ivNMeZS4B7bEb5T5+41dpAVcn+ProLJRnepQbuvwnbJjm5v7+yO2bO5BYFMgRAuQsfcCmKTatlPmnX1erpPltLjq7Q6oa1N7bGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOt+Eh2h; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOt+Eh2h"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-842307473b5so1295919b3a.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 04:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780660705; cv=none;
        d=google.com; s=arc-20240605;
        b=JCINUcu3PD7eg155E8oW557i7qRFk6YieXHcBe9aLetx31/K67Nh2n6tah8ns5EYg2
         N/NF7g2sjj1DIk5PrxG09DeUK/oy3hM2f75621N1k0BILIqR+XzlVxveEaJRbXicYBAO
         XWcKmeJWpNZHLAXUlzWspBqb+9QUwV88KbnMiorX/q17MN4/Ocg59WpsT57OZpwIti+x
         BZeWCl2K+SANype9ypJZkoDCxmO9JaL0zXjqU4s3ccGoPms36QL35HYGI1+x9f+QX4t3
         9TEx2MpbkAhkY8GvFmEPWZ+yfIfnvUhrp1FnDdMp/qj1hhqpGN7zOBJrtGVAtag7OShg
         SjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=seTsl0BfNHXqnkmPPUQSsCZCf/QgpyvWqLkkViVlw8U=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=WcbGJm1xYI57R4U1eP8GbCBkN6HtQgxDjZsbjtp8AkzAFZB9eT9ZbKsG02qEnx/DJQ
         HJ6a4L56QA6qFpc7vHypcmIY1gjwHbk13Ve7mniss3Cjf2N5PB3pAUSEBwcTh6/KXHvI
         ObeSy116hFX7GZVkR62gQs8w8X3VANmDr/GJhnKJg+psI2bo9dlcc2G9wQCrceTFqJpN
         MYkRs6AvnSwXo6zTrN+jLUCFgGKkP5x02lY0c4iFfiSdqsXd8dM4ZUQ4bePH7J3XVK1o
         5T6Mriu8vbWsv7x3EPf/491wYN/nKWyaZp4idB7qY8tyU2gj6fBggyYjfgcvg7laWPzn
         UPKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780660705; x=1781265505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seTsl0BfNHXqnkmPPUQSsCZCf/QgpyvWqLkkViVlw8U=;
        b=aOt+Eh2hIMfOKM1YbTm4JM9os/R7QPiO5JNUeg5SiZGDFl3RYylsjA+52Be0CLmPPe
         ZexyB7ysJ9PDlFr9S8nLIAV0+uvVHNcNTX0WxqckD5rbgGjR1isitOkvRPeOatrd9oY/
         rq1eIZj0QsMlX1kQvroSSi8DZH7YBLsHQtznXW286CK/9lMwivLDzk3Uia07jom4vH/0
         SyRQZ13RFimrJ14zv5wXv8MWOz1ZyLep4d+6IrjMfSl6eCRyA1Ppk7yd6k/6kBhBVC6o
         tRTQuVuMYeHup3mUPG89b7gOOUbFr3oadJ4wG+OYpRwhJNRXg9NYqt1mto5FlbF5SpXA
         1IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780660705; x=1781265505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=seTsl0BfNHXqnkmPPUQSsCZCf/QgpyvWqLkkViVlw8U=;
        b=JgJ+rUpKV4dlRc0ymcQMIPIqPCzzDaBSAUla1nxVeulflAUvkJ1zGpEITE1Iy5S4ar
         X/BAIbPZ59n2GsxYHypL3FD9UNhtX0HGAPy3fLSeFa3FDUuce/j/X3yt1DNeptkCnQdV
         pftmxlyg74CTlGp/fP9iZ2x/qVQhDGtcBHFigzeO5Vi6Hdt2BFveyQA57jIoQA46g4u1
         n2f79HxGWfB1pOQSLv10DWtpu+Na3MBlpWist8Wul/a1J+dhwjsOdGNGkiQD4QqY8fWU
         8oORb4Esp5YPYruDnkA1EuR8ds6kHbiwRdhokfbcPISE0r0Jhu14Yd0CKYce4w9wwkPq
         BRXQ==
X-Gm-Message-State: AOJu0YziqmRI5alAXhEMkLEkTtLYq+w0mUNNdtjNIvIhOpH9cQ5q9O+U
	zDRQuZa4+sZFMHAdvazQBSJd57WdT+djbyfyW5kcnT/HWJXvfwM3IwgVFYtL2Dma1Ix1lxnvfKL
	Nu7htPqnJgGvc4Tuhq/9A+PJufOm7k8iDbRwv
X-Gm-Gg: Acq92OEOXM7sniklMKjmLewBjYpvOdP+uM2lFPz2v5HExEuTqd61mu26McPrv2aOjX2
	AIttKcqha6ABB+klYZV+9PdidHR3DESFuD15n/GNenE44DiKuVKkPOhDSqnmA1Ydfzc0ZX39voc
	jdAYmP7wFrFws+sqjpUXtDks0tc1vVyxYx0jbiweCpGG3i5dAYxeY64TWCMjxdNvbFSxxAnwyCW
	x05SVtHQZnKczl44FmeK0NvWVDHBeoEEHiWpnVeBh0YO1mywPu++zO2+ZWDFNLp6rqXmWWTO3BT
	9JmPgrAYKfKFZJlqrw==
X-Received: by 2002:a05:6a00:a220:b0:841:58b0:82bb with SMTP id
 d2e1a72fcca58-842b0c07dc8mr3150457b3a.9.1780660704605; Fri, 05 Jun 2026
 04:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605104408.2378497-1-lautrbach@redhat.com>
In-Reply-To: <20260605104408.2378497-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 07:58:13 -0400
X-Gm-Features: AVHnY4I4YJCNkhMkSglEvF8_Big4xX4kZFt7UcJPUSTd-PsmZZEH-3mZMiAmI7I
Message-ID: <CAEjxPJ6QGnxS2pJVHTVmoa+SzKXe2R5N8xvPmr2SpND1yE9urg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ci: install necessary build python module
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 6:51=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  .github/workflows/run_tests.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_test=
s.yml
> index ed60921acfb7..82c44fccb521 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -71,7 +71,7 @@ jobs:
>              swig \
>              xmlto
>
> -        pip install flake8 setuptools
> +        pip install flake8 setuptools build wheel
>
>      - name: Install Clang
>        if: ${{ matrix.compiler =3D=3D 'clang' }}
> --
> 2.54.0
>
>
