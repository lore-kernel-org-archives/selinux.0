Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7C248A8BB
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157732; cv=pass; b=DFOMM0K12m+b+r290P+VgUoGxtfRTIHAPPuFsXni3jTKGfs8MIsef/CeTvbRj37lkXS+WY/HJBlqgF40f71zETVgKUTkiJQ2pjDk057Qb0OGpoztiMTmMMOUCHFIJ7ufLEG5Z7+WK4QJYi0ms4zGyTxc/TK4VHeXFwFgv0tw82Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157732; c=relaxed/simple;
	bh=xfGk5QucWOirxajC+rsivOGBK/FoGmZrmzg9oKo1iI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMzeBTRMvYoLNwhKBMqmtTsiJjO6s+nTNdHq8jZoqqSEoeN3kWxziZ22wkpb0iOpvdCzUM9rbAbCTaNyh/flaCfvGaaxE63sok2FodH3Ks0l0bfm7QiUl/bGzhVC6cXhDlDvZNkUWni7J1J88Yz53CI/n+oQJVT9GSc86abijDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScvZtQqe; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScvZtQqe"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a17c460cc0so11882421fa.2
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 09:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787157729; cv=none;
        d=google.com; s=arc-20260327;
        b=O1KJFS+iaSdhIG9757PGjOBMMqwYuLgcJm75f7LR9AJzbEKWGxNusiQeb++yoRWlm0
         4Bvf0hlBVBA7gpNHpj3CqkzDHLe0hD6AylAdWfedVqB9hT8dbRkVQRTutNRIRm/0oapq
         EXw1ynQNw2WJeeWxtzCzA6bfftQ/tcRFmm9UzVDPSipsMaIC21GFgaUso0K61OBl5jVD
         6+bQX/LzJF5lpOCNlP0RL6uEzktYX/3nIMNy6WtgOcmwHJxqqg45P0DdURV4fAjT58LT
         iszdcgz8S2z9HiSu1ZmuoW1XXdGEjvvQuQ8Ok1/r4kBAPZjoIjNRtM2LiQK46XvoJaPZ
         zImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xfGk5QucWOirxajC+rsivOGBK/FoGmZrmzg9oKo1iI0=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=BwIViBIm22Sw5rtZ681hfzMKvyoBGpzbO434eFpS7Xp0aYaEXrGfSjRV11EbR9U6p2
         KjOMG4IKn0qGEgfyqq/tOCKSwsFdAtdKsQCLxZcERgRufbRChlxEu1GSF3I8vDDs+5ec
         oe0HSjJwgsdXvTIMeZWhhqQsdKPTzhF89qU+7dPSDV9ETv/sLAI6cfKQo0KkFksDeWsl
         rtsQPMYm2Qo+0i0Q1ozWJtKEuiHItMYnSrEjm2RAmKF0LweOolD2jLM3HhEDRp2sdtU8
         UN5EjzZEbAzY0pJn6beqKKiE6QBe3QN+OsF6TOpHV5bM3sMnZCE0DHWfk0bD50wPS97u
         ++VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787157729; x=1787762529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xfGk5QucWOirxajC+rsivOGBK/FoGmZrmzg9oKo1iI0=;
        b=ScvZtQqebCPfvg4varqIX06EUiyxf1r97bDUlnMn7cE33HyRClVP85orkBJ432XlEb
         CoYMnHUhWMLLRu7TJog7FRo6ZlhgriUlj2NwXX69PSdZKA6osoABR0RMd3ut9J8EPW+F
         J6FGhnvGEjOnCg5nCKwVhWPsQIcouXGYHmoeKmqS/StkUhxl7OdDD81NJKWhzZX/W2Bo
         U9mW9HaIiTsewokNzh1reZqTazVsh3RQpXcW2HwLpUOb9LTWOHSLcKmFN51n4ZERPa4L
         pi6fxoHX30pCp0W7W96OpzoIuI9LFyYWOTyuCNB5LG+pNsZQ0BwW65nqJKz2dvmXeqGU
         Ir2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157729; x=1787762529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xfGk5QucWOirxajC+rsivOGBK/FoGmZrmzg9oKo1iI0=;
        b=jbHZ2Xonwo4wBQpxnJ5+r9v3v7ePnWE3KjEmD9VFI2iL8VZbEFWuzcxnDeEmRnt8LY
         jDvfJ8INCpwtt42klW54C0oFTb4PDKST/Hj/ZaeWPZgZPuRfpSCZYl2qGDySB4Iy0EOL
         ACMPM9Ei8kDM7bRabgL0aF+yNWzCYkIUr4HmAX76K5huXK1G5APiiRJqHu+1w8opqcSY
         i3czuh8dHWWcxWC9r4eQX3rAPN72nNTftk3FyUVVKwWBySmMWkFsOOaSgni/e8Obqnxf
         Efn++OLRzPOLaNwoPx00yYuzUFQ2KMBBOb8qiYwAQYTDS5G3BkR1jGh4GFpgl4aLjUJj
         PcjA==
X-Gm-Message-State: AOJu0YwQk9YdVLCjAzbvFTjcdef88c0UDJ0EUeo/5sb8Iy+rT4VKxMt0
	H7z+3k6Wz8F+lI+6L/LIjs8C+AnWBI6L2a7pVQiKVYJ5xF5pNKBOhDRkujbF+Ei2DCqloXZ5adC
	QELqEt0imLAumt60EG0NgqhjBRodsosIaDg==
X-Gm-Gg: AR+sD11YfQ97bEKj3aeKvA+NV5K5ZbewVPefKgPcTV/CFqKf8VFeZTlTxB/8eGBERpT
	DJXIsU9MquvKKofdREMSJXKhpvP+6DXQcFchMmI5FD9K6C+UGUeCEJCSM/fFzgBE/5cN8nJSGTg
	ayuZxcwg8Ei3LlVe5VPie4zC8RtJ/ZKDjjfo2+3fDo802oyiw/qolKPJTC/7uubBk6wqmnXU2r9
	aq/5xYqgN4iBk6HwNQHoivJVPD870wjuZUGuhbR/dhtJ+4jvUXuzO2yDmwbxpOZMP5GZPXXUx+5
	nc8vS2+h2tumg/NVMRsk81Ew9fCu7Kvl93FGO87b3w==
X-Received: by 2002:a05:651c:222c:b0:39c:a346:8a36 with SMTP id
 38308e7fff4ca-3a189974b61mr14275241fa.8.1787157729150; Wed, 19 Aug 2026
 09:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818194827.64744-1-jwcart2@gmail.com> <CAEjxPJ4HtTpOai8=x_Oxa_Eqj4FV9PzUoVq7TBzV+FC=kHhtxg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4HtTpOai8=x_Oxa_Eqj4FV9PzUoVq7TBzV+FC=kHhtxg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 19 Aug 2026 12:41:57 -0400
X-Gm-Features: AcwNN1WRmURepJGWFSgYT5EXjG7FzEwy-n8hdhbNG2xGdJJIU4BJLCwFjD0aDDM
Message-ID: <CAP+JOzT_Vppfj-rrSA=1KrobCABNeH7xkwhe2H10hS7jqdENHg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use matching integer types in scope_write()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 8:55=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 18, 2026 at 3:48=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > Since the variable "items" is used where a size_t is expected,
> > just make it a size_t.
> >
> > Since the variable "i" is compared to an uint32_t, just make it a
> > uint32_t.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
Thanks,
Jim
