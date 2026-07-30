Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B5410D13
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433360; cv=pass; b=k31Zzx+7uZ0TVgSQL9c2dIuU/JB0xLnSv9oikdM9O+BmmyDVHRc8laR8O8BiBqEn5vMmFEE8Nv8DT92VLrXIoaYv3arevC6TgdH6Q7sGFdkjXRn7NwVThyAeTqKiVL8SwWA3T+vStrS3uKWQZ1b40N4/GiNNCBfAAgPo+HZZFUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433360; c=relaxed/simple;
	bh=BntLsDpLIhc/RVLwDOGagw9kYvNtUODc/X7e+H6VjVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihN5wuZTbDEikTZFcbP5C3I1HZj8oyOB06kDlyNzWW5hCq0DGZyQf55nFjWx4bY5Fv44fpGr9ACZiglKuOeodzGC649ng82+pq5/lKqkvbrCpIWHtgw2wk2uihn6UPds/8BQzvy9luMioshddOBoC2Du4eWsB54OnUgfjy+WoPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axGCEv+E; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axGCEv+E"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ee4399c423so105290a34.0
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433355; cv=none;
        d=google.com; s=arc-20260327;
        b=QuxXnVBmtQoTTuCLjBtnFy6nYPRUE/fBIHKjvfpAp1olYRe+YpAoP8MwXpDiynrBg4
         KVMQ0RSkjRdpFEdEES3lfuz2Ti8S5+nkXAt6V2eUQVKxVGFhJxzXJUUS6DGiE9t6YhTI
         1b2hmxYOiRbNadkRHDJRrIBeM6onMJlo+0ElaDEd2Usb74AlINJF4s0FBPihbeFHenKZ
         aDKhPSddOh7xQNGRTTjkMzdrPq4/ltIqqmkV3LlkJv4/ZayRgy0TyqOnoYGZsQnXY53A
         9cgueREO1LVyjyJ+GGuu1lZNJl/UAEv+WPh61/cCOwCo+5XH/RZ97aBdW3bzuefrbGC3
         0NZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BntLsDpLIhc/RVLwDOGagw9kYvNtUODc/X7e+H6VjVg=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=EsrDhCcJQw/23n8pJpUi4sKmafknSMUGvl8BPStgLnO4KpQSlXV4ZpVnVyNZ/Tcalp
         p9bqjaz6V+/bX7IrsGlOpP/gpDM1qsidRHh0LQO9UrbHYI4FMlSHYJUbGigk91i0cMbK
         gI38aDBo90bNxDnbzL6289yWC+6pESddWFvt0g055i/bOoLOow24ty68gndDaAkrNcXP
         qrPrcUgv3eTwJuklBIBoJdMU7xwg7+rWZTrH+DH4lzdqgR1270VF6QNz6yGLJUiekZcV
         VW7DkVj9ecnWA/70n5ayJgWMUoXOcJIU5b/S0MzPWxFkoAr+L+SBowBxFPHXaT88HIgX
         ofkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433355; x=1786038155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BntLsDpLIhc/RVLwDOGagw9kYvNtUODc/X7e+H6VjVg=;
        b=axGCEv+EH0bgMyXrc6KeYqGYUBm9RfE3XuNR92lCNbE05uglJg6ZptYp/9ELmbgfvS
         gTIy/Vfpl/ayAExN6RLc3fd+wpaY/vPIN3ILYmDa6fd4G9S4YVPG4miCYIc9GGJzLBVZ
         WNOlLjYOd6Pihh1ZRyRmMTAIBXZPRahan4YrjPeHwmkVsh3YSov+15RAgqqshaoWWntJ
         T+ngwbViwzqsdLO78NV78IQ508iU576a9UUp9ljkhP9USU2DG9ZOypGVrrajQxKX1tWG
         xqTvvsW5jDx5aONeOHifh64Pks+VykOKrp1xd0cDBWfR5B4OAtSyjfwlXynHmUMNsozy
         4orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433355; x=1786038155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BntLsDpLIhc/RVLwDOGagw9kYvNtUODc/X7e+H6VjVg=;
        b=BS9TzUY4mamsVuQIWtlG/cFwvUljilC1o+YzNBFU7U4ozwMNFmidqidN6dRq8IIctM
         D+wO6p0Nia6Qm8ZrOUez6Ag5+H++kSh1QakztJPE4QmFRf7chKnPtS1S8PWMcVrTyzWZ
         fMxUQlvMLPUicqzROCTHtwthC8RaoBI2VfAyXAUdTvpZJFrhzOEOKsgqmidR9NRYr6W3
         MGgsm2rfeE4KZIH5Dlk5gu08O0LdpcK63KTVarJ0Gp3hbG5i1PlyxRGQnCDcJEofIs2W
         9XvStXEwbxBUuI4JGNdOd52HopgnSDDMCswjZGNPVQ3FLyTOIO785R9rIAEmO8Lqnk1h
         9ogQ==
X-Gm-Message-State: AOJu0YxzwSOWvX9TSeeVdOsbZL7yzZR6p6vYYwcQIjt3rSw8ZiakW0KN
	01hmeFqSEA6Fil/pv4lVawgWfXpJl/n8H0uGdSChrhnBoyI76UE/ceRtqMN4j6T/CjkRhaqSpt+
	UI2GoQ3IR8eWQuPHm57LQIxvn7Pbat7X22A==
X-Gm-Gg: AR+sD12/fb/QvMxBXi8dM5TLQmjpy0AugY3fYziLh+9TCmfhZ527V87AB47mIE/oFwn
	smHIp+V6G4soqOnrgdakVD5PDbQzOxAe8NcckhnybgndwLT3Anhs08HMjzrPURM+sSMyfyZQFV+
	vpCE85rT5bsPoXEF5gUEbwGwfZsuCPa4RZYuwsHRGF0HAZzZszxchpRAi5JspOHgo0nTwEutlta
	5HIN+MJTDuRr/A7zLTx73IQ09elKzMrwUtNA9jWyVtZSmFJME7DtnYfNohbiz8Q+ykzBOt0Wzbb
	X6bCIAFH9w5d1ftAkKHwHwVq19rZlRcybksLXJjyWcMK+LaqlrEAjIo=
X-Received: by 2002:a05:6820:1c90:b0:6a1:363d:bc47 with SMTP id
 006d021491bc7-6acbbcc97d6mr2335814eaf.15.1785433355584; Thu, 30 Jul 2026
 10:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730125712.29409-1-jwcart2@gmail.com> <CAEjxPJ60TK=pWv2m-qP4kh1gjhLEyQzA6PEuoWhhY1rqtpLxMg@mail.gmail.com>
In-Reply-To: <CAEjxPJ60TK=pWv2m-qP4kh1gjhLEyQzA6PEuoWhhY1rqtpLxMg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 13:42:23 -0400
X-Gm-Features: AUfX_mwCpR6X-cugUelf5CYU2teeiu8F6FWjj2OUj9Ji45QZ7COFqOoykA1hq_s
Message-ID: <CAEjxPJ6H5GbgtyrVhMzmXshWRczG5DqxoCe3PL17GMvTBbc3wg@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Turn assert into error in type_set_expand()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 1:24=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 30, 2026 at 8:57=E2=80=AFAM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > The assertion in function type_set_expand() can only be violated by
> > a malformed policy. Since it is called before the policy has been
> > validated just return an error.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
