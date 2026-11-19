Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095528;
	b=YhqIJaf1UHkaIq0931TQlkoS66wn8Q1K0tYCAJtAN7X9ogtBnkJHhM3rWjb7VYnrCLK9
	 SNhBXwDGkhaowHTU57G/cf2y8wyW1jxPvvnuBdvQzvfNG3BIocc/tlyqG37SUSRP/v8r4
	 oL1qgi0UWdwLXnqPgxhrTvAzYJ9hASa2wBpIDEWrGlxOQZEYVA8RV8LsYDXKCnEA+dlu0
	 H3sNAZcOT/vIDCP6X4YWxtsuEpaw8Jdmusw5rn4Cjod0o9oSQsLcKzPAKICnAn7hhfYWw
	 +yafyFisfcSE3CgfGjyaVLvGy8ZLX6eHw3d+j4y2ENyW1QjpYDR+o/tJLz2YNtOm0vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095528;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=1P7ztO1zUocWJRxSnrgPM5pBBmDXKWfiZrOQoqh2Un8=;
	b=Ewk6FnXBdnAgtfhqoYp+SxqHm6n8szdGB/5rDAQBoU/nwaf8PsS0HbigrXElQlMqcAUW
	 QRFXgo8xCN4Xk7cARXOtA4gy+7m3JJ7cls0r+P0oLe3sr2gbdXpjiumASA7cgZMqmIzVE
	 heGOAfwhmVEijy/vh/TLgpN34weI71kcFg6Lz2LtnmEfKQv0uXqhRgqC0p3I2YnnjYuMX
	 vpW4hkBjvpv/GF/vZozyPaeldklpZibgb0cE11BBhXDAyE2WUeoV+xnNuRhCj9uKHsXO7
	 DMSYTrKSY/V+OHMgDwdTLiiCljCEziMdtCv7W0N6YnMMPnIj89GsDwPxwzxNg1927mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCxEwyI4;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17AF606A324
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E17AF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCxEwyI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795095526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1P7ztO1zUocWJRxSnrgPM5pBBmDXKWfiZrOQoqh2Un8=;
	b=HCxEwyI4b+M3ofobUL/ursEEWbpF4Y5h4wN20OcgQucce68zwLqmm7+DC7z18uq8vfGzzP
	ux6j6VDk0k15LY8jChtOg5bEciy4Jp2bImq1MiYOZsKYbCU+UCnyhjJfkdDX3Qs9Uhx69+
	aw7wHplQ8LKFDf3Qd+HRGK2D6sx8774=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-SAO-vODPOAmIUXOxNeddBw-1; Thu,
 19 Nov 2026 08:38:41 -0500
X-MC-Unique: SAO-vODPOAmIUXOxNeddBw-1
X-Mimecast-MFC-AGG-ID: SAO-vODPOAmIUXOxNeddBw_1795095520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59061195606B;
	Thu, 19 Nov 2026 13:38:40 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3D531956041;
	Thu, 19 Nov 2026 13:38:37 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnacek@gmail.com, jwcart2@gmail.com, paul@paul-moore.com,
 jason@perfinion.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 3/3] sandbox/seunshare: run the sandbox in its own PID
 namespace
In-Reply-To: <20261119130355.707-3-stephen.smalley.work@gmail.com>
References: <20261119130355.707-1-stephen.smalley.work@gmail.com>
 <20261119130355.707-3-stephen.smalley.work@gmail.com>
