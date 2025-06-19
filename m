Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA6226545
	for <selinux@vger.kernel.org>; Thu, 19 Jun 2025 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750303425; cv=none; b=ALeBmVIm+veJXZ6uaFZ2vOv298pq53zE2kl/00c+EQAiETIzmKFUmixagyU1WGSuSoSQUw5HkFCQRt8iuX0i1biS25fIR/S8DYA+3PZD/8Ipch4LpsBMuMLq1TO4YFJF5jwAqZB0kMKmmZxHmpIOocuJB5VlTzwTWe1zShC303o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750303425; c=relaxed/simple;
	bh=nbuySolPRrKrb/6LuT5vebnUQjPFVCtq1MS/A8Kd8hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n119TFx9VMAVuct45bzrRTALL4SKUZpcwjFZEh59HfEBB/SYcWFg6NWJJkRZSdrE2r2S3l9xDfiK2C0vx+Sx+nTuuJofX92U5Hd/mZLYo+rmCyFxpi+kQI7skO84LWGQD2HE6PxYOxaGMwDOeeHQzbsBfPs2Qa2paIJo1TXqo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EsbS84FS; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EsbS84FS"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-710fe491842so3487307b3.0
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 20:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750303422; x=1750908222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iJFw3hcoXsGe4DbyON26AXsapbrXOUsJDzr8Kus6pk=;
        b=EsbS84FSKxXZnHZQXjCF+6Upv9EOpcGFcTUVOLCtnKH5Wmutvrxzybfqf1BNSbyKRm
         5s88hw90IYwGLcY01H/gkeGrLadMET9j9VwTMUVRM0F4eVYvD/h70qg+PuW4QXugdAvQ
         ABTg6Bg2fAVdWUVMQDbOsQ9lAyIy5DeJ7+fsrIahKP3cSxAbbO82X1BdcUVUwBk8M1cS
         3g7MAb52YZEhjLEhRNQcH4poe29H4oBnIoelr+iWJJZv6li/BPxAwNKnheUo69bAqGIU
         IFioyFhn8wDKVL5dMd5jAZ6xRzB28wMB9uY0MfjivMAo6qTsn4xYtYf9/OdCevxqCO5n
         Fcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750303422; x=1750908222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iJFw3hcoXsGe4DbyON26AXsapbrXOUsJDzr8Kus6pk=;
        b=Eo/ZvWJcJpFpC0RL6HPvTul2v1vH04YW046SlZtlNJ5q5/BjpbxnR4heM7m3wogfBi
         bNO8LNi9ECgKX4ycCf4pr9rSyJrZUcA5UV+ro9Ajvop4/hbRBpJFTZrAL+po2UrQa+AC
         kOSykOuq5RQZAo2DcCQHR+d19unjXc0wpPVB5QyTGj3OJwL7u4s/MZaXtLTQTJKlsTD5
         x9G4H1xAr/gX77aAui0B4BLYmvPDKW0TCaQdUQpYvBuvxOIiBs/L038DYU2ha8AkP0EH
         fVlUMwqmM2QPlAE/JkZKY+JSyx7SIZLMAKh+Jfq/AHdNOfgKvJTVGgANDfX+NAcukHOr
         61TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHLJOgfUvFrxNI5s4rqP+dMBD02HOfUKwWQxnv9nWGos9nICJ9PL2RmE6TrzqMoRjrKu3XNoxB@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMaE1+O6PBjve5tYgFJLo8Hg0wvvPQkJiqIFyr8TYUDYBLZL0
	9ssO1Drq+93bH1hPaMYjfshmEoSfogoE0EDTAwrECPZkCWTAVsA12rueU3+t9DKT4TdmY+WcLw0
	nj9rha02sp9bsL1JhyewdluoQ9/Twd1VWV3BC+ZBx
X-Gm-Gg: ASbGncugXgRCxhx8dZCDvtiprryMoEG6xPxPt5ZT5aXZJ1p4II+/Nut2nIgrrVlyiXX
	KiqSZQY8XG5SBXcyFl9iI1hNJXNLplAGiYk4mw3smeAfa/PMjDr2e8r6fcFJUHABDhukhbZppmb
	RT7osvy69l6f1hFPTzs+69cPz+3ZTLaSt53oRcMBuEYmE=
X-Google-Smtp-Source: AGHT+IGcN/556LS+CfAEL1VYzf1syP51qd2XAQEDn5URamBiRo8ZdesoI3xzet3HROXiTs7jECSzpEiJz/1uPLWWuek=
X-Received: by 2002:a05:690c:6886:b0:6fb:ae6b:a340 with SMTP id
 00721157ae682-71175456e3bmr301614567b3.30.1750303422334; Wed, 18 Jun 2025
 20:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1976e40bd50.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com> <20250614204044.2190213-1-kuni1840@gmail.com>
In-Reply-To: <20250614204044.2190213-1-kuni1840@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Jun 2025 23:23:31 -0400
X-Gm-Features: Ac12FXxwFQ9XrzTaZ4vv6beLeYr34oLYlm8Lv3ct4ijMlJ9Ogo8mnNb8EPo9mo0
Message-ID: <CAHC9VhRWi5QdRgU-Eko4XZ9A2W2o3uhVAagVkhu1eT18qAWdkg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] af_unix: Allow BPF LSM to filter
 SCM_RIGHTS at sendmsg().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	casey@schaufler-ca.com, daniel@iogearbox.net, eddyz87@gmail.com, 
	gnoack@google.com, haoluo@google.com, jmorris@namei.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuniyu@google.com, linux-security-module@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mic@digikod.net, 
	netdev@vger.kernel.org, omosnace@redhat.com, sdf@fomichev.me, 
	selinux@vger.kernel.org, serge@hallyn.com, song@kernel.org, 
	stephen.smalley.work@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 4:40=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Sat, 14 Jun 2025 07:43:46 -0400
> > On June 13, 2025 6:24:15 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrot=
e:
> > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > >
> > > Since commit 77cbe1a6d873 ("af_unix: Introduce SO_PASSRIGHTS."),
> > > we can disable SCM_RIGHTS per socket, but it's not flexible.
> > >
> > > This series allows us to implement more fine-grained filtering for
> > > SCM_RIGHTS with BPF LSM.
> >
> > My ability to review this over the weekend is limited due to device and
> > network access, but I'll take a look next week.
> >
> > That said, it would be good if you could clarify the "filtering" aspect=
 of
> > your comments; it may be obvious when I'm able to look at the full patc=
hset
>
> I meant to mention that just below the quoted part :)
>
> ---8<---
> Changes:
>   v2: Remove SCM_RIGHTS fd scrubbing functionality
> ---8<---

Thanks :)

While looking at your patches tonight, I was wondering if you had ever
considered adding a new LSM hook to __scm_send() that specifically
targets SCM_RIGHTS?  I was thinking of something like this:

diff --git a/net/core/scm.c b/net/core/scm.c
index 0225bd94170f..5fec8abc99f5 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -173,6 +173,9 @@ int __scm_send(struct socket *sock, struct msghdr *msg,=
 stru
ct scm_cookie *p)
               case SCM_RIGHTS:
                       if (!ops || ops->family !=3D PF_UNIX)
                               goto error;
+                       err =3D security_sock_scm_rights(sock);
+                       if (err<0)
+                               goto error;
                       err=3Dscm_fp_copy(cmsg, &p->fp);
                       if (err<0)
                               goto error;

... if I'm correct in my understanding of what you are trying to
accomplish, I believe this should allow you to meet your goals with a
much simpler and targeted approach.  Or am I thinking about this
wrong?

--=20
paul-moore.com
