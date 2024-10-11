Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD61C5796
	for <selinux@vger.kernel.org>; Fri, 11 Oct 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672133; cv=none; b=Gz2I+h5VfSUJK/vJzgijY4I0CwRsUzSoOyaetnajKX6amJx6MmF0POIij4HSwLXdpyA0Npm+4yAWkohoFNcsX10XuhEEwPYw44uAChDrtFa5PxmljtmNsu2V+rtgQ7qlLMc96h4Mz4e89eWlbeAFs3zT8Z2f1LymKSvFBkuYcrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672133; c=relaxed/simple;
	bh=awZT28/RDhTSYIZAibdl2X4pg3u5JmC0q19vaw6Rwmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3ADsNn8qas40k1lPMqUyZXyBS2d0ivEEfXeCNBuG9VRIlQsN6bh1uNZ59DDmvwAEQv6Lvw097WGeteQOCy7W1HmX8z4lvzMbrUrKcJZAF3BKDXFRIoY7b/ufv4u5KZMIp4QQsyjv6J+/QDarpci6e/TAJrCrSH5Gv8T0rNn/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UiMU2i4Z; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UiMU2i4Z"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e290554afb4so2451272276.0
        for <selinux@vger.kernel.org>; Fri, 11 Oct 2024 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728672131; x=1729276931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEpU+ihmki2IJbXkgKPvOcj9mDJ1xqWdvlEU1cTSkUY=;
        b=UiMU2i4ZXfRL26G3DOTKJOEfJO+0+38VFacxrE1Op1wZXG2+/uPW5ZjFgQPISkk6bm
         ODwpbKEPSmiPw7j4j8t3CZvRa8kSq5a42EtL/4mCG5Gvg66mzK/iqddd6Z4YkTBP66jo
         hz2Tfxex9nPaPvsNckm5mA52Yf/CkWcEv8Mij1mFY8mP1a+RtoQEE0aV0A9ipYcpdd46
         xYHxt/xMKUngl+DH3d9O5JH4hf55MqSXGhq5UYLhsLHN0QPb/O9OgobumjPgOT3Vr+ra
         oLX7BJMFdzj2DLN1Frn0D8yKWhnmo7a2OF9nL4Wj6+94KAUNxvOw9+t3YoHZQsyOuSag
         kunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672131; x=1729276931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEpU+ihmki2IJbXkgKPvOcj9mDJ1xqWdvlEU1cTSkUY=;
        b=gSUCVWq5vMp7RUUOh4f5H8bM/YUkxBT5PdqMj7Xlf+iHyGz5RRnuxDEHApLiWwZ4u6
         FCK+4GSIyKtlBoHAR8fnYH+uR7ZipMSnQ/Z93SuPs0YAFZkXAMcve1tQNaQUKQ7FsXL5
         5SrOkueh5Fr0qf7vcLgcYYsv9/qTt6UeKTYLUEAZbs1Uok9ZFso3Ux2Qy6658W7nO9TY
         2akicGb+PHeaOcQyiB7XbdFJqzSk5ZNBf74bCPPY86v5nSpDZbE5Jz+teI/VDV0wxMYc
         LdKJ6wSIvQRYr0OUusxBmqGMrGj1iViogHyF6ZH3V6OQEtpAy/Z2f189mjN4GGfhrOxe
         jYSg==
X-Forwarded-Encrypted: i=1; AJvYcCXVS+2tupLpwsIwq+NpSUmZTv/1OO/67Yg8f4L+O2G24MYvyFP2KHVsV1jrAHb/GhR+NQgos+/K@vger.kernel.org
X-Gm-Message-State: AOJu0Yzon1BfBXADLCdsB57XNkIpG31TvN+ZDBFFxbCG5ib7/ISgajPo
	62ogPDXohGUHqPwkKvWa9BA2IkXQLsXLEUDT3/0puXDlHDAgGNMcyz6hsyTawjPtdVI4qmLNHuF
	dwQ+EtSdKO9IlPalxN1op+Dw+BoUPUnjJ4+lB
