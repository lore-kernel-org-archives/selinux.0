Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DBC2DC79C
	for <selinux@vger.kernel.org>; Wed,  3 Dec 2025 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764804763; cv=none; b=dHzBQKT+Az78PtDXrjzflyyWJYY4OzucnIFwVR1nhqPUII5dBF+mtp2lSUB4sTW/h6VVXBPVwpJCCmYRRtQrBkGiWuiyrzvKM+TN8mgYMgc0+pafswDnvlVOhK/7XqAOJCVl1BOLNNz5QUT9Gr5TimmV9gx4SwIIJI+lGUWuUEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764804763; c=relaxed/simple;
	bh=kHhaOPlGd9dZjfWcIG2wpcJK4KXWGtcwGLCzRIOJ8Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLkZ5wSYxncn0P9KLVGBoXLnGoF9mlgDXcNfWkEzDkqvOcVpS74Tnkxtk6CvTeJ+AqIAmVZta+zLgYhRhuWJR3EzAC2YS7RXTgRRacRjVIPnjK5tyBwW1TlvxAZv6hr4vFkURBtOyOzu7vhIQoBAkTwgkAuzPcKdD84bTt57d2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KCKc7OI4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KCKc7OI4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2981f9ce15cso4235665ad.1
        for <selinux@vger.kernel.org>; Wed, 03 Dec 2025 15:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1764804761; x=1765409561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY2AZAVCpp6Sq52vUbSB6ZWac+lqPfjnUYQLvy5vcjo=;
        b=KCKc7OI47GBbeAHlhRdJDGI/ys69D1Bqgv23CRRHIroRXUr1jOcRx9Qjehks85bE6b
         v+PvQofkRSTr17XjU6h5Kg7c9lvMtCEPfmEXqZU901H270zYSdtiFsFTjxUOLs0c9/JI
         D1urQjcysNTGNDfhArNiMTYTWvrT1uIQwNWRfKx8CVm45dnnsMeP5Byzgn+FtWJuWDRC
         zJa3MKBczKFzVmZlD8GPzCyRtiXX9z0dxfMw0va7adSG24bx//fuGX8sPEKsU1vK+9lg
         QbZQof7XSuZazl7dDjlhxZsVLXWpERG1sUlOflVtKLftHfhFbgG8r8OAf6oysDjMMd0b
         ajZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764804761; x=1765409561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HY2AZAVCpp6Sq52vUbSB6ZWac+lqPfjnUYQLvy5vcjo=;
        b=Pklm2Fkv5RPDkgdYXLnBE56JkFriHmSuzuuuJGM7pPJ+g+JFoRqduLjCL9RPyopZtp
         6Vo5a4+pF+f0OvEv/pyHBF0zLlCBRGw9ueZU/PBrSCoZRCwMnFGdvOol8XHpHBgUz4kt
         Xn0ksCZn8jXri5jvIYb9Ve9QzJLSTPAX11IyLq3XUJTVc4qdeOxJNnqLfskGiJSeiBrc
         Sm2dnk4Nt02XKVD3juZ8WqpmQzNDXpTNjJFrBl+lj/mmui03Iy8AiAQtZPeJi4yl0Des
         v0Y8CZqUVTj834zsGjA8k8UdFlwLF8N0tREgCo0choGDtJVm8OXZ3JSGWS0uQ8bxJylK
         4UkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1VH8tBVZvAEJIbUwvTLQQSP0SHVWLkZUhdCnjPvSs0G4PoMePin7zFi2fQvuGUsL6//GIZF2m@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHABRN1Czcac7kXWuqhiES4HPhbDXaSsH1oi4qgU2rvp6kU+H
	riAadSyLlVldN1AuBbP+xltgySOeNIWRx+ewvljM2Izu1TZWf4jOmB0RxVbol0c0YeUYIU+0CIB
	wYuqyH8f+x6wiytGk4vIXN0E2OxQXyzjZ8z44uL//
