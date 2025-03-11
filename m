Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA79A2505B1
	for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690370; cv=none; b=iUibiRr/0sCpt8vWnIq3azBXMGRcAMHLRvriM3KZpffC5hXcGQv2eD/jxPjuZOmr+dd6hP6x4A6wpsXC+FeJ7i8PgriFjZYc6XjmSgkowjBc3IyrOESbXygp3tXYB+bKxofbEnGyo7kbn8Tkb+UwxkBGtgoV0pCiI73JEvZC6o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690370; c=relaxed/simple;
	bh=sdd0OqCJaqQ9ArOCtFpFm5aI44x7s82ZdF5fpof8pzU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fTonQ69Yio7VbEW2B2pqSmc03mifodvmxTMTunNTa1n/mTMrbYHCqvDvONLohaZ7+MvOgd+zqCONDWGTUXAC4M3k7dYZ9bzAJ3hB0vO9n4uvyaPGS0GGOM8c8N/k/u2VZu18uWMrZscbqLw2uJCgf2Ky6WFabncbqQmXdFDZhR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LwNjPnxd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LwNjPnxd"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so1555407a12.1
        for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741690367; x=1742295167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdd0OqCJaqQ9ArOCtFpFm5aI44x7s82ZdF5fpof8pzU=;
        b=LwNjPnxdbOZsE5q2E1vYl8299kEXsxOeQwCsNtR5bK8bEwaSo//QAm7rXp984QMqeY
         XfT/kQVuQeEKYzritLMLqE+Ex4Lxp5Ay0i/nPt1guJIZhyJg+r7uAFFUx6vBeGNfMu6z
         8hMV2RTO/7ag83J8ygtXOcZUuBz2NSJUz+nwsXJ1aj2N9TVlZUGf7BwCIntHj9LWlqv1
         wY1mHAO2/fJwQOsGhJbaOXtuwDZsi1zRpIN+MrLrFNQVqJR7JoO50py2fqsgYHhKsfFi
         f9b5+DIwMkam6eaFpZXNK5uBaVsAs7YAsQ/s+QswdsCaXuALHCmmXXxI7DHWqwAC7F5y
         pyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741690367; x=1742295167;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sdd0OqCJaqQ9ArOCtFpFm5aI44x7s82ZdF5fpof8pzU=;
        b=C9KVX2ZeqJ01ChxM5qLwzsfGYa8beRjVfow9FXEwOaoaYsdBxGC94oEpqr/LX/I66f
         DscDxnIpIDx7+8HyxbrhQXnGFnErFN27lbXU8h4WN1j76SqcgqVF2k5SMgXM13Gu5FR4
         FxjWPTkuGRN1V2VD5hYpqQFF8WLk07kJrn2TLuOWWMyCxAbP0ftIqA80ZkgEzeX0duAA
         8bLgsPIler5okTbEY5iRttjyFz06IMuWIfZIQuGusTJvEZWsoDxAH+gkCdO7OSkYpXnh
         KDdWDyY1PEJlMf5aqPZMKsCiGEO55A6LRwG6JBun/yTD+0+RU0PVRlSutJsXGt3nDE+N
         WEMw==
X-Forwarded-Encrypted: i=1; AJvYcCWS218++1cfAyz+5JmryQ9B8VJs1DIYu8FuGOhpJhwCfxrpN+/674WeYB5MYeoeoFeH3AaJN+AZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTCu1W9Cvn/N6FfhAqfI+bS24JQbTjCPgjZzbjmx2gPLgFsNC
	5IZexMqq5H4VFxFM70seH0VUW9XQqYyQ/X/Kcky8tw2q3+jCSMcmmqksGrjDB8w=
X-Gm-Gg: ASbGncsEjZvymDpeciW+s9rDb+ImVhWTY9HmEhCpMmS/RAz8xFbKxTZW8BwSJ+JBpdl
	08o6dLc3V73acPjX8j3mInw13nk2p8cWECmCt3CSirhx+v6PC1umm3LOX8U5LAY7ctA/vazlnPa
	bCUKRrq4KrmBRq+g8SNd4eEDjW6QzJ/EKg2XNcUPojiiCTSRsKyMgVPo4Oe3e0PVWofr4TAwTvk
	3eaygmV9TX2itaEgAcqobkgOIbxtIv4Pxw85y5VbjJtNsUaJ2M54u5TC1SuE47uN3O8SJX3VAaj
	kBb5Zk2lWXvW36ouGbSUTDZzceQsYMDn4Otpe8yvAf6RotI=
