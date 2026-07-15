Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B14743990C
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141978; cv=pass; b=Mz0Bd7VhZlztjOBp/JuKzjArhbGgo1rIxNiNfblKiM2TFD6eP6RmfrXRUs1dwC3tHOvxqLf5Pgg3y8iLPvFUz1SnWDsYscrb6jUcYS14H/xR1ZsKsz0a55zmKrLX5AOYb0n7yKwWy1NwUm3LeTFyIDlu4hesGTqu87y9+4YC43E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141978; c=relaxed/simple;
	bh=rj0uf/uaNWqqO0YinngNMS5HLrk8vesaza/nFRJ40EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWovzgc/Ve2iIFTXqe9XKw5pk1NW/5MKlIwHvsK8oiegHK+nv8X6RiCMbEeqgu6mfZIhR8s8sNAajMZAjSHZi1lRf6Z1Vkpu0/UtmBhHMboYAcY3VZCKA5KEQ+0i6lp8ESUuYcSoy/lP1ieGGCtoVLUHVGN7WUXFI6JVC5XDWFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rb4d/EE2; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rb4d/EE2"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39c7ce122c7so53718941fa.2
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 11:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784141959; cv=none;
        d=google.com; s=arc-20260327;
        b=flzv5DQ2D9iWARGHW9q/1XlcZ5nJDpulkoaKCkSUilZLj+yyuedtTNd+GnB2KgpARy
         cM7QXl1lE78QDc1/RNHaCKvw9JQP8Rmo0Rq0XvCF/6/gHHPfPz/+K56f6Ht3C/LiQZBj
         rI4Hh5sEBeMzKEQTd2okT0eWQFNF4ipwd/cXnJhopNAAIKVhhxNIEGj0UBByW+3aI9oh
         59nbdvMf8V5//liM+YLGWIVKlQEdjwFD2ych4U8nhQjECGY5z9JJsVyMqI+RmiRDJXJ/
         pfmXMvluOrQc2VStBHKnew3FCdKUMiw/5k4qbqdc/KVtUXiveGOAU+rW8hBc+26SJe0g
         PcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6BobxdqoMVbesU9sKe92Ws2sNb5cLRX4EhiFDTy4LL4=;
        fh=K2IQBBcrO8HnubWeTK+pps4B+GVAKD6hGCr6CeVX1cE=;
        b=gNL+7vrGf3MhyECfkVE0bI6N1s+IPVl3CibfSkbw+zUP4PYVGFUmICdLJ7+2+ctoiK
         WqtgDfYiV0p3J8I7P7jgwcOKMgBPP6uDqZNs15JVwlrlYc2pBXGMpAv3j4aoJDOOJesz
         yFngmhH/EoCf3StHr077+pyCeOXJoEfqdhjXxPLuFbu+/6QA/mD/ZsgLulYpp35+UeEV
         DeTr4O5n7NhcEzo4b9Mi74MGnnX1zEnTcpQsND9YG587jz0oKYulGkkyfYF5WSo7lV5h
         e98TCVj3g0tuHxX4UYBpFnFke3c5zQrBpzss3//qqUYJxaKQKtc0j6BCd/TPksI7xs8D
         HHVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784141959; x=1784746759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6BobxdqoMVbesU9sKe92Ws2sNb5cLRX4EhiFDTy4LL4=;
        b=Rb4d/EE2v1YAvEaZSQB9R7XgU3LHKPMs/wnnwA5XcvagkEuMjq2h40OdYqOChkv27B
         Ci+cJt42npxaiig8FtzhYrs3XHJvp4DAKLxP0pn9H+bKI/EXPlmfhvfKZyDbqiOTkkR8
         +0xEXIzIdzbKvWXNBKnPcK6/+pq0K2/KUKsIdHJtWMeJUpfh722EBWvSA+TnHZ/dtvfk
         8a+YLN41PxhFzXs+gNyY+fLlMUNC3aCnwh/PULhogQb7hKKuCGplzU/dQPtMKqXr6Vyn
         haxsXKDHyVMF72PDbZqhHP44IUeentBJoXzPi8XvimBvGcy6CKfQQGY3sDNfDxgBSiTG
         a+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141959; x=1784746759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6BobxdqoMVbesU9sKe92Ws2sNb5cLRX4EhiFDTy4LL4=;
        b=RlnptVzoGwbwbZ8DnteFrNPfSUlSlGwrpV9FL5at2qfQoD9neGtsCdrJRFSg2OXQFh
         exZfI+vEXqRKgH0DHxSOm93OyaI5Qig9FNpAaH3jbKJX9mDiD9ojWYjt1X5JfScqjLZ4
         k2AITtjdNAegRTo5VgqThcRbZNHbvpP6hWvZFb0188NoJmsod43rq9rUDXp2eaxI8b/N
         x41NXffkkhJN4ve6Y0t50aJXHxItJWlLaVoiySK4pAoFaXT8oIkn7VnFfwdrC4+eiFcn
         ipZz7DGNt79wUX66eMXVlXDAF0t7OXYJQfN3SbdTnQCQl4lTSuzDAKtBm8ue2Sje1KDm
         XpdQ==
