Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7078F45
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403960; cv=none; b=lWwtcqf99VNmU7mGvEBc762/wYRmFB7joZRDomp+QNwdI2poQSbh/ZAY5ZmfJcP4BylUci8R5cXQ2JOXGksqtiAg6bUH5CZo4vRbpfSsuLlgF0O5DUm6A4//xT8olGWQNk/PfYrJ2kjiYzYodU9vV7pBt99KwmBZEmWohgWeQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403960; c=relaxed/simple;
	bh=Dd21HafqvhL4LRmMHr6UG9JPN3gDkPg8ZPL81BYDCH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hu7ysG9fi5FBaKUGmKBkrKl+XFpDno5T6PhL1o8v3LBqxVqKmMbuqj5/mGMqvFj21VlezYgUZSlzqPJRbNyqlxz6seDBMWMxZKsdPZo3AoMNJsI5tQiUpj2Qxy/af3w5OD157RD9W/uiiHm190VCRdJxJfL0dlwuZZHJp1P/9J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TPCGUJFP; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TPCGUJFP"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e702cffe574so2005166276.3
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744403956; x=1745008756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqnWJXfJZynDBCqgWxl9HwCmqxFniyodhiMPOH67rZU=;
        b=TPCGUJFPuTBeVgbBxbPNdyOG8+ExmujInxQqqLWHq4C13oes88QgqhFPx/lWASd9+E
         sXwb0/zXyDG6W+yvFDPFmFYvBHlgfXv5Bh8Y7AiRb0wPYdtNEKxbVmuyAn8Ba3KqeGOp
         G3ATbE96cOl2/33EHjZCmyiAB2mfbY1mkmciaBJ0/wdreIKlRmVm0UWiORNVX/Ht9Wxv
         00EBHElERULvVrydy6WXRgG4R81oybCvfWF7SR9ek6/Iz9ue5nr4T0ItgzN0K2lp1Pqr
         fvEimq3uCxOnOUDFbf00FZ9H9b8DumJipGLbNy7TfedZxdmpbx6wMb5+vUI0WlXmGaTL
         pMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403956; x=1745008756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqnWJXfJZynDBCqgWxl9HwCmqxFniyodhiMPOH67rZU=;
        b=XObQTiG+jR2m4lG2o0/dpPxNKcEAgVfwq8dKJa8+wb3eyNhylxeqGQlF9Xs6cUEkhk
         AGN2ng2qsV7sDJ9gU4reOZ9HqHw8XLD72wtbBYBTMvJ018LgrOcYeZujHO1yIWP+q/gi
         gNwC49wqsDwB+vEaGcpUIR8IDdG8KV1K7okWYByMcNMjRM1+Y8Jq0dxWG045vANJiai3
         JWo5OE2g5UfXlmSEn9fOak3PK6mWNSdV88GjuT2q9zIATYcr5WU2V5+iOfh5S1Fx18v4
         RgV0IHU+VivpHAUAubNdfNSkNlMs18Cjyfz15oaDeQF4Ou+BbDM+9LQf4BmOK4vpY1hy
         JrUQ==
X-Gm-Message-State: AOJu0YwO/annd2ahxGXsMmVg4Om8j6ksY9nFsBF8hO6awRwkr7ojsUKb
	eGfssWqb8qrti32e9V+5p/wVKwaJrwcoAGyZc7lW+iFVT3uBAcQpVQQ6s/t/bWcNDpi3LjAGku1
	QdGjJ2+wYzbEhnuztOpqUik/+njmLu7REFK3O
X-Gm-Gg: ASbGncs93G+Pudky0onfOiWqL0c3fQG0PGE4At3qi9ze0EhMij/kwGwoPIqkb0XBE/u
	MQZIPGtnMp0aF1ggFB0GsfDmzAocOkJLEhDabSCA6pa8sZFFsiA9qrNy/4EDKwKYo5iSPxrJs/p
	3jYMlQhnuinC6Kd2IuEuGrRH2qpbWdbYUF
