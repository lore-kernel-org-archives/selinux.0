Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150A31B83B
	for <selinux@vger.kernel.org>; Tue,  3 Feb 2026 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770158460; cv=pass; b=C5XaL6uAgZPVtLunkB0IzYzJ0hjWCjtF9+DMsYUK5TsAO7dJYwxe8N82riMOfc+uFiUzXQ0FpwvxNTfsv7Rm4tjtG5EDiiMzL+lh+42yRqAXw4zSSogihedM6z7AuyZFxpYMvZq6P5PoV9J6u9gwobI/KBCyb8fbITF8z2/6h0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770158460; c=relaxed/simple;
	bh=mNxsZIpO12xYwIPhpNLEYqg3xGCJpxHU05Vm1/bMpH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7V7K881DNknw9CDjwoFTXWgjOkLeuHTUHrL2NEFq2uytU8BP3Nh0kIS/ZmR5oQK/pchl+TRRnzx/0/s0JxOPIsFpTium5mve5Zt2mi+m0cFPEP71XkF9o304TIOSrXIJwAKSQMsFk/w5aTGSnpWQehAM8aIMvEBrJvD/mKGM1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eFHErCUd; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eFHErCUd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a102494058so1335525ad.0
        for <selinux@vger.kernel.org>; Tue, 03 Feb 2026 14:40:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770158459; cv=none;
        d=google.com; s=arc-20240605;
        b=kQU8LcQniJlsJLbN0+gROXRLv93E0rFcV8jCMea9vAsoZLsVZhX5iodIMIK/q/BUn+
         mtwx3LE3i9cgY3bjXc+LF8qmaT32jO/Mj81/DL23SfxWK8WeaukkEfykNs/ILoXw9eal
         fQlh7twzOFxb5zqiMR1rmfE5fe5Qmd5UZhVX8W3FF1cTJjRLqBfH3/fGrGMDlqYapkg6
         VY6duzXiqJy++tHX49VyMIAwiN3+p2Cq8R+/LS5KYVvZjJfx7lsJcCE3NB2Zd3romIKV
         pBVqX/OxKRQIaSdxTFg2rxHEmOyneoHhNvV11V1YG1zL+2fXZXcuurqGr/lCX6ofn1ew
         ZbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yhF9jJ/5jkA/G3XXwtAD0z04CKPNClOANnWCQ+kHOf0=;
        fh=h5DwtxXI7e8O/Jsf7s5o7YDLEbe3hcXhw9S8zvuvMeY=;
        b=LRzVCt22Ky4Ag0kkbnSfiKWuVjpQBMf0t0RaPkBHEbBHrled79nS8ERjPpnT9vKoik
         U5M34gHlJ1uF1VLeIVl/P9+Vhwcqlg/0X5coVjGtr7eqSj6E4HpB633tmv/f692UmSgv
         nLRvArB137Kb/E9sVpb3fUxNVbad3MO21cOw2oxXYuoN7m9lL1utKd8txKeLxDm6uPF4
         lwv1FTwhwaMPsmi/5BM4vA/6PyUI6rwaEpwhD9ViLx7h2Kd57Pjg+R232SzjOFzd/1hm
         bV6gMnHVdvu2mIGcWXdxGzvYGL6iUULdPdHxc71khcoAE7FlcRtdxfuxKGRp0Qz+ICBx
         73jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770158459; x=1770763259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhF9jJ/5jkA/G3XXwtAD0z04CKPNClOANnWCQ+kHOf0=;
        b=eFHErCUdhFyWGykHjYB6biTI6lGhkeyvSU+/AGFo++dYiMonR9D2eLErqPy0mkDw4W
         2xKbh4/DpviR4nmus2RgdGNwaisyKe1eiTPPfwyu2kE7LqIIGidpt/kb68h7YfDfrvgS
         IrT90nehejOP8NrMiJ3XcHBRhXSczmZTklqN8NWV5swtwLwmX3hTf5d63xFjN01BCv6t
         wbuAr8OmZIcI4vBEeLTTE/8sesbRpwy4xw26u+/6906sqyWp0UqEv5VRVuFqLS4ZAjYI
         NgF29kbK+QaYbZ9qaLWDvl7U8mZ0VtIk7dVQ6pXScE/omqo+uz6cRUvzfDm3B37V/jIq
         NK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770158459; x=1770763259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yhF9jJ/5jkA/G3XXwtAD0z04CKPNClOANnWCQ+kHOf0=;
        b=PyAfFRWdeCFTPQWwwA52nCltShafTNm6uGIjUGGm+JTDXP2gQW2HJDjfaUSDpd7Wfg
         pEnQjbGUfA4epDoWhRTUlKTVY20BjhjmVqXb6XrVvTx+f7IjOEp/5ipUws7GaYM6XjVV
         OdMXjCH985Q1rnkaDwyK+DYwvPLlpHGEj3+PMfrrszvxelU3fQwpP3vLeLa0loXU56bX
         miQMnjbsySNWgHZGTR0N4UBc3qHX6cDh4F+eRUa1xIeuL3DEG/mWy/9e4IIjsQs+rUMJ
         Oi0y135ufqD58JNH7lkkQW4CA3zB5fixRY1zgf5FsLVf/DG4bXY2hSNkG2HhoHKrHLsM
         J6zw==
