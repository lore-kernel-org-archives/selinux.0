Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A55146585
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850113; cv=none; b=Kag0K7Ks2c+aIfUsArjfY7S1YPkZH8NYniiEc1MJR/w29uGQ54II1TxwVNI8Jufk7KaXRa2yDXKwu1m1mcaUCggeqojXY2TLiv+HXbIvgkt/S2Hz465N4OtbRFGTQHtzSuZFYYXFrUwIA5RE3nqo1B4tO8aNM+jBMHa+74bYIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850113; c=relaxed/simple;
	bh=x1k6QI5cFJmFPs/xLbocQd2ipRlUQpOJc6NWYZNCfNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5y6rBuFi0syQqurk7HcLEMX1l95dMRR5a+WYXmACj7amFtFd9a7PgSh/IsCjFFpd/6vE57FuEUOjv3p8wVLF5VZJZPArp+ytUwF8DvOK0mpl0JRFOQ+NPzM/JH+q07ChY8E5kQTjvrrLP+Y6Vg7DHQri61cZTiikhBGI1GL/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fgbu0t3z; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgbu0t3z"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso6319539a12.0
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759850111; x=1760454911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lB5nUOl2p833ZmsHRh1RM8URgMaMu/rmbHYupQKLzEo=;
        b=Fgbu0t3zoDyFkXCw/nhnpaWezQn6t+Ctyl//4O/7NF8Gn6fk+56XffG2HtynJdGVp6
         P0TneBk38eCv9+jkiX0jf9fNW2H6WhSePXndwcTkZrMTWq3OLWM58mqxWgM9+2kZkoYR
         f/t1eslQQxKHFqyKl5Nbo6eKbzvSnU/ADvdlobw5sSXEUvWh5ju6bOi+3pZowDsq2csV
         F74xBwnl3s1TS212Dv2dxs7rlG1+cIplOtLy60FBbBjuyXB7V4uiqgSqTycCurZ9qLKu
         rEvXPbfdJIZsS5B58wYusAirHIx1TyhLHO/Q9/tupcr8cthPZlPBNCePafAVSnow8dVR
         TZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759850111; x=1760454911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lB5nUOl2p833ZmsHRh1RM8URgMaMu/rmbHYupQKLzEo=;
        b=hlHuC7+/HJssU/rSGNTzmbAn9z/Eq5QDGb3qmdokNc7TOE7md1v3Cn+sQxKcJt2jyV
         8q5AguKl9GM3EmQ6CNTsHDY0OnDuKX26krz/2vLayjIVlDIUfwU32pFF8zunVi2e3jB9
         b66fkpGDqVyQevMMr6SjvgkVwhSFPjSGkO+7hsyJqijaOxHD+55LASfPKH/hU7nZ6TO9
         mbqRAbjp8KjUfqu50hPEX6COsZAhx3GOf1Q6FDbo3CEA7kVspNdoeJDk/JLP49iKcRGJ
         607b2XejE0jqUkYNEpr/Dc2Tpeq2Bifc420dx/UtjS8tmwPS15ae/HXI6isKCM5yzaE0
         LA5Q==
X-Gm-Message-State: AOJu0Yy0r6a9lBLpZA0EDzMh7pyO2Qe0u+IE5QMYEwxme1fg8XMGGTU0
	cqgfJ9dJOAW/rldLMpsBdFNAz093YkBN0n6jVTWXGSE2Ok2KeOpSI9wZbWcNPi4D2JpzjDxZXf4
	S1NdUxBgZsc9ci6OjilGwTGSCQJEBxvI=
X-Gm-Gg: ASbGncuQeDrUjFbkar9GSaQ4uGiiIij48GHYcFyt3SRRSaCVXWnGWaYwU3Zh3XF5tpS
	4eve82sU3SUtxt+lx+DCn+X3Q3o5PFGIkg4UIj0ElH4WZtkfp5+D488RG4113gwnrpXEIhN7GRm
	HGGerwIu+BdPOTyHnlom2UXsIfprDjM+6AVRVpaQRym2cEhzfdwjhxfTt1Z5AeyCjH/DOvr1Vch
	S4clpXKzE0w2acEhzM5pJdMsGFacaI=
