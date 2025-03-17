Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFEC1FF7C3
	for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246234; cv=none; b=Qr19pi41WTzRyax3qRRs1NImVm7NxxEPtUiPO9AhAi6s+zrRV8pfBj4iegYwFUu002oeANeNL1OxV9sxQtECXh/hk748G+tI7FkxtyD23qwlszUyvl4TrSbdpZQ1RMYWEMYBSbFvSL60kaUZOSI/NW/OeNvclWDFTSQW7vsv0/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246234; c=relaxed/simple;
	bh=NT/K25cmcnnBX6QzIcBu5FXMupG/8yJIWJxGccHMp0E=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ltB5q0Lv8RCNuIWsi2Uxo3wWA8trMTP0X0x4GV6b/V1o1TV8/sIvXO2jJGF+zvpsvtUDeAYFqGXvkJdqXi0q1P5A5raPyT/qnbyRvbW7WEcPTQUoj++bmDg761Fkz1/f1uzX3aPkuwU5SOhZIcIrobcftZp87qJ9xJksqsKAbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dvtnRmml; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dvtnRmml"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8f916e75fso66969776d6.1
        for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742246231; x=1742851031; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nm7JxfgD1i5a21sOUZgyWiBipBOWRr7gyHrbd93BnV0=;
        b=dvtnRmml9PkZDXUjrIA6SfSeJZukrzdd1fhqb1Etq34ky9W+0TOkfG4zfFlQ0kvzZo
         rfEJ80GbbjMuDCW8Yb39kCguiyUBHM6t65op8wJO/XyKLKVmOZXIRh9p6+QCKkGGtrtg
         A6FprRvzS8xLp7F5sYuM1hPSAC7P1AitCbV4s2sMuXjST8l6BvJJU1v3kfLrFfAZ1of4
         sARkwfi7/YuIrYrmE7InLHXvBVUqxkkKvHI9DOXw9vUFg0tWnk19lDXho+v59qffA/GB
         B+M1oo8NSTXMx2GDtsYuAsVIoW5GbambPSiHn3Y5qi5b6DNgaN4f9MqZTv/BnAF/sWxt
         H9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742246231; x=1742851031;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nm7JxfgD1i5a21sOUZgyWiBipBOWRr7gyHrbd93BnV0=;
        b=GtF5x3kJVcvPnW7varf06jxuDCraSa+lJMA35pRLrJLilpq5DJWCSdktk8cZGLf4rk
         oMBifwUPp7M7z24LeKOTa4k+sLPnLuMUBwSU8+3eXkz42WGiE4Th1sZEuQ969JQEoHj3
         TG6MNvNQLttzhcUuyWz6srpyTiy48maxzheou6Dr/DEjcQIYGSMNueRgeEnisbTP8+px
         zqj4PRyMvMA3TuT/K+fbd/jHal5lSv5wMRTovRaDdaa8ibyd/g1IEbaHSXeHT6z8+vLw
         u4AKaHSDD5p/ds3BFhjU/GYQnkSuzceIz3SMsFSaB8DcqiSFy/7XpBaGQ/OD8kvuP+zy
         hRjA==
X-Forwarded-Encrypted: i=1; AJvYcCWySFPM8cqfhtp99JQgFjn8z7JngBcFDFkjz9I7G2c0qnLWDMWmOSujJZVc2zRjVUBI6pLctP5W@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQeEmADsQROLZhmValOvnESfhi6UbwePz7LdP6DfmQu+uKExP
	3fBZEGhRGpculxHrv0vzz1YX26zDV/06pWzN2u0ZdRwjgJwPKWEezQIgqPBkZg==
X-Gm-Gg: ASbGncsMPoiLkEdHPt0sOOBxL5mTCzSri/LFzMQ1KvMlpFVTUup3LwVzJzXoVyJzKEF
	ZITQCwWf6vjyiHaSOBOtSXydTwPaQtsL7mPQZcFclgWUtMxmI7EX8OFIs9tWoa+nmevsJnLnokO
	APXP42gIWi19RVMil+9PzMrNG6UZ4vk0fjfL9sB3srrlC3YQVPqdqyhus7cK+xQ1E6KqMrAQt0O
	Uvwk4K/GWY3HAXDb0IQNfmppRSncryT1o0wtCyROZR/hSXHnh26ysM8de060VUgFM+qLBq00XSb
	rEowpTn8e6eX/ZS8M2jGZut4rvjLZL4L2U7+66we2KmU1QTgIBE28o7dzpNptR925dIgEWQtFqa
	wKzQ9dOHvomQ0kg==
