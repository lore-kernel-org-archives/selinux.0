Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF619922F
	for <selinux@vger.kernel.org>; Fri, 11 Oct 2024 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663074; cv=none; b=TjRfIypknp/7vY6yQKdY0PN9ZbrW8jQm5sqiYBT7ndDp09MLZPzLz40RTZI8qnRJeQWqUxa2sF/PrEdMqhBb0EX7JjUCWmkTfikkHuFJhWZgrmKymoPXZ+ha25799fD8GMdrjlwF5a+ovz/Q8lgvMyu7ThsStv+bjWnS9FcLE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663074; c=relaxed/simple;
	bh=l4RWFWAO/aVOL75wfpJ2dRIK6YuWibT61ePGGE9YXfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiqrt2kyXzyrpuXspbBXQIGFZFAc8Xb2SRJSa9pU0G2d9a94ooeU/CoWspQjUeKdlN2KRtFeUiBwlbaQVvQWeAR4H2qptOaFeaP3j5bnHtwbo9DOv6Te99Et0t8Bpx48a5kITYN3VP33FqvF17w5fCNJFmmSswFpd0LAl22Dww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HUXHLunT; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HUXHLunT"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e290582301fso2549712276.1
        for <selinux@vger.kernel.org>; Fri, 11 Oct 2024 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728663072; x=1729267872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/95GiLQzO/ms2Ix7Jkzwr/0YrEtOp3SFzqgMi8X4J4=;
        b=HUXHLunTj3WxgbGEQSqHP08S/LFcNL5rPR8p+gjdh6aPY2L4AvWfn34+ypQJsFjntg
         rRt7Rb4AziwFPdCP0XUGLM7xwGdwy3EpI9AQ+HefOnfJRPGG/dyJ5dJCpsAFAm7YvT5T
         VfhwWiRSQCQjOA9Od+SLykKGY86mfZ6qyL5EPNxg/epcE45z8xBwk/a9O1RB1T8iYN0L
         HxhA/mkIrU4/9n4IU1xpInOJgCDUs+rZqM544qYYD3ZnlmCsZBLCijtN0P8fjj4i6QXj
         YFXpaKVhnUdgYHXqIa43vwJoifD7+vK12Y9akSrw+gbkD1Uj7NgAZ7g7lBaFVd7OF9eh
         wKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728663072; x=1729267872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/95GiLQzO/ms2Ix7Jkzwr/0YrEtOp3SFzqgMi8X4J4=;
        b=unrhcbVMs3J2TppfmXug2AUz0RtG6x+vphzZ0twXAAILnXqjbZ3Tv4AFZAGv06nmnx
         7bOOWlkeXMRfgaVlZ1xTnU4pmRvuBO/3VU0dhh1oQfuMncXQqhd/9JVr2T1hLSqwRzwu
         xrH5lrkueH/CQs5ySbNBmyxw68tw/nT94h/a9tP9pvdu6zsiNzHxji2zy1uQGP9+TP65
         DBrJxT667MpebyTXLb5AHqZgLvk1tHadnUyK/m87ikG9uenuB/n4HPDXW/tvNW1p64Kl
         2ebsrLGfDCStspDt3zHUWx7iK4w6vIgOnskw91Re4d61jdTmHmkt/pZ++tJw4nKlzEeE
         fYCA==
X-Forwarded-Encrypted: i=1; AJvYcCWjo/kWiqHKWVcKZpfPu7+ZGsd6YwrjDO5h7K5pgkbrJJxi2QgI+Hsxn0oHnI3lgwZO+Fxkqomo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvr+PAgzmfOfO047A4kO2uqJqn3IXILBDi6uiY4vY9oCNlaEF+
	kUMzajhqKVQ1N7cJora3Yb+hwj5KnNNBDUQo3uNJu1IeSX/4u9LgKnQ98G5dIdtEf44R6jEdpEj
	VomGZKTVLPMFLzPDxSJtExl+ibgGuxv2XkaKc
X-Google-Smtp-Source: AGHT+IFZHZ47lJ6yP1+B4chXm0/ct/9JuqorUcmLJwaiVv7U3z2eilQKYuDhW80tIHcjJS9Xct9UfBaiTyEEa9zobhg=
X-Received: by 2002:a05:6902:1b8e:b0:e29:20ad:8281 with SMTP id
 3f1490d57ef6-e2920adff78mr2314361276.33.1728663071733; Fri, 11 Oct 2024
 09:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009173222.12219-5-casey@schaufler-ca.com>
 <4e2669fc0be9b0f1ca15b17ca415a87d@paul-moore.com> <a4094e38-44c9-4ab2-9b37-c1eafee16d5e@schaufler-ca.com>
In-Reply-To: <a4094e38-44c9-4ab2-9b37-c1eafee16d5e@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Oct 2024 12:11:00 -0400
Message-ID: <CAHC9VhSaCVvj-+U+WEBxvzXyi=FPNaL7HMt4Kg86Ugi1SNnCdg@mail.gmail.com>
Subject: Re: [PATCH v4 4/13] Audit: maintain an lsm_prop in audit_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:52=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 10/10/2024 8:08 PM, Paul Moore wrote:
> > On Oct  9, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Replace the secid value stored in struct audit_context with a struct
> >> lsm_prop. Change the code that uses this value to accommodate the
> >> change. security_audit_rule_match() expects a lsm_prop, so existing
> >> scaffolding can be removed. A call to security_secid_to_secctx()
> >> is changed to security_lsmprop_to_secctx().  The call to
> >> security_ipc_getsecid() is scaffolded.
> >>
> >> A new function lsmprop_is_set() is introduced to identify whether
> >> an lsm_prop contains a non-zero value.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/security.h | 24 ++++++++++++++++++++++++
> >>  kernel/audit.h           |  3 ++-
> >>  kernel/auditsc.c         | 19 ++++++++-----------
> >>  3 files changed, 34 insertions(+), 12 deletions(-)

...

> >> +/**
> >> + * lsmprop_is_set - report if there is a value in the lsm_prop
> >> + * @prop: Pointer to the exported LSM data
> >> + *
> >> + * Returns true if there is a value set, false otherwise
> >> + */
> >> +static inline bool lsm_prop_is_set(struct lsm_prop *prop)
> >> +{
> >> +    return false;
> >> +}
> >
> > If we're going to call this lsmprop_is_set() (see 5/13), we really shou=
ld
> > name it that way to start in this patch.
>
> Agreed. That's an unfortunate artifact of the lsmblob to lsm_prop name ch=
ange.
>
> > Considering everything else in this patchset looks okay, if you want me
> > to fix this up during the merge let me know.
>
> I can do a v5 if that makes life easier, but if you're OK with fixing it
> during the merge I'm completely fine with that. Thank you.

For trivial things like this where I've already reviewed the full
patchset it's easier/quicker if I just make the change as I can do it
and not have to re-review everything.  Otherwise it's another revision
for you to post, me to review, etc.; granted in that case I'm really
just diffing between v4 and v5, not really doing a full review unless
something odd pops up in the diff, but I think you get the idea.

--=20
paul-moore.com
