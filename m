Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095501;
	b=DqUgqMsBX9l+JCvKWsdB29MyEsZOogpffrHpl1RkBdBf63PYOaoKU22mQVUfGQ/kf4Zj
	 Pen/GBcxwOosUkcFoAPrY9GYSA7CgHiD4oh4EoqGm0I6SDEeda7q9Ln+KiLboNLRq4wJ5
	 9m4zckKXMKFqwSMtWGooWo9tehgpoGDL0CFCsr4EuIQ4hdPydjwS3P839iycJ5XRntr9+
	 sRdAdrfEBsZ7yKvYMYuo2hQVLOSPr49yqZdGBw1/waBG51vsv6n+/HJcSVLmgaqA2X9ev
	 ZjVbNGyZk9tylpREsqKk1U9iSgwwPZHU0BStkVNg29nC6xQ3W1fzjjRnqcxtMaYOIQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095501;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=x+qeW5632vxIOctYtE/pPY00qPCGLgizlYsE5w3xGOA=;
	b=Frbf++oE2p6+O9lJIdxC2u3A8IDFZS99REWQ9pbt5VfCOriTh1bHovvTZ2n+4LSG+CUe
	 StbJFT44OKjAwBrkCFWFxPV9yydvY4EoJri5wIyB44mImK1rm1AF6nwBggnVYvrFPQrdb
	 SdYVN6MeG3sV6ZYyPAFYehINLXmR34t2w7zvfQFysL5Fb6yt0Wj4ZqUUTm0TdurTcWtx/
	 lhaA4EYyedNNtFVayKK0WoNgLUsa0KofPZE9glIu9hkufnLvCHez5tWUpd3DEnvzBlDw7
	 7BeJAh9HtR8QGY+EbIGHga/YtGm7o64u4EHAYubG5uXu/bOUHDhA2zNZG5Khl4ij5jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UhbF5Gba;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D183606A320
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D183606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UhbF5Gba
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795095499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x+qeW5632vxIOctYtE/pPY00qPCGLgizlYsE5w3xGOA=;
	b=UhbF5Gbaes5LRrB/BleqKZrZBcNcy55mIuM1JgyssH86+MTarlct7/crDbHE8Uykm9XaAM
	9aTRIErUiPD1iZjw1gFTna5quxvTu9xumto28sul/awxXd1BTFYDgFYDpXP2OwmYW4vjHw
	HB68VpMt1L0stkw7XT42/0YTXW8EJDY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-JCEnqrQPNJi-mKj-lUdIhg-1; Thu,
 19 Nov 2026 08:38:17 -0500
X-MC-Unique: JCEnqrQPNJi-mKj-lUdIhg-1
X-Mimecast-MFC-AGG-ID: JCEnqrQPNJi-mKj-lUdIhg_1795095494
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38DB3195605B;
	Thu, 19 Nov 2026 13:38:14 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75EE23001DB1;
	Thu, 19 Nov 2026 13:38:11 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnacek@gmail.com, jwcart2@gmail.com, paul@paul-moore.com,
 jason@perfinion.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 2/3] sandbox/seunshare: SIGKILL and drain the child
 process group
In-Reply-To: <20261119130355.707-2-stephen.smalley.work@gmail.com>
References: <20261119130355.707-1-stephen.smalley.work@gmail.com>
 <20261119130355.707-2-stephen.smalley.work@gmail.com>
Date: Thu, 19 Nov 2026 14:38:09 +0100
Message-ID: <pjdh5hdvt4u.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> After the sandboxed process exits, seunshare sends SIGTERM to its
> process group and returns; sandbox(1) then walks the sandbox
> directories. A descendant that ignores SIGTERM, or that is stll
> draining, is still alive during that walk.
>
> Send SIGKILL instead and loop until kill(-child, SIGKILL) reports
> ESRCH, re-sending each pass so a process that fork()s between our
> signal and its own exit is caught the next time. Bound the loop at 2s:
> a grandchild stuck in uninterruptible sleep, or a zombie not yet
> reaped by init, holds the pgid alive, and with the fd-based shred in
> the previous commit, sandbox is safe against a survivor anyway.
>
> The SIGINT/SIGHUP forwarder in handler() is left forwarding the
> received signal so ^C still reaches the sandboxed application; the
> post-wait SIGKILL sweep runs afterwards.
>
> This does not cover a descendant that left the process group via
> setsid()/setpgid() before the sweep. Placing the child in its own PID
> namespace would make waitpid() returning imply no descendant exists;
> that is left to a future change.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  sandbox/seunshare.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 9f7e49da..b39ca010 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -7,6 +7,7 @@
>  #include <stdbool.h>
>  #include <signal.h>
>  #include <sys/fsuid.h>
> +#include <time.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> @@ -1274,8 +1275,25 @@ childerr:
>  	waitpid(child, &status, 0);
>  	status_to_retval(status, status);
>  
> -	/* Make sure all child processes exit */
> -	kill(-child, SIGTERM);
> +	/*
> +	 * Make sure the child process group is gone before cleanup runs.
> +	 * SIGKILL each iteration so a descendant that fork()s between our
> +	 * signal and its own exit is caught on the next pass. Zombies keep
> +	 * the pgid alive until init reaps them, so give this a bounded
> +	 * budget; with the fd-based shred in sandbox(1), timing out here
> +	 * only leaves a straggler alongside a race-free cleanup.
> +	 *
> +	 * This does not cover a descendant that left the process group via
> +	 * setsid()/setpgid(); a PID namespace is the complete answer.
> +	 */
> +	for (int i = 0; i < 400; i++) {
> +		struct timespec ts = { .tv_sec = 0,
> +				       .tv_nsec = 5 * 1000 * 1000 };
> +
> +		if (kill(-child, SIGKILL) < 0 && errno == ESRCH)
> +			break;
> +		nanosleep(&ts, NULL);
> +	}
>  
>  	if (execcon && kill_all)
>  		fprintf(stderr,
> -- 
> 2.47.3

