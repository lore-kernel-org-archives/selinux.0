Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA48725BAD4
	for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710233; cv=none; b=p8UlmMEr88BLWkzHHn5rBjJ68rbY1qRKqDbY15wzOzrskP5D5Z0nV/SdIibwjT5Qgf5YpuYMlgdQmGJtb5IW9YDKFt3LG9eEwWdqOhPRy5+B+GEHs+H4/X9iIwgwG4WeR6V2JSnSfg/whzlr1FEtrSFqJtSOroi1dpLfHhACVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710233; c=relaxed/simple;
	bh=rg7gNS28DMX9p6/TeUVitpb3E118ASIwrFKZpSowqec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U01S4Eb/Blh1CY3og8IjkqfavRjDRf62yLKykZw/+QlA0anpa4dLgvXBuwwPNIeDkzV7p/Dh91oOmj3jeJv64TGgG6GwBsaiIMBgFY1H+t2IdXzz+5JiVnyIBcY771QaqTe4Zpn8YBpO+RuH9G2xnX5fuJM4Sl+RRlzUU/4Jv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSXQXzsa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSXQXzsa"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-300f92661fcso2913667a91.3
        for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741710231; x=1742315031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azpJgbwHHSyFKFEckKCoMgYqjzGx1BMGqnhFS7w2B2Y=;
        b=KSXQXzsatCPjEmv8fxEC+EkZABcpsSVABNqq61wdFQ0KPOmTxzNIL9DiqAu7IVBZ4a
         7SqAN0sfQgf1giDcZdifepoB736tKApT/u7Rcqticdl4GDmVMmXkcPpTcXzXHrXdrWpY
         Tt3rxrJblLOshiuXVRStExbt2laSgFuwH/UcVy3SaRTyrxuE2vg1cQk5nfjAw3Mp0U+O
         RP/PnhesoitmqgIlJOPGSljOK0iWw/FTp+TVUniuBQxOXrMr8UtS9w6T0uT/d7f3mpEt
         vIPJUZOLk638dw52JkE0+MecSLwexmtNa4uNnu/9TGwcKPpuzP9hYwnrtn5o3BxCyTQ9
         H1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741710231; x=1742315031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azpJgbwHHSyFKFEckKCoMgYqjzGx1BMGqnhFS7w2B2Y=;
        b=l3a+zb2GP07eTO19SJs/kDFDXs0etK90JxxBM/UE1u5VU3ykdFwihwsSQek8/hPLL7
         P3cMwG1ANaObVraKXAkPI2kzHrlCpqBO9xENWxhA/qRvhEsAjluwBL5uMmYUb6xFg/VO
         R9SSc4jSsyQTsVBPA5fDcZxMIj1PgHYIMcQRZtoyDab0scKfTFEasXRNFUurAs2RQ1CP
         l+qCZ2sUEjG2n1DXiNFZo7rLGQ04VQ3+DzyVMxM+CDto2BnTsBwKLUz4VMqKClPRXXcH
         QTFDFV4FoB4gwt4hGmMuhyxJqoA0OwSCilU5mt3jcsERjB/fLOxTMaeA7T5ExBJBizPp
         hNFg==
X-Forwarded-Encrypted: i=1; AJvYcCU2rZyLMFinbZzx0IyI1I8QOtKgPPWIsIoZGFLNMrxYp/6+xiUNMfUVksQoeom7HjG1iSRYSXsc@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9un7XTzyfLiLkyjagSJ1G7WVmQvEccpuy8t19Mh578vB1w+b
	VT5RXUc5eqcqf2vLNhSQnkOZOHkEAAIC+WHP1XnyVhk2EU1cMyBbC8zRRSEP7p0+Owt2W2xRFVv
	i5G7mDdT7nW5hG87AEWxDt9dC6kU=
X-Gm-Gg: ASbGnctQ7NRQzzLHGhkQ8clJVbHdf9a1gNnvSo3j1JPyviRXAnqjCkUnZybM4auP/Z8
	/L1bEpN6MWnxzfSeoDg0/j0F8V6KPpkdKj9gjpomcLdAxicC+W/UjtavOUJSjDa08FknjrNV5WP
	/05SLxsvvbSt7iopunAsci00k2aA==
X-Google-Smtp-Source: AGHT+IE3+Yfu0dom3RmDlNd/k1+ke0JIVtInhrgR7FxAnHIebdloY4pKlBpFQddwbYxk1zyWXsPwed7KVf5/N2Z24M4=
X-Received: by 2002:a17:90b:224b:b0:2ff:71ad:e84e with SMTP id
 98e67ed59e1d1-2ff7ce7abccmr27775945a91.10.1741710230747; Tue, 11 Mar 2025
 09:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311092920.1114210-1-takayas@chromium.org> <377a513c-2824-41da-874d-943190ad8937@googlemail.com>