X-Google-Smtp-Source: AGHT+IEu/zA/KmBu3i4+yYYBasDOL7q9y+GfHKDnVq+VWDyVOBtl0w2WBN9k4ofRexTO3FCkNGVVRA==
X-Received: by 2002:a05:6214:54c6:b0:6e4:2198:12fe with SMTP id 6a1803df08f44-6eb1bd0a6eamr17902346d6.18.1742246231461;
        Mon, 17 Mar 2025 14:17:11 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade34bae9sm58857796d6.99.2025.03.17.14.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 14:17:10 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:17:10 -0400
Message-ID: <b193793a15fe88b6f390e824da073238@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250317_1618/pstg-lib:20250317_1551/pstg-pwork:20250317_1618
From: Paul Moore <paul@paul-moore.com>
To: Takaya Saeki <takayas@chromium.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org, Takaya Saeki <takayas@chromium.org>
Subject: Re: [PATCH v2] selinux: support wildcard match in genfscon
References: <20250311092920.1114210-1-takayas@chromium.org>
In-Reply-To: <20250311092920.1114210-1-takayas@chromium.org>

On Mar 11, 2025 Takaya Saeki <takayas@chromium.org> wrote:
> 
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
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/ss/services.c             | 20 ++++++++++++++++----
>  3 files changed, 18 insertions(+), 4 deletions(-)

I would mention in the commit description above that the new
functionality is gated by the "genfs_seclabel_wildcard" policy
capability.  Otherwise this looks much better, thank you for the
revision; there are a couple of comments below, but they are minor
and you already mentioned one of them ;)

> diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
> index 079679fe7254..2b4014a826f0 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -15,6 +15,7 @@ enum {
>  	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
>  	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
>  	POLICYDB_CAP_NETLINK_XPERM,
> +	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
>  	__POLICYDB_CAP_MAX
>  };

As far as piggy-backing on top of NETIF_WILDCARD, it's generally best to
use individual policy capabilities unless there is some reason why making
one change to the policy would also require you to change the other.

You could consider adding a
selinux_policycap_genfs_seclabel_wildcard() function, but since there
isn't a need for it in this patch, and I question where else we might
ever need it, it's fine if you want to omit the helper function and leave
it as-is.

>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
> index e080827408c4..1053f2c95ff3 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -18,6 +18,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
>  	"ioctl_skip_cloexec",
>  	"userspace_initial_context",
>  	"netlink_xperm",
> +	"genfs_seclabel_wildcard",
>  };
>  /* clang-format on */
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 8478842fbf9e..9f98c9dc71f6 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -48,6 +48,7 @@
>  #include <linux/audit.h>
>  #include <linux/vmalloc.h>
>  #include <linux/lsm_hooks.h>
> +#include <linux/parser.h>
>  #include <net/netlabel.h>
>  
>  #include "flask.h"
> @@ -2863,6 +2864,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
>  	struct genfs *genfs;
>  	struct ocontext *c;
>  	int cmp = 0;
> +	bool wildcard = 0;

As you mentioned earlier, I think we can get rid of this assignment.

>  	while (path[0] == '/' && path[1] == '/')
>  		path++;
> @@ -2879,11 +2881,21 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
>  	if (!genfs || cmp)
>  		return -ENOENT;
>  
> +
> +	wildcard = ebitmap_get_bit(&policy->policydb.policycaps,
> +				   POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);

It looks like you're adding an extra blank line above the wildcard
assignment, please don't do that, a single blank line is sufficient
vertical whitespace.

>  	for (c = genfs->head; c; c = c->next) {
> -		size_t len = strlen(c->u.name);
> -		if ((!c->v.sclass || sclass == c->v.sclass) &&
> -		    (strncmp(c->u.name, path, len) == 0))
> -			break;
> +		if (!c->v.sclass || sclass == c->v.sclass) {
> +			if (wildcard) {
> +				if (match_wildcard(c->u.name, path))
> +					break;
> +			} else {
> +				size_t len = strlen(c->u.name);
> +
> +				if ((strncmp(c->u.name, path, len)) == 0)
> +					break;
> +			}
> +		}
>  	}
>  
>  	if (!c)
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog

--
paul-moore.com
