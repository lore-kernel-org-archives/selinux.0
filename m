Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2411D9A4E
	for <selinux@vger.kernel.org>; Thu,  5 Dec 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394856; cv=none; b=AvojPD25pUdmLkRgTRRbhxknA56xHKWnxs5x7e8PWMVCMlh3RrTKnXULtCBOxxXfAdUZtAyS04X7nnTDNepS9uphDjYSjPRCjsilg4usNuvNX9f3RdRqrNl7ikOgoc69gH6xpcD32ZG2IyV8OncwURjfoAxTG6ijDf7estTHeSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394856; c=relaxed/simple;
	bh=iNNSlUMKio6BMScmGlcjZKiFLz/tKqFuBlOe3QJsMHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1sVx6XsjQDarhiYVrozUNlSQQRPtTPdV+3aDRYFKWa72cimW0VzOm9dPkMEdH6O/vPj8NGWoWg4BXZAVlPR3tOiVA/vWATemHb0NTsPii23rx0xyu7FrMYU9UScVUuljFqehSC9lc4SUNiuCPeprur3hAzYiqEjPiNFrPpCYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUS+sSwG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUS+sSwG"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de18437aeso4483e87.1
        for <selinux@vger.kernel.org>; Thu, 05 Dec 2024 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733394852; x=1733999652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAX9OZc5fi5Jorm88cMfQH8I9F+YyQu+8r7M5mFyRn4=;
        b=sUS+sSwGxt6DK9/VthAUdRIRcr5p0dID1Kqe3VoCWyeAtkYQb3j4FkoA+nLx83zWJj
         mSkOl0gUKKsjE1EK6z28MS4Sm9IS3hWyGC5OvKhBFUle5mzUNZhK4Npy4lisqJUiiN9R
         lfkY7BirXtyJaxkoWZHwsLHaObtUFh48XgRCo+veHPr+zna239nbCjZZIreUKefL7hid
         YsTBXmDoHSmcFf2Tgc+/mxJEiZwELPVb10IxXRP+PtTtMGRZcyXnV2T9UqUbHWfiUMAw
         sBaaJHMcTHisVDi3A0vlhn6PzR7Uoapwp4qIZIgIW+Zr+iJcm7TMtn5HCYhA3tZowP77
         6FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394852; x=1733999652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAX9OZc5fi5Jorm88cMfQH8I9F+YyQu+8r7M5mFyRn4=;
        b=Z14u06qv9I3hPSb0KGEnxSm+Bfd2w0zJQKeSLtoSIb5F4emEZc7Fscm9WrvhdHSgA+
         7fcCWINR7HsEKYppx1qAWJ7xHSYr9SWHTCAfPYoc7+lo5M1KNMyMSRPdJIcx/IbUGaKP
         5qPcat5U2Y0P8ge3kfPLBy6ESzxpULbCkovg5u22yOoRrWfo96YhTsRcE7wbwSXA2fMr
         qzAcqupZfqqkGiNJgWMk4QZWJK5yMuQx18YEkDbzfb1ssNUAJNSf8RwYsIUugEuPYAGT
         iLQdH5kn3Cuh9IwI0YzsId51C4Cfkko3+L7kmamuWp82o/L9a0j+b4kr7PBFK8FSAqCA
         ooWg==
X-Forwarded-Encrypted: i=1; AJvYcCWgC/t6UZ9QEBUREI/hKz4yZleYimig0CDflA7fSziGpTcBW0AKsSlfzzUTW7K21JHRNDd5mN6c@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bDeCptgwLh2um/nTduh0SWHOE+z4usSkmm6bfyZJoJ5Ijqpv
	MBGQFlDLF9W47fwj/vweOoyXtvDWCqPsG+/sY+xWugeIWGO6Bq8ZwFsFntsE9c5Fq1+E3qtL5e5
	Lpit3xIc/r1wqCdsOJFTgyp92Tq9YQEOzLAns
X-Gm-Gg: ASbGncuRJjpDe+Y4N9aU+Oc0twZyNCK0g3WuQNKyJ3ojpd3eFy+WAuUCpFcn/pR/wAe
	TRu2w57nNTuvIKBaeD/PWm+0tKWSn1x8=
X-Google-Smtp-Source: AGHT+IGt+5aP+iEfQ8woydcbNlVOoacxjPcRs4/5HKPXiqt0zdaJFDxLUiU7UR5wV85tYrUBnM1Yy3zidsxa1C+Swd8=
X-Received: by 2002:a05:6512:32d5:b0:53d:d8a5:2833 with SMTP id
 2adb3069b0e04-53e229c0d64mr130211e87.3.1733394851665; Thu, 05 Dec 2024
 02:34:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205010919.1419288-1-tweek@google.com> <6e526f37-960a-4db0-bd17-4dab7803ca68@googlemail.com>
In-Reply-To: <6e526f37-960a-4db0-bd17-4dab7803ca68@googlemail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 5 Dec 2024 21:33:54 +1100
Message-ID: <CA+zpnLezpYaagkF=WxoVFXRWhcRMSMD2JP6_G==HErp0LuE_uw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: ignore unknown extended permissions
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:42=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Dec 5, 2024 02:09:39 Thi=C3=A9baud Weksteen <tweek@google.com>:
>
> > When evaluating extended permissions, ignore unknown permissions instea=
d
> > of calling BUG(). This commit ensures that future permissions can be
> > added without interfering with older kernels.
> >
> > Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

> > -       BUG();
> > +       pr_warn_once(
> > +           "SELinux: unknown extended permission (%u) will be ignored\=
n",
> > +           node->datum.u.xperms->specified);
> > +       return;
> >     }
>
> What about instead of logging once per boot at access decision time loggi=
ng once per policyload at parse time, like suggested for patch https://patc=
hwork.kernel.org/project/selinux/patch/20241115133619.114393-11-cgoettsche@=
seltendoof.de/ ?
>

I agree, warning when the policy is loaded makes more sense. For this
particular bug, I am trying to keep the patch to a bare minimum as I
intend to backport it to stable kernels (on Android, this is
preventing us from deploying a policy compatible with both older and
newer kernels). Maybe we could land the first version of this patch
(without any warning message), with the understanding that your patch
will land soon after?
