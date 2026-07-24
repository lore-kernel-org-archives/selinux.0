Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039701FBE90
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 03:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864983; cv=pass; b=d4FQJlTuaN1YOGmj3c3GH5jfE3vJmf14P70RAVl6KmX1QDRg14Ol5ZyioatwtKYTfIP+phDnEZFWfx9orTQ3ZanKnLIO29rwzcqjI7unndKEn5DKWpZU+BqCYGb3jMEkIqVkm2bEjZEpkcH1QyOziVJwtybm/Dbd98+r92nsrI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864983; c=relaxed/simple;
	bh=J+05Sw5eH8ufX6Obh4rHx0rgu2YkjPuhN8o4gvaoQGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnTUo+lry6XNSKR5YkKyP1HDa9/c0CBt2HaY2D50roiJOri8Z76nJHwo0YURHYstAqo+jieWdpVDeV2WY6ZxfJ6CKgbgyDnE1P4q0vYhWmXYgcxcChn3UICvaDacc89l82OawgMxNPMZv7AF4A+ca6h2U8jufK1yHGfyqILdhHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MBLg64nK; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBLg64nK"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c15a5b265so55631cf.0
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 20:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784864981; cv=none;
        d=google.com; s=arc-20260327;
        b=akWFXfKwr+2QCdgIncqyz8SejypiSA+LW3VHALm1/SKzYUqGcHaR+uYSOfZxa2zBTd
         K50kj3ior1N6PlxklnOMZuM2acIoXIpEiRMqk/k64dOwOBKvvYP8XakaLU6unHoIOnbi
         u4BsWjy/Toi94bRVn/e0zYxCU4mzexOMqKJzP4s4pft4oPgyRv7K824BQvT/1oH3YZlS
         ZsbAgbLWklsGD3wg8/UMamfUlGbHxi+ff/2uEJ+NkBMdqyYeXLFJjtwjnrBhwP2qZaqG
         16kCLPhFGBpugDMGXL3M8zUkXnhH5Ursn9cRWy9fpncoqqIaTgPZQkpRDlg6UUEIjFrs
         ONNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F+wmMw+c2SSY8iYW1TVaMIMGYvSnP5gyBFi3XeEptYw=;
        fh=dqHFtmpwEH2A31NRIg5bR+efaFlyzlh3Mf8OvtbR8mY=;
        b=dln6yrnmWBoses/8/n7DG1vwIePTHx1jBPZ0eRSqgK++n42sXhsH+JAnUAibcheHpH
         P2PrMrORDLIqYkGRIVNRDhxh5UA+Vq35TfPxHWlFGFjy61KNImQl5d1l7pITnGpORY8s
         QLx5KkbPKAJ5KgywmM/j9x7uD1ZLOOy2Sc2TSAKBQ87topGSwwhMb0xQdmO5kqiSLXjo
         5Y0aL2Yg0QGr0Ep/E9+TO43fRctAZJ8gXysC5sigmX12ccBO1uuxZeRkuImugpD/OwPo
         gCaEgJHxi70CJ2xELWVnu7XAvu+TBoliEuZQlpAuImOLPaeG/fqgvwqZgqOyuVQ8I/Uj
         a6YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784864981; x=1785469781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F+wmMw+c2SSY8iYW1TVaMIMGYvSnP5gyBFi3XeEptYw=;
        b=MBLg64nKVQ8q+ppycq/lMpkJsZxSltdpTk8TFhSEBxbH6OVqYI10Li3H+7Tqr3v0DV
         Aie/dPlIj5smBd15e704QjPn7aPABNKA7X8OSp3gukcNQVmGZeF5hYeQQnkDp4XMODSO
         ZM5EcAiBnTCV9sf/mgyvGJLpPOCCSgxrfir51DGNmDAG0Wd84ZlfdCitQWhhlD22ruxD
         OleoJ0qNhhPzYERsNpCJirogxc8N7oI63TF/FUD12dzHFwQi8yJtBsz9VTBvictm3urD
         QKSjsQQYZlIzuRIO9JyR8t6/7RddBkygbjJtAuGKX6ioRjeu07Kb48sYV7jKz4DusE1d
         4M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784864981; x=1785469781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+wmMw+c2SSY8iYW1TVaMIMGYvSnP5gyBFi3XeEptYw=;
        b=V72URN0SLCxiMUzgNKcuUaVjbBYSbpyO/z4QsKhIpAqQJ1J6M8ACKlWr3iH+f4iCja
         mne7Ts+SFUnoPfNj6dlYpAF2rwjttw9VQGl0/n9QLEZ7YOXpPCCD+fZl5JH/B5TKqY72
         00Z8Uy5RzsKW2RAih75VFMO6hW8Db97iyqWygcnm7iZcGaSSXdxLtb/K9cTo+SjLe+WJ
         33TvVMjOqJfd+RBy6JU0IPSi6FJaQJ43/bYDIHv0yCIE6yCswX50dbbypUbMwor1lulq
         DyMpZYd14Wj2OQNHhlLUXERo0E54bS8JGXdv44WmxtpYraizgVLqsFqe8S8A0Pg4Piqo
         ihJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrF+NqHoybbQtqiZpSZd1oWyN1CRyxUuUFTCV4RD5sjE+Daw02Zh+Z06DL7ZevKYFH2A7AGvNnW@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFxrP7jNC1fYh3pdwW4jEsIK94FXej+1ymVNX86kCexWRLlsb
	kMzZhcRIlawqmlOV62WKpMoBb65HOp+awzW0mLURhokL4e19XkhKptrKtjy72J2zp1dA6HxL6rl
	UsSy0e+7x8IyIVvvT5Zhd+ffsa/p179pBqMGE/5oH
