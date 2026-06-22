Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4434C9AD
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159762; cv=pass; b=IXtmjocqW9HXIE7wtiMg1T+KKJIq5BBxWtCJQleQ67qzycjgYN/T3zF+hRBk62nDaQGQqIJofbynxUyrPoNWtRMhOmVA65oZlhuvWgE5xmRrF4e5xzy31tDG5GNgq2FSTNRG9dhj7I+z8TjX12qsBdTgJVvhHVdBf0RIX8+For8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159762; c=relaxed/simple;
	bh=umn347wqZHV6MjZrh+bsh3zJzDcJlUZDmRF3PSCdqg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVMhytJzoA09x/QLoCgNwF5xT7iyWJvv/Yg6j5G0dlLnVp1AovkIVUyzWhyIVoYjRBKc8hs15HrcFBlKzGNM/+wXkcwDnemh3mI3WgrKqmoIKDQx3FV95Hu+mz/M+b0FgQtMz1hU975BSLTVaAE2PlTp9jyUqVNkni9mw6a3fJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W++MRaqN; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W++MRaqN"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-845438a46d4so2566453b3a.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 13:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782159760; cv=none;
        d=google.com; s=arc-20240605;
        b=RNNnP3zwypjlwR9dWbd7EFtY8ATNNTtir1CqVFFCdQ3J19NI1BoqeKD4iaQvI1NHMF
         E133oQ4iFh28Wwp6/VS+sr2WfmORDLOfHvYrkxDNgeVqAtiVf8Q4mYxSrKRvMaNwQQ12
         lBaCIfwb+KNeiVnlXwx6F3IxHojiH+YYwECiz3uHb1Nfu3JnmGlA3PcqAt6BeZv/H6yZ
         XMCHzIefvG50eBKdkdCzImNbtzbQC8oISwMrGX0IDll3/xE8U7tewY9eqanFHj2M/QuR
         Xe3h6OxW3O6oyiPzH+9dD9AArNgZmLc1r/uCY5cXVHrDNDo6JOsqx2jr+iGL7oTlVnjG
         rUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cb7K5ZVP+P4GRxu7SWg722NF+1tEN3nqSjdZiIb79qI=;
        fh=xUIEdyyMTahocdAwxVJKugJikzXabTv/rbYYi4zNoGo=;
        b=cF+rlnEKP0X8+FGzRDcP6yBd6LYWdrRLAgjUaTJQvfhpmMbEx3p2iXH1iwaihORnlS
         e6TMTWUcN6fSLf+RKTYCecu+35HW3xGEwb5DfcQbGRkeroCjgjvnP4MbRkzJo2WT7+0I
         yXwY8EBB8kiw7ypN5rzHPVuQZ2WUdX/shwu721lzNtV+NkQJYZlTyqtN9cZ3Wm0MwnrP
         1a6Nyvv+F0Xx0azTPrAwmB6dUOXqkD6SRafcdNbkLaIbSGLpxC0+2GEXr8q/8UO3kMco
         V/1Fs9jQ77znItk/jqVKMyyQPYMsKhBZBwz60MkiconGYirXfQqZ8nPXiXq06k+pt/dZ
         Sm2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159760; x=1782764560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb7K5ZVP+P4GRxu7SWg722NF+1tEN3nqSjdZiIb79qI=;
        b=W++MRaqNm4KIU5VNfFjnvaw7aFvYi/hrpsmqJpxlTHyCj7L0FEk5G1N6uGrQ980xL4
         qEO4gZHme/j2Oc7V7dJrWcbjTbDs3pST45x51JDCK6pmJYWO6PrzCIfZt4dda8EgyD8q
         v4UDYu9BZKG341e3626LOhyUBH4ZAgg9QAl0v5p62aRr4aQYARmIrcg0PcpABczYD//a
         hDurSj9P+jatFjRZ8YXm9FU6QUuGn8lM/7L4vGWGgAYoKlCT5SST6tK0ljOkSqd7MgwT
         PdbWgfs1xQyW5FEIDVh0gefEaL8mA7LlUvODQUdJ4DUFb7K+luUb/85V3ZpGwKvG8dFi
         qbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159760; x=1782764560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cb7K5ZVP+P4GRxu7SWg722NF+1tEN3nqSjdZiIb79qI=;
        b=VprXQUq3e6Tj9+dixOG863OabVvJDQVv67SPNQ3dzPJ1MMvwdqq9Dfl1gYV+lo6CN7
         +dX2UIWMseZM21y3tOWKvvGpNoiRxScWgCUp1KorDlXDr7Tpd+le7D6YzXkDMCQx/9uG
         Ck0B1YDHWkUPjTZQ74gT0YGF5Sw7JLjuBFewioI8k3+0u0d/xUYo1iwe7b4Ih8AZMnCq
         atKX8KTTj8uggeB/xGOeOlP/ihg3R+DbOzGqToQ6bGyca33XzYbU24OZdT/y1JPhHSKP
         vkJT+lhQpHXS4rpZAVVinK4BK5X7W79W8duY9Ipl7bbox77d/k7ujJUwdzEqstY9P+EQ
         arFA==
