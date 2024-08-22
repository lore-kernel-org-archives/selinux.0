Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AC16D4EF
	for <selinux@vger.kernel.org>; Thu, 22 Aug 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337489; cv=none; b=uozdExW7rGm+65u6NOgwHUpgYnL/231dR1lsbm+jDuLuJ7gPZN75QHMbN2nJkqyc2R/T0HdkFXIGgw9XuD0OxzpUQq8CJcaTdO/N3aSHS2+1BXFtXt3POjCEUTsPbvRfhwldS5KmaPbVEvsO/CUMIO6IKnyVJqa8JkNdLEPnC8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337489; c=relaxed/simple;
	bh=WKguHcEUcIriy0Iu6wPNIoFb4RzaOvO7QnMqZ35A3D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWXlrgiEWQf9IokUqFNUQk8Teh6T1TCGcFa/nh1/gKcHmuFxqDAsXPfqOEKjc78B57zSTUGrBL8vvKgOxcuQ46qt2scCML4Uc35bxr8JxT5vpcxjqlCgXboe/iZQJIhQ+w9hwIwIEIAXdZz2UNJf0tGfIRm6VB7zIw+Bk/jJOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIGJJthq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIGJJthq"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso669492a91.1
        for <selinux@vger.kernel.org>; Thu, 22 Aug 2024 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724337487; x=1724942287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKguHcEUcIriy0Iu6wPNIoFb4RzaOvO7QnMqZ35A3D8=;
        b=OIGJJthqSIySHcmtY3QmfF8ms/IKP41Zt5FSWNbP+56Uav3KabVqFN4VvArYkUM0FP
         adabtxwk4nxr2WBCCfvNO/7m8lzi95RHeKqCChfE3ibNXPIhptZ8xjuX+fpK9vN48fpP
         KhIpECzGfgwVoPrr4qK9V6wc0QQO0ITNjBcei8Lsjd2k2VyO32lFdZfLEaroMIBAtats
         pRPgdA4NC5fPQRinCjtPdTVUVMecaI6tgH9j8G5XVlH2PpL8b126VlxS/6q0qDwE1ZCU
         k49TYUubZazBqosSZ2HEInG6h4fjiR2QMFjqHlGVHo0uc+qgongfJzeytSCWv7cYPA9w
         6Gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337487; x=1724942287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKguHcEUcIriy0Iu6wPNIoFb4RzaOvO7QnMqZ35A3D8=;
        b=QlGbm0zthsMjKR7biU88k4LtAhu/PNEkGFCUPkaieBw/BR7o32uhBk9/oCsElHX6B9
         dOAU2HjcgLTotNaYg0UppeUPXpjUX40zOWJtGiaOAwmiWO4BDAA19pmh7VGr9mC+EGd6
         SH4hfX5DVjaKJCQq2OvgXBG7N9hbaYpoECQ+OM9YiCpDHP7tWc2PLyYPBrV96t55EADt
         CEOqHEu4HZ/wyUh2FscEuglTIIxjrtntVK83hWTP7fn1FlD+6ICEuehKob0LpGZXNgRL
         Ug9qaFXM7OeaxhF2fc8Kme+qevGogGMgeZ9lj2QhTIRGmrKnVGfafDB97owihEKWrvDK
         +Wiw==
X-Forwarded-Encrypted: i=1; AJvYcCUPxj84PrK6akTDzhU++VHrJ+ewtQzBM4XqOOKIisrtyJOtNu+hGK7n4u2ZA+qKbdBFcQfBcQXO@vger.kernel.org
X-Gm-Message-State: AOJu0YyGzns8I9fHlbj30215CfExQeZx2y94Xcuo5Jau/PcuH4mp0TZk
	t5OgSKJ3dOBu/WPWCPd6P5D0bht+b2wSGKDMg8HBNftaw9P4ZqoxrDP+qORTSTZQvk511gKA8xH
	PJwPYfw+Hqcm81XzsFXnNRg8dKVnl9w==
X-Google-Smtp-Source: AGHT+IFi92oEvH3STRFaNVqbxZVm93lJgNUO+r1UNtz/3XtYAQRm4YQjVTfm1Uw5Hx5zgONDPwsxK1Q9+4P2A21vP44=
X-Received: by 2002:a17:90b:3e84:b0:2d3:cb16:c8e with SMTP id
 98e67ed59e1d1-2d5eacbc625mr5437427a91.43.1724337487145; Thu, 22 Aug 2024
 07:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820002723.1345639-1-tweek@google.com> <CAEjxPJ7Jg6vYOQXVr_tT9F4SZcDHN==7LfORxxOACqtn_SRKTw@mail.gmail.com>
 <CAHC9VhQU1oEaS=bB-Kc6Bfukb_MMFv+CrhpJ4F7L=tK8j_c8Ug@mail.gmail.com> <CA+zpnLeoz3yuVd5EUtct-CDi2zT9u7Y61edB3s4HbiEfxLOZNQ@mail.gmail.com>
In-Reply-To: <CA+zpnLeoz3yuVd5EUtct-CDi2zT9u7Y61edB3s4HbiEfxLOZNQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 22 Aug 2024 10:37:54 -0400
Message-ID: <CAEjxPJ5g_9CDRi8zm_=0tPyQf4D8Tpo0q3ai13_txNW1_Wd6kw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add netlink xperm support
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, brambonne@google.com, jeffv@google.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:56=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> On Wed, Aug 21, 2024 at 5:54=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Tue, Aug 20, 2024 at 2:02=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >
> > Thank you for reviving this patch.
> > Do you have a corresponding userspace patch? And for extra credit, a
> > selinux-testsuite patch?
> >
>
> Thank you for the quick response and initial feedback. I've just sent
> the libsepol patches for userland on this mailing list.
> For selinux-testsuite, an issue I came across while testing is that
> the policy capabilities cannot be updated (that is, only the
> capabilities from the original host policy are active). I am not sure
> if I got that right or if there is any obvious solution (except
> toggling on the new capability in Fedora).
> I'm still hoping to get the extra credits by: updating the selinux
> notebook documentation as well as updating setools (for sesearch
> support). :) I will send pull requests if these patches get accepted.

With your userspace patches, can't you just do this:
$ cat netlink_xperm.cil
(policycap netlink_xperm)
$ sudo semodule -i netlink_xperm.cil

If so, then you can add that along with corresponding allowxperm rules
to the test policy to exercise this.