X-Gm-Gg: AR+sD10lZVcvBVt7UQMJ6vRqAu9CNgIJw8+LVpJaJPEcaWOP+JOrNInYe8Y7FHY4BpN
	sD5oLB1bArbIXZWYYbp9by/NtoeotAzkdmmQ1iG3nR7LdTDRTR8wT7GGtEvznwBpJAoHoMRnMI8
	xh44ri8o83J7Ro8nJNGjfogt7rKYN/0ZQsIkeHT5gXMQDCJjw1/6UWwruz0RRpk7ZUiH8yezCw/
	f9t0HOttqvpAyemHNF4T7LfvmDJskmAm25c9yT1Wj2s99515YIHyhi8CGC+RvyYeI9KUUfL89zu
	59mh1cqBqE1GIfEQszsxUtchQq2cKDm73o0+NBB7d2nB+A==
X-Received: by 2002:a05:622a:5c0b:b0:51a:713c:7444 with SMTP id
 d75a77b69052e-528525824e6mr562541cf.18.1784864980282; Thu, 23 Jul 2026
 20:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723062355.3096648-1-jason@perfinion.com> <CAEjxPJ4cexAeJbQdDWzD=NiyukP_THb9PHhTYi=n8ww+3bwrCw@mail.gmail.com>
 <CAHC9VhTpaqdbd4NOZO=2G-OneFTnoi4BtA-JeB_o=hQO6kCUWw@mail.gmail.com>
 <CA+zpnLdz-s+yQg4EnpFXZA5XGxN4mF66cuXLFXu7AB8Bie2tHg@mail.gmail.com> <CAHC9VhRu=UjYoDxwiAfN29t5iUqFtu1oOQoSEMJaN=4K-5M=1w@mail.gmail.com>
In-Reply-To: <CAHC9VhRu=UjYoDxwiAfN29t5iUqFtu1oOQoSEMJaN=4K-5M=1w@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Fri, 24 Jul 2026 13:49:23 +1000
X-Gm-Features: AUfX_mz3wHviV8FfUbAl4UvEmRqo3i0U1XkhlLkCdDiBf4s2X2TUzvoAfdljSko
Message-ID: <CA+zpnLcN=1WcTYRfLaC1NS6j9AYiVPOUj+s431YsNwws=xhgsA@mail.gmail.com>
Subject: Re: [PATCH 1/3] SECURITY.md: Update security contacts
To: Paul Moore <paul@paul-moore.com>
Cc: Jason Zaman <jason@perfinion.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 12:27=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Jul 23, 2026 at 8:24=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> > On Fri, Jul 24, 2026 at 3:41=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Thu, Jul 23, 2026 at 9:42=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Thu, Jul 23, 2026 at 2:24=E2=80=AFAM Jason Zaman <jason@perfinio=
n.com> wrote:
> > > > >
> > > > > Part of the annual cleanup of security contacts, drop people that=
 are
> > > > > not as active committers currently. Thanks for all the work over =
the
> > > > > years!
> > > > >
> > > > > Signed-off-by: Jason Zaman <jason@perfinion.com>
> > > >
> > > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > It would be great if Android could still be included here. I'd like to
> > propose myself for inclusion, if that's possible. Thanks.
>
> I believe the goal was to limit the number of people who receive
> vulnerability reports to active maintainers.  Unfortunately, none of
> the Google/Android folks currently listed are active contributors
> which is why I believe the patch removes them (and others) from the
> contact list.  Like almost all Open Source projects, the best way to
> stay informed of these things is to establish yourself as an active
> contributor over a period of time.  I can't speak to how the userspace
> maintainers view your activity thus far, however, from my perspective
> you have made some nice contributions but only over a limited period
> of time.  I would like to see you demonstrate a continued involvement
> over a longer period (historically this has been an issue for Google
> contributors).

No worries, that makes sense. Thanks for the honest feedback Paul.
