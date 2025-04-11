Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300B27BF7E
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337705; cv=none; b=eaA5yq2x1nQ1m8CxjNtDPSEPVpkakm6Y84qZhDjcSIBZWCCtT7KoOFyaLM5uY34zrGj+Nn3yy1WRvtbUsvX2PLxEkdJ7WED11x+foYkGOcx8dqmHWq6jCW1MdIHO1XEocNdbmQlWVKv/YiFCLFlaYfB73dhFy+1XJ3r00AvFGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337705; c=relaxed/simple;
	bh=pgAT8Qc2QoFkFKo9CcaUohfX6BdbfmZhvPmHWJJSwzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeJYHcpzG+ea5VXFf/p+dpNON5xk5ubRadP8U6zOQGVFl5mdTSOOkLvLtgNN61Ne8T4iuCb1uZgscPPGIafmSUhrS2VPT1oBk0S2CZm6hHdscKhp1CVUw0XUkhyWj+6viuTsULz5avHgNV6+Bs2lg07t/Ziw+W7EjpDYhXtzgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cEiV/auX; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cEiV/auX"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fead317874so13589497b3.0
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 19:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744337703; x=1744942503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgAT8Qc2QoFkFKo9CcaUohfX6BdbfmZhvPmHWJJSwzQ=;
        b=cEiV/auXOeksXq8uT2oTwklewEg6x+g3XUKLCmCSz2IwStRGJ9UP2FP0f4CfSW3lLQ
         gAPe8ogFt2kHwbzdXsSQ+olJe77xhp2/Xc6dtAOGLGyhUlIZ6p2iVWw3Zhp6+1VVJcJA
         9wk+W5PJ+8at9U5H/sKSEsLnQuHsznNTkD/IwenQcTVUf3asKOgejK1clFfWopQr+Of2
         +WnJygW5QivB2vtFSO2gMeMcEXYla7s1PlOSnjSZKDmc7jhz/ajpKXcngNEnVI00BL0n
         c8S2CbpjoybtJydSlC+s8gNoor5CRu8o0PUMSAUzxh20CFE7XEZN7Gz1Qow5PNc4ACfm
         pTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744337703; x=1744942503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgAT8Qc2QoFkFKo9CcaUohfX6BdbfmZhvPmHWJJSwzQ=;
        b=rrUEDQYwlCPbyN5g2tQqzu6mV2IK0qknce4NAGRRz1oL7V865HhwGDP8vHZTBqKk7q
         zq/wWRcWkpuhTmBs22WyL7vUhZ7Nze2oGZNCPmfJrM0pSLlsiVYYsBy5s2LkbCayZeS+
         nc2tHq3Aq0R549gYxD9oZFfFNX7b5pkzXc9ni9Vpdvsp3AlLQ0HL9XzHx54A2Eps1NPZ
         j/XIW5s04CzRG+jR4qQjCV2tDztdUFnBSoUNGD5+gJpj50fSWy/OwBH9tG4nqj1Gj2d5
         qY6dajGfFZN4vFARtlzgkuKcaK9SZ+8TA1e2ApT1NZgfQbu+s7BNrq1RhCaTUJDxIsyq
         H5lA==
X-Forwarded-Encrypted: i=1; AJvYcCW0zaEpGRC6maPkByWXpL9nBWchTvSGEltCu0+TZRl/I8shUrSj3TUKOjeWnvDmRF4FidJiFIQw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5MSIDsQMTNbAHvmcPUtQOelHvtL03MbhWyidqVO45L17VNLxd
	NSlq02bF8r8iAc2fQ6VLC2PK6u4XnBgt0VdbBIgYpz72W+ZYaCnUl86UoiITA+1wsosPpDeSZMq
	Yw3P27TTTic4tzdj4yKpV65JSggkJao0ARqvu
X-Gm-Gg: ASbGncvJPoOPUtRhpa9HCMfEOXv8xsVRefhBRv09V4JC+yKD81qsaqLsUCsWhfWZrGt
	XU6dshAozKprnhNwUTofxZvKUibQoC30EYOOGhh58rUVfFw2QzeYiSZdXFyjULGRAdgYCd0bAu+
	WOqWrjmAibsZ3Ee5AetQYLVg==
X-Google-Smtp-Source: AGHT+IGrM2n2rbgpwcEO5kOc/D9dhDNnGXDOY3TLNKyzkfl2Hg5nNHGBO/S9yZ4DvomKQWEMD32rhbni3kdmuWNZONY=
X-Received: by 2002:a05:690c:6606:b0:6fb:46dc:d9c4 with SMTP id
 00721157ae682-705599c9de6mr21538937b3.12.1744337703320; Thu, 10 Apr 2025
 19:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-40-paul@paul-moore.com>
 <202504091656.21EEF38DCA@keescook> <CAHC9VhT7M4GWLJ0Kx0nkCAC+kirQ0LKqBVaqps9z-0kOc77iDw@mail.gmail.com>
In-Reply-To: <CAHC9VhT7M4GWLJ0Kx0nkCAC+kirQ0LKqBVaqps9z-0kOc77iDw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 22:14:52 -0400
X-Gm-Features: ATxdqUFgbb3sqVMjbtBqdDPWycG5EM8g5SzhjnvXiM3Xmh9QxxHw6T_UWbYo7YI
Message-ID: <CAHC9VhRT_dBRusxjsD+mwAXG=bg7MmwA3L_3W9J3GgtoODqZWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 09/29] lsm: cleanup and normalize the LSM enabled functions
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 9:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Apr 9, 2025 at 8:11=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> > On Wed, Apr 09, 2025 at 02:49:54PM -0400, Paul Moore wrote:

...

> > The simple renamings looks fine, but would be nicer if they got split
> > out.
>
> I can look into doing that, let me try the squashing first.

... and I pulled out the enabled/disable setter/getter functions into
their own patch.

--=20
paul-moore.com
