Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D12DF6E3
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769754945; cv=none; b=PCLe572LF+oChK1lgeaAfdGKXVQgzNsW8NH+/n32cY/MfDwnoXcaC/8ZK0yvxJxu9wY7K5Pmw8i65VZCleUCfmtvaKDkQTob7Jt2KC3a7EHVirDhuYlEROdBc/arIe+nNCaysT2mWXkfzViRg6sXzX4HPlVzo2m598X89E5offI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769754945; c=relaxed/simple;
	bh=QCetKqtQFgs+azjjgQYvSMkMtCYAMzwvY2iDCmE0u7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fPOiiaBcPmjd5ZBCiW5dCAKwFLfdYMHlva1j2jleki13VomzhPWg4As1R/LMYUuq9CjAYKPN0/cvlPXekJ+Iy1s7NxzHOkRdTwJ9QeamG0+gv7dGO8s+5ISsNsZwcbFk/u+xbNkdh/uh1QDkbwWcoglBGiv83agKNC8Kzk5tAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+g47We4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+g47We4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769754942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhCUVnbMtdSrOFbkf7StTwPK2H4W9us9oc7lcCcEei0=;
	b=X+g47We45Ax3hehyGBmjBM52Kt15hpLtmqNY317kXVYD5x1zbxizWSikrhARlsHg/pilPL
	hh/rJ/oPD8o5J/p1EVE/LGKVOTTz6v3e7fh751ZG65hUdZSY4t60AFlIh8lXuNqyYtcbaN
	qQGkBnRaIEOG1xN3RVyBMhViY/asBxU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-6KPE_h_mMja84ShoZC18IA-1; Fri,
 30 Jan 2026 01:35:38 -0500
X-MC-Unique: 6KPE_h_mMja84ShoZC18IA-1
X-Mimecast-MFC-AGG-ID: 6KPE_h_mMja84ShoZC18IA_1769754938
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECFC1956050;
	Fri, 30 Jan 2026 06:35:37 +0000 (UTC)
Received: from localhost (unknown [10.44.32.77])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 093911955F43;
	Fri, 30 Jan 2026 06:35:36 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
Cc: Jason Zaman <jason@perfinion.com>
Subject: Re: [PATCH] scripts: GPG Sign overall tarball in release
In-Reply-To: <20260130014405.47915-1-jason@perfinion.com>
References: <20260130014405.47915-1-jason@perfinion.com>
Date: Fri, 30 Jan 2026 07:35:35 +0100
Message-ID: <871pj7r4js.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Jason Zaman <jason@perfinion.com> writes:

> In the release script, there was a GPG sig for each component tarball.
> There is also the overall script with all subdirectories at once, but it
> was missing the gpg sig.
>
> Reported-by: Petr Lautrbach <lautrbach@redhat.com>
> Signed-off-by: Jason Zaman <jason@perfinion.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>
> 3.10-rc1 and -rc2 had the signature missing on the upload to github.
> I've signed and uploaded to those releases. The files I signed were the
> local ones on my machines, ie did not download from github and sign, so
> there is no risk of any changes/mitm.
>
>  scripts/release | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/release b/scripts/release
> index dddbdf22..94125a7a 100755
> --- a/scripts/release
> +++ b/scripts/release
> @@ -53,6 +53,7 @@ for COMPONENT in "${DIRS[@]}"; do
>  done
>  
>  git archive -o "$DEST/selinux-${RELEASE_TAG}.tar.gz" --prefix="selinux-${RELEASE_TAG}/" "${RELEASE_TAG}"
> +gpg -b -a "$DEST/selinux-${RELEASE_TAG}.tar.gz"
>  
>  echo "Add the following to the $WIKIDIR/Releases.md wiki page:"
>  
> -- 
> 2.52.0

