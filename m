Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1352940C
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689994; cv=pass; b=d40E7G1t87SPQBPFUsliNA6dJfXsd8569JoKk+GoFNIRL/WYdoLda+0wY/eoximr5qV5CsTshzGvRLXOWWePy5P3PHLRe1BlMo+EQoDUXumYELMQ30rQ55OPWmsceu40SETfAkg7DGXvXAx3YmmA2KDFsjQUsJx4NslAwjWugDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689994; c=relaxed/simple;
	bh=qQidFD7p4bKWQAvtdCDQbx/6i+L82pBBRICRbIPvUok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQQoBm1yL8t0HMlrcQr4OwWTdFqfrPB9L8thPIhHRoucZRD/TWV0e2y6PD/7JJCCiHHUWe/stZ+ASM0Q3PakxSxvnxJ6Z4SCYo3SC5jkXUNem9nkeCES6RLhbDUL8gsI+iWOcjKtwH7kbHJVomi3gAy2I9o0EX+X3FI8thCoBAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8ZrNjKs; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8ZrNjKs"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aa8d882so4833982d50.0
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 06:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790689992; cv=none;
        d=google.com; s=arc-20260327;
        b=Q5WXbL+S65hDECIlp/w87X/ptPb2u350DwIYuSwzW9kYkhqo4yyagvCbMQtNovu4Xl
         dkEmniOJ0lrLMyPtZ+FKgQjASLFoItSZFfOrQ6JBqeDQX+EJ/dE3xohz9QDMUnvzIR8P
         UY5FEpADDvSz7S5ob65kSUFruHD9wypG4c6LSTVznpCjEXxCyUrIxFrINX+PtLBfvbJb
         eXpHmP4SsrtBZcrnaSN33qg/8XxzQ+aKBEETkmOslAqg5AOj6T8UCfRLQmeVmMfCXlCF
         Q5mTOGr3rtI4G86itJFMW8ylZTZm4O38HiMmhglVGU0xPw45RbCa3uvuE2aDuqDrVgD2
         BqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qQidFD7p4bKWQAvtdCDQbx/6i+L82pBBRICRbIPvUok=;
        fh=9CvfyTln6mlGi4sBe9JH0kMBicdx1bffQat4jneQZt8=;
        b=el1qCrtf9UORKLS0G7EF3jX2uLW7wuOES7nZpPbFWNbJX7JCuSrcGBtD/wnCTZYaXp
         TePDR5n4vwvX1pag6QA5YeWP9rihDDY3tB34w/bKSVsD3Y68fSpwBmW7lETEnhQsPMrL
         d8qJzfCzlkxYKZs+Gs0HfPNArzA0f/Xk4s0xfTcgQBbs5D+J3cudc6hCq7pc6BhZqVKx
         jkW4E6oA6wCt0YYMgsa3sHMR+t8coZQC2jCHt5IwWy+owhxx/c71ZcP3LwWTEVQ9eqxh
         KKSJgGq/gawqj9zJ6z9XAo811isnAg1psiKt4pGzYgwaT1LX7jWDNOIPJgx0FpGp3k0s
         rZ+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689992; x=1791294792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qQidFD7p4bKWQAvtdCDQbx/6i+L82pBBRICRbIPvUok=;
        b=o8ZrNjKs6DcJQVFvtsZ5A43Pm2wDicfgSVi6NBZTQ8sJ1RrC/oaJOnKJnJTDeEh5j+
         mgBFtfYqXLxJUSh5ABimBAJxo24g8rGzjc5X61lfCD9pgrKpikvvKBQHTpxqKnoKth6c
         U3fROGoHXmgaiFfo5WxaPsEjRa5u4Bw1KN5W+/rObBL+7hk6kIaLFCn9bFGGXPESy3K/
         VJMSFDu/jjlwQbWSV3+KD1Qj6/5rdavpZ6by2tCBr6/zRh8dkNfdw/hfyZk35eJ1Y+L6
         k2KFiGIkQ8ZJQJN8KQ/fNrNkMLQv03ru1F0/AOM/FhqMfXjBs/xIqdOB92jLNIFn6UEI
         oqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689992; x=1791294792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQidFD7p4bKWQAvtdCDQbx/6i+L82pBBRICRbIPvUok=;
        b=RgkUonzwwVa+7HqrNSRwtk8MRcl8eoBSP1XB5yLOfmgc/wGH2FTBdbWbpu746zTCi+
         mIYNxDA1VoW17MpnwZsIIJuwL/tyzo0owrO0hQNRYcLU6yOZz13KXKzN+RRPkhIh391g
         QvNuwxl8Ubfo4QJI9h2NRTyvQy2jSyFxyLm+639PkdUGoNdny6+R6GHu00NUaeW8d47m
         GbN2YOSJt6if9P3IFlKzHp9n9WuIpEyCdRayVVEHfJYsmcadHiO9pz1JM/cRfAvr8ePT
         hAvZ2ywRbS5yNYx/lhI3kNIyt0Xhj+tE3fGIaMik4gmslcfMiEc0P3mlU4MeRr7pFYjU
         gdHw==
X-Gm-Message-State: AFq9FYJ/rjZ+kIHUldqWHpVpFWv9+tPNxWpENU0OJG4/pzPGnzQJ7GXR
	w0TipoS0rFwbTkmxWlj8VDkFvkxVY+ZDlRFciWSsmnm0u/qdeKlLUD401hHjASRKgqNjfNcOFeD
	0BlXAVv3rJ3qnb6H0FpZgzTnya3SjCyjptIL6
X-Gm-Gg: AYBFou2P/Eq5vI2sBVFzqEe40GJu/VIxvyrLBNSbnM8lcEMA0nvCMcTfaMxsi9tE6Z1
	arF/3isXXEaCdGyhpY4LOvikjhoOYOzRP+4D+aZun8HXmvcTuaINDADf4T2SVjZbvXY+8aSe04V
	s/WZHFbxYDF/IXygfnW4cVIP49vjJRFDC9FhO1DgMg2IWU19CaxAQ70FLep/jhm19CVvJxORGxW
	1NvWddccTLzNT3orGe7wcvhHMW7dlXKlf/yn+TWINSWOwhMgbgUYZzVn2YvkGJS1X36gODEtl/E
	he4Wugwg4y3GtfMmqLvtyrcBSxmZRlogvnnUcdragbHQoG7SDe2sQnlOW95o0RMRSg==
X-Received: by 2002:a05:690e:1309:b0:674:d78:4bd with SMTP id
 956f58d0204a3-6740d7809fdmr5934190d50.5.1790689992378; Tue, 29 Sep 2026
 06:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929124730.87841-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260929124730.87841-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 09:53:01 -0400
X-Gm-Features: AclHuK_zTx6FMfSjvqSvbvdSk8oxduCxw2UjLughgFckmscd8UPUWVBP3n08wQc
Message-ID: <CAEjxPJ5s4tDU0mzNhxPJA4ri-RT4BSva6bvheRasaQwgUc2neg@mail.gmail.com>
Subject: Re: [PATCH v2] userspace: update man pages for /usr/lib fallbacks
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 8:47=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Update all of the userspace man pages to note the /usr/lib fallbacks
> for the configuration files.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
AFAIK, support for vendor-shipped policy under /usr/lib is now
complete throughout the selinux userspace.