X-Google-Smtp-Source: AGHT+IFPLhcr5L/59GJRRQ2LqbLK4h7HOqyvP+abWxQpuHH0UQwzOR7/thIG/EHltxfKse+eWxO9sLrVdwl6KyaWtWg=
X-Received: by 2002:a17:90b:5807:b0:339:dcc3:82ca with SMTP id
 98e67ed59e1d1-339dcc38971mr12630003a91.6.1759850110736; Tue, 07 Oct 2025
 08:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007150659.33954-1-plawate@redhat.com> <20251007150659.33954-2-plawate@redhat.com>
In-Reply-To: <20251007150659.33954-2-plawate@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 11:14:59 -0400
X-Gm-Features: AS18NWAgGCJh1Btd1E33OAeo2_87w0eqr7x_jQZduEEb0cv9PU9bN_dlDqn3qBw
Message-ID: <CAEjxPJ5MFzohCxfjkk6x=c1V2qqBR5gqX22DY6Bc0PDQF-yzWg@mail.gmail.com>
Subject: Re: [PATCH 1/1] improve semanage man pages: Add examples for -r RANGE
 flag usage
To: Pranav Lawate <plawate@redhat.com>
Cc: selinux@vger.kernel.org, pran.lawate@gmail.com, vmojzis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 11:07=E2=80=AFAM Pranav Lawate <plawate@redhat.com> =
wrote:
>
> From: Pranav Lawate <pran.lawate@gmail.com>
>
> This patch adds missing examples to the semanage-port and
> semanage-fcontext man pages showing the correct usage of the -r RANGE
> flag for MLS/MCS systems. Currently, users who try to use the -r flag
> without proper examples often encounter unclear error messages when
> they provide invalid range formats.
>
> For example, here is a command with wrong range string value:
> libsepol.mls_from_string: invalid MLS context s0.c0 (No such file or dire=
ctory)
> [...error output...]
>
> The added examples demonstrate:
>   - Correct MLS range format: s0:c0.c255
>   - Complete command syntax with the -r flag for both port and
>     fcontext operations
>   - Clear indication that this is for MLS/MCS systems only
>   - Verification method using seinfo for port changes (semanage port -l
>     only shows type, not MLS range)
>   - Use -F flag to restorecon in fcontext example (required to force
>     relabeling)
>
> Signed-off-by: Pranav Lawate <pran.lawate@gmail.com>

Technically tcp port 9999 seems to already be defined in my policy for
jboss_management_port_t and has an entry in /etc/services for
"distinct" but I don't feel strongly enough to insist on changing it
again.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


> ---
>  python/semanage/semanage-fcontext.8 | 4 ++++
>  python/semanage/semanage-port.8     | 3 +++
>  2 files changed, 7 insertions(+)
>
> diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semana=
ge-fcontext.8
> index 3a96c62f..a29b7499 100644
> --- a/python/semanage/semanage-fcontext.8
> +++ b/python/semanage/semanage-fcontext.8
> @@ -100,6 +100,10 @@ execute the following commands.
>  # semanage fcontext \-a \-e /home /disk6/home
>  # restorecon \-R \-v /disk6
>
> +Add file-context with MLS range s0:c0.c255 for /secure directory (MLS/MC=
S systems only)
> +# semanage fcontext \-a \-t admin_home_t \-r s0:c0.c255 "/secure(/.*)?"
> +# restorecon \-R \-F \-v /secure
> +
>  .SH "SEE ALSO"
>  .BR selinux (8),
>  .BR semanage (8),
> diff --git a/python/semanage/semanage-port.8 b/python/semanage/semanage-p=
ort.8
> index c6048660..0df44290 100644
> --- a/python/semanage/semanage-port.8
> +++ b/python/semanage/semanage-port.8
> @@ -61,6 +61,9 @@ Allow Apache to listen on tcp port 81 (i.e. assign tcp =
port 81 label http_port_t
>  # semanage port \-a \-t http_port_t \-p tcp 81
>  Allow sshd to listen on tcp port 8991 (i.e. assign tcp port 8991 label s=
sh_port_t, which sshd is allowed to listen on)
>  # semanage port \-a \-t ssh_port_t \-p tcp 8991
> +Add a custom port 9999 with MLS range s0:c0.c255 (MLS/MCS systems only).=
 Verify with seinfo.
> +# semanage port \-a \-t http_port_t \-p tcp \-r s0:c0.c255 9999
> +# seinfo \-\-portcon \-x | grep 9999
>
>  .SH "SEE ALSO"
>  .BR selinux (8),
> --
> 2.51.0
>
