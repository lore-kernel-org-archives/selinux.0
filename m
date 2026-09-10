Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24DB327C08
	for <selinux@vger.kernel.org>; Thu, 10 Sep 2026 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048089; cv=pass; b=l4UaLdksXh7KhGl1Pfq1KrnbPDzybIx+k2e4lyT8WtT0rHXvtqLWWtgDkrpwVZoQSDg1ankeHghXKm5Ly+F5KaL3/MXcJJANjW0tc2ybsRpi88mV4JVWrKukPVwVCmTvy8/SnakQhxDiC2wQBN2d5ecCka7ybjTUV0Zq+kjDSj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048089; c=relaxed/simple;
	bh=DNTsUC5N5XXoVCYlhZ6jc6YWXfTq62DJeISClvSrvAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCWrAr5YRG3f+Sl5MFxpicQm2Xg5wURJN2/3xgaWrdpI59Sx1nBUeSt3zxEeYTEFUszX6V/8DQEDC4laT1KN1Jm8Wfr7iYd7Z6x4K1HtZuaxvcrJyVnCWOnbYXZyy3nwlepR+eOrT+o4QKohX8sjA8RZK5fHLdw6AJGvZAAup/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQQh/p69; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQQh/p69"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b1ba286f6bso543775b6e.1
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2026 06:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789048086; cv=none;
        d=google.com; s=arc-20260327;
        b=ZQxJ8mp3M5cWoRM4NplPyg1gRR8cw5hIegyAaDw0CeJ2HT7xTF9a6ZApbKIs06ubES
         5GchAsKT+TKgIcaoJIw3t4jL6wUp3KTB4JV50OmJMyb68dKP6LwXHCBxLHrThY8okx+i
         r37s1tZ0miIeSfioLP+mS19+aKlyUihaVIOpIm/ehifJZl1lHg/mCQzvE6xpaQoHp4AJ
         Ic4VTMQOSvPsc64mtuJCrNrlblpGkh0/+APRy+q+wJz4mgfOfSpzk8opwKly/mcyhfiN
         6Yaw4hx5HR/lHG26+hc31u2DFhtJ8ILWmbxNaMkRgHZGfuQIxpNd3gQimP46fdP/bolr
         MKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DNTsUC5N5XXoVCYlhZ6jc6YWXfTq62DJeISClvSrvAk=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=pjABPk8o7F2n7aWfg9uWTkqKLHvgxCTU7WqhtMgCZwgnIGFF9wvIYtCcsALvzHN8bH
         1+rmasR5d6Y0L1eHLvcpQXj1oXjAQOvsDnuhdl2xi4Ns5hOVrtLl9S6ox1wyPSmCZB9f
         loeYDmc6Kw2LBNcYukKM5F6o5ijiK5T8gfUco6g+FWACPereW4KJdP6Sxsd47KuUJqPp
         urhaTYbs9QD19TokHdNIACdsbXcfwoDsfz3DC8+XqbpkNLV4j6C8DplQ7EGkmxG251z2
         Y7T/imyh3rYidveEosjF3ZXoG6SbIbVDCDqwam1dOv+ercjEgSrQVQImj/kKE5yq6JDF
         OcKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789048086; x=1789652886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DNTsUC5N5XXoVCYlhZ6jc6YWXfTq62DJeISClvSrvAk=;
        b=BQQh/p69+eEaYRR+5WnwzeBnJ/Y0OcBKR9nBc95IjHVxLc87z+gJz4FT6Czco2vYUx
         jwpgBn5ExOCOx9lp635N5cAGk2eRvUI0Y0p2o3/LEWV218AGcYRBRJ7kP15xgjgi9/+v
         9NBVkyijB2aacZGIx38TJ+xum2/vw5FToC+20WQNpR0FLLBWbAuQ3aXgNXVhouM8gL41
         Yg3njao+Qt39Fg3akmHEzgfoo8SzAYffVvRI3VET72iXa9W7coedyvOfKRNDa5EE699Y
         DqywcOVNeo3oIR2l4B9W+dDOTrNr6u10rkYu6kBOXKKecN+pBficVM4KrQultPzXhtvH
         2kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048086; x=1789652886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DNTsUC5N5XXoVCYlhZ6jc6YWXfTq62DJeISClvSrvAk=;
        b=ksiGQUnH7n39RdoY6s4giQ2wDgbttrmTFoAG2F+LTb0eidxjvGxSWJpNGcSMVxRs8A
         XcMGTxqp2UeS7vniP+eizoGXThB78enBQJT48iz+G2qyS4usYnnHTcpQ/nzQCRZ81iy+
         et0tfZ43kWN0WgZILFC7EUlzII2a1N6O3GATKyc1GJJ8OFkvRzKI/19E1RHHikQBYyO2
         LTqTjkDetrXfwaXYlfW656C67X7/lxAw1q0OI4vZjoxgNxswK9g5ZH5/gai2C+fjSFw+
         Y1xDlLGbKkWMbmKg71N1gHPBLd2blXBOkWzNiXUGdq/6CSo2PV7C70IsVyyPrcmJtuzb
         RAaA==
X-Gm-Message-State: AFuF++mkJO51WEZ/RrmbeSJ+4z2udTLzvXlkhcqm/QOao5Yn0UfbccdD
	izzrp05gLjzC+EVUTheV21esa8fWl+f9EBIH5Tsg1crR9qHQZuAfikg/YAr4GyNASm7Atz1UGuh
	sWXKTRuH2bOKxai5TGQMxlawvYVoc4H4L4g==
X-Gm-Gg: AYBFou2bUtkGVv3JYpyTWOWfk+0evH7VX9N0bw2MC+dUvvKdiXSrTr35vYmfqOtweFH
	7DsKt2x9jak/X5wzyGtSVSWLmGAbEot7OpOvS9rRXzCijBMX7Sh/Wv4bo+ZTAXXBRf4ZASMdFGt
	UL+wF8Phe1DwwPWJvIC8OjUkN+iQ23WztsGswduRH0n5Lm6hANXzrwtcyjkMxAOyk7yUoZH99Ue
	fF4jWyhAQuUboeZNJSPAUrX3SnLheS0UsZRnTxFo77HoebJ5rVTg7oATNTpexeYF+Fi+90pvw0Z
	q5iA1jLhXAgaF2JAIbTSRYuATLv+uWSKk/jOG5uMFq1t5tKOFTwSfeOdxpIXQsl+KQ==
X-Received: by 2002:a05:6820:f005:b0:6be:7d9:b05 with SMTP id
 006d021491bc7-6bf43d77bf7mr2152682eaf.9.1789048086304; Thu, 10 Sep 2026
 06:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909135918.29943-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260909135918.29943-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 10 Sep 2026 09:47:54 -0400
X-Gm-Features: AcwNN1WbwppmmdwxAjoHx3xVfWo1It_Ha7YmUU4pIglx76OTJrWPUVUJbMlfMlI
Message-ID: <CAEjxPJ6Kz6DCKwPnqZxNu6E0MkASiRYHqJELJjSZz4qifBDBeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libselinux: fall through on EACCES when searching
 configuration roots
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:00=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> When searching the configuration roots for a given configuration file,
> rather than failing immediately on EACCES, continue searching
> lower-priority roots for the file and succeed if we find one that is
> readable.
>
> This prevents an unreadable file under /etc from hiding a readable one
> under /usr/lib.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 removes the double S from EACCES in the comments.

This series has been merged.
