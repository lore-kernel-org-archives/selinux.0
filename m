Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513823E33D
	for <selinux@vger.kernel.org>; Thu,  9 Jul 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602143; cv=pass; b=qv3eJ/Lo3Fzf0MQdJCy8YucyX9lyd9WLKYnQdxCXU0wIwPzbz25p4DbGmTNi0xQR86QsTKIU3FgI/pWj9uhscIX2h1HtzPxAnfJD5kfQ+NFpIsgEfh0blYOK1LzGTleb3na++vOdg/LZkdT1kD15FZ6dCIoZ6AAsysBw1AFhGok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602143; c=relaxed/simple;
	bh=gkVz4T8SWAQYN9jnQDPongNQtVqhLBDLi7GP/8259bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AX51eidENu7cG76T3fRIo1ALzKqHlha6lXJxUDbtsJjH06eOk1GM9MptebCQC/NQ7u9HQ6Ga97+5BFPWKYVSZx1B+8ku7UdQtKUfA0j/BlAe19xTBvsVXdF1V/CQGB7NuYrZjCT0JCilxA7EshehBJM5ADSolWLxtA1o2Olm8DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAd6e3sr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDhntngZ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAd6e3sr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDhntngZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783602140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkVz4T8SWAQYN9jnQDPongNQtVqhLBDLi7GP/8259bE=;
	b=YAd6e3srjU9yl58TIDUQuST5gYp/sCiIlUwJIPgnwovc4GvJdpWRxUSvhuK9hXXN5WenWy
	ndv8ep+uIVwS2F0p+wbt5wxDPXZSeYTIW5tLnmYNF7s7yiP40uNCY3Lohmt1a63yMYbhX3
	YteHwXUKn6Fyj8lNDbl5C3rGtVFQzzI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-xV2dRp5JM7KOdCIwIb2Yew-1; Thu, 09 Jul 2026 09:02:18 -0400
X-MC-Unique: xV2dRp5JM7KOdCIwIb2Yew-1
X-Mimecast-MFC-AGG-ID: xV2dRp5JM7KOdCIwIb2Yew_1783602137
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84854c2f888so2045466b3a.3
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2026 06:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602137; cv=none;
        d=google.com; s=arc-20260327;
        b=d6sXHHWCSf9Wc6UfSjVY+O3eigul9CQNLQDxWVyJ1ULyOwMRcP0V4gY7BnQntsmOUB
         1LJNN+9FyP8moXclcsFmtTbivgg8o9YBLibNUsj9wRqkCs0FgExrH5ewRZliT3VJpx6m
         e0Vm7cJCKc7V47Vwdz/5zYQoqUfs3kSSFqTGPu5iqf25ntCy7ne8qtKqkSea7/dTCH1W
         +IzLuuZ+BE8PEOME3KsIFHGLFQqlkfrOsjAW3f6IoDOCHtRGM/48ur6sB4FefTpmf4sb
         WLMWu8/VjcNsx+R5y0Dvn42L9jxkhO4uPq1i6t9f3E0ZoNSXqW0B4ahyNEq4Y1Brchtl
         k6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gkVz4T8SWAQYN9jnQDPongNQtVqhLBDLi7GP/8259bE=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=c1z4xki8wl4ZZCVzyqTrP8QbxTlOhd0sa4hETpBMD0SYXmAgGuPJ08hZriu6kMMI0e
         X2W0Ohcf3QBA5YffVyRocqXpB4EX2b/oTwjkBgOEDC3wgy9S7KiMIPXvJ/MAPXf7HVjl
         IucQnSble1XLRPtE14gSo5vs4NaAQNk8mnHZt7MsCVa1yM5Fh6ZHtuc8DnvoLDjkepN6
         xAJ4/RWAr2NUrbffDUE+mi4LI5P0CwqeG1zXg/RZ/4r0aINmHYzDNsPym+d8QbtbovpM
         8GLsFyKM0QcMA1deaY0iIpPDKfIc5+L0BTe/vCJ3O3M2uCSO9OCECamDHArZUYuZzOjS
         uHEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783602137; x=1784206937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gkVz4T8SWAQYN9jnQDPongNQtVqhLBDLi7GP/8259bE=;
        b=DDhntngZjs/A468fgQQBXjjhDrHhxIlqLbrJNnKeL/GEaj96LulwGf1taf5ZVrLXGR
         +dPAccl5KgNgVAu/A2PIra8BbWcZKpmV0mN2KDUz7E0PjnWuvzmRQu3qu58akah3xe42
         xFimzfyk69qn0cXVuIBhBXsKi1kkDSr5HqpIr8w5yj/4eTs8Ou8oADQKUeG7QvWc2Fbm
         wnbptApa3SM+eDJ1ndPbYwnk+prdIb50I4u3YhdcoscKVm/zEMjHRCdSrqAh1P+ri60j
         3Yz40zJs/TzP7g4Wkq6srSKQN4LwzoxSZLyztlIsjlIkAy+cANnr+SwqPthPInWLDEpC
         BU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602137; x=1784206937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gkVz4T8SWAQYN9jnQDPongNQtVqhLBDLi7GP/8259bE=;
        b=M2ZQMzwhfGCr5+XogFElNXAUIvk+RME3FHMCwwn2XoWZzDLHcsH7w7e1JFSoFp8ec9
         RXMw0DZbZlq+sA0lm1ysZVDNO2C+5b6a14MZjgIrI8BEUCLIPiuYJGGufH31fOt7N8E8
         /Ou7vV2hZyMn052aYd1404DgrB2zAUSLUk2OgNTZdXMbkWJaVDDFwSpsjNm/sTl3yuKv
         LGYDgIhr22JvdwdZb2K1SwZ0W6lzFYeIRauKz+4mjr2ZJiCWkQLNl18zStVciO7jPfn1
         BkRzoGev3cUC1iSHhCD0KwvZ4AzpvPMgq7KCy03ipdD3TkoYa+kgp1orhX8qQybl8iKt
         Ckpw==
