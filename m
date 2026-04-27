Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B93BA246
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294048; cv=none; b=YkILBPayekhdP9tMuXBol6483/ZjhtK3v2eY6mWhhFWUczDOoKwtiCgP4klw+u2floD1Fm4aBVkGgwou86xJhW6tqPD4xrAWCZnCTqzTf9VZ4owRS7ZGcaWbLTDmA09/WQi5Gc1demHl/xUjsTnFeoIDES1jL+enj2dSSYgh6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294048; c=relaxed/simple;
	bh=mToOnvzHiXuOZhjjswBIgq9IMPSQbbKQzJDPVmqWR8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a51AyUVOGa2asH3uz2o8+W0GRtZFHzU10dmRI74wNH5FOEvBUl5wkDEqqbQCRkT90o804HoyD4+o8WRGRgftdhBVLWf/RVlI7DxaqfaCvgFqRnt4La8sYDa35wrjXbslrFMg5SBt/4Z+uRmb05xexGXf5g0E0P1Wrq9OJOa77kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzgAABzS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzgAABzS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777294046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hdJmQkxR2oAAqY4OsFWk9TfavI++n0aKbfprHlPasPA=;
	b=fzgAABzSgwMBGzyVIQZwS31C2u7usxFjJLf8FtUGuwUBZQHauk5JgLmKsA+D0W9O/qpGbP
	4vDya3I6fk04NH5ZyON4Qdx3Yuv7b4MAfcElZq2gqHGvPyTAPc3AySlMM6SoJZpIUqzCiu
	5HNM8KccVjrYZE/RYjqD3mA2Ael/kiM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-jSjkwiFhOpKcUWnHYTZMoQ-1; Mon,
 27 Apr 2026 08:47:25 -0400
X-MC-Unique: jSjkwiFhOpKcUWnHYTZMoQ-1
X-Mimecast-MFC-AGG-ID: jSjkwiFhOpKcUWnHYTZMoQ_1777294044
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E83CF180061E;
	Mon, 27 Apr 2026 12:47:23 +0000 (UTC)
Received: from localhost (unknown [10.44.48.171])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C46019560B1;
	Mon, 27 Apr 2026 12:47:23 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Dustin Kirkland <dustin.kirkland@chainguard.dev>
Subject: Re: [PATCH] policycoreutils/secon: fix discarded-qualifiers warning
 with glibc 2.43
In-Reply-To: <20260427123304.74899-1-lautrbach@redhat.com>
References: <CAC-oOXP04oBE7ciLr7eZBx857uw8sQm6u5v1DpjwYzfzY8vvVA@mail.gmail.com>
 <20260427123304.74899-1-lautrbach@redhat.com>
Date: Mon, 27 Apr 2026 14:47:22 +0200
Message-ID: <878qa8tvs5.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Petr Lautrbach <lautrbach@redhat.com> writes:

> From: Dustin Kirkland <dustin.kirkland@chainguard.dev>
>
> In my_getXcon_raw(), ptr is declared as const char * but is assigned
> from fgets(), which returns char *. With glibc 2.43, strchr(const char
> *, int) now returns const char *, so the subsequent assignment to
> char *tmp triggers:
>
>   secon.c:365:18: error: initialization discards 'const' qualifier
>   from pointer target type [-Werror=discarded-qualifiers]
>
> The const on ptr was always incorrect: fgets() returns a mutable
> pointer into buf (a char[4096]), and the result of strchr() through
> ptr is written to via *tmp = 0. Remove the erroneous const.
>
> This is the same class of bug reported in issue #506
> (libselinux/src/selinux_config.c:284). The fix here is analogous:
> the variable should not have been const-qualified in the first place.
>
> Signed-off-by: Dustin Kirkland <dustin.kirkland@chainguard.dev>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>


> ---
>
> Resent of the original patch downloaded from githu as the original patch in the
> email was slightly broken.
>
>  policycoreutils/secon/secon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
> index d624fa136f3e..9a05cf1959ba 100644
> --- a/policycoreutils/secon/secon.c
> +++ b/policycoreutils/secon/secon.c
> @@ -348,7 +348,7 @@ static int my_getXcon_raw(pid_t pid, char  **con, const char *val)
>  {
>  	char buf[4096];
>  	FILE *fp = NULL;
> -	const char *ptr = NULL;
> +	char *ptr = NULL;
>  
>  	snprintf(buf, sizeof(buf), "%s/%ld/attr/%s", "/proc", (long int)pid,
>  		 val);
> -- 
> 2.54.0

