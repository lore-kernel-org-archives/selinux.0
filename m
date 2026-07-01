Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5B26CE32
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950023; cv=pass; b=MB9QqpPJVNPYnsvsa1CgFevlAfwFk+D0KeQvTb535nTPnH4nl0zVUxv+cpYPpPihmTy7AddQ4Q7c2Ib26Pk5y4t7Qqr5GqfmkBLiTY1myP7I6Ub2YnGTPYzKFzk0mHhU5HjdDCIUuZM1/ghqwG1ZMf2+z/FvwBN7jslwZ0LCLpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950023; c=relaxed/simple;
	bh=S0Rn2cAIYAgijt6U/rRiOu7ts9CQRA/H/8wZTnaudL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQCY+QqHfyOOvYrgv+Q0ZOKYSzZyrMxHNnsq5yrM4vL9wgjZjl1Q+yQF1zHGCwQWkG52WNMld26GoQI+3ZXsTOm5GeCK3lpEEjUEPeq9Z2UuiYTTXGKsapA+MMdDVUyrUQpCFTiHLTegEGN4ErP9x/8FdI8vOlSfjA5aOoLthJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TaQcWuFl; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TaQcWuFl"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so50594a12.3
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 16:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782950022; cv=none;
        d=google.com; s=arc-20260327;
        b=IsKdqb0XpVq8CFBOMURGxQgxMETC0GvibMuk1jvlIlLMm9gAHTFOjttPkWGLXaKEi3
         SR+kbKGpcFqNNQnPjmzY2ZCaEYji2AjicztWRzE8+pka3vVVADL73puznEIfVTYC5kqt
         PRYPdvTOJ/uLL0NOeqsVGmThtuIR6QV+KoKUNDc7+TIq4uiInY3LJH76vNnZO5hNDKVN
         w5Q5vnEWa47JLtSY/Y6MWnQ1srGii4/Kdpj3XgW32zUnkZgaWYJJvDOsBDzOhlOUA/bv
         ax3BZmHtI/nK6xIb9OyT+/YOAsUTsvQz2t9epM+/E+C1rTrBENzu5f+7oy+8/mQ638ac
         N3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nlxXdRlOGfdr+QlxeqaJwk6DjvYZRhxWYxc0EK8Kt38=;
        fh=RYH0SEZlIa8f5q8aFkk41tuknOR8J6uY531EW87mlUQ=;
        b=qdFas6jBhX98cgc7ScP8pUBofPAJDW2j1ucdq0RNe6uw4E6wfdExDkbEViehJ/UWVY
         HuJsLD7CgUETORxlCEBBLEUlbbsMXOCvEXdl5wAgTSHBe2of8xRR4Wim9PwergJDFjzj
         cZ0XrsTr50/N7nA14YnJUyNLp8hmrjoFRvsM+kTBlt5F6oQ0nmstJjN1d00MKbsUEISf
         qc401oMM45HaeRGoKlBm4YrXnPuNGQVd1yjxNCkd1pO8Q5Y8KyWi8jGJWed17y2YPfre
         1d5cAheXvf/vfFtb2obG2+QQbNViCh28KviDli4Nht6SV2p5cf7k3o27Rfxxd9dYfCqw
         Hs9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782950022; x=1783554822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlxXdRlOGfdr+QlxeqaJwk6DjvYZRhxWYxc0EK8Kt38=;
        b=TaQcWuFlpE0guf89DlnZ10FCBWaoCY9FQvw/0fgt8WDVOFSQXXnzaALCZSzz9vH+Yj
         EG6XTAey+qSWo/0QeAQh6aetTMOcOFXREQ/dn+64qMB5/2Ldc+Whw24tyiZRwWzRI1Qa
         +4KNScqkG5wA4Enb87dDBjIPZ+l1e/8E4kOJkaBIvLzbUjOUB1y8ZgQIqaHzngFPisEX
         RyLJMQNp8sCxokxjDA5jWtLcrW4opi19yxG8iiw1KOb3frqKj+AYKl2G+GZGtBry5yPQ
         FVFZcYyAFw6ewuF6t9BEC+aNqLgmyVzj7e2v1TilCjkCYL3MhK2vT2+4EyPM8LGtGAhE
         mzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950022; x=1783554822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nlxXdRlOGfdr+QlxeqaJwk6DjvYZRhxWYxc0EK8Kt38=;
        b=FL2qRILN5rrkMkT2rm/MhgmTJr1bb/FjzpXeaNZnU73k6OQNFWzc0AQ3HvO8SpbP0R
         IBQYa8B2JwlERK1TJdIBF13ay1Ggn3WvLKXSc0Ve8/CspD+efdAoNsY4lBepqEHETBDm
         CZCIPpzrm0NCtE/RusGrNcrTcuM+OtIQS8G4UI6gBF56+6eiNN/a6RA2cpfbY8SCKdeM
         zMFV62Zj9deg5MrLt5yehCHSEZM4zPbOfVfONG0mWKlN0Zu7DfX2XAned6OpsxCL4AY+
         y5/9TUZm1RO/YXAkd+T/8YnwUQWHbhl1xgeuW802rswXXTa2eKpwpN/w0ovAQpmFYCIN
         mceA==
