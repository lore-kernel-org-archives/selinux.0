Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E90B1F667B
	for <selinux@vger.kernel.org>; Fri, 17 Jan 2025 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737099653; cv=none; b=XLP3RpsU249hr5R8NWKxhIywsJf8Ag+Ll0mGKjI35VDYr897ooTsrGNLJAuj9K6f3zLrB0e7SkHBBvZLv5RWHmtP1OBhYEC51gyjJ5oYL7uUl1COCe3lPj7sIo3tMPWcdYAf/OeaOQKZehoRnxxreoSxVKFehUiMpFmWub3a4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737099653; c=relaxed/simple;
	bh=NsDwyKKLY7avPILW/wmzoJLA4v2l0AXo2I1CWht2BpI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EcxI3fSZCktY1i5uRf4Y3OcZS9O9Xl+/TLefv2z5eq8UkldD7rv9Yb27lPp5psZmN/bdGoCtCt2LlKMRczZXg9KzWBp26TWp67ZHslXZsiGQ5nbO9sKJz6pxqWI+FbfSbzq3V0n2RiLxbvOnfNgPsqNpEPxu96BvzF2eDGjd+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7Wl9+ws; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7Wl9+ws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737099650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lIhhbmTtozzChKIrjU04lHHNcVLgFkG6DyPj/FGkuAM=;
	b=h7Wl9+ws04MP/7CXu4Nnk4BEZm+yc4bo9jxGA4Snbhxr+a5vFjlQSDk6vXDd2OoHSPmlru
	SQRAeUCeEdKQsh4rlSU7WUH2vNUqhBW7llHo+KPgSaiU+Rj/5dFFsHAFRBcxhA0Cz6K9ss
	U2qsTMtpe0G0zTee13YvmtLJHehGBMY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-K_Zr92cHOp-saV708-xw5w-1; Fri,
 17 Jan 2025 02:40:48 -0500
X-MC-Unique: K_Zr92cHOp-saV708-xw5w-1
X-Mimecast-MFC-AGG-ID: K_Zr92cHOp-saV708-xw5w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C25D91955F69
	for <selinux@vger.kernel.org>; Fri, 17 Jan 2025 07:40:47 +0000 (UTC)
Received: from localhost (unknown [10.39.196.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 377D230001BE;
	Fri, 17 Jan 2025 07:40:47 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH userspace] README: fix broken testsuite run status badge
In-Reply-To: <20250116131410.50853-1-omosnace@redhat.com>
References: <20250116131410.50853-1-omosnace@redhat.com>
Date: Fri, 17 Jan 2025 08:40:45 +0100
Message-ID: <874j1xx4zm.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Ondrej Mosnacek <omosnace@redhat.com> writes:

> The workflow name has changed for the testsuite run, so update README.md
> accordingly.
>
> Fixes: ee667ed976b5 ("ci: use Testing Farm for running the testsuite")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  README.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index 765b5626..1e16beea 100644
> --- a/README.md
> +++ b/README.md
> @@ -3,7 +3,7 @@ SELinux Userspace
>  
>  ![SELinux logo](https://github.com/SELinuxProject.png)
>  [![Run Tests](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml)
> -[![Run SELinux testsuite in a virtual machine](https://github.com/SELinuxProject/selinux/actions/workflows/vm_testsuite.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/vm_testsuite.yml)
> +[![Run SELinux testsuite in Testing Farm](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml)
>  [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
>  [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
>  
> -- 
> 2.48.0