X-Google-Smtp-Source: AGHT+IHl9pAM7khqQXTT6XeQ83ZZMoJPB/ej4flIEfjQ9ig+rT5Tafd7vJpMVu9ZDKNGmsLDDiBR89PO0T5VeahSCpQ=
X-Received: by 2002:a05:6902:727:b0:e29:255:c61b with SMTP id
 3f1490d57ef6-e2919d66b89mr3821890276.5.1728672131311; Fri, 11 Oct 2024
 11:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009173222.12219-5-casey@schaufler-ca.com>
 <4e2669fc0be9b0f1ca15b17ca415a87d@paul-moore.com> <a4094e38-44c9-4ab2-9b37-c1eafee16d5e@schaufler-ca.com>
 <CAHC9VhSaCVvj-+U+WEBxvzXyi=FPNaL7HMt4Kg86Ugi1SNnCdg@mail.gmail.com> <c3423767-91df-4dc9-afe8-895540b185d7@schaufler-ca.com>
In-Reply-To: <c3423767-91df-4dc9-afe8-895540b185d7@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Oct 2024 14:42:00 -0400
Message-ID: <CAHC9VhRcAj8Pjt9E0_bMa5ybW0+LuzpQkgQ8Q+hZ5Pc6GHH9wQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/13] Audit: maintain an lsm_prop in audit_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:34=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 10/11/2024 9:11 AM, Paul Moore wrote:
> > On Fri, Oct 11, 2024 at 11:52=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 10/10/2024 8:08 PM, Paul Moore wrote:
> >>> On Oct  9, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>> Replace the secid value stored in struct audit_context with a struct
> >>>> lsm_prop. Change the code that uses this value to accommodate the
> >>>> change. security_audit_rule_match() expects a lsm_prop, so existing
> >>>> scaffolding can be removed. A call to security_secid_to_secctx()
> >>>> is changed to security_lsmprop_to_secctx().  The call to
> >>>> security_ipc_getsecid() is scaffolded.
> >>>>
> >>>> A new function lsmprop_is_set() is introduced to identify whether
> >>>> an lsm_prop contains a non-zero value.
> >>>>
> >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>> ---
> >>>>  include/linux/security.h | 24 ++++++++++++++++++++++++
> >>>>  kernel/audit.h           |  3 ++-
> >>>>  kernel/auditsc.c         | 19 ++++++++-----------
> >>>>  3 files changed, 34 insertions(+), 12 deletions(-)
> > ..
> >
> >>>> +/**
> >>>> + * lsmprop_is_set - report if there is a value in the lsm_prop
> >>>> + * @prop: Pointer to the exported LSM data
> >>>> + *
> >>>> + * Returns true if there is a value set, false otherwise
> >>>> + */
> >>>> +static inline bool lsm_prop_is_set(struct lsm_prop *prop)
> >>>> +{
> >>>> +    return false;
> >>>> +}
> >>> If we're going to call this lsmprop_is_set() (see 5/13), we really sh=
ould
> >>> name it that way to start in this patch.
> >> Agreed. That's an unfortunate artifact of the lsmblob to lsm_prop name=
 change.
> >>
> >>> Considering everything else in this patchset looks okay, if you want =
me
> >>> to fix this up during the merge let me know.
> >> I can do a v5 if that makes life easier, but if you're OK with fixing =
it
> >> during the merge I'm completely fine with that. Thank you.
> > For trivial things like this where I've already reviewed the full
> > patchset it's easier/quicker if I just make the change as I can do it
> > and not have to re-review everything.  Otherwise it's another revision
> > for you to post, me to review, etc.; granted in that case I'm really
> > just diffing between v4 and v5, not really doing a full review unless
> > something odd pops up in the diff, but I think you get the idea.
>
> Indeed. Go forth and merge. Thanks again.

... and now everything is merged into lsm/dev, thanks everyone!

--=20
paul-moore.com