X-Gm-Message-State: AOJu0YycU12sijfTbiGExI9fF2hYr6sVFNZc0dIkdyk/WdRvo4o0Ow0d
	xHwUN5kTpe1ZyJrMYT6pd3CIvah8KrOG+rUVImbScBEEvtDDQtDU85/X8MNUpulOzR7vngEZB3V
	jAIqvO+tlVAtY1navWwYb/0uLeTUficguAtJdUU2j
X-Gm-Gg: AZuq6aKjLl8hfmcEub4Hh7hxVMlT4lirIAnLYEAwA6ziGkmpTj2siVFZlFH9Qe/9WnL
	tt18B8Kg9SBtfuK8MLveQW39xB4VLXN+c/hZlEm4ZIKX+pkrpI1pURaLWG7U+TX/ouDcetnlqUv
	5VU/3J01byxd9pw58dkDzq+Qv03JkNfrMZA+ij3KHGkK9G9JO5BByR2yrvdRhwB/IuFx3vOLuJ4
	D1TxEqUudisjx3DfvijfAvtWRA/Scjo0zGjM6KwRx3A+kwWvNK1vAaNqKt9s9fCxpp+ayY=
X-Received: by 2002:a17:902:cf07:b0:2a0:89c6:1824 with SMTP id
 d9443c01a7336-2a9245acb81mr45534675ad.8.1770158458714; Tue, 03 Feb 2026
 14:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
 <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
 <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
 <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
 <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com> <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
In-Reply-To: <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Feb 2026 17:40:46 -0500
X-Gm-Features: AZwV_Qif3yehzpr-f2ndt231BFo5lijgl4EiKO49mjjc8a7vIRsWIa1o9OOEp3s
Message-ID: <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: SELinux <selinux@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 10:48=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/02/02 13:07, Paul Moore wrote:
> > I'm asking you to verify that we have the LSM xfrm hooks in all of the
> > necessary locations to ensure that we are safely and comprehensively
> > gating all of the operations that result in removal of SPD and SAD
> > entries.
>
> That is impossible. We can't have the LSM xfrm hooks in all locations
> that result in removal of SPD and SAD entries.

It's a good thing that isn't what I said.  I said "... LSM xfrm hooks
in all of the
necessary locations to ensure that we are safely and COMPREHENSIVELY
GATING all of the operations that result in removal of SPD and SAD
entries."  I used the capitalization to emphasize the idea that the
goal is a comprehensive gating of the operations, not necessarily a
placement of LSM hooks in all of the functions.  It can be a subtle
difference, but it is an important one as I think you can understand.

> It is your role (not my role) to verify that we have the LSM xfrm hooks i=
n all
> of the necessary locations, for it is you who is wishing to ensure that w=
e are
> safely and comprehensively gating all of the operations that result in re=
moval
> of SPD and SAD entries.

All of us who contribute upstream have a responsibility to ensure the
proper operation and maintenance of the upstream Linux kernel, this is
especially true for individuals such as yourself who have accepted a
maintainer role.

You have identified what appear to be issues with the upstream kernel,
and have proposed changes to address that.  While reviewing those
changes I asked you to verify that the LSM hooks associated with your
proposed change were still working as expected, since it was not clear
from the discussion, or the patch, that an investigation had taken
place.  This is not an unusual request for such a proposed change, and
is something that I would expect a LSM maintainer to do without much
hesitation.  If you are unwilling to investigate this, can you explain
why?

--=20
paul-moore.com
