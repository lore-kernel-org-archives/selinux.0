Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E603F9F50
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276899; cv=pass; b=NWBUJoTMP6DospyHHwq3AyIbKJjhwzl8BtRlyPvS81A4JNKYY2l+08TJUxFF+qMu300ta42JW7fn1V7RU+Unm96opNDQFotCsRdRnIrTuEZNeWcnx3Y+/AStG2JdhW8N3//jSTA9Bhoc9S2aIbaoQ24mRsJHLzEM8kQb/44r6vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276899; c=relaxed/simple;
	bh=FEHNa/Ni1dUNWpgbOuMXN7jz8DcQrUbIlRLrdCz3VjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmtSmBcBbhnVrhbbKd9IZ7RstHKIHyMYBT7WmbOIGXx+AssemXSrR5HNaOMEJof5LqSE3hweA+lIOdzNcX1FmtFCXW3zORb9d1K0EXJTRzZIYVxiW7emhu9pkNSfIHflrQP+TKgzAm2b5IcDwAPSB2R+EWRS9BEWtuWsLQQ4Dkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+8ORp0l; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+8ORp0l"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-671563fb8beso305266d50.3
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 12:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790276897; cv=none;
        d=google.com; s=arc-20260327;
        b=Vr3hW6OmjyIa9gBzcAdMK4Nv0OqLNEDpvdI/mPXFKrVWeeFdyT+fvTPz3vbFfGhw51
         cMjoT2zxOTuobWCqsC0oQk5V7RdAWlZDf+qTL7h22cG49nsy0WxzCUSBN2HffhWvLBgf
         mF8Bs8CrR2Ir0FK9j9ajkiv/n8enzWfHRPjSdCZW3LIOX+hQf7WFc5DhRXmwcWpJ8nWZ
         xk5ONozr/sosKLlcp0SNWUW+4vS8fYAZ6OdkLREcy/wrv4vUe329RZyNJ9q7x6ynnpYI
         md6erp/ZRQwY9PBz39SWCFCibcZvX46v8TzxcMekFuFe/q9OskaCqSen6KaB9/BPlQdG
         KILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6u9brcSWkKL+p7FBBMMb2/QpWfabLFGuu2zgxmu0Mog=;
        fh=9CvfyTln6mlGi4sBe9JH0kMBicdx1bffQat4jneQZt8=;
        b=C34N+zlWAJFl/IA2yNZ8FaJCWr+GGNBZ7k8L2veAcUdhxefFVhG/uQuV5oj3NpQHT9
         3+BVbxAiOhw6AnIhTn680d72LKpZQQjrzY/8gk7tswbFg7JVZpuHRNhoYY5R1qu5E5iF
         rJpbnYp+I/w6fMeyuVpXWqN0qYbNS5gPKlcOxzXyWez3lLrCZaOvrT8xUrmP3xwc/onB
         Bg741nsZB/quamzQW4u0CayEa/zCZ8WpWBLjXSSG4acrx6xQ/sbU1piGyErKgkWcdpKx
         bYpZY6jGIkwXWgbE1CH1AFrM6lgXgrAs/SfO1Ze+azXG8ZWVxehNeYkSAXYL7mhW5A9j
         ZI2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790276897; x=1790881697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6u9brcSWkKL+p7FBBMMb2/QpWfabLFGuu2zgxmu0Mog=;
        b=S+8ORp0lXTyfMQ8OlTAPkgr3sZ55IWJdbjq5P5qGZtTajYDXWL/Xu7PDUL6vzT5EYN
         X7Zmb1KSGoG/FnXcALdmj6tL9ScZydC/fnboQW8LoYMLILe7rRec96cR41jyrNAfd1rU
         IYBqdqBA2DlNMQ+PvtxhUaKeZ4HplgAHVjMXhl0FqhK3KcL/8VoICvhYnfXSEtVK6bpl
         oZ7Fc4vppKwV1NlDenhTjL9YzsglxP5UHYmRYzOoYiZevaQHwpCb3VMVRdPleMzgC19t
         D9jYjLK7NUwd7s/Q5w+IYcgx2iCAew9QmQS+aUBnNoa3mP6ENbOERzMdTdTG4/BY4KcK
         jOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790276897; x=1790881697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6u9brcSWkKL+p7FBBMMb2/QpWfabLFGuu2zgxmu0Mog=;
        b=TDT1LGD+HPkIfsoNL0b5k63ntRLWMzbeGJ6m7mc2h7f5HtN/h2c7L9X0PPqzRzvzFZ
         R08n4nZ7hMFUwHsEKcyB/o8tDwxNvKDMQLaXhqOPbtjR/KYuGSZNTPZ46Ahx4ovqSLV2
         DbdqduFdU44co0rUZ8r+VAeO+2A4Oj1ZH6caZKyyPZI2DrJkS9DdfkJfraKM+QKSy4Er
         exVP+mz1RZ1vu+GQmq1G3BcoKb3QJaRVd38z/l4kmfTR9THBOOmmYOFJUyL34YzRnuc2
         jRqsVpKuTKaA1YCZYOPjGfKZdCmpQ5KV+eIypw8Uj9ZLOBw8u0QraOJSd//x9aCVCA94
         CroA==
