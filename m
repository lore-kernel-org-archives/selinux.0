Received: from mail-yx2-f23.google.com (mail-yx2-f23.google.com [74.125.224.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE611EBFE0
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790339286; cv=pass; b=PQou/XxBmqZbKhzxj8z9U+kRL2tLCUU2bd+CY+eNgbhQqxRr4Le0JEQc7OHZLWEGetsDc7vHlDKYlrSXzIJ7Nw59Sz1U46y/nORhI+AkQyzkUIyf+O8NcN0V32INdRLy+uOTkShsGbfGZ9Jp1hRWyfyM/oo0yHtzneN+UjTUAi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790339286; c=relaxed/simple;
	bh=FPaAnStCt8qfESmAk8uQRHTgG92NhOhh5ij7VYEW7DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rxn2jxKjt0SYzcWqgayI7S2jzYdBZuntQRaZ8f3cv6hP8nSYK2J353m9YTLl06LKb/Ktu6dGCH459U95rcCQ0CLzuhV+5QmP21jiqp4zNtV0au7cvtjQI02AcEI26BT+uBDHvSTUy/OZbHpBDmGt5u6vN8j7uTN0m7lA5kbW2jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a967t5xS; arc=pass smtp.client-ip=74.125.224.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a967t5xS"
Received: by mail-yx2-f23.google.com with SMTP id 00721157ae682-8a7411012b1so7222987b3.2
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 05:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790339283; cv=none;
        d=google.com; s=arc-20260327;
        b=OIGTgwx8dR/f4jFQebyqheJI9mzY4hlcOHHvSprKtV/iLtPPZJVWT5n7NwcftjJHsH
         J3QRuy5178Vtcs/7q039eLK8H86uZ3K+g3iVXnzKlulyl2WeNEN9Iihu6aF9kH9XjW8K
         4lwNBernA+lR+zo2XZq8vdZSnR/joA9pU2RqzRUQv/AoM+o+EHzlf21h4owjrl8PA4BH
         6zFslvkJEjHiv9Xiovz+u7c+1ASLtFTtY1Tm+tCTBgcP2tfuqYH8GBMfkfNsZmbtDhrT
         cDjU82eeZN8u+/zxk/xMPpabDc1uicELcPVgjI9mk7q9bGZGmqgg2donLfEMuU+tRRrc
         8e0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xD7WWvBGdgvT86M4gExhiZWCt3TBZaa160Ifu8x7Yy8=;
        fh=2VXmMxiH43HPbs6cy5Hd16eSnWpMt7ppMKAHWRGc9CY=;
        b=D+teX6dZ4ljk1MvEWdZ+uLloQkbF3RRvhCcjZrFUI5pOOSZMiYqdjwHH77r8pTb/Hk
         EIy99QykC1onpJ9eyorkugQp5EHeQ99t/jCeSLKXkD3FuQIksq/w0FNDA3Nqb3WFydyT
         p+pKabGqDOfN16XG11jgxmuFn226XUHresIpupCxvi8r/5k17mf2mtTPzzqm5fbs76oh
         8JpmghXFxvSYIIv6ZYCwrEV2ubLHHJOHuFMQmPwOi5BAb8aXuyFg1qNo9YJOvMR8CdIL
         XkT/hrlRCRAI0W7T2rfyAGwAtngOO/q/qwKtpfYmBTQbNTjPM7b5DzYp1ltPKvFV+hwy
         rnSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790339283; x=1790944083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xD7WWvBGdgvT86M4gExhiZWCt3TBZaa160Ifu8x7Yy8=;
        b=a967t5xSdY9AdnVt/J+iuGmLoj2V9QVt9l7BQvC0bvXbHd95WqloY/8s89WzQmKPzg
         IC2ZW+ItROhh/MBmtY0ipVLSuO7Acpo/ZI9/LB3/qAWif/8EuFr+NR2QpusNkUjTAypX
         V8mUOiT8Sd1JhsRzn6lAQVuT2aYg2jztXT8bvHImAbwsDXzD0JeiWzKUHfsXlVJMzsOJ
         TBTTfjtYP8JCoU+luLB890lY28yftuEAlXuPj687fGMduBuOIKOqYsG9N+Xyd+mAZApT
         W70rxBmme84oMbhexK3CFYPe0haFkqIp9i0IPjNZkt9iqET7gX5jN5W4U5bX+W5d0sMP
         HQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790339283; x=1790944083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xD7WWvBGdgvT86M4gExhiZWCt3TBZaa160Ifu8x7Yy8=;
        b=0zR1y+fyO2ZzGUpwd2ddWohJ2FfHk8BIJZ/gbPUryPUVxJfWTn6gnCR4MOPTcJH8H7
         v2FhBlU9k0CHGpjFwGENG0UHGEbiTxsVrTMMKzhW5zbr+9ob70WEAsVZVPYk6KYm5uMb
         4WwLaFUa99H2EV22huLLqevw5uCrlWoyNcUbw4WQQ1twBg1uJcB8uXTpe55uA48c3T/g
         0yYHbf6w9xj3XwyCs57HNdgD7ACuOpNDTvmcQu3fiGacR+FsOhcc3XBkTe7Gb+9I5Md5
         BPAqOTWpZ/qRehd0cTN7Uun9NObs6IQ/OEHskd6E+6q4WleRNbdTMeQSlUdy6gTe3O6Y
         bAEQ==
X-Gm-Message-State: AFuF++kDIQ4tklROX5rondRcjf9nSSkDb2VGby2JG5BwJAkPJTg9E4yC
	Gu1SCwSlu8eX4a/Vr6blQhcyWLJJgXbt2dmKYLnywCNA8jFwQW0A2RgeCQ+985BRPIkbsop13lv
	3Ut7jc3RKT3InJ3knaRIZQEVGTuEVrTU=
X-Gm-Gg: AYBFou17P3nVt430FUqGx2uY2mGiplg3T48Bl2kcfKgv/Z/2rPvFif4fyOiol2JwhJB
	m6Gp+CEMhnwRksq/LL8OlnZW5eJ8dxesoiZbrAJdYkDSVB0Su8cyXjIdK+jg2JbeHLTi0kBbErv
	YK8rZH0rbuYTF3UukS3HtcTY9kypb6+VGtttn1IZsOS4ekiWG8vjOmKUkqV1IH51LoX7KibSSth
	sU0Mg9/WNV2IesJqxcfjPZSX1EVtMp1DEDCoCANMT7WCrV/vA3jC6RtXMscOhYNA0hcAOVa+80P
	N+w5M2JryhvlQjYG0r31u9dGJOSOFOWXoXgcNfqCA7AkY1uLsCy8nVa1uWyUyqIM9g==
X-Received: by 2002:a05:690c:c4e3:b0:871:8a81:a2c9 with SMTP id
 00721157ae682-8a86cac1faamr5065637b3.22.1790339282979; Fri, 25 Sep 2026
 05:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923165248.56940-1-stephen.smalley.work@gmail.com> <CAHC9VhTYA54ThOArtOihdaYLgH30RXOnq=-RT1w49kiY7ug0TQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTYA54ThOArtOihdaYLgH30RXOnq=-RT1w49kiY7ug0TQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 08:27:51 -0400
X-Gm-Features: AclHuK8IARO4v7cgX-2haTqcDKjiEzlKW7zU1uiRBgqPwfjW9icOm4Ep6qaXHTs
Message-ID: <CAEjxPJ4Wr7p2KPeSJ2QAn5ub7fT28d2oJUNKZ4ExqtvMdmZ-Zg@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: update to reflect our current disclosure practice
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com, jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 3:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Sep 23, 2026 at 2:04=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The upstream SELinux project has never posted security advisories to
> > the oss-security or distros mailing lists. Historically this was
> > handled by the distribution security teams. With the recent enabling
> > of GitHub security advisories for the selinux userspace project, we
> > have started publishing security advisories via GitHub and on the
> > selinux mailing list but are still not posting to oss-security or
> > distros. Update the SECURITY.md file to reflect this. Others remain
> > free to forward advisories we release to those mailing lists if
> > desired.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  SECURITY.md | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
>
> Looks reasonable to me.
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Thanks, merged.
