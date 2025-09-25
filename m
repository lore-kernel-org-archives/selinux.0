Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1006246BC5
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778832; cv=none; b=DuRXOc+TNhaBNUDV/gx43NhP/LP4jRSg8frEN3w3dJdurJ3mz/FRQbhvxFQ0hbtauk1GiHZOq4a9Y4SQCTP+mlCtPDtJ0WguKTXmuszQpNr16UQXIbO4TfnystGllQ58FmTcyi+EBng00NB3SikJ/drrAj+cwE4bYusrZedqi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778832; c=relaxed/simple;
	bh=bb6grp5jCaz2L1RJ4foQ2CSin4jyqX/MvssfqrWiy8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 In-Reply-To; b=OjTm2HqvUMmEN72OjeuNtimxf8njD/IlvZUF2SbheLf+9pTl6cBpNavqTKDRuz14mDNb1o2YQbL9Qyjpi4sEUL8QTnfcsF2m2hVsxo0WRdNgmt7vMl2tWlLKEix9G/ni22ugcaejlYSunc5rq5SOjahrOpw8vK3sQxhEvu7izVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ48d+6L; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ48d+6L"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45ed646b656so3749755e9.3
        for <selinux@vger.kernel.org>; Wed, 24 Sep 2025 22:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758778829; x=1759383629; darn=vger.kernel.org;
        h=in-reply-to:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb6grp5jCaz2L1RJ4foQ2CSin4jyqX/MvssfqrWiy8k=;
        b=aZ48d+6Ls7tsViAqRd+nrdvBGRcVbR4qZPXcR63gx4KYKa0PgBjuCnGQ2zNcTXO1Uq
         fzvjkiSpH1+/vSP+rcCZTD83uL6iAd3dinqC3lFj34RFt9vM4dZeOvv/CMvITcguRizB
         i9d7uSD4LL47NC4d01aEgPkOODpHQe32hx5Cj8Fdq64Nois7M2k8zgVQ+qej7bfr5RkW
         swb+ux1oNV7mbI03mYkBxuJwQRNXZqC5yYqrS6F2DVkNZRvBZ6Y5tgFP9m4ti+gd0+Kp
         kO4J0QX4qelV57HiMcBDFUCcft1afaGvsGe3f0Iuao6wCqZAs7fyMGjdV75te501O0tU
         3R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758778829; x=1759383629;
        h=in-reply-to:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bb6grp5jCaz2L1RJ4foQ2CSin4jyqX/MvssfqrWiy8k=;
        b=LlfmGX4vAYEudsYPemPrNDnb0jSRWZ+/dYtFKnuCatV35+IDl8RyYSzrINHdxKXxfa
         YAaVcKfq817O8WRayvjTS+GFIjOc4n5LVJ6IUINYH8m+jg2GmhbGb9J5Zi7VZ9fuDDMu
         hyi15PvVus5kFxBeIeoCzYK76zBb/XQOPAGWJsNrxOIEqbZ2P0NRXOslnNiqU6OPHjxy
         H+r9cZwaD3eM4A6EDYex5msDq/SteYuPphrHKSSCWbTboL3LdrUpYtkql5jE8cEiMR+N
         jF9xYKeeJA2APJVYeZoJSXt/CT/ov0Bdlq4yxztRB6dkqu+EPe1dXTc8pSVBd0JCyx0v
         SV8w==
X-Forwarded-Encrypted: i=1; AJvYcCXtGaCc4Qb9AxeWpM6QHsAjNYD0Yjd+hx+p/gH5zzFE7vgm2n5UQfeNsXx+oDy+RqQQ+QmUC/b6@vger.kernel.org
X-Gm-Message-State: AOJu0YzKYJ3qnkYwqTkkrEkiPNqcmk9MpkZ+rRALwAZNP+6yOrD1OU3b
	QDxdyicdlaz3xbJURHVJMe8QuG+Ma83GiJ1LOpz92xe45eqqoidTfhIM
X-Gm-Gg: ASbGncs+Pvuc/QCgAdutV2HeTn5Lds7qGdJOp9JpmQOLXkSUBk+lF8Nr1l+L24aiHLl
	YIx0zXh6ghuM2dFXn1D5jKaWgKqIAadyQS6g566U3RhnkrvytMq/4zIIiy0mgepm59nW6ERCYn0
	arnXEFJrfguthOU+zdigMjLRGQb6qw/KMJTqc/8lgk4oAXgAV4eGYttI3lLkd4hNqlrzJMEpqsH
	wMlbHVck8huhlol+Nf2NFhelGKPHV6ScE0p1WGxCQiWDz/OEunUiHy3ePeaoDFsAW25qEwSQ/0z
	phbnm/vDLhxnLlAEBCqCYlhfPVffQRlnHvqlNUii+2+9RHiTIDcHpatdeXjBEXUz+bB9qlvDzSc
	UzgVhTlRbpZU=
X-Google-Smtp-Source: AGHT+IHWgsiMoH5/gqWpEt5SewktvGZZK6dpDbIECYk6VdVBiiUJLWwm+e2q2BitOf6VxY3gctLNjg==
X-Received: by 2002:a05:600c:3b11:b0:46e:2e32:4e37 with SMTP id 5b1f17b1804b1-46e32a3ce58mr18307145e9.26.1758778829224;
        Wed, 24 Sep 2025 22:40:29 -0700 (PDT)
Received: from localhost ([81.79.59.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e34074983sm14952565e9.10.2025.09.24.22.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 22:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 06:40:20 +0100
Message-Id: <DD1N2422PKKD.2TR1X9RCQTO89@gmail.com>
Subject: Re: [PATCH] python: fix flake8 F824 error
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <jwcart2@gmail.com>
Cc: <nvraxn@gmail.com>, <selinux@vger.kernel.org>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAP JOzTBrgKgzf2M4VRXXG_1=wSd-Zf-xGrp7J6w=o34
 adGCg@mail.gmail.com>

Ping

Regards,
Rahul
