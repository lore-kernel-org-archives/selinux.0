Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1881E3798
	for <selinux@vger.kernel.org>; Fri,  4 Oct 2024 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061055; cv=none; b=C5+Wxe77qIv8trwnfGzlOX00FX96JPj/eohBW9i9FNqWuT4vwQTqbcafzGnlM6ZHz6rDaJGz9CCmjLhq62mdJpj7bXU7C8RqwheumMNwBuy2H/sjS/5jOiqEhi9lf+v/+3Qa3ZfAjbR+2O8Oj/KsrzOmYBRe7FE/DvfmqT6KZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061055; c=relaxed/simple;
	bh=dILKSs9qHE+zIHOKvCgpDYc3KEetwWseqUWQZZtJZwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TocNEf6/EklG/ZL5IjltZJ9Mo0JNZQp2IKl7/o0l4CofUQ014nVr4sNbaIm3c/rOA40EDzNZVobcijEEiz9wagsPb6Z2+V5lwtH/pObGXxRkdxnc8i6DEd4nI4NCAXgLciVAJOscxMdFJEN2lPlKI6JrXndTI82ESZdkr10U5cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FtysHpUk; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FtysHpUk"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e2d65673c7so3408147b3.1
        for <selinux@vger.kernel.org>; Fri, 04 Oct 2024 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728061053; x=1728665853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nezXNqiHWIXGNMp6a+lWbE+UIiTPfb1Z821WxJCjIDw=;
        b=FtysHpUkux3h9cM82Wia0ERIC67FjldmSSI6focozoA6X7enJoayzJHGkD0l9cMdqA
         +oZkL23NhmifOl40H6pRJV/G3CmJLDtxENx4MJdX2cqTIYPNHdGtqPzSTOItGPxni27f
         5vv0zuYPtZyuGjoloMavwuRbqwn1TcONQNRneTLg/Z/9P2YuqPMBuZ/v8SEQdpFSubL1
         YcRdKxUAD1CsSoN6iN6gvuzEisFwtrhzSinkpoU3/eRFTJN3sIv/OdezTpMl7W0/ep90
         M9Y88f8d0WydSTA43cbRWAKkkuilzAbWfkfga+D2dddf8ZKJG9JFLMtimiX5kUI4J9OL
         Yxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728061053; x=1728665853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nezXNqiHWIXGNMp6a+lWbE+UIiTPfb1Z821WxJCjIDw=;
        b=OIr2+asLe2Y61+OJwWYwHK4MBIOCqgtC/btWjFOv6mTpYBUXYP1Fw9p9IrvPawIiMZ
         EUaoxquKg5SLkMEZlsMTq1zjmtAom1DQ/UDa5cGAl0JrQbuY7dqpI7XVHHxXHCxL8lVM
         JaX1krQYXY7XJiHqDARWtcoxmeIM7vKT5XN71c+YDOpmIYD3EqaMYZrlsvWgNxlqRsJP
         X2qP0MU7LQDazqOSZ+OlADZly6kA7HGNI0NTESptQnCW74NHOepq4yTTjov8FQxc1O3A
         LFkpKC9eiINTjXcsRQGDqW+skma80wn6mtBswk0paEWsVI1vulNW9OCpyMkjhako9MBF
         VJwQ==
X-Gm-Message-State: AOJu0Yw7oIprkRiIspTnbEe0XW+rkfe9q3MdTRiix5gx7kp+mGFuki7r
	vLA/ujS4O1kgHSvoNupRtqKiVvRB3wCvM6rgledTl0ThBevIZtGMpo+QKcq5XgTo+xuiUKgxUov
	H3kmybiA19G5eiPoSooIgJQ2mhLz0OHxszVrH
X-Google-Smtp-Source: AGHT+IFSu7oPufoQOxbfriUXaACY9eG8okH6Gn9SGP33W7uVkJrwoIT1Tn7hfKYxNERFEeYCb2WPImudNZTfh6I7fFE=
X-Received: by 2002:a05:690c:7007:b0:6db:b8ff:9128 with SMTP id
 00721157ae682-6e2c72b2502mr34091807b3.46.1728061052915; Fri, 04 Oct 2024
 09:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004155320.16629-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20241004155320.16629-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 4 Oct 2024 12:57:22 -0400
Message-ID: <CAHC9VhRbamWqztn3NMxuiQ51S9sVvDw=oB0U6Znrw_mukFONAQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Deprecate /sys/fs/selinux/user
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 11:53=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The only known user of this interface was libselinux and its
> internal usage of this interface for get_ordered_context_list(3)
> was removed in Feb 2020, with a deprecation warning added to
> security_compute_user(3) at the same time. Add a deprecation
> warning to the kernel and schedule it for final removal in 2025.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  Documentation/ABI/obsolete/sysfs-selinux-user | 12 ++++++++++++
>  security/selinux/selinuxfs.c                  |  4 ++++
>  2 files changed, 16 insertions(+)
>  create mode 100644 Documentation/ABI/obsolete/sysfs-selinux-user
>
> diff --git a/Documentation/ABI/obsolete/sysfs-selinux-user b/Documentatio=
n/ABI/obsolete/sysfs-selinux-user
> new file mode 100644
> index 000000000000..8ab7557f283f
> --- /dev/null
> +++ b/Documentation/ABI/obsolete/sysfs-selinux-user
> @@ -0,0 +1,12 @@
> +What:          /sys/fs/selinux/user
> +Date:          April 2005 (predates git)
> +KernelVersion: 2.6.12-rc2 (predates git)
> +Contact:       selinux@vger.kernel.org
> +Description:
> +
> +       The selinuxfs "user" node allows userspace to request a list
> +       of security contexts that can be reached for a given SELinux
> +       user from a given starting context. This was used by libselinux
> +       when various login-style programs requested contexts for
> +       users, but libselinux stopped using it in 2020.
> +       Kernel support will be removed no sooner than Dec 2025.
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index e172f182b65c..8117d8f6ac2d 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1069,6 +1069,10 @@ static ssize_t sel_write_user(struct file *file, c=
har *buf, size_t size)
>         int rc;
>         u32 i, len, nsids;
>
> +       pr_warn_once("SELinux: %s (%d) wrote to /sys/fs/selinux/user! Thi=
s "
> +               "will not be supported in the future; please update your =
"
> +               "userspace.\n", current->comm, current->pid);

Since this could be triggered by multiple different applications, it
is worth using pr_warn() so users have a better list of what
applications are causing this notice?  I understand that there is a
risk of log spam, but considering the limited use of this API it seems
like this is a reasonable risk?

>         length =3D avc_has_perm(current_sid(), SECINITSID_SECURITY,
>                               SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
>                               NULL);
> --
> 2.40.1

--=20
paul-moore.com