In-Reply-To: <377a513c-2824-41da-874d-943190ad8937@googlemail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 11 Mar 2025 12:23:39 -0400
X-Gm-Features: AQ5f1JomSc_udiUUAVcuWqsCUHIgLHGr4Ruh30Fl8JjWnmoTrxnS3HPM_nTefrg
Message-ID: <CAEjxPJ4bv98z5Ok286ZMKSCG2ei74dWaB3wZ4xws2ejcxHaLdw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: support wildcard match in genfscon
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Takaya Saeki <takayas@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 6:52=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Mar 11, 2025 10:29:42 Takaya Saeki <takayas@chromium.org>:
>
> > Currently, genfscon only supports string prefix match to label files.
> > Thus, labeling numerous dynamic sysfs entries requires many specific
> > path rules. For example, labeling device paths such as
> > `/sys/devices/pci0000:00/0000:00:03.1/<...>/0000:04:00.1/wakeup`
> > requires listing all specific PCI paths, which is challenging to
> > maintain. While user-space restorecon can handle these paths with
> > regular expression rules, but relabeling thousands of paths under sysfs
> > after it is mounted is inefficient compared to using genfscon.
> >
> > This commit adds wildcard match to support rules efficient but
> > expressive enough. This allows users to create fine-grained sysfs rules
> > without burden of listing specific paths. When multiple wildcard rules
> > match against a path, then the longest rule (determined by the length o=
f
> > the rule string) will be applied. If multiple rules of the same length
> > match, the first matching rule encountered in the genfscon policy will
> > be applied. However, users are encouraged to write longer, more explici=
t
> > path rules to avoid relying on this behavior.
> >
> > This change resulted in nice real-world performance improvements. For
> > example, boot times on test Android devices were reduced by 15%. This
> > improvement is due to the elimination of the "restorecon -R /sys" step
> > during boot, which takes more than two seconds in the worst case.
> >
> > Signed-off-by: Takaya Saeki <takayas@chromium.org>
> > ---
> > Changelog between v2 and v1
> > - Use given genfs rules by the userspace as is, instead of appending "*=
".
> > - Fix __security_genfs_sid hadn't checked caps of the given argument.
> > - Fix the wrong strncmp usage bug.
> >
> > security/selinux/include/policycap.h       |  1 +
> > security/selinux/include/policycap_names.h |  1 +
> > security/selinux/ss/services.c             | 20 ++++++++++++++++----
> > 3 files changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/selinux/include/policycap.h b/security/selinux/in=
clude/policycap.h
> > index 079679fe7254..2b4014a826f0 100644
> > --- a/security/selinux/include/policycap.h
> > +++ b/security/selinux/include/policycap.h
> > @@ -15,6 +15,7 @@ enum {
> >     POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> >     POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> >     POLICYDB_CAP_NETLINK_XPERM,
> > +   POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> >     __POLICYDB_CAP_MAX
> > };
> > #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> > diff --git a/security/selinux/include/policycap_names.h b/security/seli=
nux/include/policycap_names.h
> > index e080827408c4..1053f2c95ff3 100644
> > --- a/security/selinux/include/policycap_names.h
> > +++ b/security/selinux/include/policycap_names.h
> > @@ -18,6 +18,7 @@ const char *const selinux_policycap_names[__POLICYDB_=
CAP_MAX] =3D {
> >     "ioctl_skip_cloexec",
> >     "userspace_initial_context",
> >     "netlink_xperm",
> > +   "genfs_seclabel_wildcard",
> > };
> > /* clang-format on */
> >
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 8478842fbf9e..9f98c9dc71f6 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -48,6 +48,7 @@
> > #include <linux/audit.h>
> > #include <linux/vmalloc.h>
> > #include <linux/lsm_hooks.h>
> > +#include <linux/parser.h>
> > #include <net/netlabel.h>
> >
> > #include "flask.h"
> > @@ -2863,6 +2864,7 @@ static inline int __security_genfs_sid(struct sel=
inux_policy *policy,
> >     struct genfs *genfs;
> >     struct ocontext *c;
> >     int cmp =3D 0;
> > +   bool wildcard =3D 0;
> >
> >     while (path[0] =3D=3D '/' && path[1] =3D=3D '/')
> >         path++;
> > @@ -2879,11 +2881,21 @@ static inline int __security_genfs_sid(struct s=
elinux_policy *policy,
> >     if (!genfs || cmp)
> >         return -ENOENT;
> >
> > +
> > +   wildcard =3D ebitmap_get_bit(&policy->policydb.policycaps,
> > +                  POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
>
> Commonly policy capabilities are gathered via a helper from security.h fr=
om selinux_state, shouldn't it here too?

Those are for accessing the cached policy capabilities in the
selinux_state from outside of the security server (and without holding
any locks), e.g. from the hook functions.
No need for that here, and this is more correct - using the policy we
were passed rather than whatever selinux_state might reference at the
time (e.g. during a policy reload).
