Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794324961;
	b=If7NVeXll5pVTGbsglA04oypVOM9w/Woi08Z9PNdf0dupt7u8Kh2R7VHD1e0BeZ5Q60w
	 YLYfd5zZgpPnQY7PnoGCxTMzjvE1ifZz+U0+BBRNVDBO8dA0XYIes+n6vyCK1yXNSfcZP
	 kbinRIHh/manFt/yVwNciaW5cZSOFQNy9ZsC8hlXs/9JyGwiDB4peV/fphIRGh1SwqlIM
	 XGJOCSiwcEMMbtQEcl4l0DTuvs+9Fo7/ay7PTa/iTwTvB5evvB5UX1xQK69UO0hBS1TrG
	 4TbK7hmv8vN8mENJQm0waDuQhQtziP26bQt4FtTg6+hR+lCK0Zrg7xvKnwyYzsN1/nQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7/dL633gU9pIAb5KV4i72n6S4H4LKkqe3A0a8gUulTM=;
	b=tskeJHafrQ5RFNGorAJ56wucsNx/5RNJyhk9/PWep5OobtytJUKW9nz5ermjRkiIqKRO
	 j3zXBGc1kuFWaazc3XC+qNkGHvFuRCMBx7+TmGXXboCFsq4ry6oSvKzIl1t6XytodXxYv
	 dfBUJ9vtr29/qHCfoYSIO51LWl1OZ1cdX8p2bnz9wNifp2jxFyYL8/rYyZYRQ4XtblK84
	 vDfN6NCn4eE5ny7UErw/rnoxud6lwowxDOuQSxVMubQI0rz467ZtjIw151oNocm/1C3VA
	 FripUlB+efWSagqUDT/cT0hIXR3YBV3zwrDVezB2ZOOvNXk3OUXvDl3BUY9HnlfBLWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="C0b2/jOh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A387B606A326
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 15:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A387B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0b2/jOh
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6798af41644so1777810d50.2
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 07:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794324960; cv=none;
        d=google.com; s=arc-20260327;
        b=rpH8sUDEREULupoEGGBSStK5nZMqiG/UgfgvIAZ8we6b/Fcw9cMqaYsAt/PsrezXPp
         xecX3VQlQQHcO34qOW5EAx7ucj6aYWZJ5DeIuR3IIuBUU1fsXzWbqrOEeHGGoaas1DW7
         PVcy7y6dHgHKkaufCaFiJK+/ObubnwmJNHNkSRBG4jYVFq141+8FiH4/5grznAP29sWY
         dkhGTAri9Xz89tTaWaztBBaWrMzR5g/Qln6WfrLW4V2+0HF7jNtB4/v/iONzJ1GhYEBS
         egMYWDYDz/oMWjhV9KOMRsW1GhzpucDgf9twFEstdp5DWq9oMOdSrdXuUO9W22dgcn4w
         fxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7/dL633gU9pIAb5KV4i72n6S4H4LKkqe3A0a8gUulTM=;
        fh=lhf5QyCa6WDp2ZvLiEKChBxN94jgvuHJeEuS0nTTqOQ=;
        b=J2YiWXDZ4dXFcj2kgYnIx8M4+ise1XJaVe7S2FadQXPqMSwT1zVVnLZYJVpBjXSqEV
         QwTLGhYC4vtIsQcLbQ25C1GWofB2ZdAomruaV+Sd+IqUif2MDWd6CvLx6Ai31KPL3s6O
         3Az7J1Lk4Z7nfY5BED3Xjz0M2jkQ+AumVSIdMhDhCPb8sWh0XqMQ2Dz/+UJKdQ4ACuEa
         VJgzV7cksazqMjIuzC5dmBzxe0x2s8pczXnqUjUmKhVVJRaeb+Wmz3eTgTz3nengIetv
         PefBhTAkPLQ9hgwDnQA5ppen9D0YHyH8VwShSBLZPrTGI0+ZslHHxXnWE0nOpwM8XVG0
         TQlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794324960; x=1794929760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7/dL633gU9pIAb5KV4i72n6S4H4LKkqe3A0a8gUulTM=;
        b=C0b2/jOhHCQhLU0HPLo28wTF/A4hUUwe5nuPjm1MCJF/9+1XobGxR0NwFuUdeeA/3q
         AUkWOxGE/VnRP9NerWiQ01W6PI/zRpJpQ/Ptrye1Oh50gvsXI0IQw24svCkOR2ftNPbD
         F+EiYp8RbSPxuil9HrYsf3tMcPF+/MfHB0MlHSOZLioN9xBGScYmkdMqASHqjCCSd4Qx
         YFTurw0E4L+9i4ipnT/vSxx2wcZCY6vMCr9dwehOFJyH6BjEeEG772C/VPMRja8vdOGR
         54w1pzPAh+mCd55AvMW/u6tWIHBlovkMp9WlB67TM4TVmlP2UwqWIqkOJaQu1NJFH63M
         T+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324960; x=1794929760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7/dL633gU9pIAb5KV4i72n6S4H4LKkqe3A0a8gUulTM=;
        b=oVV3QUsBlbGwX+TzI7qtufXE2Uk7vzFj8kuisbKICHiaPkvCRfvv4oR/+/33C1Cq/5
         O+Oj2vs56p+pITGrWluQVvabaA5/VIbigTGLFM/PDD0i0+HjZ5leNFpeJvaU6Q2FjRxY
         AQT8VYkVdeYobCykUqUkVNMIk3e5hbsalgICnPOoyS7EyyTWo65I+JcwT4QQi7bdW2Ex
         N/jF3lOWvaMIpY10tN0gZ+WaCKeQvZPkB40kRyTGiwV4wpqlyBjdF4c6jfLapYjyWY6n
         pKez7Oc7jKpLd/HwKo+6/+6q7UfKQ9zZQlNeFOUIY2o1M7SwQTMhdB9WPkVWCztt32x/
         LVzg==