X-Forwarded-Encrypted: i=1; AFNElJ/gJu/r4hAZLRhDwSmNmpvxf/cMaUbNJdqxd+mYqe8RGaa/8iZVGIJkp3r/SEfxL8QGrBjhO31G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IfWfob5egurdW8J/HBQpLi/6SIrqeWohnchXxtrquRDK9ot4
	Api/bABNpNdtG2Yg4/QkFgJbV82Q0EwxRTXusYFyoW9pxY1atCJAyMSa02SFRavVgBadovBFYjg
	zYkP7f3EWDuy6/UZRYTKdv617P8GFt+g1Nw==
X-Gm-Gg: AfdE7cls2UjHp5ZdYkk1FuGmHZNel4mDpVk9k9+jta1M13a1UGf88TTyl3eEPdKhlvx
	UJN3KXWBJx4Osq1bWFLOTq5fekqNjtwpXVAFpSVLVg/dzptl9xgTeULmoy3P5xUhUuX45RU+JI3
	gMO5VFpQX3nTM5mhQ2cqVXVkDJC/6FC79UC4jqZ60kID8+46DkZ7BGWi+NzW/+Ceb3fcvuIOngn
	Fpr9gZ4OdbxxjULMAkCFTx8UPdqgDnMubnz7jQ5IIKQeKALVtQvuf4mtZNbPXKTiJfR5h8y5PQU
	MpC3Ar8=
X-Received: by 2002:a05:6a00:2d98:b0:843:497e:b392 with SMTP id
 d2e1a72fcca58-8455077cd02mr16271235b3a.9.1782159760192; Mon, 22 Jun 2026
 13:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616161418.62569-1-kalevi@kolttonen.fi> <CAP+JOzShTOCMYodDcyC73Rx0EUkGWk5Rd=D1SOA45gSQ=vfN7w@mail.gmail.com>
In-Reply-To: <CAP+JOzShTOCMYodDcyC73Rx0EUkGWk5Rd=D1SOA45gSQ=vfN7w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 16:22:28 -0400
X-Gm-Features: AVVi8Cf-2xyRT_Cc503JiFoeEvXkm7Nl_XC07JA7Q-wBFJ25pwsd46RxphoDuxU
Message-ID: <CAEjxPJ4-N5a9Z9HBbQ_5KK47j1DK_ZTxYKpMJDgixxNEMign6w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Add missing comment to context.h
To: James Carter <jwcart2@gmail.com>
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 3:28=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Jun 16, 2026 at 12:27=E2=80=AFPM Kalevi Kolttonen <kalevi@koltton=
en.fi> wrote:
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  libsepol/src/context.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libsepol/src/context.h b/libsepol/src/context.h
> > index 525c43df..7c99c9b6 100644
> > --- a/libsepol/src/context.h
> > +++ b/libsepol/src/context.h
> > @@ -13,6 +13,7 @@ extern int context_from_record(sepol_handle_t *handle=
,
> >                                context_struct_t **cptr,
> >                                const sepol_context_t *data);
> >
> > +/* Create a high level representation from a context structure */
> >  extern int context_to_record(sepol_handle_t *handle, const policydb_t =
*policydb,
> >                              const context_struct_t *context,
> >                              sepol_context_t **record);
> > --
> > 2.54.0
> >
> >
>
