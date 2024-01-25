Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1CF7C080
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198950; cv=none; b=nArOpQHy0nMBam9AF70hEJUQTy/DRu84/4Vze1hZ+q+9jZTF44HR4181y3FTDRjg/A2sy5l0OJFS/w2JbF04D7jkUZnsViazYp4mRU7JkNnY+PkvfU4EgdySxZYnPT7oju4Km7zVfBuaVlQAYLyvoD+qV1rosN+lXWfMQeTU7Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198950; c=relaxed/simple;
	bh=s4Lz/7FGeBQQtJriVan7R/e0fU4M5YDFyrKWuZ0VGzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdVZK2bxB/o76h8iA/6zAYC45Cffx8nnH8UtUndmHB4y48Xkj+TYCAr5ax6pFK/GRsqnK6v82pvIH3Y2Trh0un18DFfS4BmP9Yi7CrhzuN7Vy/GgkxX72er+8j+SyY+m1ZYwj12zjBSJglMPbItrsOe9utXGaqDdyuNWeXflVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EH2EQmNq; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EH2EQmNq"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc608c3718dso1946933276.1
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 08:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706198947; x=1706803747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD/r0uWbNZgJgJ6cYKOc4BCZAT0s04XhH9xFaYpEDbk=;
        b=EH2EQmNq3prhlBoZmtjkYy+dAnlclgzXxqrTt1cZkFxMTl+WH+GtS7iUov3c+05szI
         aB3gE62MFU6V8F5CqF8vERrDmddAM0v4rt/o6GWx3KFT8vSNizT2pom26q1ebAyn4krj
         6AiGfGAI3b29D6VKUQ1zbijqvW+aViLoDb+FJldtj/uS1POu1q5UJwDqZpufIN7MhdbA
         QK8ZrlTPhRVtPG9GWOFcsSSrsCLNXa6zF/zJvibEQiHmLUPtllr8fEdqtqnvNEvZU4xn
         EiHNQmKCiM5AB2RqPnf8D7jWkwej4A4nsMPPar0TOphh/gHPWMKccrl6PRJreeLqJYS0
         7+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706198947; x=1706803747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iD/r0uWbNZgJgJ6cYKOc4BCZAT0s04XhH9xFaYpEDbk=;
        b=kZ+gDHm3OhPSyVz4LhvLIyDYjqjqXU7ascnKmXg1J3mZMfxWf958AHMZEPH3McvkTz
         VSIKCyu1NJ4fU7rfzegNNO/A6e1rb1zAX5q9q65ArlPIKWf0IZL1ekzEa2moNtHTA+e/
         tZ1xu3zqkoY3BJb626cm7SqL759YXxWnJlMP6hhfHYKWwfJmlpcb6TKzKuiL9eTUGnvE
         XGJrEFj6j0Ctr+K6H1kzyy5JWCu7bH4U4AgccXGut0AgVhQ5PNnW6KOOzmApNnpdXkLU
         KbuATGFZ6aSIdcgNbxOaQ/7OQF71J2OFrnXhzEjBBw6iAsXZCIBkOWY/XwGyOjObMFXz
         Tdow==
X-Gm-Message-State: AOJu0YwAxEluAqUgT6FJTEw5lQCPmJB/U1HS7ryAF7nqW8wlc7pBrNvy
	UU+T/N4Oz6zPfD0PwT1SmXLPVYLcWz6t3gK7E9sm2lx7AwqGNoW2veb/rgBC7mvhcjbBZ3Ecyf8
	SQwFwuwV+q1dJuhkzsOak3JSmVvow7si5lOjfrZlO/3llMkk=
X-Google-Smtp-Source: AGHT+IGwkmlcT10pTLuPxc16LvADsNL+DsHH60D00tpYkTWkTyjtJEHHEdwSyV++1dT0nGVr3xpNFbPAdib47HFlCwU=
X-Received: by 2002:a25:e04e:0:b0:dc3:18dc:71ed with SMTP id
 x75-20020a25e04e000000b00dc318dc71edmr27454ybg.103.1706198947659; Thu, 25 Jan
 2024 08:09:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
 <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
 <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com>
 <CAEjxPJ4czKz+4SfTo6g3s6ztSRbfyOv_GBkgp=k38nGDFssRiw@mail.gmail.com>
 <CAEjxPJ5_SQDmR9b-+0woBLg25omtERSLBKawTV9AqLpZAHFvcg@mail.gmail.com>
 <CAHC9VhT_zOjJpg-JOaJQ4s9ybArfq2Ez_OiFAk0siPiqEC0KiQ@mail.gmail.com>
 <CAFqZXNvSn-Ct04ghSxiceKkRBgfyUeWJc3J0tjnU-Mm8mfPtAg@mail.gmail.com>
 <CAHC9VhQ4hopKwh6y=M2kZfgM=cdcWvqAbGAD9HMRhDDj88R_xw@mail.gmail.com>
 <CAEjxPJ4LvVr8w3bPLXrB7Aw=RS=CVnVwH0q7egQTP+F1Qzq1jw@mail.gmail.com> <CAEjxPJ4FxSe2RqLbnN0brsj32LspZ2Gh6r4GPWixv==X3X0oag@mail.gmail.com>
In-Reply-To: <CAEjxPJ4FxSe2RqLbnN0brsj32LspZ2Gh6r4GPWixv==X3X0oag@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jan 2024 11:08:56 -0500
Message-ID: <CAHC9VhRTfUO_b+dfWRNtFBPUCnk5iRCkCfT4PcNBt+b856t-iw@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> So as a side-bar is anyone running ./tools/nfs.sh on a regular basis
> or has it been wired up into the automated testing by anyone? If not
> and if we can get it back to a clean state, that would be good to do.

I am not as part of my kernel-secnext testing, I should, but I haven't
had the time to configure that as part of the test run.  Building and
testing on Debian in addition to Fedora is still higher on my
kernel-secnext todo list, and I haven't made much progress there.

I believe the IBM/RH folks are doing regular testing, perhaps they
have something in place?

--=20
paul-moore.com