X-Gm-Gg: ASbGncv0E/7dOT8pFwxSIeJ26jcS/d4GMWSuINBgzKzUEVp1fsll9tzuflVXBLHUX2v
	zelXmveehGDug3jLBWv0Sc0X7LeqLQY6BU9zCZK86eBwocogw0ODkCNauPaXL6e+yyk4eJWx3Gb
	QWsT1Z9if5X1Iei3Jvcv168eWt3f4yzUmdcGHaJY+tarNZdV8wWCTu6P0S6mpu0DhKe3icGoD8O
	9KBua3SjzJpGXT0suuy1jFiNwGLPIGidDIfRDUH9RrTXBE6tmLrcLC0yOD0RFQSDYSrV+M=
X-Google-Smtp-Source: AGHT+IG1Jsjm1UuK/qNamOiWRevRd2cMtkd+ihRs6an6FM35jAGZvI/pIjHY22NzUCZWyyhO3AxBhbZVHdSVN5kgYl4=
X-Received: by 2002:a17:903:1a43:b0:297:df17:54cd with SMTP id
 d9443c01a7336-29d68397afcmr47724655ad.27.1764804761160; Wed, 03 Dec 2025
 15:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cb4293da-41dc-4586-adca-2859944905dc.ref@schaufler-ca.com>
 <cb4293da-41dc-4586-adca-2859944905dc@schaufler-ca.com> <866a132a-b6e2-4e40-aba3-d8b733184672@schaufler-ca.com>
In-Reply-To: <866a132a-b6e2-4e40-aba3-d8b733184672@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Dec 2025 18:32:29 -0500
X-Gm-Features: AWmQ_bkCUuE1qDK-R0RrJbFIhp34-Oy1qVUWpXzfhCQjecsRkI8eSq5yea3Mb4o
Message-ID: <CAHC9VhQOW8a_pTKS+Mhtu2LEFCPRhEzuhLsJOFHNTNUNUELChg@mail.gmail.com>
Subject: Re: set_security_override_from_ctx()
To: Casey Schaufler <casey@schaufler-ca.com>, 
	LSM List <linux-security-module@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 5:03=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> Adding David, who wrote the code ...
>
> On 12/3/2025 1:32 PM, Casey Schaufler wrote:
> > While trying to ensure sanity in security context processing I
> > discovered set_security_override_from_ctx(), which is not used anywhere
> > in the upstream kernel. Does anyone here know what its purpose is? I
> > would very much like to remove it, but of course wouldn't want to break
> > anything important.

It looks like set_security_override_from_ctx() was first introduced
back in v2.6.29, but I didn't see an in-tree caller until v2.6.30.  I
didn't check every kernel release, but doing some spot checks it looks
like cachefiles remained the only user until it dropped the call in
v6.12 with the following commit:

  commit e5a8b6446c0d370716f193771ccacf3260a57534
  Author: Max Kellermann <max.kellermann@ionos.com>
  Date:   Fri Dec 13 13:50:05 2024 +0000

   cachefiles: Parse the "secctx" immediately

   Instead of storing an opaque string, call security_secctx_to_secid()
   right in the "secctx" command handler and store only the numeric
   "secid".  This eliminates an unnecessary string allocation and allows
   the daemon to receive errors when writing the "secctx" command instead
   of postponing the error to the "bind" command handler.  For example,
   if the kernel was built without `CONFIG_SECURITY`, "bind" will return
   `EOPNOTSUPP`, but the daemon doesn't know why.  With this patch, the
   "secctx" will instead return `EOPNOTSUPP` which is the right context
   for this error.

   This patch adds a boolean flag `have_secid` because I'm not sure if we
   can safely assume that zero is the special secid value for "not set".
   This appears to be true for SELinux, Smack and AppArmor, but since
   this attribute is not documented, I'm unable to derive a stable
   guarantee for that.

   Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
   Signed-off-by: David Howells <dhowells@redhat.com>
   Link: https://lore.kernel.org/r/20241209141554.638708-1-max.kellermann@i=
onos
.com/
   Link: https://lore.kernel.org/r/20241213135013.2964079-6-dhowells@redhat=
.com
   Signed-off-by: Christian Brauner <brauner@kernel.org>

... which basically just drops the security_secctx_to_secid() from the
code path.

I would suggest sending a patch to remove
set_security_override_from_ctx() since there are no longer any
callers.  Send it to the LSM list and I'll merge it once the merge
window closes.

--=20
paul-moore.com
