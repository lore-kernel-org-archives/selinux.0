Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D2A134AB
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054412; cv=none; b=iUgrCvBAlqoRa/SG+cTKM1OHRZIH4X+sLz8ixp2FPDWkBlag0XRH/UFKYRfNN8gW8KvlpTgRSOjES51QJxDMYsPuNRW6qW1G/gsuZUyGZ5SdhoNx1yhf3YYcs7jIOjFFNCLcN9tQTpeBQM74oBn4aovygDenIUyiOZk1T+cGaYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054412; c=relaxed/simple;
	bh=N7/xykEepbQwGH1aynQkMmgQOjBCxpcCLsUCTvcotpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJG5H5ZdXY854KGzmAYV7RUtypCZDgQqfE/n6kL+7ycsJu6KvL2kELsNRUNafvV3UFK5ZyZzv0dLGazdvRgq1Z9rj+J5oPlXy9GoiIAXNbDdsb4iq92bYhzYkaUlrCIPmtF+qVB9V+Q1jTaAA4U3GrHb2mdr8coZq89630KI9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIu71V6X; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIu71V6X"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781db5068b8so4330325b3a.0
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761054411; x=1761659211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7/xykEepbQwGH1aynQkMmgQOjBCxpcCLsUCTvcotpg=;
        b=aIu71V6X9fmkmCwPBTRwCTurROl8PKNoVQhZuUfMdOmhwvlmBb01j/vH/fdQYZGHxU
         JRp59/PA/pmPXRfdl/c7BfpeCJ7FBPbCmP1iYq+9HuOZBq3WiBg+sNB7IXbWiO3fqSL5
         5Fc/HCJmkS5J2tjcZ+v+BNOwHFPLwHO6FcGnw0rsyDACccghj+Xi0r2uLtx+S14ON0y6
         qRZJzrid74F01GRDJ/xJ67NcMudzqzeSu69YFH0ltpVh5qq2M/rPm1DAZo2kfqOdWeYx
         5k00s9+B7ZbYwA6lCbd+VUhZ9vTVL8Jv9mXHViKdf69VV4hq6b7M+sz8uiD4KmvEQCCV
         KCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054411; x=1761659211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7/xykEepbQwGH1aynQkMmgQOjBCxpcCLsUCTvcotpg=;
        b=OLxgkpKB5AFynM0K3pIgQWsoUKqG20O8mVrxf9TKxxYBoT7txDyZkIt2R3kcJX4Uxh
         NSAaFMj1uEXVc6ZtyYeDtHt1MItpsFzQHkdSmCO/WFk69+2QftiuyZT0hAT+zXHJVnt/
         5QU0T9BMPM49pstRct+2auR5bQS5msW8xGZvjKyG6m8fGxHBbiXpOMRxqRdY7OdKlzA3
         yBN1jLLSVx+jxNZhlkJ7XtQdsqqN7pVnToUIPskiZKvn9ospj16KgpZOIS3yvCHuYDIq
         Jl4nHETiLJnDh43TINsr/7WLWRYCqRWD6QbOaVhoD859TAwfIwuMDLXDDELWINJSp93Y
         Xiqg==
X-Gm-Message-State: AOJu0Ywu6rEBQZWCyDpW0thKS/LYEOeHByQ/VY/TPEIxG1pUubmmUDPc
	BFYwur8at+zllB+PhK3mfDS7rHqBhAu3Cd4qdSWUsDCkR4Y0J+aIlrzjBfzKnsCt55lodj6bCqU
	bcxNAoLEQuxJ21Z6aqYo47im+cWWgsPs=
X-Gm-Gg: ASbGncuiCxnIJphQfpQGSAssTpvHpYH6NVsmeO2FIk7ltQXUZ7aGlL9rTcxn4ok9i0J
	KH0uAbg8XYJLwpMeM0VfdT7l6Iceo5O5YJdBbo6r1+yAj9zxW3Wg/TRJleQmcxqnoH2exA3LHjI
	d2mQtTDxhJoml3HVRysTo510+jKPdTH5r+BJdvFxEbpDdPBmkvecAXY++ANIE9AAmDspcJ4ytEE
	eOXZ8rb+2wTu0moI0/QUeo94KqsNqHehk2Q59cqTP4MGGlEs4McamMHRxFwceHHuWZ7vy0=
X-Google-Smtp-Source: AGHT+IF9cShAOYoUNqYUhLv6qgYm9/tX8EYRlJIu3I4h9UwfODju7Xem57IzZvsQz0cCXRpjHNDAWLNIYhnCqRLeZnU=
X-Received: by 2002:a17:90b:2b4b:b0:33b:c20a:35e0 with SMTP id
 98e67ed59e1d1-33bcf90c1d3mr20463967a91.30.1761054410685; Tue, 21 Oct 2025
 06:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7UE2vtCBNwDphKO1SPC88vbTHCyq+ENhvZe1Tea2hCGA@mail.gmail.com>
 <20251017150847.580771-1-vmojzis@redhat.com> <CAEjxPJ6RJCGmizB0zX6pHobiUhWuXFjhhpE2n5EvP+iZgOmYUg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6RJCGmizB0zX6pHobiUhWuXFjhhpE2n5EvP+iZgOmYUg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Oct 2025 09:46:39 -0400
X-Gm-Features: AS18NWCw4P0q6TvOY5qJrRNu26yI_L6QWRlTGwcYR47KmXdp_sVxVrUv43Vvb_Q
Message-ID: <CAEjxPJ4RXf0Z+T+xOiqUvDh4gvG5LeBcshqufWE8P6VM5O9c+g@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Ignore files removed during relabeling
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 8:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Oct 17, 2025 at 11:19=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> =
wrote:
> >
> > In case ignore_noent is specified, ignore files removed during
> > relabeling (race condition between folder read, file read and label
> > set).
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