X-Google-Smtp-Source: AGHT+IG+ivbzYDg7Yv8rMqkAPpM3eUX3zyW4y3sU5Qf5AdYqwiVa67YziIg7FB0f1ZB4OQCwHpVPSczbJI1218No19Y=
X-Received: by 2002:a05:6902:1b04:b0:e6d:ec5e:b5ee with SMTP id
 3f1490d57ef6-e704dfff3acmr6346753276.30.1744403956343; Fri, 11 Apr 2025
 13:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410192031.259180-2-paul@paul-moore.com> <CAEjxPJ4G6+f74EA4usHA+ZqW_tuVXCkft-2+3wApXVpRMtMNEg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4G6+f74EA4usHA+ZqW_tuVXCkft-2+3wApXVpRMtMNEg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Apr 2025 16:39:05 -0400
X-Gm-Features: ATxdqUHtj0GWX7zruQ-rUYchCdb0P3RD3r4XBJcgM1EMHFO_0JxpB5iFclG145E
Message-ID: <CAHC9VhTuw-Loa0Yi1wB8s-q0=jUgghWXDUiSrU-vuf3fa3ncpA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: reduce path walk overhead
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 9:15=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Apr 10, 2025 at 3:25=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Reduce the SELinux performance overhead during path walks through the
> > use of a per-task directory access cache and some minor code
> > optimizations.  The directory access cache is per-task because it allow=
s
> > for a lockless cache while also fitting well with a common application
> > pattern of heavily accessing a relatively small number of SELinux
> > directory labels.  The cache is inherited by child processes when the
> > child runs with the same SELinux domain as the parent, and invalidated
> > on changes to the task's SELinux domain or the loaded SELinux policy.
> > A cache of four entries was chosen based on testing with the Fedora
> > "targeted" policy, a SELinux Reference Policy variant, and
> > 'make allmodconfig' on Linux v6.14.
> >
> > Code optimizations include better use of inline functions to reduce
> > function calls in the common case, especially in the inode revalidation
> > code paths, and elimination of redundant checks between the LSM and
> > SELinux layers.
> >
> > As mentioned briefly above, aside from general use and regression
> > testing with the selinux-testsuite, performance was measured using
> > 'make allmodconfig' with Linux v6.14 as a base reference.  As expected,
> > there were variations from one test run to another, but the measurement=
s
> > below are a good representation of the test results seen on my test
> > system.
> >
> >  * Linux v6.14
> >    REF
> >      1.26%  [k] __d_lookup_rcu
> >    SELINUX (1.31%)
> >      0.58%  [k] selinux_inode_permission
> >      0.29%  [k] avc_lookup
> >      0.25%  [k] avc_has_perm_noaudit
> >      0.19%  [k] __inode_security_revalidate
> >
> >  * Linux v6.14 + patch
> >    REF
> >      1.41%  [k] __d_lookup_rcu
> >    SELINUX (0.89%)
> >      0.65%  [k] selinux_inode_permission
> >      0.15%  [k] avc_lookup
> >      0.05%  [k] avc_has_perm_noaudit
> >      0.04%  [k] avc_policy_seqno
> >      X.XX%  [k] __inode_security_revalidate (now inline)
> >
> > In both cases the __d_lookup_rcu() function was used as a reference
> > point to establish a context for the SELinux related functions.  On a
> > unpatched Linux v6.14 system we see the time spent in the combined
> > SELinux functions exceeded that of __d_lookup_rcu(), 1.31% compared to
> > 1.26%.  However, with this patch applied the time spent in the combined
> > SELinux functions dropped to roughly 65% of the time spent in
> > __d_lookup_rcu(), 0.89% compared to 1.41%.  Aside from the significant
> > decrease in time spent in the SELinux AVC, it appears that any addition=
al
> > time spent searching and updating the cache is offset by other code
> > improvements, e.g. time spent in selinux_inode_permission() +
> > __inode_security_revalidate() + avc_policy_seqno() is less on the
> > patched kernel than the unpatched kernel.
> >
> > It is worth noting that in this patch the use of the per-task cache is
> > limited to the security_inode_permission() LSM callback,
> > selinux_inode_permission(), but future work could expand the cache into
> > inode_has_perm(), likely through consolidation of the two functions.
> > While this would likely have little to no impact on path walks, it
> > may benefit other operations.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Thanks for doing this!
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks for the review and additional testing :)

--=20
paul-moore.com
