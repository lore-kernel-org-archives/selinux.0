Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462A51E420
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800800; cv=pass; b=c3EDpuzMhuA3BkHiW7dS9mYDQHzWQwDz6Vbfv6DnAYGV+KtVQkriBGMxSDKAjj9kzyQeWjmVhHTOklqdxx0bvO6QqkTjkYdFVbTocSWmAUXHCwN/oxuYRZ2YUNJ5VxFcapmWwUxssRJeYEnjuwJC7fO6kYfvqWWzsFZ/tn3w+mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800800; c=relaxed/simple;
	bh=n2yyiNnSJpSjx9cBer6H3f7XD8sFjF3TfAayqFmpcII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtB7BW/JjAEyTi/V7zFDPcduHyJslkcjkoJh1iXVDlLTyKwjiILRNxaax6pTT6WncJCn03ummKmleUcFd+VUsou36iyWbdLKXKSRjqhtxM5dVK/R8J771+onx91xfdJSnsBJI+IyIMWIY8rFDOuIMBvhaVo/yNHxGGPiI2AN5iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goYTAy13; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goYTAy13"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4563ac048f4so3899398fac.0
        for <selinux@vger.kernel.org>; Mon, 07 Sep 2026 10:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788800797; cv=none;
        d=google.com; s=arc-20260327;
        b=Q1IpO2miwb5LsrLelVj2IcdujSsnjJ/V5OyFJqq0Vsnzatc8cSlXjpaq+Z3WAjDGUe
         CdYpL7P6oMlqK1XSk2liQmgHj3GTxdC9VVdhJLVRhOaCWhpv6EUlwghzd0CCh9FNq4ki
         VQSQy9MlchHD2JHZ6TIOFyhWRXpXYH9IKelMX5RldZO2v6c6+/MmP5SnmayKyXxYDSyV
         woOQ70o9xmmRB+x1mrzP9tXjtaf3471J48uUPo9CS8bsEbkbmotaBO9QsxEs+5Pf04xs
         uengYodwctBq2t6ZfECYrUkIK5aX2/4N2fwDNW8S3/QmWJJoSAEZThzx/J0pTm4D9bRC
         NcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SbiqrnSQlGWx2zgEBcrfPr3DDF15v4ErqzZugzYGcmc=;
        fh=WT2pvQtROL5GVYNwxkHoBfAA8oOL5j2UZ5xCJU9MPvM=;
        b=Xl567RakMgoN1i5iyA+qXjqhm0F+DYmHfWR9COl9OQI87LVxv541AMzwMORpgrjZCP
         vnFldk9nRI4a9oOPsZrx6vsZrud1bQnydX4HdUZp5/S5WYYOzXDPPIYOEt68IQBSPPp/
         Vm4nMdNOt9mLQELlVKDWYt5WrUr8oOu9X+S1NrVczS87d5+/98jYtnWydyYJDOJeIxAM
         wohSuBXS4lOyeE5zIB56oEHgplfPVlfi2Tg1mr70X7JDwpM57ZPzJTDwrq39HzLSy0q0
         nm66aBjFZBEl6ajvJ5vGV4JaoC3XeNw4MoKKcXaJip7fJMZEs8af6dd3oztVsQjGjRk+
         Za8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788800797; x=1789405597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SbiqrnSQlGWx2zgEBcrfPr3DDF15v4ErqzZugzYGcmc=;
        b=goYTAy13eZWImX2PXtXJhtPGKXdiNrj3v4FHCBM3rWbEOTvDNCCTgbw3LS5pDn2rkS
         sbBJHt2iyu0Eksj9Za369a1telGX/iS64knx70fT/Ouozo9uBHi08Aoa7QNiwuz0MWNC
         L7NtN3O6g9BkZBq/KGOKfC2Lg0lTLoAS9jsAGsp328Ir/NjoGgB2Zn9WjJcZJqYZGth7
         2cQ1z4s41W0eLX9ZRMq3hsd7ep1xtEyNFg0EbvFFKQw4FrKOohAPoI++5EouNuz9ydO1
         b9A1+Q0JCuH4vgfvnQ/pthW/Ts1bw0057mq61vUwV4iYxmmQosSFseQVsLcFZZNe7MOJ
         anBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788800797; x=1789405597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SbiqrnSQlGWx2zgEBcrfPr3DDF15v4ErqzZugzYGcmc=;
        b=I7jaN4fGre4TDlxmZ/0BsKJxptVuKKAnkX/hgUlbdQYZ3/gkTQWI7oDWWwNULGg5uF
         2lxTtX+Jf9DOIjTRB8QQdW/IOpgUUmfd7rKtxOUsTztydn2wDrBlvVDI9BWY8Len9IEi
         wwgEIve+35mn9zitWjMcsdv6JZAdavrhHStu13T5ZKZFVtqbmugTQxLFpwa7dPA+weB+
         YlkLOM6ZzLujySxkSMqxlksYgfZcPqdLfgGHVH83DBajn6Ezl+mDYY7z6Cqc0Krb7Dah
         fgrY18Nqrv7go9CRB6b0eAJmE1Uu8vZw3A6GdjHXhUBSfu1Bnf51gzW68ou0bnkBzneu
         JjrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqkwt6G7KmbNlEkPag0BtGu5HCrHMrYfVdOItEqvUSPGYUTGY6bBjLSGzpPgo2aoaC00dSF55X@vger.kernel.org
