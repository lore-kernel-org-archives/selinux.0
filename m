Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D76D33FE36
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050668; cv=none; b=J3jsA7XXQ7esei7kbgp9wae0NHf5IH05j/B+mi5DUrwE94tQW1l69Zy9DCfcas/FovebcHVZHf8jf6Ik5wgAwFcQ2N3/Zh1IEDCgyUMMLII04GPGTSwypJs+fm/8Asv4nneyCn4Fql0b087ru9Y+zhspc+IW3cFZPmk8Zxd9zBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050668; c=relaxed/simple;
	bh=N0YTeXenN0zCRBAVUxgtOhbvaw9akKRQFDELVDesPEY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oy6NCEXQwxTuM9SZ9jERmoA/I+1DZmMzZaYTX7n8aqLKoR20mIL0/4p61EdwTO3Cx877oaX/Uk/HPINCUsaZANzLLAc7ZlHTXJrSZBIRnAuOnOcTLPNhG1CgvQ/IQfK7+u5tuCgNzUVPRZr1IiObU+G6WG5z1+oWkee/icqsg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7mVXb5/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7mVXb5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780050666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlxeL2aJdXT/8FSOi170bfniT1AlGYsZzAZ2zIfwWUU=;
	b=C7mVXb5/rCloWf7Y7Z+dCjFEGQ3xJ1KJ0B1o8A9PipKhBvCIlk+IR42Z2svQ9Shw9FfrMH
	b7RnyAL+RTldXudQl8uPumkpkYo/3e5/cT5FGF6ieEnzSqXwmYdl+vvYDRQvhDveMqH01a
	7OEfVWXINXXmHOxYec7X00ebriNQpss=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-NQECT831PCWb2IJRm2Pckw-1; Fri,
 29 May 2026 06:31:03 -0400
X-MC-Unique: NQECT831PCWb2IJRm2Pckw-1
X-Mimecast-MFC-AGG-ID: NQECT831PCWb2IJRm2Pckw_1780050663
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEB3218002C8;
	Fri, 29 May 2026 10:31:02 +0000 (UTC)
Received: from localhost (unknown [10.44.32.147])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C76618004A3;
	Fri, 29 May 2026 10:31:01 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Pepper Gray <hello@peppergray.xyz>, selinux@vger.kernel.org
Subject: github Issues and PR
In-Reply-To: <CAHLDejyUiLXZBKhGFpZZxP+k3CCaTL0bPA_xhonYc6pXvOsx6A@mail.gmail.com>
References: <CAHLDejxHRvHPWYK8q-VO4_OpEozY-4bKc4hSuFL6SL6o=JKw_A@mail.gmail.com>
 <87a4tjod2k.fsf@redhat.com>
 <CAHLDejyUiLXZBKhGFpZZxP+k3CCaTL0bPA_xhonYc6pXvOsx6A@mail.gmail.com>
Date: Fri, 29 May 2026 12:31:00 +0200
Message-ID: <877bomo6cb.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Pepper Gray <hello@peppergray.xyz> writes:

> Hi Petr,
>
...

> I will investigate how to send patches in the proper format. Please note
> that your Github is quite frustrating and consider disabling Issues and PRs
> there if nobody is gonna look at them anyways!

If a PR is opened via web page, there's this template:

    Please read [CONTRIBUTING.md](https://github.com/SELinuxProject/selinux/blob/main/CONTRIBUTING.md)
    
    
    ## Contributing Code
    
    Post the patch for the review to the
    [SELinux mailing list](https://lore.kernel.org/selinux) at
    [selinux@vger.kernel.org](mailto:selinux@vger.kernel.org).
    
    When preparing patches, please follow these guidelines:
    
    -   Patches should apply with git am
    -   Must apply against HEAD of the main branch
    -   Separate large patches into logical patches
    -   Patch descriptions must end with your "Signed-off-by" line. This means your
        code meets the Developer's certificate of origin, see below.


I guess that it's not shown when a PR is opened via some tool. Sometimes PRs
are used by the team to trigger CI or when it's not possible to send a
patch due to the size limitation on the mailing list

As for Issues, they are monitored even though not consistently.

It's clearly stated in the
https://github.com/SELinuxProject/selinux/blob/main/CONTRIBUTING.md that
bugs and patches should be sent to the mailing list.

Leaving both open should make the contribution for people using github
more accessible even trhough we don't really use it.


Petr

