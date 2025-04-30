Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CC925A32F
	for <selinux@vger.kernel.org>; Wed, 30 Apr 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039078; cv=none; b=mPEbM04RvP+UV7EgONEv1iQupbbMP0oGtE6lNENVlzxe6TDwk5oI4MuepJkHGlWfxqUPliDl2P1ncojhfhLrAr4rqlhhq3TXKb7OdG575C8Z/1gJD8KNXJkNVl6DZCgST13DN0IPWvlIQOzOrr43Ybix6Z7P/QZYNgV7uvc+t2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039078; c=relaxed/simple;
	bh=8/3Vu1D+LVVPxV2vHCD21bHGPb43u8RgJ3L+nYHuh2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7QbUoxYiMJuAI4JgoeieCfKRsVb2i788GOZbhConQMnk3BlF8Hkg1iFqT+TTl6M3hjd2aP2W5utjqAZg1udmMHoczLMcpjg5RbgEkdakdlOrXi59CNp9iTk2RD216srDcwMt+UjtWIqQK/GSIBnHyDGg9W4mMAaJNARfHspMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M0HnFOP+; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M0HnFOP+"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e6e1cd3f1c5so159919276.0
        for <selinux@vger.kernel.org>; Wed, 30 Apr 2025 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746039074; x=1746643874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE4E6ahlqj9qOjKExuQG4V41IoSftlZFpt7HNxvcZx0=;
        b=M0HnFOP+A0airj9rqmzm8ESxWdVh2Ud3eKHFS1roLu0wyB1KEQF0gfbGtEuqhyj8WG
         Kd+IgI8aKr5T4fdDGbiqLuWKznMo8vX2iyBPdey03dHm5Wx04m7ogBQwiBM+7OvHy/S9
         Qc5MMx+7H8mLhvLqou6evNikBPCc4zsCtEQg5rt3zxrMB8abUKoslEqXcVHnuvp7SyMR
         +W9me81MdbFws3b1iKw2pJlxDrOtLBUiaAfJTAO4rEHC8lx/mp/mg6WTCxpE7TS5fHtx
         vbS3OmOSfyabBx2ps1ekwkJRp0Difgs10AJcin+NSPjKkWlFV4kVIujNDvSTzGAv7shC
         rcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746039074; x=1746643874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE4E6ahlqj9qOjKExuQG4V41IoSftlZFpt7HNxvcZx0=;
        b=lwGFlB2mqRRO0svFFvGmJDzxpbEmqKUmFCfjoZYk8YYFoL5AI26s1pFv5rL4glTlF6
         2VI4Ok3H0YAmZuHlvQNP/eJpn0Sz2LS+krCDCT85JkgKQSacyKxtgAZTrvs/AhDNsKht
         pu9YytyHo7FecZHHBTr6YWrZlDhjQhkMPikeXx866xKyR3c0OCA66qs/14feOAn1aruL
         h1ln37IjXWNtojExHijXRBUnPCQt1L5aALuzzHWh1jYlKnpldtftV9E+qRHowl04koAX
         AKF4fiwCIZeAmzhdkXkcYe18HyMw/wmj+4wtNMYrkidhbR1bLNn1SRzYzSSo9aKiNM/R
         HapA==
X-Forwarded-Encrypted: i=1; AJvYcCUkTglAW1jT8D4qXYCpwwrQ78CPvt6x8RvHUuB21lm+JXrVDPqkmtVgkOvDGT1oxmCzow7DzuIJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr3Z8OL8T3CoZ8Wov1rFIVYNaEx8oaaln8Oa0Unx8lBdYq1p4I
	xIJj8zSbgA5PSzRRT6X4Tihxeh4h7w296w2b7Db8Tpx9y755VVKZMW8Jk0daC4vJ2AXU3ND0dq7
	TC3cDu2SFpXzD1vOZHHUM+04Kfq+w9jtLgAVa
X-Gm-Gg: ASbGncvaotxbFzMbLQv1PG02PWmrc/a1cPGA87uRvuNmDDBktUFUbWupj9032UXnDEQ
	365ic8Ajo9pC+YFIXFQX8muTKqTREhmCIrw7jdwLZwwTi3ZS80hw9i1NnrcZIE+rpUeoX54MCq5
	sRWXv0fMLAsDxAT1WD98X8GA==
X-Google-Smtp-Source: AGHT+IFGVRlgUQ78u+BwGAXsh8y6G1LjqMSHEQkoG4q+UkDPQkOssWg8INldt0gpGq6aM8/J91W8xIUVPyuoHL+fi4Q=
X-Received: by 2002:a05:6902:220b:b0:e72:89ac:b7c6 with SMTP id
 3f1490d57ef6-e74f8e7fb23mr347826276.47.1746039074175; Wed, 30 Apr 2025
 11:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319222744.17576-5-casey@schaufler-ca.com>
 <0211e4c6561bf2eabbad2bf75a760e03@paul-moore.com> <c53cf38a-f159-48b8-922a-550bd21b5951@schaufler-ca.com>
In-Reply-To: <c53cf38a-f159-48b8-922a-550bd21b5951@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 Apr 2025 14:51:03 -0400
X-Gm-Features: ATxdqUFt-c_vhDhdD3LFcCyct7_rWPW5hvTca5RmMG4EeWbCJDu41dKAKTCrllk
Message-ID: <CAHC9VhTbrk_XovghLTtqPUv3br9aJbn2YcnFyn3uugTUKAHNFw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] Audit: multiple subject lsm values for netlabel
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: eparis@redhat.com, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 12:25=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 4/24/2025 3:18 PM, Paul Moore wrote:
> > On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx()=
.
> >> This is used in netlabel auditing to provide multiple subject security
> >> contexts as necessary.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/audit.h        |  7 +++++++
> >>  kernel/audit.c               | 28 +++++++++++++++++++++-------
> >>  net/netlabel/netlabel_user.c |  9 +--------
> >>  3 files changed, 29 insertions(+), 15 deletions(-)
> > Other than moving to the subject count supplied by the LSM
> > initialization patchset previously mentioned, this looks fine to me.
>
> I'm perfectly willing to switch once the LSM initialization patch set
> moves past RFC.

It's obviously your choice as to if/when you switch, but I'm trying to
let you know that acceptance into the LSM tree is going to be
dependent on that switch happening.

The initialization patchset is still very much alive, and the next
revision will not be an RFC.  I'm simply waiting on some additional
LSM specific reviews before posting the next revision so as to not
burn out people from looking at multiple iterations.  I've been told
privately by at least one LSM maintainer that reviewing the changes in
their code is on their todo list, but they have been slammed with
other work at their job and haven't had the time to look at that
patchset yet.  I realize you don't have those issues anymore, but I
suspect you are still sympathetic to those problems.

If you're really anxious to continue work on this RIGHT NOW, you can
simply base your patchset on top of the initialization patchset.  Just
make sure you mention in the cover letter what you are using as a base
for the patchset.

If that still doesn't offer any satisfaction, you can always
incorporate the feedback that I made in v2 that was ignored in your v3
posting :-P

--=20
paul-moore.com