X-Gm-Message-State: AFuF++l5JACi6Iw0VmIcAub6J3XtNe2KTX0OeBoTSjACIvAeQDI0O3tu
	93d4GaaSpKCMCHq4/kkebSrTatzIyFdacusGKFOH7Aswvgyfh1N5RdVJY6C4dZeXP/usY0Ftge9
	Ty/uJsgBFO4GS/m07tulnLRUGRZQ2w1r/7g==
X-Gm-Gg: AYBFou3dJtR4M8LYWIhVJSAodmLaXj65rn1VBE/ffkZ3fpLEHVqMLltNmQEMuGv0u77
	BNvc0SVK40MUlkdu/e9QfMycEKq6OrjF8KtISGqeyYJfFHXNxeCVi63lAT84G6iR6CQEhwqvQt3
	yljOJ14sD5+htZxjzk7BP1Yj5hG+CUApreUb+2R3BTKmyQ79agGDfaE5Ki3Az/7HPq5qtjLMcq7
	5gl5drEaIbsCN/4JecBQ2+ySmU5CCa/YA0rTCNkch7uQyF1SNDhWSpQe7jqLNEiNCSSCHhquxtc
	pY31yB+54DbkELSuOS+Wca2D6rdKbpF4DpuKYJ7ibp7ljupMBEEUbpg=
X-Received: by 2002:a53:ac9a:0:b0:672:f620:3554 with SMTP id
 956f58d0204a3-672f6204d15mr1449003d50.17.1790276897196; Thu, 24 Sep 2026
 12:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924162220.64876-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260924162220.64876-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Sep 2026 15:08:05 -0400
X-Gm-Features: AclHuK9px-aDaQWbb-77vBPkfIxzg4hIe4-FNruWivEP_iQ41G0qMTksQZp1lr8
Message-ID: <CAEjxPJ5sws4Z_P42Z7cVOd8smm==Wggu6HcnrrkADYAeDw7y3w@mail.gmail.com>
Subject: Re: [PATCH] python/semanage: fall back to filename completion for
 fcontext paths
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:22=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> semanage fcontext -a -t TYPE /some/pathprefix<TAB> does not
> auto-complete currently; the fcontext arm of _semanage()
> unconditionally offers the option word list for any word that isn't
> the argument to -t/-f/-S/..., and the completion is registered without
> -o default, so an empty match stays empty.
>
> Register the completion with '-o default -o bashdefault' so an empty
> COMPREPLY falls through to readline filename completion, and only
> offer the fcontext option list when the current word is empty or
> starts with '-'. The path/regex positional and the -e/--equal argument
> then get ordinary filename completion.
>
> While here, the __get_*_opts helpers echo '$ALL_OPTS $MANAGED_OPTS
> ...'  in single quotes, so the common option variables are never
> expanded and only the per-subcommand-specific flags have ever been
> offered. Switch to double quotes so -l/--list, -a/--add, -h/--help, etc
> are completed under every subcommand.
>
> Reported-by: Germano Massullo (@Germano0)
> Fixes: https://github.com/SELinuxProject/selinux/issues/278
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
