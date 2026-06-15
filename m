Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272A411694
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543686; cv=pass; b=qNmeltsEPplbD0ki1IF3PEkQm9IMu/rkdxbJk8MAedyND1anrft4HOfReP+2zFcOQdDotH7VGw2cQB5fvsV33yMyviPSVaz2SBeTpWuvViE7YDtSR1DrrA9CcIpPoUJ5e7Iul4dnIdpG8pBI2JPGTu8F7NV3maCEg8hPm6R3PnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543686; c=relaxed/simple;
	bh=mqaAN5d141+xa9yejaGvUhvIQLDs5AjpJldAAT40F88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ju7c7HgS6PLQBC0GbcHMez0ix1R4kyOYkT3jtm39yJKBtWkIgjYczBgbPrqbg8dwl/x2bMyqkDVFFOGFLgoLA4Ue4pIzoUcC9mzrEOh3O6ZqiMZ8Z6yeyy/LYvnI33036vODfguUoT3smZxNfJuPM4hPkdk7ixBi/j+c0YyDE5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMD/p43n; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMD/p43n"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f52af13so2877087b3a.2
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 10:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781543685; cv=none;
        d=google.com; s=arc-20240605;
        b=T7Xbqsq4EeQWfmw9E4GL/LKj/Riw56uzmBprQ9rJjlfm18YKynW5PPlJhT5gsVaikj
         g2lt7vawOr7Jjfcp58QubLJhLNGuYhqKZx7LZ5nCK+kGV10sxrXpkM8tPbVOfE/KVmyu
         yEg7NDRltMrbPvudIMzgkzvUXdpGb5boXoESDjIg9l87PcrxTtb+ZdkTpWCzE3XKrj6p
         PX3wp1rfcSk6uZyAX65/moMs5pgb2g0N6FPoHnxWhTumwe9LcTM2FLOaUAtiikFD5w7x
         90AzXsUNgbn/rLgQwnKa5M2iGL7YCxmLTJAa67cXUUJFE8KC3AAdyrONbqCAPWW5fbLW
         4h+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mqaAN5d141+xa9yejaGvUhvIQLDs5AjpJldAAT40F88=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=S2USDoyc1NSLxR/BzbbSe7n7T0Xxvws3CEOFdOua7CO8C6q6fBIaeWjWW5RmfaVX2j
         /DkVj/nDdTayCnD5S+MI/CyzihMze65oibItuSD4YU4jaVnrbHX1PHwrKh9C1MC+ummr
         UFgsnSI+ogiX+7wk1pmgxAfq5MqKn6QSz/tQQax/VE1cpdA1sEeYaNOooCbFQUdpeOmA
         3YpETPi7qsxA/C139xhwpTnsGhnQVcv29XY7a20c6J/+NGrLwgADndqyBXcQ9wHGbAMv
         NkTPCv06aDPmmrPLpLip7bZd37ONnFseHTsNHAm87C4VBkCkIG8VYQupHSBJd8JNy8c+
         DVRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781543685; x=1782148485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqaAN5d141+xa9yejaGvUhvIQLDs5AjpJldAAT40F88=;
        b=GMD/p43ntm7auzEI6tsN7Nw265jn9ZyRQMJYqBUGQTgQbjjocjENj2YmLB9onHc//A
         Ke3lTUTsnruY06wLgRpE0r2d6a6Te94DXFjbzgb6l/oGWEVOjVbxAV8ul5z/0n0GvOoH
         XZlSrVBun1f8kkZFZnAiDTyNX1TgO75XjrDMM7esl26rm8Qgnhb8XIleiQWBUmWmtQIe
         0YYEjK/Y3WQTctwbG5Q1r6s+FpmaM9JkDfKQASv0FLpNWGbeWanDB28mkpXErgShvI1h
         H5CmdHBykFhQ1BmgNO9nnXkvHnjj8HkzVQz9kKLOwDv31HF8dD11SjjJqsMC7sh2ejjk
         iKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543685; x=1782148485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqaAN5d141+xa9yejaGvUhvIQLDs5AjpJldAAT40F88=;
        b=Wr195GU/yJJFf/F3b5NjHdwcqoM9rzGpqyuWt4e1uZzUmm5NicHWwdxhMKiq+EbOf6
         chcCT19WyTJWLauv3aKsdlpPAyGSDPXOXlSSlr7B8ZTTnOadV54GfpxTjZX5b1WUS/N6
         DIFndn+AHZL7WL2fcUZDHofHc72bjkbYSrDd2VfjvaZw5bbN0SotVD4YnL3KvhlQR1C9
         PkeaW1YkuFFYqmX4x8o12Ox7MWVIaQp0z6ZJoZ+26gwiGQUpYZOxiRZqU5OzacD9RdAD
         RUd4Is9EgH4+24cTjORqFlDFxgRFkZzaGNNZ3atDMcWhsrGJi0Ei/evXXHsotQXjiYpY
         9IQw==