X-Gm-Message-State: AFuF++mxi5r+SXudMpFQyy9W5Ymk3UoJGWZYR2GH8aA9OsMUiKQtldcG
	FN63PpA9Py8NOAnHAFKk4dx0rLjBQ9IoBh9fw6dqhDGFbfRWL7zbz1H2i8L2K7RH0oWi+byvi5E
	iwruywWzTsiQgCw8kj9PJkbygUlwO6XE=
X-Gm-Gg: AYBFou2XblmmqqM2YwuM9nOyluh1tAmA5t9TUtcDI9GH5/kqxlg213FmzCWarB+WT97
	3lVP+9s6FVq56Xp76HuOhgMYEzWnu5bF+YHnQEc263LMJGhFY9uQyapyUWjTDejO8d1Z752HwSF
	71nZ29pxCrcnL9eIx+51llgiC78PNneeCnizkATZHtxtnf1cA/VrmiGnZnveJxvcbpHHXZ5uMuM
	x9SfqYEaWvx277XzvHTgi+5iTge0r9a5b6JxADiRDNOejpCQxQ8zKEMAORfYcMSv+m2h8DGRZI0
	ajw+TKgEdQsD3Aj1CRn+lQtL5gFCzpzVJazrRJ/QS1l52w==
X-Received: by 2002:a05:6870:8088:b0:475:e066:7712 with SMTP id
 586e51a60fabf-475e06695b0mr13867832fac.25.1788800797150; Mon, 07 Sep 2026
 10:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <L8sbFRgfQca4r8AaNEEfTw@coker.com.au> <CAEjxPJ6SQcdEDFfV3W7Bk5JKbAxRp+9tuvr2yhUdDePmeXNAKA@mail.gmail.com>
 <CAHC9VhT+k9qWsA40APOi4Q1hg8M+Ft_A7D3epdBW7P2QczPf6Q@mail.gmail.com>
 <RvCmRlQYQ3uewSzEeY0utQ@coker.com.au> <CAEjxPJ5f1DCW5FWSE77_3HcMjt3QxMewCL5fX+PsdE_SXn-VZA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5f1DCW5FWSE77_3HcMjt3QxMewCL5fX+PsdE_SXn-VZA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Sep 2026 13:06:26 -0400
