Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B67155328
	for <selinux@vger.kernel.org>; Fri,  3 May 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753623; cv=none; b=VSa2ASVmuy4VFujPTfSN+Wl4P/kel4CY6x4Z9m/ggboQcU8of76SMjVBe1rlNT/ghL+/dh84IyEw72izNheEDJ7BGR6iLCIURV6vX6TdfcF8xMTlIAknbM2lHikEYkf8r4Q5RgnfvG2diQUrRJ3+jXL3edC4jJbUJesKTHJN3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753623; c=relaxed/simple;
	bh=SHDH9xrhc6Ced0XEhiew+Ce8jcBcildnUePGEjdQosQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egtrHNhM0R0emL+ResdpcbpbftMRFZ6XNuLiei0MC05D4WAcTx+3nZUnw9qb6LJl2IQ/5e5WON8IZMEJsteF2n0DT+woljfZSAdt548nC1RUGPD5gbwRf9qTIwxyL4c24pUrz+yORF9N2ad9NwN0jZprhU/nKb0j4i/j4xwh7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ghWzqQcj; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ghWzqQcj"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61804067da0so89377877b3.0
        for <selinux@vger.kernel.org>; Fri, 03 May 2024 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714753620; x=1715358420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNKY6mvbjnOkFxiD0Oxxob0RwimRuUPgxJbq729JMqs=;
        b=ghWzqQcjZft0CI/pkazDtAw3uboq8uG5dBLIs1HsJLt5xRfQYJsZO5ubNWfP0G4MlL
         gSLywG5TK5/8NWkuvltWRXSaWLyfHUtEP8lxZ+JPNnGAT+ECfkvtJ2CvsJUVkg+fDz6u
         7w0/mlzOA2D9xAd6sFRQTxIHRgjoJIL8omvnsjxlYwrU0n4t9Wni8faRHJt/XBAb6V8G
         MIvndtGDLqUHGKHdkAE281+PIinUc2ejaBO685p3pEyNHz0sUa4ucZBEfphvpAyQJU2M
         zM7Eky6dNCFJuabHq73OErPH23UoPYZHdP7V16wa/WN8Pw2mAhHLQMTcK2gP3ImBa9AE
         qtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714753620; x=1715358420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNKY6mvbjnOkFxiD0Oxxob0RwimRuUPgxJbq729JMqs=;
        b=ULc5or0Wov87EAWGdUE/CxoKtC8PM2L0FM1SZMSlc8xBq8956Ry9XL1d0HzbmqGr4t
         FsdDqMXh5kLRM3jiyNYpHkt4z7+90EdYtELt0VAZCd7260QS15ivL5zldvxknEpcaF5H
         PThBDX8PYowf0NNDfDlqzl5ktNnQ+aAKzPqfa1nlgp074EswJgHdPWy5kYnXfR0G0ZXF
         mPHqIwPWkxlYm7ZnB9r4y9SoC4AG6XNA52LfPGzgNt9XNdjW+vAsageVwKxXDYU1ks0U
         2YlUShWQeZ6SsPj/Uyi/6yGI/FCiGenR3ZyNY8SzKvkd0TxqH433MNWboOPk1fvbZ5Y3
         OBaw==
X-Gm-Message-State: AOJu0YwzLDFSR1h+FA6CP5TtB8dw8VybqEzFM4xsWu6NR+2jBxzeEqJA
	S95ZB+U830lNLI1P2Han7U0yzwVQMyJVRg/dKevMJu5Gch5DjcODYYQHlPpe2FdZIpSMg42Cgmf
	QKDqQI4eFVKrKTU5ertUYHlfKqLjrwQPX/nsF
X-Google-Smtp-Source: AGHT+IH3mmUPlCwa2GCJe/RXeSniZOWE+lKk8LAl6KQhA9wPyfQ3hs3QqkGPlei1mntzdCyiWJkZvICBu3ZLyxjVqJc=
X-Received: by 2002:a81:ac66:0:b0:61e:124c:e71f with SMTP id
 z38-20020a81ac66000000b0061e124ce71fmr2976644ywj.26.1714753620528; Fri, 03
 May 2024 09:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005850.466144-2-paul@paul-moore.com> <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
 <CAHC9VhQUW42aicyiMAVaSEsCR-G8E+uVZJVCXodDv8obC3V0VA@mail.gmail.com> <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com>
In-Reply-To: <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 3 May 2024 12:26:49 -0400
Message-ID: <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:51=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 5/3/2024 8:36 AM, Paul Moore wrote:
> > On Fri, May 3, 2024 at 11:26=E2=80=AFAM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 5/2/2024 5:58 PM, Paul Moore wrote:
> >>> The current security_inode_setxattr() and security_inode_removexattr(=
)
> >>> hooks rely on individual LSMs to either call into the associated
> >>> capability hooks (cap_inode_setxattr() or cap_inode_removexattr()), o=
r
> >>> return a magic value of 1 to indicate that the LSM layer itself shoul=
d
> >>> perform the capability checks.  Unfortunately, with the default retur=
n
> >>> value for these LSM hooks being 0, an individual LSM hook returning a
> >>> 1 will cause the LSM hook processing to exit early, potentially
> >>> skipping a LSM.  Thankfully, with the exception of the BPF LSM, none
> >>> of the LSMs which currently register inode xattr hooks should end up
> >>> returning a value of 1, and in the BPF LSM case, with the BPF LSM hoo=
ks
> >>> executing last there should be no real harm in stopping processing of
> >>> the LSM hooks.  However, the reliance on the individual LSMs to eithe=
r
> >>> call the capability hooks themselves, or signal the LSM with a return
> >>> value of 1, is fragile and relies on a specific set of LSMs being
> >>> enabled.  This patch is an effort to resolve, or minimize, these
> >>> issues.
> >>>
> >>> Before we discuss the solution,
> >> https://lore.kernel.org/lkml/20231215221636.105680-1-casey@schaufler-c=
a.com/T/#mac61625dc1983d13ee5e8015fd22e1165381f079
> >>
> >> ... or am I missing something?
> > Yes, that patch, as well as some of the others that have been posted,
> > change the ordering of the access control checks, moving the LSM-based
> > checks ahead of the capability-based checks.  The patch I'm proposing
> > here not only preserves the current ordering, but it sticks with our
> > access control convention of DAC-before-LSM.
>
> Fair enough.

Are you okay with the patch otherwise?  It's too late for v6.9, but if
everyone is okay with this approach I'd like to merge this after the
v6.10 merge window closes.

I also need to track down the appropriate commits for the 'Fixes:'
tag(s); I'm not entirely convinced that some of the other patches were
targeting the proper commit ...

--=20
paul-moore.com