X-Gm-Message-State: AOJu0Ywb0nv1yW6M08e5C7R9RWHMIXU1G9wobsu0BAZPBH7gPnLCPfvR
	jNXYQ5NcaXhxXjSfWCcUNmUo5XFG4raIXqaz75PyB8o8riac8535p7TFdlA5lH+D3apwrx5EGJA
	OVJvAUlo3I9TcfeNG0FQ5B42SYQO9liY=
X-Gm-Gg: AfdE7ckU9rf3tUujqepp98o1BJTlfV189flOMNy6IdxnLAvMaCIe8yNBiIpuuiwi3LM
	QSL+WxeWU1oMv7RSA+56m0buwd/V0A/kMMYxLeAvDZfywZT2BFQhSgYN8mE3dhP9AEbCdQDf/yL
	nIajYO1d1yk0jyBv4dwZxhaB2XRfLnXT+ROAbF9t+VX6KJYHONwwQqE4fsM2Ff74EMryn6vLp+3
	kTz6LD+m9oUJrSv/9WQdKAo0puufph2U8zxwocy41aXaoTiQhUaPjIhAfFNk8pekd7fVQ==
X-Received: by 2002:a05:651c:2229:b0:39b:374a:afb8 with SMTP id
 38308e7fff4ca-39dadafc115mr15328151fa.0.1784141958809; Wed, 15 Jul 2026
 11:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143155.36629-1-stephen.smalley.work@gmail.com> <20260706143155.36629-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260706143155.36629-2-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 15 Jul 2026 14:59:06 -0400
X-Gm-Features: AUfX_mwu0nfPx3s-kbN4P8mUst77okt3gyoQpUf9xzW0Z_eU46yHGh-QnxpX8uo
Message-ID: <CAP+JOzRA48R83Bb6=OXMCqjizYftiRbdGbZKFWbYPuS3+YtFNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] libselinux: avc: use pthread mutexes by default
 when no lock callbacks set
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	Seth Moore <sethmo@google.com>, 
	Purushottam Choudhary <purushottamchoudhary29@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:32=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The AVC has a set of locking calls but defaults to no locking, and
> only the deprecated avc_init() allowed applications to set their own
> locking callbacks. Since selinux_check_access() is now commonly used
> by applications implementing userspace SELinux permission checks and
> it uses avc_open() internally, such calls are currently not
> thread-safe.  Provide fallbacks to using pthread mutexes by
> default. Single-threaded programs that do not link -lpthread will be
> unaffected due to the existing __pthread_mutex() helpers. Applications
> that explicitly specify locking callbacks via the deprecated
> avc_init() will also be unaffected.
>
> This is the first step toward a thread-safe selinux_check_access();
> the class-string cache and status-page transition handling are
> addressed in follow-up changes.
>
> Fixes: #287 #335 #336
> Link: https://lore.kernel.org/selinux/CAJsHiNx1E7x1jaBkS0i4L1nBWXp8YXLHRW=
cCaDaH4LOn=3Dzm+Zw@mail.gmail.com/
> Link: https://lore.kernel.org/selinux/20220120073329.15234-1-purushottamc=
houdhary29@gmail.com/
> Reported-by: Seth Moore <sethmo@google.com>
> Reported-by: Purushottam Choudhary <purushottamchoudhary29@gmail.com>
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

For these five patches:
Acked-by: James Carter <jwcart2@gmail.com>


> ---
>  libselinux/src/avc_internal.h | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.=
h
> index 719be934..3c21ffef 100644
> --- a/libselinux/src/avc_internal.h
> +++ b/libselinux/src/avc_internal.h
> @@ -14,6 +14,7 @@
>  #include <string.h>
>  #include <selinux/avc.h>
>  #include "callbacks.h"
> +#include "selinux_internal.h"
>
>  /* callback pointers */
>  extern void *(*avc_func_malloc)(size_t);
> @@ -115,25 +116,41 @@ static inline void avc_stop_thread(void *thread)
>
>  static inline void *avc_alloc_lock(void)
>  {
> -       return avc_func_alloc_lock ? avc_func_alloc_lock() : NULL;
> +       pthread_mutex_t *m;
> +
> +       if (avc_func_alloc_lock)
> +               return avc_func_alloc_lock();
> +
> +       m =3D avc_malloc(sizeof(*m));
> +       if (m)
> +               __pthread_mutex_init(m, NULL);
> +       return m;
>  }
>
>  static inline void avc_get_lock(void *lock)
>  {
>         if (avc_func_get_lock)
>                 avc_func_get_lock(lock);
> +       else if (lock)
> +               __pthread_mutex_lock((pthread_mutex_t *)lock);
>  }
>
>  static inline void avc_release_lock(void *lock)
>  {
>         if (avc_func_release_lock)
>                 avc_func_release_lock(lock);
> +       else if (lock)
> +               __pthread_mutex_unlock((pthread_mutex_t *)lock);
>  }
>
>  static inline void avc_free_lock(void *lock)
>  {
>         if (avc_func_free_lock)
>                 avc_func_free_lock(lock);
> +       else if (lock) {
> +               __pthread_mutex_destroy((pthread_mutex_t *)lock);
> +               avc_free(lock);
> +       }
>  }
>
>  /* statistics helper routines */
> --
> 2.54.0
>