X-Gm-Features: AcwNN1UD_yr-kVJnA6jO0PwkhvgRLfmICkW55C_vskVeMxqe18N_fKBkL18dV58
Message-ID: <CAEjxPJ56+YkfCgt_08NgD+6pQsvDGrsUgx3o5eC-U1ZmE9pfqw@mail.gmail.com>
Subject: Re: kernel oops on recent policy with older kernel.
To: Russell Coker <russell@coker.com.au>
Cc: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>, 
	selinux-refpolicy@vger.kernel.org, Chris PeBenito <pebenito@ieee.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 11:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Sep 6, 2026 at 9:17=E2=80=AFAM Russell Coker <russell@coker.com.a=
u> wrote:
> >
> > On Wednesday, 2 September 2026 01:35:44 AEST Paul Moore wrote:
> > > > Date: Wed, 22 Jul 2026 21:04:27 +1000
> > > > Subject: kernel oops on recent policy with older kernel.
> > > > I get the above when loading the latest git policy compiled with 3.=
11
> > > > userspace on Debian kernel 6.12.74+deb13+1 and Debian kernel
> > > > 6.12.86+deb13.
> > > > The same policy on a 7.x kernel such as 7.0.13+deb14 works correctl=
y.
> >
> > https://www.coker.com.au/w/
> >
> > Below is the kernel message log output with Debian kernel 6.12.107+deb1=
3-
> > amd64_6.12.107-1.  The above URL has the Debian kernel image and the po=
licy
> > file.  The command "ar -x linux-image-6.12.107+deb13-
> > amd64_6.12.107-1_amd64.deb" extracts the kernel if you want to use it o=
n a
> > non-Debian VM.
> >
> > It's hanging not crashing which is an improvement.
> >
> > [   10.414520] audit: type=3D1404 audit(1788699747.392:2): enforcing=3D=
1
> > old_enforcing=3D0 auid=3D4294967295 ses=3D4294967295 enabled=3D1 old-en=
abled=3D1
> > lsm=3Dselinux 1
> > [   10.530653] SELinux: no sid found, defaulting to security isid for /
> > booleans/aide_mmap_files
> > [   10.535475] SELinux: no sid found, defaulting to security isid for /
> > booleans/amavis_use_jit
> > [   10.537368] SELinux: no sid found, defaulting to security isid for /
> > booleans/allow_httpd_anon_write
> > [   10.540012] SELinux: no sid found, defaulting to security isid for /
> > booleans/allow_httpd_mod_auth_pam
> > [   10.543230] SELinux: no sid found, defaulting to security isid for /
> > booleans/httpd_builtin_scripting
> > [   10.546402] SELinux: no sid found, defaulting to security isid for /
> > booleans/httpd_can_check_spam
> > [   10.549244] SELinux: no sid found, defaulting to security isid for /
> > booleans/httpd_can_network_connect
> > [   10.551298] SELinux: no sid found, defaulting to security isid for /
> > booleans/httpd_can_network_connect_cobbler
> > [   10.554654] SELinux: no sid found, defaulting to security isid for /
> > booleans/httpd_can_network_connect_db
> > [   10.556863] SELinux: no sid found, defaulting to security isid for /
> > booleans/httpd_can_network_connect_ldap
> > [   10.559776] SELinux: failed to initialize selinuxfs
> > [   10.568734] systemd[1]: Failed to load SELinux policy.
> > [!!!!!![   10.585074] systemd[1]: Freezing execution.
> > ] Failed to load SELinux policy.
>
> This appears to be due to enabling this policy capability in refpolicy:
> https://github.com/SELinuxProject/refpolicy/blob/main/policy/policy_capab=
ilities#L154
> which was done by this commit:
> https://github.com/SELinuxProject/refpolicy/commit/2e810736211785675f0be2=
3a26638cd44c69eaae
>
> As noted in the comments, that policy capability requires kernel 6.16+
> and the one above it that
> was also enabled by the same commit requires kernel 6.15+.

I could be wrong, but I also think that enabling that policy
capability requires adding "*" wildcards at the end of existing
genfscon statements to preserve the prefix-matching behavior, so that
change may break even 6.16 and later.
Could likely make the selinuxfs case non-fatal since it falls back to
the security initial SID anyway but other genfscon-based labels may
still break without updating the genfscon statements.
