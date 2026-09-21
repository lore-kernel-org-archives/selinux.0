Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE7485CE6
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993641; cv=pass; b=B04eJv1o9wTTqhl9aKPkgdti6Dh0HxMzCyf4r34bohrOJrU39Tn4dVYkB/hYPuPbfszMTZD0kcMPCFVZZzRQtITGgUdyDVX8Ar9a5t2I+UUw/hQZhlhCCWfadvLijRf0XomlvgAYhLyggI0CiwCpR6bdGyQZcsDFlPgOg/3FSE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993641; c=relaxed/simple;
	bh=NtroXJdAF6ZytNsc1ONp85WWnsLRTg6TPwZlEs5IeAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dy6hLzk8f/8Qz8s+twxMlvem4DjFuIftjpm8GcR85/NWexHQv4hMjr07peSyNuHugT+kPhrpVaaZRwwagqCXrgatoEe733Nd2fTvsG4ovB2P3Ei8kAezP3vysHTQoWZhMEMkOv4so4L7n1s7TaPSos7YQypQxAcCb21Op986GvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l553UOR5; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l553UOR5"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43db0c16so20586447b3.1
        for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 05:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789993639; cv=none;
        d=google.com; s=arc-20260327;
        b=bKRfjCxbD9f2QuKbtPir6/CMgKJLzw9wSPyQRHl5mnAmY9RAOBH6333aAMak6k7fxt
         /UaratOW10V+bqjDb5SicBWizMjS2C9pzLlCaU081NcB1lKQxq2LcNkJvpwWa/rqwGxE
         Vl3qG6JQ5jH9OOCAGBkOwaHCWYakgYaD9Q9yOY1jehXpQCttzazyx/SLu+EnIy5tiJK9
         o7xlwa0UV+TJElMUUXc8NDNKChH/Gs+H5bZGFLaq3mNfGB/7VdG2nTaK7lYCMFY5J31w
         5kjlVw/Z/BoWoKKxpCoXdtrT0Xu4mMDPmbhgGvWVFiFmAywjF4QPvVpSc8uQ2hKMzDwa
         UUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NtroXJdAF6ZytNsc1ONp85WWnsLRTg6TPwZlEs5IeAA=;
        fh=KcNbqYfh5/rp+3O/oy/Rn1Jlbpp64wJ640nU1xb/jaw=;
        b=hzGQxz80iN8g3dTSD30HVmdaxxAyg5boflBziUT3QmL0b4sLrfHMvx9HwHl8EnPlgp
         myF3TsRGyjvlOMa3WOSrDG16SFhztoWZnSubaEUWawyim+Zg9IRlqsQRwzscDW3Zmcha
         LjkNlmvlaOXUnaqdLaIxX1NjfPPqkQw01rjWye2CB/ll0hO44qpVBdORy1Bzj4VGBwRj
         8d1hp/pW1K3mVXl6GSjfKUVq3NlSV5yJkO785FaaoN5/tTWuKMRVlUS37uH5K+AMmhCT
         E2J7wZkz0sZVgYLgESbeIDqUqEdttWviXzDtjvt/fedODtVD1F4SELo0uzzkfB0hryUu
         3ZhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789993639; x=1790598439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NtroXJdAF6ZytNsc1ONp85WWnsLRTg6TPwZlEs5IeAA=;
        b=l553UOR58X0CTE0hCCGHtXKVlyXTbSaZ7O/yX/Mb02ynza1YDCk6MlSTqZxZv6zNww
         jQSygMKjUgfsfz8vfpKWCSADcJ8b5qC56sQELRfEDVUPPMia8szfS505HXCcJ1wr32Uy
         EAbzM/stzNZoTsUTpef1H2rylNyVxViuxqxA/k5K1Meude4k5ThZSfmra2dppK4D9scO
         etBpQJu47wovOBgx4LPtbzapvwfSbrSsJ+ZlFcoKzOAenAWMXw2YhNVyYHEnDj+pnpFz
         hALfUyfMlvMUt5eVbZYiGYBSB7u8A5co/YMM2JqD+KYsofjTY0xCUYYds62tAJqxn0Nt
         JZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789993639; x=1790598439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NtroXJdAF6ZytNsc1ONp85WWnsLRTg6TPwZlEs5IeAA=;
        b=Dx6vT2C6u1b+WksO9MQHJmBMHPXOKGqnZS19mO35pi4yTk/wG1PUa5yrVSY2+ZvTDP
         TQfHrf5oWXljkL1+UMgyAjngLtcbgwHczSQBMISWhzbZF3Mz38UM1E84vP6GhH3ehvda
         KM6eOXKH0Wu/s0iAsNxSG72owAKMgJkGJJlp/dJ2q8zN+ohe3x2ycPcJtJbOAwDmmayr
         xpLGRlk5gvFf0irGfRrLbEWMcWD16XTFQqE15FOmih7fGSFvQUBV+/jJq4ehNQPMQlJb
         PPaCPi8bjNU6icsZnDl2wHRwjg7bcBAVah6FC0J9Pa68r8YKQBVKLJA/F5Q+vkP7H3KC
         NoRA==
