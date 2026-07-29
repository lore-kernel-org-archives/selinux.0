Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3844AB79
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329587; cv=pass; b=dShoHmBSiZ6MruhAmQvKk3n9oX3uITU6A+TUsMf6QcRKeCjj2IyFzVrTWs2sRdqAPvu6s7gFt/vlewYmDeFB4RGkTs7zdS+obFGLykNAbVdsAczLtQu0rIdk7LgGyjrnPxEQemOLuWPacM2DPoRSPWaAECCSnWrD3e8fbXbyhIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329587; c=relaxed/simple;
	bh=+XUexqAfX4oJaeDagyOH4zgCscu6O1CcrZipPBUrD54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWgoocF2YZPkhn2kxu3U3RCDkW/bb2LZJ1XPl28YIiwfhQqz7PwoOzpWQu45DFdnbATCztiOZAfEhpZnT2FGtTb/e0mTEkNrv/p+zq1jdDVYrGUKvlFQW3iiau9Aa6fcp0KTqBwRr70tcnoK2Cb1wpbax9CcjEXrzd8dg+fZJhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tp5lltUC; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp5lltUC"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso637830a34.1
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 05:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785329585; cv=none;
        d=google.com; s=arc-20260327;
        b=ACg6+ImBx744zoTir8VpLgSUZKoXmMKjgLJXWqcyjXzpah6g+lCYV1QUBL/xWFpxqU
         2Sto92QO1uIB25vbzOus1BV/YSRKch13hn/aqCMG1JwjGbgNGc5Ds0teZFjTMFDarU/i
         lwpdYv3VrXjzbNwPpbEbmVo9/aXZFqEzU0ewnbNcErETRfK0POIBCCCFVOHYewx1WZZ2
         L7J43Jub+E6pBaQXTbgZKCqyXrDhO+7o9AnI5z9dVr4q5NkhQgYLpPk3VSHhj1EanLx3
         o+G4czh7j92M4azd0/4iVQJltGsmKkZYSk8YDeP4vMrWhyy4SH0y+ricIWgPsxb25DaB
         iEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RMBwGuIdf4vizqDeMjckSGqEph153Fx1t30JiadhuuM=;
        fh=/2ny1hta1ukHqbt4suum6E6IyYoiSem2SJxkjruqluc=;
        b=ITXhn+tt05ZyeqxP67VJ6PldiIO2mmWdM4xYwHWi9BIoe9k1qtc40xqIEBXHnIB8m3
         7Mq9kq2nb2x411hUVCUhcSsAeWLF+6C5oFEMpYe2iLSq+Uk3L0c6H2pzgDDyHFQxPfei
         MjIusBzJzm/P1DhwgZ5xorzhtyD04AyEAw6F3Cmou31HhnV0VsjBKcXTgwzrda1AfK6M
         pOBun4ncGrKAGgpBGBR2ZNgo9i3cZPVxDfh8l+wRUcD2s9ZCRSeYBlqZgtUSiLvimLgZ
         /8Sq4YaY6pA+t798ayiVPZfqqbEIgc0+TqcHGwj46nfuZT36ZBLhvg6DdLsR7f5+R4TM
         rL+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785329585; x=1785934385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RMBwGuIdf4vizqDeMjckSGqEph153Fx1t30JiadhuuM=;
        b=Tp5lltUCwdCBfOBsvnwCrKmOK4lHsVf7PU5t+1DItq2szf0vUJohNyjLsnxvH7ddG/
         QkHxLKq0Cjj48fkwrHuH7b5E3AD2fyW8cb7IHykzE7+Ksd3cJsmevmAEW9pOnuHb7ers
         +Up2LjM33TRWTusEKJjfGsZtDvukIXRkRO5cYueJEdVv1YjyUkusfzp9jBZT0FCFHq2C
         FYBbqOjtvT6/1r1IU55G14gqN5Rn/IXatYQSDJM+SLkM/OcTD45GlOFUD6rgzCfX2IfA
         6tqU3a5wKK5LMNYJ1BnRvSZhPDhVhI/JbSfMgkO8TInDCALFlQGAMcReptXOSbdfVCNo
         FQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785329585; x=1785934385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RMBwGuIdf4vizqDeMjckSGqEph153Fx1t30JiadhuuM=;
        b=Tk/QNjG0x1R6wemCRYap5xarljbk/Kftpp0HHR+tDbdNsqFhMSCCjaKCDlb+9PgV6+
         9LqFOYOpaTsfOCRGkh0WuoLPD7PZuGPsw9ddor9RlQ9WEo9BacS9kHUkcfmKaNfxFLJq
         pDTDMFWrEp8h81i9zyjUOOxLw07DNfu45qiohbjaiADvprb5yHoOTuV0O5cBNf2IVK3U
         oFz6o4RtoMyYyp5GDEc8qYzpVDaA1SKi20FYT0aKBq7NSAbiJPK+wer+oN/RBMdKIkmM
         B9eJQ3jz2QpDSsZ53lTAsYuUU/XadrOTCrwyczHf17CEct2Fpoea83U+9/dC1TUkeLM+
         GW+Q==
X-Gm-Message-State: AOJu0YxKLtmpouSHWpCWyCfWYVW3gtJPfOZDBUh1o1XnNg9Dgz6Esp7g
	M8xOlmbVAqcyVxyckd3BKB+uph7GFXnRltjinwT7Ipx5i8bxIy07z0GmH0+ubuuzsBrBx0ANpGZ
	p9jIjXwpAk2qW77ai5VLfwN87Pxt70VqyFw==
X-Gm-Gg: AR+sD13ibEy5qHQhlxWiyFFPYqpoKUY1be3tBZZguwLgEAAi79txDYx9tG+qZsK2y0U
	KtnuXmkMD81Ug8WIINLU0alB0vT3eb3gTeXf7kRtBK8Mxc67U0fQJosZ9AFA2OKE9hvlB8c3xP7
	SHcaNlPbBzxHgWhODWJy4STW3s/O53uhhvD8Xx2EuA0HKSCRxJkICs4DHJNne6vNyHHX2r7FyAQ
	SlQMKehtVNfWyQGZ2wRHV9hNRvdmShVVdJH9qRSFKysRvJ0NPcaDNHq0a0ratsX7tC032H5d0Lh
	SYvKR3wD6qBWxe+aKjGPGK/FDUNmNdnDstXCqkHGSDwE
X-Received: by 2002:a05:6820:1f10:b0:6a1:82f5:b009 with SMTP id
 006d021491bc7-6ac969bdf0bmr3405525eaf.13.1785329584395; Wed, 29 Jul 2026
 05:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729121232.53444-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260729121232.53444-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 08:52:53 -0400
X-Gm-Features: AUfX_mz5BM_9J5E29eKuPp9D8uh0kWlrYgilNOB22sM1XdMk71eWPKk-L1OJKhc
Message-ID: <CAEjxPJ6gjYY8hwGu07j_nf2ZKXvb1y+2eC1i_3rdLVKV9GKz0w@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/file_contexts: update .gitignore
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 8:12=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Add test_multiple to .gitignore.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This is merged now.

> ---
>  tests/file_contexts/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/file_contexts/.gitignore b/tests/file_contexts/.gitign=
ore
> index dd877b4..8b95fcb 100644
> --- a/tests/file_contexts/.gitignore
> +++ b/tests/file_contexts/.gitignore
> @@ -3,3 +3,4 @@ test_lookup
>  test_open
>  test_open_base
>  test_validate
> +test_multiple
> --
> 2.55.0
>
