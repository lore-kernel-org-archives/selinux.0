Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729827BF7F
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338518; cv=none; b=rbTa2rIm81wW2U/VPfIGHFI1oWcNzPoPOiFZE0Qwa4ZpfUVO2XEi0LcDLO5GwKK384c+lRXOSwvPsMWd1OBDRKH4ujDwmSZOV9p26Et+dNL6iW0qpJ+zxWS1a8EgkKOezUf56TXauP1yyvZpOy2BHXDRcjlrBCj2Az7hsSGiKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338518; c=relaxed/simple;
	bh=icjBLFY56UHJrggxVGEqEhmJgnElvi6Hulw/BacZfJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n21dXRBm0kBBj3RmZDRSJlPrMiDLMMrNI+329X1gohiHPgyBAljpMGrQFldPYVEZk1lobdlMYp3lr/3jfhZtx+nme8GRfUKyQrzPo26zqCT0AQH03iOWFoS+q1gHzSxhWup4ZbpPkvrUJ8vNg5I4BBq8ZAAe+youS2c7IYxpv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eMmAg41s; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eMmAg41s"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e702cffe574so1224685276.3
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 19:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744338516; x=1744943316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZEtF/pCU0xjSpnJWvxPICK3BcguIOKOxPbIc47ziq8=;
        b=eMmAg41sE9oc3tkTSqCSfNC7pNmyBAGLZvMWUkLbnDP6l5O//v75Cv5SckX+Fbjcql
         A5tdLcDPdbq9lop0N6Z3eKYtfHaXvEduAbf38G9vu9OgD1CdinpG0qnt29/MULMI6tdU
         tKvgRPZbfLq674HXX3ecTwLzhFhn5z1e3/mI9BHMEQxzR+IoSK6iVNtmOrTN/HNNJjLF
         Pqpmq1NRLDyoiJbH3XFOiN8XpHeCS/Vch0iBxKRTuawWNuvfPSkVSodHRa1aN3FxOS4c
         hn9nOQ3T2POWeqreiDq4QsplZOrY3ymQ+dTg5PcITzOrA4HkW0wKcOryQLawuZA+TCOh
         BagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744338516; x=1744943316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZEtF/pCU0xjSpnJWvxPICK3BcguIOKOxPbIc47ziq8=;
        b=j+AE0hYJ6//IzIaTFHI5IgrIzXy2K+letttAxpoTIxQPY8ytxTPbMGgsTridvVUZmX
         DhKRyfrH/cKSsdSO10JQfi7Z3fLtX9nXCghh/k/6DAuDutOjtmfYUP/0Kf3MMBAelPwF
         V/TETYh2gqvcd4CsmOZTk6kCX1fb2kF1XbJon4Iyr97nNKOCQ4kDYHTyxcb+vv/ywmsA
         haNQugvS/xCTMwCiPENOwZzPamgpeeInoHH8epy89zTxraziQXWO9TS8Kac/sFlfYy4D
         2S/FOmKYhg+BqR0IdHGgKyO7oj/8+QUCS3dUcS729XHPWEoE63W8HlaEEuje5Lk4Jj/4
         1qMA==
X-Forwarded-Encrypted: i=1; AJvYcCWBZ0/M2A9WkLtu8goaSVbzGrBKFLtRyZRShUEvGBRTezytLIamN+3jTdmibMdcQ3PF18YaE+m6@vger.kernel.org
X-Gm-Message-State: AOJu0YxokKq02ARo2cpr10W/YYA8Vy7kQQwGyWph05zSkDycK03EXc1O
	PBxVMTTadS672ZjuZRcJVsoOKAWXVhKMFrmgRc0l6uX+8UoCjm78dARK7Pdye2G+zeo+v7kT5Pz
	S8DMufq7rNGWuLFL9cYB8WvF0eDLtJnZnvwfdhbqqJ8nCZA8=
X-Gm-Gg: ASbGncsMzRCcpl83xq3AcDCkx5elMCcGH3T6HZ3hcNdQH9o4Zxem4M+8e9LjaiYfTzL
	8TQFRZvUwhA+1FYoUbLVVToNSuV9EDgJwAKB85xfkjz2Ul/cN8tzi0wOmyqrSgyLTuoxjvz4ZCj
	fdigEXzTZzHtzA4RDQeiXC36P+Btoix1EB
X-Google-Smtp-Source: AGHT+IFdWXV2emA43f6xmM+9Cj7EAvrjlWdR0Rugh3hZ9aV3RgG2k+YBMLUiynWoHmvvgOrlv02InaGJ/HXSr/8W4tA=
X-Received: by 2002:a05:6902:1b8a:b0:e6e:195d:406b with SMTP id
 3f1490d57ef6-e704df6d71cmr2252687276.28.1744338516006; Thu, 10 Apr 2025
 19:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <1c13537f-b088-464c-87ee-3e81fb909f92@schaufler-ca.com>
In-Reply-To: <1c13537f-b088-464c-87ee-3e81fb909f92@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 22:28:24 -0400
X-Gm-Features: ATxdqUH4GZXGi9EZedguqE9quan7dOI0mPbGtxlvbQ_Q1bZXzlWCNGq98rj3Gx4
Message-ID: <CAHC9VhQznX3GphP6X47Mr7ZsD9c=UnmrZPrspsFY0+v4uu2vNg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/29] Rework the LSM initialization
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:13=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 4/9/2025 11:49 AM, Paul Moore wrote:

...

> General comments:
>
> Adjacent patches with no more commit message than "cleanup" should
> be combined, as that message is telling me "these aren't the changes
> you're looking for".

Things have been shuffled around quite a bit since this posting, and I
expect there will likely be a few more adjustments before a v2 is
posted.

> And about that. I believe that missing or uninformative commit messages
> are on your list of things that displease you. You will need to improve
> them to get them past yourself. :)

You'll notice that I highlighted the garbage commit messages in the
list of things that made this a RFC patch.  I'm well aware that this
is a big problem in this patchset, but I know there are individuals on
the LSM mailing list who have been anxiously awaiting a peek at this
work, so I made a decision to post a very crude revision to satisfy
that curiosity.  If you can't appreciate that decision, I hope that
you can at least understand it ;)

While I hope to never post a proper (read "non RFC") patchset with
such trash for commit messages, if I do, I would hope and expect that
all of you wouldn't hesitate to chastise me!

> There's a lot of churn here due to unnecessary name changes. I can't
> say they're unjustified, but the patch set is bigger than it needs to
> be, and more disruptive.

Perhaps, but there was some pretty awful code, with some pretty awful
names, in the initialization routines and if I was going to spend the
time to clean it all up I felt the renames were justified.  If I'm
ever going to pull a "maintainer's privilege" card, it would probably
be over stuff like this; I know it's trivial, and churns the code, but
I can't tell you how much it bothers me when I keep reading/reviewing
code with awful names.  That's probably why one of my chief nitpicks
with a lot of patches comes back to naming.

> I haven't tested it, but I don't see any substantial problems so far.

I appreciate the review, I know it's not an easy patchset to look at.
The next revision should be cleaner.

--=20
paul-moore.com
