Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B521191F74
	for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684985; cv=none; b=ufK0xmsecYU5nNyLTXYzmRaT/nQPdYGBpM8VJ+tC7RtArNR1OEstC3al9am71Lub9n6vJmjg8Nrg4Sy0LE+HE+C8lUMtnBVv0eOpYfzF1yifO9CRcuSBbZs/5jMYa91gjzMidU10NtoCMe6zAKT1ykuyYEJmL979BW8CeF7mc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684985; c=relaxed/simple;
	bh=JrZ8FvK83ZoPDpoc9Z0d2jCCQx1EFHrJLn3qJbB2uAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQu1kv9nGfzUKqRlX0FRRJk4dNchVc2fEEubwIu/vQ4Uk8RjV4H05AtmIZDYFd4ZcQvNOKXfAAsAisDN0EXEZ2vYTkKYKirnuCVhYR7WQpC9wmkByc0LcqSJTi6rM4u53hqWcpyaSp8sMx2uODX8KKbpRsmXdoyq0GJKVPjznQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8nyQEFV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8nyQEFV"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2793895a12.1
        for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724684983; x=1725289783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrZ8FvK83ZoPDpoc9Z0d2jCCQx1EFHrJLn3qJbB2uAA=;
        b=e8nyQEFVzDokgQ3MKlFdjT4F3ORaKoJdmEinK9pzEw/HaJEqFOBbGdhJQH2TFGQup4
         d60yvJksFscIhWKQUpQwToSIDhQ1D4h8aY7OOuXfWNfUXN2Q8xFuq6l1Yqy2FFKfadd6
         BaiduoULMZoa3xPt9LcXHYNCnmWU9kfEf8NwPCnLV7jTIO1wNmTBstsZ2Xd9QmG0N1vK
         +mFWH8zZHLnHK23MLp3Fa3P0mf44JEt98BERmkO0x4afxrdmctuBTM5ezZigjrB8jXLr
         j+9Jlcf3yZHt1+TZyKyObXcmGAE4JLLthx8hf96JMLebXgpOWbKXmAy1I+MlcxeOI6Ro
         mX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724684983; x=1725289783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrZ8FvK83ZoPDpoc9Z0d2jCCQx1EFHrJLn3qJbB2uAA=;
        b=Cae2d4Qd67PMHqJs/NQF5FqJJx0N4dOx1FV/uGsIJNtmtbwxrxx+u2k5LuYy66QlVb
         20haC9RmGb3It6t6goalSm/D3MevW7vfM8P/EYygkZjI4ozXVTORUnFI8RXTTbuxDbuf
         BxHa4orA/nSupCkabgaBhphktiRR888jQ8nPGXiw/gSt7nTZ5mo71AM2isUUpJ+bgR05
         Gq+DAoflSfqldbBBkqPZ59gZxPFLiTaYUvmTGjxr4FMSZWiQUooDfjEdtP+7y0HHSKpO
         ksos7NQ1FZAqpCy1p78t3mef3tZJkiM2wlDnNjFxako27TrxmPMMx5Fw+Sg4Cc5kLsCt
         30Cw==
X-Gm-Message-State: AOJu0Yxavn2nYLfFwLbBnNA6bAbPOM0lp8KLKnFfxFk9BuCQx8vobG+c
	F96QFlUPH94jB2CtW1AoHkQi1lq6JK86+7Yb7Wn5MlrRFb9/rc/bpsCZLMov9B8f82bcq2THusg
	psnl1obGcr4QQx+DnOer11cuE8lXqV5Kb
X-Google-Smtp-Source: AGHT+IH3/btB5pxTdGQI3a/w2UiZvT7/xLkzenysZJzgYFdj7FQQfW7XCyySgx+5I/TjZO154o99x6xZi7Tyz+Oyi4o=
X-Received: by 2002:a17:90a:12c2:b0:2c9:69cc:3a6f with SMTP id
 98e67ed59e1d1-2d646d0c2f3mr9482073a91.31.1724684983030; Mon, 26 Aug 2024
 08:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826124709.23530-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20240826124709.23530-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 26 Aug 2024 11:09:31 -0400
Message-ID: <CAEjxPJ6gEP5LsA5qydC=Tiq0qXobR7k4GqijMeHtpieMerq+tg@mail.gmail.com>
Subject: Re: [PATCH] selinux: annotate false positive data race to avoid KCSAN warnings
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, 
	syzbot+319ed1769c0078257262@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 8:47=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> KCSAN flags the check of isec->initialized by
> __inode_security_revalidate() as a data race. This is indeed a racy
> check, but inode_doinit_with_dentry() will recheck with isec->lock held.
> Annotate the check with the data_race() macro to silence the KCSAN false
> positive.
>
> Reported-by: syzbot+319ed1769c0078257262@syzkaller.appspotmail.com
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

With this patch applied and the following KCSAN-related configuration,
I don't see any data-race warnings in SELinux functions during the
selinux-testsuite (lots of them elsewhere though).

CONFIG_KCSAN=3Dy
# CONFIG_KCSAN_VERBOSE is not set
CONFIG_KCSAN_SELFTEST=3Dy
CONFIG_KCSAN_EARLY_ENABLE=3Dy
CONFIG_KCSAN_NUM_WATCHPOINTS=3D64
CONFIG_KCSAN_UDELAY_TASK=3D80
CONFIG_KCSAN_UDELAY_INTERRUPT=3D20
CONFIG_KCSAN_DELAY_RANDOMIZE=3Dy
CONFIG_KCSAN_SKIP_WATCH=3D4000
CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE=3Dy
# CONFIG_KCSAN_INTERRUPT_WATCHER is not set
CONFIG_KCSAN_REPORT_ONCE_IN_MS=3D3000
CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=3Dy
# CONFIG_KCSAN_STRICT is not set
CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=3Dy
CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=3Dy
# CONFIG_KCSAN_IGNORE_ATOMICS is not set
# CONFIG_KCSAN_PERMISSIVE is not set
