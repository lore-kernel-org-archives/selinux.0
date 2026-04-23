Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2F32E62A9
	for <selinux@vger.kernel.org>; Thu, 23 Apr 2026 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944601; cv=none; b=gWAVGKe3A3ad4rCIQA6i/7HqaQknzvuhlhjNHcAluVYx9LIqeW/OuyF+aF4KQmo8/L7ncm3IOgfLgxhSzgHN+EWAy/d2AhD59ortgFgTrndKAlrdyP9fvUxTJn8uKqb8TFX2/xEjJNJS/b/9J9hZEGpQeCFrvjeSZbk/u4Hi7OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944601; c=relaxed/simple;
	bh=jux2b9oeeaHbqEVKJnMhKW+mDGsq2V5/gLe3aanZ50E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r+n6tYFPz83sZWkgj6YoKPL5GpJj6cYZ7futbo5BbqhKdmyN2Wc7Fxq+Z/8wEnWyWRNeKKnWoLj+viMsvgGqZ+HTEtwnnoLnwx+WOMpvgHvtM4IQ8ZI1IK221HJEkZBj81Cy9CmX+Ivgli844Pwhr+7zxinZ5mhYk/W0Ny8zS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gkYV05tj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkYV05tj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776944599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eT+d2+1vNm3QzACXCvxF+P+PVQ6Put6QlvhKQweMUC4=;
	b=gkYV05tjbI7hP7xQV/5sCSww0iUTww3IBPyl/ChKcVwVc94L46em8zuNj4tlhag/p1cQXY
	ay9j7oBpYdkdwHGTDM3uDQzmH8okIGkStSAWPxckhR9Zar6JIwHnl8yexstZq15lX2/r1R
	AJnEORCJ8ZP2h0CPhiOxWuWPxPUjWjc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-3DnCM80zMsazvw_sj5hGrg-1; Thu,
 23 Apr 2026 07:43:16 -0400
X-MC-Unique: 3DnCM80zMsazvw_sj5hGrg-1
X-Mimecast-MFC-AGG-ID: 3DnCM80zMsazvw_sj5hGrg_1776944595
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1135B1956095;
	Thu, 23 Apr 2026 11:43:15 +0000 (UTC)
Received: from localhost (unknown [10.44.48.47])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9322E3000709;
	Thu, 23 Apr 2026 11:43:14 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, jwcart2@gmail.com, Stephen Smalley
 <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] libselinux: Do not fall back to /selinux on a sysfs
 mount failure
In-Reply-To: <20260304200238.26493-2-stephen.smalley.work@gmail.com>
References: <20260304200238.26493-2-stephen.smalley.work@gmail.com>
Date: Thu, 23 Apr 2026 13:43:13 +0200
Message-ID: <87o6j952cu.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> Even if we cannot mount sysfs ourselves (e.g. in a user namespace),
> we can still try to mount on /sys/fs/selinux first prior to falling
> back to /selinux.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>


> ---
>  libselinux/src/load_policy.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index 8e737a23..bb7f2dd0 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -290,16 +290,11 @@ int selinux_init_load_policy(int *enforce)
>  	 */
>  	const char *mntpoint = NULL;
>  	/* First make sure /sys is mounted */
> -	if (mount("sysfs", "/sys", "sysfs", 0, 0) == 0 || errno == EBUSY) {
> -		/* MS_NODEV can't be set because of /sys/fs/selinux/null device, used by Android */
> -		if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, MS_NOEXEC | MS_NOSUID, 0) == 0 || errno == EBUSY) {
> -			mntpoint = SELINUXMNT;
> -		} else {
> -			/* check old mountpoint */
> -			if (mount(SELINUXFS, OLDSELINUXMNT, SELINUXFS, 0, 0) == 0 || errno == EBUSY) {
> -				mntpoint = OLDSELINUXMNT;
> -			}
> -		}
> +	(void) mount("sysfs", "/sys", "sysfs", 0, 0);
> +
> +	/* MS_NODEV can't be set because of /sys/fs/selinux/null device, used by Android */
> +	if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, MS_NOEXEC | MS_NOSUID, 0) == 0 || errno == EBUSY) {
> +		mntpoint = SELINUXMNT;
>  	} else {
>  		/* check old mountpoint */
>  		if (mount(SELINUXFS, OLDSELINUXMNT, SELINUXFS, 0, 0) == 0 || errno == EBUSY) {
> -- 
> 2.52.0