X-Gm-Message-State: AOJu0YyeoI3jrkEHcRBr2c0qyDI+gAnW3w1JiZnvUurJz0LlLfinCgOu
	bL373CImS3Zsb6TwOWSNloE+pwdIkXesWxuol1DMH5Q8fzbh3l/+J8YUGdtHctEfxa8+IepXbPO
	thK0qhKdf/cG06bKSKDpbES/oLjWrq5IlOK0ZVjVg8Xb+j8292NfglXsx82e2L3IMTfP/QDda8n
	Vy9Usu38smW/ilx/xdMlOzLXY2FFRaso06tQ==
X-Gm-Gg: AfdE7ckLdhxiasljeZk9VrbsukRjqn+kpB5md+0R2nWrhsn0S8m+Ti6aBLa/97kAENY
	HFxBN1JvfPBZnx0uejJJKORvOhIqIIEtXmbKltxh4clJtb4tm/tKNNJnlJD85Un+Xs/XtfATiIh
	vt7abUMCKKbAEkkVVCXQr2sjqZpjVQZgAAQX0LVR4lvsugM+zgFXpe01e9dhdbO8B1YsPwJBP08
	nlzOcP1AxUjqgs=
X-Received: by 2002:aa7:8894:0:b0:848:2f7a:2e5c with SMTP id d2e1a72fcca58-848438d7a00mr6403218b3a.75.1783602137157;
        Thu, 09 Jul 2026 06:02:17 -0700 (PDT)
X-Received: by 2002:aa7:8894:0:b0:848:2f7a:2e5c with SMTP id
 d2e1a72fcca58-848438d7a00mr6403161b3a.75.1783602136499; Thu, 09 Jul 2026
 06:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703114816.1244235-1-omosnace@redhat.com> <CAEjxPJ5A4RQRZXcZnP67LmG0-FYmCUi7218+ADdQ0mJ8ypb2fg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5A4RQRZXcZnP67LmG0-FYmCUi7218+ADdQ0mJ8ypb2fg@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 9 Jul 2026 15:02:05 +0200
X-Gm-Features: AVVi8CfhVbOWCURTycY52mRpvxuLDLlz4lRtWPuqvq3iBtvcEn0OZnKnSYQd1eY
Message-ID: <CAFqZXNsfL3Xg+bY-kweFePgWkWHyj+gAf41DJs4s10PNGxvubw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/overlay: verify that execmem is not
 checked for the mounter
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 5:56=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 3, 2026 at 7:54=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > Add a test that verifies that the execmem permission is checked only on
> > the process mapping/updating the memory region and not against the
> > mounter credentials.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Needs to be reformatted via ./tools/check-syntax -f but otherwise:
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Right, I forgot to fix that before sending... Re-sent a v2 with code
formatting adjusted.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

