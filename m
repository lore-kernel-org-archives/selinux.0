Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C945695
	for <selinux@vger.kernel.org>; Sat,  6 Jul 2024 04:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720240333; cv=none; b=c6eI5bqIQrc27599ow4Bbrm9ekpJI2MVeZL0mwNYomQtwxXqAF7eydIxDMUd2RuQfFTAAymBNqC+++qHfAnDTL4jtr2jo49mk/Q4FIK4fXqlZU28JLgfmKxAhViUVjAmTTbZoAqcI0LzkYHfCMNyatZXGgWa4bQAaKGndZZbiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720240333; c=relaxed/simple;
	bh=S2HiS9W/LFKVDYseKKOBN73k+bkKc9vaO6Co/zYuo3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ag+FtRcF36HrsbVkfGGBewesTN9sN4Mtz5AcTLFK9OeGg8k4Hy94359PeYJdIwadQvzSl7IMDvxmjVlSaSuK0Blz9clOrcStyEdmlOJaFTTTa3pfqtieW+XdPgh0B4z6VcrMP/lh3418CK5X1Kax2ZUK27JCu2myBKpq5V4v6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QkQ2BHkE; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QkQ2BHkE"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e03c689addcso2307091276.0
        for <selinux@vger.kernel.org>; Fri, 05 Jul 2024 21:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720240330; x=1720845130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxnC2JAV/5eDu2A30I3BJlNQHMpxNAX8P1jOwLsIjlw=;
        b=QkQ2BHkEmxZoKD1qk5+Epn9ITMAV73hFJ2pBml/VBBASPZSYBIwn5q68Fjh6p1gJOI
         lPGHLrBKPQEQS9bib/wBFWFFdOBfJ3pHGaVrDSC1Z3PDm6X/iIU1Gk6KfBsayOk/4TFs
         Gsqo/4bYZWgrnXD9+G9iYScg56pQl7Alhxpq6JCDM1orKS3JCGW2yeoI/92pgLV+CHXG
         e2IxYjc5SC/amirrDeDFqT342q9+9zqOcM6mNnJInpJ0rxXfpn35eEH7kcUA86X/uugy
         uYE65rMTBABLQxpBne6bXQ3SOzWx+xoixGJHNe6uwfwjPSI89GBJ/pxJkO64fNScUxrj
         zCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720240330; x=1720845130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxnC2JAV/5eDu2A30I3BJlNQHMpxNAX8P1jOwLsIjlw=;
        b=U0QEYPZVutPvtXlurgzrGxgTO+coceFoqdtVUeICcW3rz1z2jKgNPparT9fyNDEGaG
         OpWNKtCJFk5RNUUgFL6qZY5J8liYV0kzKHu9TKv3wWNuKl7omUpkgNXCUSiHkmAGMmot
         ShQh2MXPD25egFSzsZElZfDqmyc0kRUkVneVnXSo30K5h85kr0Cv5B9eTXMmm7agmnYb
         pnmNwwYyU70Qga4JQ8yTElfMyrvWaAzHEIvF2/qXrTxcQQdCSKWZhNfkdsislkgOAG4p
         AVS6YMezxZgzFmpy6b0B9renmH/tIa8DvKlowiwwvKpfc1lRjNz/6xsuoNoT+Mog9oYd
         SF1g==
X-Gm-Message-State: AOJu0YwJeBDpt0DrEU/p6VSvywpL2zygO3j+MDDx/uMiq21meSiHTg4p
	g8DHFTaXY//NVm3nCztXhHmv0PJ7LWLZ+kOAdOh7MLqDn31z9YW+ek7ZNVomaIQNCTh96X3fIAI
	dnxcW0h7um23ha43FzaVPAWQdB2o09PlvDh9J
X-Google-Smtp-Source: AGHT+IEEIleWfDy7tOBCBHJ6QQf0C/mkq/n1xU7UQjx8OrDXD6d6Ixz9u5IgmrOk+m5J11g1t+8RCCXc/OEzVXZm9I4=
X-Received: by 2002:a05:690c:4d84:b0:652:e90f:cd15 with SMTP id
 00721157ae682-652e90fcd25mr70109747b3.25.1720240330577; Fri, 05 Jul 2024
 21:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005850.466144-2-paul@paul-moore.com> <835A3242-CE91-4F73-99D8-66980DC14234@chromium.org>
In-Reply-To: <835A3242-CE91-4F73-99D8-66980DC14234@chromium.org>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 6 Jul 2024 00:31:59 -0400
Message-ID: <CAHC9VhT_MA2wjsMwrHjKBmJL_Rv-M4M2r6H4UWGnY3dRH+fNnQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: KP Singh <kpsingh@chromium.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>, 
	Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 4:28=E2=80=AFPM KP Singh <kpsingh@chromium.org> wrot=
e:
> > On 3 May 2024, at 02:58, Paul Moore <paul@paul-moore.com> wrote:

...

> > Before we discuss the solution, there are a few observations and
> > considerations that we need to take into account:
> > * BPF LSM registers an implementation for every LSM hook, and that
> >  implementation simply returns the hook's default return value, a
> >  0 in this case.  We want to ensure that the default BPF LSM behavior
> >  results in the capability checks being called.

...

> If you want to go ahead with this change for other reasons, please feel f=
ree to. But, I don't want the BPF LSM default callbacks being cited as a re=
ason here.

As mentioned previously in this thread, over a month ago, the patch is
in the lsm/dev branch and is therefore scheduled to go up to Linus
during the next merge window.  It may be worth noting that the current
BPF LSM behavior is cited not as a "reason" but merely as part of the
"observations and considerations" along with the SELinux and Smack
behaviors.  If you look at the full description as well as the patch
itself, you'll notice that the core issue really is more about legacy
SELinux and Smack behaviors, not that of the BPF LSM.  The
considerations section that you highlighted is simply there to provide
some background on how things work to help the reader better
understand the approach taken in the patch.

--=20
paul-moore.com
