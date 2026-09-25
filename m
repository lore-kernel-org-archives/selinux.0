Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25F3BED2D
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364426; cv=pass; b=VexStgX2W91BU5fvdE174c2sp0Nuk+7CPveh4vYFFEuIl1YsCjyza8HMN9VlJamaR8BO4KrWbipCwYI27NMipm/W0escBRoIH6X6GI6fXWAUjPlMV0CzECQyiO+YzKlAdllTYpYYj56x9SN3SfU4dU5+5a7heUPjn7zkXS7P89k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364426; c=relaxed/simple;
	bh=DMtW6MfK98Lge7Dxht3QJ8CcW0I0DeIb1u7OXky37O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIyUjWR3ED7uUi45loD1uxSBjsFlqMYdWPQQF2c68ZlWlls9mBPD+cyq05aplRKm9fUoTUf8M062TB3QEJZhkpU6/NYPX2xOIyB3HVJonrARGzgydY+mKQ5lJcBv2Vrg8OrBWba7RVAybQ1V9VLVwl20mw16vowasZpn/BqGL8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY7UWzKZ; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY7UWzKZ"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a886df36faso10097327b3.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790364423; cv=none;
        d=google.com; s=arc-20260327;
        b=BfRbRriQLoJC6uV+Yxe6nnIdlcnaza3gs+gQA5pEtJVtzZf8qc95rMYomXgTaKHTKC
         f0/Lj9JR7YLZxWHWudfwpLmMnMxcuE+kJ2XTFWxA6xVmdRU6IbqQN1w7SV9m1p6mUQwt
         sJXnBFp4A52rvWvEu0YNnRzeqUoMndgyWJWQKfKGXLhPX19aCkV2AN8WspdutFtGCt7p
         EpdJk4fXojXiEaI5DxWPvYfn70lyhzHdUNyllIP3uWgEV8xjjobdC1AXiCibLvatCyyR
         OK9xYLv7Fe7sIECOUnFAo9n4LhdIVfoJkZ0vjJmDr6DjVBi1mj+BBkzw1BFmhYU4jRqB
         Xtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9mhPO7ejmQcW88Tw7zZym0lxctHaYYN1X0xiF0c5q/0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=LCSxxl1EfpJ6Y0i8WeJPHJkz/oQM9nhLF1mo3JWG0Cf/EO8YmQ8NuHLHID2VXxiVqn
         CrQcTCA91kJpbQtK7WQtYKv++zqpialoQ70LEm0OGEBcsE6CJOGSRcVxVFVhI6T18LgX
         EaCRmwutl5lW6djp7vZ8hE/gIoplHRKylVBaNGvIsUceRhIFh6BGCnN5L8o3TB1oZrke
         rYnEiqGlnEAz11c0EIaVUtFaGWcXsLfZ/EOBIkzCRx7fkrQAkT+LT5xw9+diR8XTt166
         z5nB1O+ekRxKZEiIpDavZAF4Kp3gWkq3GNNUybPCptIqtYxjCZjwbrX3KUNz5j3lsC0H
         ukvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364423; x=1790969223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9mhPO7ejmQcW88Tw7zZym0lxctHaYYN1X0xiF0c5q/0=;
        b=IY7UWzKZ1+/yBtTeGogdcStcWrSz/sbaRCCfH4/Tf6+6pJtpMyJTntWtNNnmq41qAP
         Deq4nOUze/EJ+XJHPVnl9qpIh8KV42L+l8TPKy38JiPBPQSl5161M8cAePdPNACG1zZs
         NtYjRlrs/mjm0WNnsPFmJYpZk7e+TWGo2k2cyfxE96Dpeg8RNuohKVGX/dVnntg4/DnD
         OVcrGkoIwyYimca+moToRgAGPAkD8Dny9TifEfPez0LlBTdlSWCZgwZAqoolP9+LlloF
         yd4Zq4tNLccinN5I00CjusSfrV3aV8oTOtySl5/iDvU6G5nzkmFU+0e66Y/5mVGO+7kb
         VP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364423; x=1790969223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9mhPO7ejmQcW88Tw7zZym0lxctHaYYN1X0xiF0c5q/0=;
        b=fbOjGDUB/FZRjQ5SVHEkgdYdhoVCAdj8rnoOW2sy4QCmFRu+Zvdr5FdsFpdqa/9L2/
         nI0pB1AmCZeHkvGQ6SgAlTOX1ZFXN357/N2u1PO24NMleCtEdmwAITNpsdQN78+jUh2j
         3Up3NBIJ4WfJjZHy1KaFyWnzjiJJfbFmd9FC/AuiJ5AedmNJciKP0bsOMid9+fyuP7cT
         0chANLfr+l7HbPFjCJ3iUxxUASxkSROl/5EVeJXsvfCzByrQ5SAI/mXn51FNusMuIW4X
         q/eDyKOzSbzCZSIl33n2len2sEu9wi19YSJabiLhpP0Pk5V1MfJtzf7Y3dXjDUCe4eXk
         fJvw==
X-Gm-Message-State: AFuF++kr41RhWPO9Ja9/9zqm+YTuuWnsLFOm7oMDoEGihw5Mj6gdzpy0
	yuCa+/qPANSDSGqcfVnYr8O6qxMQpWcJuUWwPETqmLJ/cSk9vee5FhDzPItNDCjdO6sQYspjRsL
	D075v3bouvyiirPW2RzfY8147nJFyb6gCEIGS
X-Gm-Gg: AYBFou1bvUydpW53e6yvfh4aRTtZ7BKJBYCEKFH5mV/cgOKfddjnoafIGyds45QYh+N
	PpjTXPQU1sjjLB6OBMlbirx2uyQxwE67U28HnGrH3NnoqgLRBil0WjEVGtKZ7UuuQOWW11Ggj6X
	Je3GcFsbGny7QkjaRiQqLMzqtUL/RzSPDOsCMpD8HeHBANsmeozAb/hnWYFczHAsDuSCISbJlaQ
	3mG1uEWODZCKRO7KGfg0b/eDwSMDfcMAa355gXkI5nWwPukN6hzSvBYxRfW4oj/4Dzz3GJ3hagg
	Ed6egIcK86mwvnAgFM5bk9AnKZvqSn+mmtuKT8a/GPmkosbHxsrIRsI=
X-Received: by 2002:a05:690c:6b01:b0:8a8:6c5f:5b21 with SMTP id
 00721157ae682-8a86c5f6f28mr14276917b3.33.1790364422847; Fri, 25 Sep 2026
 12:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
 <20260925171755.2029271-19-cgoettsche@seltendoof.de> <CAEjxPJ5Epx5knedsBXPWV9Mqn7wa8KsiRjNTObhx1f6ss6Y06A@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Epx5knedsBXPWV9Mqn7wa8KsiRjNTObhx1f6ss6Y06A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:26:51 -0400
X-Gm-Features: AclHuK9d3Uz2H3GbFezZeqvZxdLz6E6HJFZyxOogAX2f9px5SLzD5wZiLdu06W0
Message-ID: <CAEjxPJ77O_JsJwKVtk9uUFCuYBkVeEyvMkcG3WbRq2fXi1MqVQ@mail.gmail.com>
Subject: Re: [PATCH 20/21] tests: fail on compiler warnings and enable Wextra
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 2:25=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Warnings issued by -Wall and -Wextra most of the time point to actual
> > issues in the code.  Treat the as error, so the resulting test run
>
> s/the/them/ or s/the/the warnings/ and s/error/errors/

Otherwise,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
