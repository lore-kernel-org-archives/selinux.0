Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34384A35
	for <selinux@vger.kernel.org>; Tue, 22 Apr 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339486; cv=none; b=MbCYIyrwi/Pq/Fiihi2DLwOQTX5J6odKkRZnqoqkT6PViz5GFMqZ+Ic8eD0B5MvVehsrzWg+iYTrtU625azlF7xvh8VLWxyDCgqUGyA4nuJ8tBqJi2Zt8/9AgIpBLzn8n4bELMoiM9W9VgrnYrZqQ5WGPHs4bSzNBJ7ZW8ny/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339486; c=relaxed/simple;
	bh=O352kntcGuSDonvgWfa/5L3Uj6mKr16QzAvVMMfZC8c=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 In-Reply-To; b=EdLP9p2hknh1rxaq/KX5KUwg4g105E90sY2rkAW0BiOole+gBPtZ9/T2HmIG+jctKcQH7Qp2qB6F0g0wu+a5UoMybmD7Q628pkGLHvTxpVxALQwc7KNJvk2NYMoOYMSmy4xvWZ4/lCCtp4fKnL66Gxcb1czeaiy7qA4R7UNIBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej6KiYbq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej6KiYbq"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac339f53df9so919993066b.1
        for <selinux@vger.kernel.org>; Tue, 22 Apr 2025 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745339482; x=1745944282; darn=vger.kernel.org;
        h=in-reply-to:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O352kntcGuSDonvgWfa/5L3Uj6mKr16QzAvVMMfZC8c=;
        b=Ej6KiYbqgU1rrDixDj8o+sMfn5ZVWXwJPpERCFJRr09LICtMpzyJP5GBIOIE+viQZk
         /joakxfFt148bNagNg1I3dZ8Eu0vukfYlfbygvOBfEBgvgvmIDcViBPFWREzDJZVBAWZ
         OsCDo2nvZo1I6N676HDlFWLbjh8a9MoyecBt91kOzgbzvVAxIcXe/QayWL4YVIklLKY4
         62PJuO4s/mhUpy1A3IfDFi1x4WcZpTfih0xGVftbQsqr9/9d6k6dfHuhsiZcW3rIYmTr
         H3T6bumOnJ+19AkH4oB6yeLKrlxD8vXwe4tAtuFpWhvHIQgR9CJf3GoJBeZyTDiQWIus
         pzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339482; x=1745944282;
        h=in-reply-to:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O352kntcGuSDonvgWfa/5L3Uj6mKr16QzAvVMMfZC8c=;
        b=Ipv+EzUOd4V+SQy5S4Cd0pXhKGQYh6bghnrdu+z5zmpTsv3zhNMVylfbIzR/b0DY73
         +GowBE/rvc5B4ddoyiHfzJYentSqO9MtCv3g/OyYnTo0BVMuswF4lZTPbuUQvEPC8TpL
         Jme2EHYACeTLcnzZZzezbeQRyb7UBox3dH1iYNNYMXqjoTl5THpDihSFJa1HDsn5rx2g
         6alXRrtpSL4c7W7EfQ106A2fh+Ein/E35rn5AMZQ9zydGV3B1ZRxx3dCUYfCN2zXfUx+
         BblwQqxBAHA47HMQGs6EfhMgNeweX85R+6W04BTcysbbQo0LNTl31JkFrz5g3tkZ73dV
         epVw==
X-Forwarded-Encrypted: i=1; AJvYcCVMETD1V4/+n52iyJItG4Tx78lhYdN08UnKv0xuWE/Q90rBGY9y0/KPHJ/IexSCXOfsdpov6VZj@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIahhpCc6sbCQ6kvCm+TdnCB/9DhibIWQEZ5tuWCGZeH5bwSM
	gV7HAm4kQHmW2qrLYCt8LEpG3at2wFY7WMkBMykv9Modkgcsopub
X-Gm-Gg: ASbGncseDVP9T3qvLc3p7xyEXbJrXk4RFBV04Fz00+WaeWv3MEyPXZQu5hb345yakPQ
	HsPKaFB0DML9WBYYnr3asF6zC0nqOKSxXMw8lNqb5t+79IQix2bV3h/r7Xve9PH/I2onRlyQVQ3
	pzABb1f9cN9I+QsY1jGksNaXkwydIOofF0L+TbbA43DGj3hLmlAFAnlNAi4Mgx/9AHSzsimcqa6
	JhvyP3tRGFeju6NFjjnXWf0b6BcZKNgiMqhwWJbeASvH+pg0vHB2xtCmtA+/PvVTOBMdPzuUeeu
	pjbflbJ4xqyfiuenFMp8onH+OqUSnmU=
X-Google-Smtp-Source: AGHT+IFbx1FlSiM/CMs5OAIyvrgZPHVa1WF1Qvn/bTSOIK8TEuHRnTWGg4Z90SRpy+Lk+zFopGWPnw==
X-Received: by 2002:a17:907:7f88:b0:acb:5f9a:72f4 with SMTP id a640c23a62f3a-acb74b8368dmr1309033266b.30.1745339482322;
        Tue, 22 Apr 2025 09:31:22 -0700 (PDT)
Received: from localhost ([81.79.13.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc722sm677587466b.99.2025.04.22.09.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 09:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Apr 2025 17:31:21 +0100
Message-Id: <D9DB7KSD01JE.1LSPBCYV65C6Y@gmail.com>
To: <paul@paul-moore.com>
Cc: <omosnace@redhat.com>, <selinux@vger.kernel.org>,
 <stephen.smalley.work@gmail.com>
Subject: Re: ls from coreutils 9.6 doesn't show labels of some files
From: "Rahul Sandhu" <nvraxn@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAHC9VhRj4CWBbSCEiznjNh_WaHr2vEGB-_Xem=VqRyptR=MtGw@mail.gmail.com>

Hey,

> I can't think of a good reason why we would ever want the *listxattr()
> syscalls to not provide security.selinux, if there is an individual
> filesystem that is different/broken in this regard it should be
> treated as a BUG and fixed.

I've spoken to coreutils upstream[1], and they also seem to see this as
something which should be fixed in the kernel too[2][3], and appear to
want a soloution in the kernel rather than working around it in ls(1).

Thanks,
Rahul

[1] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00011.html
[2] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00025.html
[3] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00031.html