X-Forwarded-Encrypted: i=1; AFNElJ8rj10dXlaKz11khAIiytaXc25xMGjDQlP8PRHNPL7pJruT8QPjwGyOXOcmNe2qrYA7F02oMB2+@vger.kernel.org
X-Gm-Message-State: AOJu0YzPfrOLajnGckXQ8qMmdeGlgh+HpcyMoY0t31kepoka08XAkNJR
	it3IjyU9e3SmZaX2QPd8VskbGQVtYJzSiMko4uDycuU9DBQsk5LBsWZ+vdAN+9MZTwv1+MdHbm+
	rxaTLGr34Os70jHB0o5uYxzLxhNsE/TgzIfr0WKbm
X-Gm-Gg: AfdE7cmuOLMVj9nhbhhUTg4cQXcZQyOeWdHqObgMhNAfU02ObMhVeVD8XpUsr7+ICmC
	MvefNNG2fScU2CWiS9js7rz02kErBYYio50k/Q9WQKgVxoiI+bjl/kWDdyVgUlzAUEeZW0djvrU
	yeS4E733fBnGs+o9tg9rP6kdY9nHryjJKOZBV8nu8+KYun9PTMS8gCasGKG9raNTqJUdEqmQB0Q
	5zZtGwXbwoVYbOzXELV9EMEMY0ZpAorPVDrIcg+l1+FlIE4hxEaSRSOln1hGnMTtX1ACkhd
X-Received: by 2002:a05:6a21:4cc2:b0:3a8:21e0:1ffa with SMTP id
 adf61e73a8af0-3bff40f4cd5mr3528994637.27.1782950021854; Wed, 01 Jul 2026
 16:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629063005.64700-1-laoar.shao@gmail.com> <CAAVpQUD4tpO7h92FCrp_phkjQv-QXXyrYBvhGRDDDG=doht1nQ@mail.gmail.com>
 <CALOAHbDvvk1pkZb8dqz9+FET3N813b2Hhx3M9hKF95FETuDgSQ@mail.gmail.com>
In-Reply-To: <CALOAHbDvvk1pkZb8dqz9+FET3N813b2Hhx3M9hKF95FETuDgSQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 19:53:30 -0400
X-Gm-Features: AVVi8CcRAE8JAJVGmGuC5AXtSIJqmNLiov-MgZl0t8LanS1fdQr_Ba840wbU3tg
Message-ID: <CAHC9VhRHG19f+TvDuCo5DJp=XtiOF1otDzc56khkdSWTJedrLw@mail.gmail.com>
Subject: Re: [PATCH] selinux: suppress warning flood for retired DCCP netlink messages
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	casey@schaufler-ca.com, kuba@kernel.org, selinux@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 10:24=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> On Tue, Jun 30, 2026 at 12:16=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> > On Sun, Jun 28, 2026 at 11:30=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > >
> > > When deploying linux-6.18.y stable kernel to production servers, we
> > > observed kernel dmesg being flooded with SELinux warnings when runnin=
g
> > > `ss -l`:
> >
> > Please update ss instead of reviving dead code in kernel.
>
> I will submit a patch to update ss shortly. However, I suspect other
> tools may also invoke this deprecated interface, which could flood the
> kernel log. It would be preferable to suppress these warnings in the
> kernel to maintain compatibility with existing tools.

I think there is a middle ground where we still output an error
message to the console, but we only do it once.  Yes, we are adding a
couple lines of code to check for DCCP netlink messages and print the
error, but I think that is preferable to log spam.

Yafang Shao, could you update your patch to check for DCCPDIAG_GETSOCK
in the -EINVAL error handling code in selinux_netlink_send() and use a
pr_warn_once() to output an error?

  pr_warn_once("SELinux: DCCP has been removed, pid=3D%d comm=3D%s\n", ...)=
;

--=20
paul-moore.com
