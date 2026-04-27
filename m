Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76D2F12AC
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308783; cv=none; b=WEHN5jLY+st5G/YzY7W1LMY9b5/0Z9bCI5rt7FV6Q7QA6xUR5vububDkiUYGMufCcYZl7M5BtXKJ1rqALCocuwnCzUUEw0xFmgPAUHBLi/BRLIrq3DpbY+yAkFhrnnoOYODKh6u3770gRJ7vU/H2eCm+cq2trI3IlwqCLDHjb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308783; c=relaxed/simple;
	bh=lhu4d+0JS4SuM1Z04lHvNgdwG4u/FL3atkA+jskD7k4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kNHLO53NL34rHjgSwyd39tkcUdKNcXMf9ZsiV0tbZ5u7XoktJz4EGOyM2Yce+V7Y6jueECHFAhRWLIjitoYCQFdqynkwZ7kYQ6RbjFhzm94dhx1tdC3Dmi+zZPQCuqyMlpLpCncSGGTiauUZLjSNCi3NHlulIW9UtTsTJOJpyzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QowH8r4q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QowH8r4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777308781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53tyLH8UgiEZGCFgdJcpJG9gqlQsXvHb0NYVu+LtKWk=;
	b=QowH8r4qppFd68iEWRcpAE9a4LHDSPPBowprw4suONYu4a+ZQCAV7u+VIn9wseKKen4WmO
	HKmK6bxotb18zW1PI2E93rJffzFFCaAzciuEbReF5X/UfAzEatCz8aKsmUM87WLPhndvH8
	xv2XcklFaWeOzlWFIDwpE6kHXoGYsEQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-PU2v5_j6PyK3RN4JLwQO3w-1; Mon,
 27 Apr 2026 12:53:00 -0400
X-MC-Unique: PU2v5_j6PyK3RN4JLwQO3w-1
X-Mimecast-MFC-AGG-ID: PU2v5_j6PyK3RN4JLwQO3w_1777308779
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 049FA1956089;
	Mon, 27 Apr 2026 16:52:59 +0000 (UTC)
Received: from localhost (unknown [10.44.48.171])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F7A019560AB;
	Mon, 27 Apr 2026 16:52:58 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org
Cc: Cathy Hu <cahu@suse.de>
Subject: Re: [PATCH] restorecon: Only log error on readonly fs (bsc#1257996)
In-Reply-To: <20260310153249.2077092-3-cahu@suse.de>
References: <20260310153249.2077092-3-cahu@suse.de>
Date: Mon, 27 Apr 2026 18:52:57 +0200
Message-ID: <875x5ctkeu.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Cathy Hu <cahu@suse.de> writes:

> Signed-off-by: Cathy Hu <cahu@suse.de>
> ---
> RFC Patch for the issue described in thread "Question regarding restorecon and btrfs read-only snapshots"
>

Could you point me where I can find the thread and is bsc#1257996?

What's the expected outcome? Before this change I see:

$ sudo restorecon -R -v /mnt/
restorecon: Could not set context for /mnt:  Read-only file system
restorecon: Could not set context for /mnt/lost+found:  Read-only file system
restorecon: Could not set context for /mnt/a:  Read-only file system
restorecon: Could not set context for /mnt/1:  Read-only file system

After:

$ sudo restorecon -R -v /mnt/
Read only filesystem, relabel not possible: /mnt
Read only filesystem, relabel not possible: /mnt/lost+found
Read only filesystem, relabel not possible: /mnt/a
Read only filesystem, relabel not possible: /mnt/1

This seems to be only a cosmetic change.

Petr


>  libselinux/src/selinux_restorecon.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 8fadf4d2..e8545e27 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -774,10 +774,14 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
>  		if (!flags->nochange) {
>  			if (lsetfilecon(pathname, newcon) < 0) {
>  				/* Ignore files removed during relabeling if ignore_noent is set */
> -				if (flags->ignore_noent && errno == ENOENT)
> +				if (flags->ignore_noent && errno == ENOENT) {
>  					goto out;
> -				else
> +				} else if (errno == EROFS) {
> +					selinux_log(SELINUX_INFO, "Read only filesystem, relabel not possible: %s\n", pathname);
> +					goto out;
> +				} else {
>  					goto err;
> +				}
>  			}
>  
>  			updated = true;
> -- 
> 2.53.0

