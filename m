Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8E40683F
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908584; cv=pass; b=dEj3QruRJCWR6ss7l1Iq6IHViQOKd9BSlUviY1XE6unvvs+PRaQ9l/bp7VJgI3RDnesdGAZxg9soD2kVJ6RERceICbSwgayGRL/Ajw2Gy2AA3BnhLxaGWSSM3j31JrAbB/EgboKDwOe0Hb0zT/egG0hYrrsAJl7vNDSn2sUh0bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908584; c=relaxed/simple;
	bh=LHhfGLH6Iv2IxP8Jqz4NTm8fcT9rHVxek3YqgnHDeHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+GpMSbjPUHOEyJfzHGuQXQBg4FQ/qsl/JVLiJDb4K59OkjNAhv7h6OKHp/47gVjOeGlSmSUAmgXrddCoMaaFGzwBE6qod6BDQ9mcgWbk7l8VdPgF5ssd1qsbjt6Q7ZOPnBwMnGwnTIeXi7iujB7+Jq5AbVJaiUwasdFiLAFydI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bikW6Ufc; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bikW6Ufc"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9ecd7216cso252392a34.3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 08:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784908582; cv=none;
        d=google.com; s=arc-20260327;
        b=c0eXqTl8K5pU9uRk12AW9LSx9+vPT9sB5393GlYUU8ewpbvD5eB3JzzReZ341HwByV
         XgJ4noiPTBvEfFjdpDWqrF3p4nTbioSXpmcSj1gqpkJDTI+7YH3px+N4Lk/SEAw0sEe+
         vETOmD1LwNLkOOxFZozwuX1m9mOx0hK7izT8zqvrGIFMsNbWrxacQyI7eRQ9PuEcS+ul
         sVvBbY18hTpoVUu+qNTnWKFdHDJ9qzUcH/TWC4CWUnTyF6wIjIZPSrs/9EeT4+JfdsYJ
         zEvYMqjbzAbPO9kYUowps2xjGxOZzaiFLqOBSegZ7R347yMpkCpoQMNKSjZQtEXY5ibO
         UsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4QJXtymRrPbskIjCJAsm436RbhtTeB/HbmQAABsH8Z4=;
        fh=zSau4nOy5XQ6OJNiIGCXmcqwqVhuG0A0YtAnSegVMQY=;
        b=A8LW+EuJkXunKc9kBLOdfOFjQsh9eUR8wnp8p5E/W4fMY1ttEIV8setOMJhqO1UWiJ
         N1bwwA3FMSGhqQx/3nwJrcca+o8s3eLTLXJ5ew+ZWxNHgMFEVt6pudWNZc+HguRZPx6i
         LhhnHNjHBSA9NcG8gbs2Dbz2zWDpnep66TH96gpgsf87iJyl67+icyWBJiPMIwR8ZeoU
         VvPHNDat7+0H7F9HOJqRTSa2hoOngQVyOh+t3ByjEbBWNJD9X6xqIYnXJrsTeW11sC1I
         GQC2H1gOxFOLnHhulChun4QN/UuH9P4tgfr3bGsflMrIoeCMspW3PE40dkelodPqDJ0K
         pTXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784908582; x=1785513382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4QJXtymRrPbskIjCJAsm436RbhtTeB/HbmQAABsH8Z4=;
        b=bikW6UfcqijNr+q6poUXwIyTBPcWC7Uk0LleIT9ugSv7wsyOEL5RX97d4DOC5TVnTq
         xBcLM6SGib8WD5DNm5KVkfsg4mZY3nP2n8l04OGRY8ct2PHkqJu/qp0KbvtahyU4FGX3
         RWA7qmfsdMPnZtvu5kJsiogLA1o9kTW/omwfrvHJLYH6xnY5mMpFf94PmofBmXLHdKwp
         3HeaG4D7zQMsqdH+YO6ApqWFfkQDWdG3GPugkfd0PIqwUQoTgXWvuEkzg4+vdAm2FTGO
         ZB2Ozdi7nDktgZySh+OVcXSVSyB+oubjpa0CVXmE+fJsi8x3UrC2JcFGmsNgdHyhDflk
         RlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784908582; x=1785513382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4QJXtymRrPbskIjCJAsm436RbhtTeB/HbmQAABsH8Z4=;
        b=iIznWPcLmr+Bfc7Lh5T+nuRlQ0t6dZ6vaimD9Mz+rQVvqmmkcoVpF6nATPCQ1b9uCh
         FSgfleeH3l5bDJcwudYmtwCHVhFW3SLp8FN+KZJ2zkRhmajbLPVP9TrOkLEqRfYR0TLR
         76nt2i7m/zOdj7PCT/ym7B6n53Rk0q2hVecATPIQUYy/gqUG3xL9I9PONN3OGiEl7gFr
         1i3iDGJSeraJLLPS99m4mvbp3USfcmNazMUS4MbgWGm+qGTpUUU8AxW9xC3bP9xT0c9G
         X6Gh74t5l1orgVMrEYE3V/HM9RzYbnZ9/XtoCHNFpmJLw0baNPVTZYQrtQ1hqTEL55Ty
         fb1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrtHSl0MMwSblUYi5C6Fcx9b/qI22QTeeIVnlKQxHCB42uCKbRvWB8DMLllp+zv6uSmwzyRW64j@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkrgodtp63q9eXEy1tD1OAumyfFS3FsgGsi+TiCRLG9kdNhcs
	lWrakJDgVQ/C6BLGb6i7foZjAtWncoSMx4AwVDDRjggcLZ0O10f7agd5kzRw+9oZCyy+mAcK3Y4
	l4+VdJPRwltRPsFIEn1eSExDwWOcrfJcChfkO