X-Gm-Message-State: AFuF++mfpvnjcazoS3E53eUjU/DCG0KvkXHeIWTDl1GvPthAmfofhkFy
	kSNhGzwfHN80ih219Uf8DNhyJuEH22Q0S/PCgB9xD2BPNsG4KthjBAgbUHRbDiSaVY4ghW5ClCc
	gs3+OY1/267uY7v/U1MyV1SWcMK//CjWlnA==
X-Gm-Gg: AYBFou1XMvYauSKHACtlwpkhz8oOEwo2FXGGyBCbHdoIBquBLt1DUL4QvOro/lqPti9
	nkTEGyt0r3MsemR3OK6h9yiT8k3ZSLO+O/bhlzyVOExTISYLywKTOWTXTXTA4EfuIaolk9eeXCS
	SAD2CiahsXeUZ8s64kNQ8p4dU9DpQmnB7tbUx1YBw3lXSJUckNV6fkx6bwTFr2vHPxHrCOQuGKT
	YYZ5tZz8c7XYtXi8CL66UhLxvkKLfAlLSqLoDCNdMSQLRJvieZgrWfppV2327Y0uQE1/JlmO3eB
	5xgsjwa5v5yQNU4OdvNixOg1P3rUnGWpTc8R92OpkwfGNdR9zH+g3so=
X-Received: by 2002:a05:690c:c50e:b0:886:8c4d:2189 with SMTP id
 00721157ae682-8973266df6dmr30711407b3.8.1789993639343; Mon, 21 Sep 2026
 05:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918192636.32626-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260918192636.32626-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 21 Sep 2026 08:27:08 -0400
X-Gm-Features: AcwNN1WWIddOX22GztUbrDo4-O5sY4CjZ_Mbq1wWKSo19qmLk4lgUjmSNrIjZws
Message-ID: <CAEjxPJ4J9g0ZtJCJadXx5PHuM4Sqc2tDAPV5fYWWE39sRjr7OA@mail.gmail.com>
Subject: Re: [PATCH v2] policycoreutils/scripts/fixfiles: pass -I/-D through
 to setfiles/restorecon
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 3:28=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> setfiles/restorecon -D enables per-directory security.sehash digest
> tracking (skip a subtree whose stored digest matches the current
> file_contexts) and -I forces the walk anyway while refreshing the
> digests. As noted by issue #44, fixfiles has no way to reach either.
>
> Add -I and -D to fixfiles and pass whichever is set as ${DIGESTFLAG}
> to every setfiles/restorecon invocation, export it into the unshare -m
> subshell used with -M, and record it in /.autorelabel for onboot. -I
> wins over -D (setfiles -I already implies -D).
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/44
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes a typo in the description.

This patch has been merged.