X-Gm-Message-State: AOJu0YxHoPD05KSV8oDDu8x3G37ASMWanxyB8OxAKizTRO+xHGKdYxT6
	i/BWWUuxtE5zTXIEQywLpFYZP2RMDx1BKk6bXlffLss4NMQ+DxRixAPPLLE8n4/5555YCi6QLDq
	jiaFjrRhF38SUmx/aFYekzZ/KFwxU6JE=
X-Gm-Gg: Acq92OFw1SFvyY+t7rs9seJKgIOzZoLKNuQZfus9/adahLqd0lQCs/xspdyj62LxIFN
	Us4nAgNq/IZNVi4b4Mo1/BiYS8m0R8UY0pfJTjdLIek19P600Rses66xAKNKol217q9PJjJieUl
	0SjDAbyNN5JWTCA7xq8FLh//AxDYC+dMi9LKRVKg2A0oim9nfdSFRgZ//OdkYZZPr1CUbZdBvG3
	lo3eyfr32SEY2sdJ+o/m3482QQTu2SUHzxfzPT6t+QgGOazsJUrnPF9aFjb6i55t8DxWvglvzPY
	4x58QXU=
X-Received: by 2002:a05:6a00:a210:b0:842:708f:39a6 with SMTP id
 d2e1a72fcca58-844e1962f2emr12381240b3a.10.1781543684879; Mon, 15 Jun 2026
 10:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614162323.18730-1-kalevi@kolttonen.fi> <CAEjxPJ6C7ST4B6Xuq1dvE7Bx7EuZ1NVzh6yE7w0VRziXKHORiQ@mail.gmail.com>
 <CAEjxPJ58UmimfTz9VhOVbUyGEyGWA7G5SfVs1iRf03-Fnfe9sQ@mail.gmail.com> <ajAySI0DK8a86hJf@AA-94-54-42-0F-E2>
In-Reply-To: <ajAySI0DK8a86hJf@AA-94-54-42-0F-E2>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 13:14:33 -0400
X-Gm-Features: AVVi8Cd3cLbNPKBZwnDYcr9AbAxo5OCtfs8ENlRC9VvG6_J3zXCctsUG1lpRpCc
Message-ID: <CAEjxPJ5xWAL=Sxpu+KSWx0PS-q7jesvqm9h6ym2ODJcBHVvu+A@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: use bool instead of int
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 1:11=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> On Mon, Jun 15, 2026 at 01:01:07PM -0400, Stephen Smalley wrote:
> > On Mon, Jun 15, 2026 at 12:58=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Sun, Jun 14, 2026 at 12:23=E2=80=AFPM Kalevi Kolttonen <kalevi@kol=
ttonen.fi> wrote:
> > > >
> > > > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > By the way, note that several of your patches had exactly the same
> > subject line even though they were modifying different files or
> > components; it would be better to either combine them into one patch
> > (if a single logical change) or use a different leading prefix to
> > indicate what they modify.
>
> Yes, that is admittedly not so good. I was going through the
> source file by file so that is why the similar patches were
> not combined under s ingle one. I will try to be better in
> the future but I have already deleted all the local branches
> that I used to generate the patches.

Yes, no need to re-spin the already posted ones, just noting for
future reference.
You'll find examples of git log messages that either extend the
leading directory name prefix to be more specific or put a secondary
prefix that identifies the particular component/file/function that is
being modified.