X-Forwarded-Encrypted: i=1; AL+hErEdga9MsIAfvErd57stw8TSnuCFe1673B8ETqpbQkYRBIPhuG04I/p18hTWxJ5fr879zFsVhhLM@vger.kernel.org
X-Gm-Message-State: APuU4Z/RIeN0VWyL4XsM43Fqb/8vmvHoG2LPOHe2ozTeSOgw+86msZFk
	0VWH1TG10j0Wswozr7UZU3U5xi2zOeOfXH79BXCYg67P4Tl/DHfPMz0xU0CdxUjc5gGsuIkCr91
	EUN514qLYodRuwouAlU3I7ftAFYWuO7I=
X-Gm-Gg: AYBFou2FnFVm1d/cKrNgh0vcUBdWhyLsmBW/kYTTbomQKcaY/6e/Zwp9zOBALqDeFaF
	WaJwyKhgOIVDc7q1ji9kCi7vkCpKAjTdvTfhajHCWYgIncVwvRiK0ISdIezG9xk2jrLSCCv0htl
	A23xo/83uWIHwVe/EvuikApQ/2SYmxR82CDWfEeiP/tNk40EniExukaBcPl+dJeDETlykcti79S
	enPM1/SnJJBWrwrhDNAhF0AjesRVpym0d9WHm1M4DzQzYGJWFPlaa5Z+U3k+YbiBsKYdAYZS78o
	YyC/tW4+aH+P2cGhWIq4N+HmHF1kzlffxC/jOP2dWHmxL0XIfeEUxfUHRbUhXXX+WdPVFXbSeJx
	nHctjKqpdfyR8IsF1mTcegAWOuvealzk9FcDkQy8hhtIfxXYb28ihu5MEbAXzmXg1ui+5eRVXnl
	zjkrV3vPayjEMF6zxZuxz38K8TDhYPOzG2vrBV2Woe/QD3nATGL3PoHubdjA==
X-Received: by 2002:a05:690e:1206:b0:67c:1d44:7887 with SMTP id
 956f58d0204a3-67c5643601emr1815642d50.13.1794324959329; Tue, 10 Nov 2026
 07:35:59 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAAUqJDt1pXQ2KVBvMoMiDrzz8ishonqhQ0nnQLEppot4nmv9Bw@mail.gmail.com>
 <2026101814-strut-endnote-a0b5@gregkh> <atYj06gmgCa40q6T@google.com>
 <CAEjxPJ4zV-YE9vRJ0=DgjuQY5gjXwRa8hcd0KpgVtyK_9AM+oA@mail.gmail.com> <CAHC9VhTzV-6FbwCimrdUHuyvVhmUfzwL8PtydKx7Xq3Jkp5mmw@mail.gmail.com>