X-Gm-Gg: AR+sD139Nr6hrjiiLBnYPjOzBB2h9V4J1UT2s47ynLJ9/w3Avov4KkvMovhXq9nJcYE
	v8avkN22Am/MK4F26Nt+Hr/VNKHBYfqMzQuzkAcbmDfVdpxW2CtRJtIrRqIhC4IgZAuv+lpCwqm
	57tsiqOSwD7rp7v7RQ4hmNsgj6lbIFJwDoblY9ToBpkcrKdJjZkMyFkXA2W3rHAZUpjWZfgdIeW
	+0jTK+QNAb4EPJdTgzBGobbf91OOLrNWEXyCLahiE7LJZUmZD0MRGONHRA3gg==
X-Received: by 2002:a05:6820:2904:b0:6aa:8fb6:b951 with SMTP id
 006d021491bc7-6aad3fe940dmr4775161eaf.19.1784908582201; Fri, 24 Jul 2026
 08:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me> <CAEjxPJ4_chAbtJa4obgN+QSjMnCwk9XQ-4bnyOFxgFoFxTsV9A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4_chAbtJa4obgN+QSjMnCwk9XQ-4bnyOFxgFoFxTsV9A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 11:56:11 -0400
X-Gm-Features: AUfX_mx_-mGYLnOr7d6rKxhbPBiioAJ_XuztJJ3AqDPObjSwX0Nh0bu445RiyQA
Message-ID: <CAEjxPJ6pTrKAdhGFVO72x5117RkXCn9xKeqW9NTHfgi-6eaywA@mail.gmail.com>
Subject: Re: [PATCH] selinux: reject a permission value exceeding the class
 permission count
To: hexlabsecurity@proton.me
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 11:48=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 24, 2026 at 10:47=E2=80=AFAM Bryam Vargas via B4 Relay
> <devnull+hexlabsecurity.proton.me@kernel.org> wrote:
> >
> > From: Bryam Vargas <hexlabsecurity@proton.me>
> >
> > perm_read() bounds a permission value by SEL_VEC_MAX but never by the
> > owning class or common's nprim, which is taken verbatim from the policy
> > image.  security_get_permissions() then writes perms[value - 1] into an
> > nprim-sized kcalloc() array, so a class declaring fewer permissions tha=
n
> > its largest permission value drives an out-of-bounds heap write.  The
> > top-level symbol tables are validated this way; the nested per-class
> > permission table is not.
> >
> > Reject a permission whose value exceeds nprim, which is already set whe=
n
> > perm_read() runs.  Well-formed policies are unaffected.
> >
> > Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes =
and permissions from the running policy")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> but also see:
> https://lore.kernel.org/selinux/CAEjxPJ7YRgtOXrbPYar0qXAq=3DwNbOTTMS-EsU=
=3D9HKR1NQ3qA1g@mail.gmail.com/T/#me98ec932b314ae94242ed3af7ab74445d273cc7d

Also wondering to what extent this may overlap with this series that
was never fully merged:
https://lore.kernel.org/selinux/20250511173055.406906-15-cgoettsche@seltend=
oof.de/