Date: Thu, 19 Nov 2026 14:38:35 +0100
Message-ID: <pjdcxs1vt44.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> The SIGKILL sweep after waitpid() only reaches the child process
> group; a sandbox descendant that has called setsid() or setpgid()
> escapes it and can still be running while sandbox(1) walks the sandbox
> directories. The fd-based shred in sandbox is safe against that, but
> leaving the escapee alive at all is avoidable.
>
> Give the sandbox its own PID namespace so the sandboxed command is its
> init: when it exits the kernel SIGKILLs every remaining descendant and
> waits for the namespace to drain before the exit completes, so by the
> time the outer waitpid() returns nothing from the sandbox is running.
>
> unshare(CLONE_NEWPID) affects children only, so this needs an
> intermediate process between the parent and the sandbox init. That
> process takes the new session so the parent's kill(-child, ...) still
> addresses the sandbox process group, ignores forwarded signals so it
> outlives the sandbox, and relays its exit status. The setsid() before
> execv() is dropped so the sandbox stays in that group.
>
> /proc is left as-is; the sandbox process still has a PID in the outer
> namespace so /proc/self and the /proc/self/fd/N mount helpers keep
> working.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  sandbox/seunshare.c | 58 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index b39ca010..528eefd4 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -1009,6 +1009,57 @@ int main(int argc, char **argv)
>  		int fd_runuserdir_s = -1, fd_runtime_dir = -1;
>  		int fd_tmpdir_r = -1, fd_tmp = -1, fd_var_tmp = -1;
>  		struct stat sb;
> +		pid_t sandbox;
> +
> +		/*
> +		 * Put the sandbox in its own PID namespace so that when its
> +		 * init (the sandboxed command) exits, the kernel SIGKILLs
> +		 * every remaining descendant regardless of process group,
> +		 * and does so before the parent's waitpid() can return.
> +		 * This closes the setsid()/setpgid() escape the post-wait
> +		 * SIGKILL sweep cannot cover.
> +		 *
> +		 * unshare(CLONE_NEWPID) affects subsequent children only,
> +		 * so fork once more; this intermediate process is what the
> +		 * parent waits on and just relays the sandbox exit status.
> +		 * Take a new session first so the parent's kill(-child, ...)
> +		 * addresses this process group, which the sandbox and its
> +		 * well-behaved descendants stay in.
> +		 */
> +		if (setsid() == (pid_t)-1) {
> +			perror(_("setsid"));
> +			exit(-1);
> +		}
> +		if (unshare(CLONE_NEWPID) < 0) {
> +			perror(_("Failed to create PID namespace"));
> +			exit(-1);
> +		}
> +		sandbox = fork();
> +		if (sandbox == -1) {
> +			perror(_("Unable to fork"));
> +			exit(-1);
> +		}
> +		if (sandbox > 0) {
> +			int st;
> +
> +			/*
> +			 * Ignore forwarded signals so this process outlives
> +			 * the sandbox and the PID namespace guarantee holds;
> +			 * the process-group signal reaches the sandbox
> +			 * directly.
> +			 */
> +			signal(SIGINT, SIG_IGN);
> +			signal(SIGHUP, SIG_IGN);
> +			signal(SIGTERM, SIG_IGN);
> +			signal(SIGQUIT, SIG_IGN);
> +
> +			if (waitpid(sandbox, &st, 0) < 0)
> +				exit(-1);
> +			status_to_retval(st, st);
> +			exit(st);
> +		}
> +
> +		/* PID 1 in the new namespace from here on. */
>  
>  		if (unshare(CLONE_NEWNS) < 0) {
>  			perror(_("Failed to unshare"));
> @@ -1225,7 +1276,6 @@ int main(int argc, char **argv)
>  			perror(_("Failed to change dir to homedir"));
>  			goto childerr;
>  		}
> -		setsid();
>  
>  		/* selinux context */
>  		if (execcon) {
> @@ -1283,8 +1333,10 @@ childerr:
>  	 * budget; with the fd-based shred in sandbox(1), timing out here
>  	 * only leaves a straggler alongside a race-free cleanup.
>  	 *
> -	 * This does not cover a descendant that left the process group via
> -	 * setsid()/setpgid(); a PID namespace is the complete answer.
> +	 * With the PID namespace above, waitpid() returning implies the
> +	 * namespace has been torn down and no sandbox descendant is
> +	 * running, so this sweep breaks on the first iteration; kept as
> +	 * a cheap safety belt.
>  	 */
>  	for (int i = 0; i < 400; i++) {
>  		struct timespec ts = { .tv_sec = 0,
> -- 
> 2.47.3