In-Reply-To: <CAHC9VhTzV-6FbwCimrdUHuyvVhmUfzwL8PtydKx7Xq3Jkp5mmw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Nov 2026 10:35:47 -0500
X-Gm-Features: AclHuK-QtaUGpHT8dJnVLLwqsnwfmgjvLZ9HoyrzUVY6mTTya84Y2fYg1AAygIU
Message-ID: <CAEjxPJ5nfVfK+Ko4fp+4k-gWkx3dO87HkXs-jnMV14Zjquds5A@mail.gmail.com>
Subject: Re: BUG: selinux-testsuite binder tests fail with CONFIG_ANDROID_BINDER_IPC_RUST=y
To: Paul Moore <paul@paul-moore.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Carlos Llamas <cmllamas@google.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 7:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, Oct 19, 2026 at 2:33=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Oct 19, 2026 at 12:58=E2=80=AFPM Alice Ryhl <aliceryhl@google.c=
om> wrote:
> > > On Sun, Oct 18, 2026 at 06:53:49PM +0200, Greg Kroah-Hartman wrote:
> > > > On Sun, Oct 18, 2026 at 06:36:04PM +0200, Ondrej Mosn=C3=A1=C4=8Dek=
 wrote:
> > > > > Hello Android binder maintainers,
> > > > >
> > > > > Fedora Linux has recently enabled CONFIG_ANDROID_BINDER_IPC_RUST =
[1],
> > > > > which turns out to cause the binder tests of selinux-testsuite [2=
] to
> > > > > fail.
> > > > >
> > > > > Minimal reproducer (no SELinux involved):
> > > > > # git clone https://github.com/SELinuxProject/selinux-testsuite
> > > > > # cd selinux-testsuite/tests/binder
> > > > > # make
> > > > > # ./init_binder.sh
> > > > > # setenforce 0   ### <-- may be needed if SELinux is enabled
> > > > > # ./manager -n &
> > > > > # sleep 1
> > > > > # ./service_provider -n &
> > > > > # sleep 1
> > > > > # ./client -n -c -r 3
> > > > > Client ioctl BINDER_WRITE_READ error: Invalid argument
> > > > > #
> > > > >
> > > > > With only CONFIG_ANDROID_BINDER_IPC=3Dy the last command succeeds=
.
> > > > >
> > > > > The issue reproduces even on a kernel compiled from commit
> > > > > eafedbc7c050, so it seems to date back to the origin of the Rust
> > > > > implementation. I'm not sure if it's a bug in the new kernel code=
 or
> > > > > some bug/wrong assumption in the testsuite code - can you please =
look
> > > > > into it?
> > > >
> > > > Given that the "real" binder client works, perhaps the test is wron=
g and
> > > > should be fixed?
> > >
> > > Apparently there is a divergence of behavior if the SELinux permissio=
n
> > > `binder { impersonate }` is granted to a process, though Android neve=
r
> > > uses this permission anywhere.
> > >
> > > Thanks for the report.
> >
> > I would treat Android as authoritative here and fix the
> > selinux-testsuite to match unless you think there is an actual bug in
> > the Rust driver.
> > We originally implemented the binder impersonate check just to make
> > sure no one ever impersonated a different sender without us noticing.
>
> Unless someone knows of any other widespread Binder users, I tend to
> agree with Stephen that we should treat Android as the standard at the
> present time.  I may have missed it, but has anyone posted a fix for
> the test?  We're at -rc1 now and we really should get the test fixed
> soon ...

I have now posted a fix for the selinux-testsuite at:
https://lore.kernel.org/selinux/20261110153110.29256-1-stephen.smalley.work=
@gmail.com/T/#u

I didn't cc the kernel binder maintainers since it is specific to the
selinux-testsuite but certainly if any of you see a problem, please
let me know.