X-Google-Smtp-Source: AGHT+IGpq5/OCEFdQ+TZF1zpryf6y4xM+iZt7lLVSUOq/usT8S7qreEVV73onZtKR7ARsu+4VQGyUw==
X-Received: by 2002:a05:6402:51c8:b0:5e0:4c25:1491 with SMTP id 4fb4d7f45d1cf-5e762be893cmr3090490a12.7.1741690366467;
        Tue, 11 Mar 2025 03:52:46 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.240.197])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a476sm8097883a12.57.2025.03.11.03.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:52:45 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:52:43 +0100 (GMT+01:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: Takaya Saeki <takayas@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
	Nick Kralevich <nnk@google.com>,
	Jeffrey Vander Stoep <jeffv@google.com>,
	Junichi <uekawa@chromium.org>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	selinux@vger.kernel.org
Message-ID: <377a513c-2824-41da-874d-943190ad8937@googlemail.com>
In-Reply-To: <20250311092920.1114210-1-takayas@chromium.org>
References: <20250311092920.1114210-1-takayas@chromium.org>
Subject: Re: [PATCH v2] selinux: support wildcard match in genfscon
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <377a513c-2824-41da-874d-943190ad8937@googlemail.com>

Mar 11, 2025 10:29:42 Takaya Saeki <takayas@chromium.org>:

> Currently, genfscon only supports string prefix match to label files.
> Thus, labeling numerous dynamic sysfs entries requires many specific
> path rules. For example, labeling device paths such as
> `/sys/devices/pci0000:00/0000:00:03.1/<...>/0000:04:00.1/wakeup`
> requires listing all specific PCI paths, which is challenging to
> maintain. While user-space restorecon can handle these paths with
> regular expression rules, but relabeling thousands of paths under sysfs
> after it is mounted is inefficient compared to using genfscon.
>
> This commit adds wildcard match to support rules efficient but
> expressive enough. This allows users to create fine-grained sysfs rules
> without burden of listing specific paths. When multiple wildcard rules
> match against a path, then the longest rule (determined by the length of
> the rule string) will be applied. If multiple rules of the same length
> match, the first matching rule encountered in the genfscon policy will
> be applied. However, users are encouraged to write longer, more explicit
> path rules to avoid relying on this behavior.
>
> This change resulted in nice real-world performance improvements. For
> example, boot times on test Android devices were reduced by 15%. This
> improvement is due to the elimination of the "restorecon -R /sys" step
> during boot, which takes more than two seconds in the worst case.
>
> Signed-off-by: Takaya Saeki <takayas@chromium.org>
> ---
> Changelog between v2 and v1
> - Use given genfs rules by the userspace as is, instead of appending "*".
> - Fix __security_genfs_sid hadn't checked caps of the given argument.
> - Fix the wrong strncmp usage bug.
>
> security/selinux/include/policycap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 1 +
> security/selinux/include/policycap_names.h |=C2=A0 1 +
> security/selinux/ss/services.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++++++----
> 3 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/include/policycap.h b/security/selinux/incl=
ude/policycap.h
> index 079679fe7254..2b4014a826f0 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -15,6 +15,7 @@ enum {
> =C2=A0=C2=A0=C2=A0 POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> =C2=A0=C2=A0=C2=A0 POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> =C2=A0=C2=A0=C2=A0 POLICYDB_CAP_NETLINK_XPERM,
> +=C2=A0=C2=A0 POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> =C2=A0=C2=A0=C2=A0 __POLICYDB_CAP_MAX
> };
> #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinu=
x/include/policycap_names.h
> index e080827408c4..1053f2c95ff3 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -18,6 +18,7 @@ const char *const selinux_policycap_names[__POLICYDB_CA=
P_MAX] =3D {
> =C2=A0=C2=A0=C2=A0 "ioctl_skip_cloexec",
> =C2=A0=C2=A0=C2=A0 "userspace_initial_context",
> =C2=A0=C2=A0=C2=A0 "netlink_xperm",
> +=C2=A0=C2=A0 "genfs_seclabel_wildcard",
> };
> /* clang-format on */
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 8478842fbf9e..9f98c9dc71f6 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -48,6 +48,7 @@
> #include <linux/audit.h>
> #include <linux/vmalloc.h>
> #include <linux/lsm_hooks.h>
> +#include <linux/parser.h>
> #include <net/netlabel.h>
>
> #include "flask.h"
> @@ -2863,6 +2864,7 @@ static inline int __security_genfs_sid(struct selin=
ux_policy *policy,
> =C2=A0=C2=A0=C2=A0 struct genfs *genfs;
> =C2=A0=C2=A0=C2=A0 struct ocontext *c;
> =C2=A0=C2=A0=C2=A0 int cmp =3D 0;
> +=C2=A0=C2=A0 bool wildcard =3D 0;
>
> =C2=A0=C2=A0=C2=A0 while (path[0] =3D=3D '/' && path[1] =3D=3D '/')
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path++;
> @@ -2879,11 +2881,21 @@ static inline int __security_genfs_sid(struct sel=
inux_policy *policy,
> =C2=A0=C2=A0=C2=A0 if (!genfs || cmp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
>
> +
> +=C2=A0=C2=A0 wildcard =3D ebitmap_get_bit(&policy->policydb.policycaps,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);

Commonly policy capabilities are gathered via a helper from security.h from=
 selinux_state, shouldn't it here too?

> =C2=A0=C2=A0=C2=A0 for (c =3D genfs->head; c; c =3D c->next) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t len =3D strlen(c->u.name);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((!c->v.sclass || sclass =3D=3D =
c->v.sclass) &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (strncmp(c-=
>u.name, path, len) =3D=3D 0))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!c->v.sclass || sclass =3D=3D c=
->v.sclass) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wildcar=
d) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (match_wildcard(c->u.name, path))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 size_t len =3D strlen(c->u.name);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if ((strncmp(c->u.name, path, len)) =3D=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0 if (!c)
> --
> 2.49.0.rc1.451.g8f38331e32-goog

