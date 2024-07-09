Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97417F508
	for <selinux@vger.kernel.org>; Tue,  9 Jul 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535864; cv=none; b=o7Rly5xOfsoxJ8i+2sabQTSlXICP6ZCbUiaps7Ed8VV0LJJFhS4IXbUfSNKU9yWX4UF4xUqwMrcEexMjZxSaEi0DucLCupRcwfrsZpCjXLcuHIGCDH6IQlxFWCUqXnV4GgwYvUiBfrewphXmBp7tzRRA2Env/5ICkyz3YFvuRCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535864; c=relaxed/simple;
	bh=T2F/5EscAjcJ1CwTJc/wjxxI94OCiatn+OLhl+wMZzA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FctcqM/fQu1stDh/P+WISHlgCGdAYQrly1hN6mJ4jJ+pn88Hz0kwi1tp0v2hwtLVaGdjFT+ILBe1+JUplmSnB/ChHRBC4/IjI+wd7YXmkq/VqI5U0djPe+ygVepPhav+H7Za/El6YbFR4QXLoD4W7mwilOA1J5o4JoV5lASNyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/Fdq5oG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/Fdq5oG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720535862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCzusrr3nlJVOZF4AGHHCrDUk1+PBlwt1PIHKdkBzBs=;
	b=K/Fdq5oGk8TlSymkEqFFdzQKZzZaKucPQZV7BGfGapBSjTAxqcaVEkrdHIx0DKa3Hi7owR
	FRmLoZVnTy9/906yY1Pj3PLPVKyRrvF19z/3qRY3Zn8VkvdngVaieGjaymFYjkCzvocRVj
	OWLnXQQVGpWndPqDbfTn04NHcgNxgtA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-T02EmS4XPLeqL0x45I1j2Q-1; Tue,
 09 Jul 2024 10:37:38 -0400
X-MC-Unique: T02EmS4XPLeqL0x45I1j2Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27AFE195395D
	for <selinux@vger.kernel.org>; Tue,  9 Jul 2024 14:37:38 +0000 (UTC)
Received: from localhost (unknown [10.45.225.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9699B1955F68
	for <selinux@vger.kernel.org>; Tue,  9 Jul 2024 14:37:37 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: Re: Regression in 5876aca0484f ("libselinux: free data on selabel
 open failure")
In-Reply-To: <875xte98hr.fsf@redhat.com>
References: <875xte98hr.fsf@redhat.com>
Date: Tue, 09 Jul 2024 16:37:31 +0200
Message-ID: <8734oi8wd0.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Petr Lautrbach <lautrbach@redhat.com> writes:

> Hello,
>
> Katerina Koukiou https://bugzilla.redhat.com/show_bug.cgi?id=2295428
> discovered a regression in libselinux [1] which can be demonstrated by
> running `matchpathcon` on a system with SELinux disabled and without any
> SELinux policy installed.
>
> Fedora reproducer:
>
> $ toolbox create
> $ toolbox enter
> toolbox$ matchpatchcon /abc
>
> Before 5876aca0484f:
>
> $ matchpathcon /abc
>   Error while opening file contexts database: No such file or directory
>
> After 5876aca0484f:
>
> $ matchpathcon /abc
> [1]    761709 segmentation fault (core dumped)  matchpathcon /abc
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7f9a7b8 in closef (rec=0x405a10) at label_file.c:915
> warning: Source file is more recent than executable.
> 915                     free(spec->lr.ctx_trans);

The following patch fixes this particular problem:

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 2732972e61cf..59c9f2ef3442 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -942,6 +942,7 @@ static void closef(struct selabel_handle *rec)
                free(last_area);
        }
        free(data);
+       rec->data = NULL;
 }
 
 // Finds all the matches of |key| in the given context. Returns the result in




> (gdb) bt full
> #0  0x00007ffff7f9a7b8 in closef (rec=0x405a10) at label_file.c:915
>         data = 0x405a80
>         area = 0x6ffffdf48
>         last_area = 0x7fffffffdc90
>         spec = 0x405
>         stem = 0x2
>         i = 0
> #1  0x00007ffff7f968b7 in selabel_close (rec=0x405a10) at label.c:364
> No locals.
> #2  0x00007ffff7f9648d in selabel_open (backend=0, opts=0x7fffffffdd80, nopts=6) at label.c:228
>         rec = 0x405a10
> #3  0x00000000004015e7 in main (argc=2, argv=0x7fffffffdf48) at matchpathcon.c:131
>         i = 32767
>         force_mode = 0
>         header = 1
>         opt = -1
>         verify = 0
>         notrans = 0
>         error = 0
>         quiet = 0
>         hnd = 0x7fffffffde20
>         options = {{type = 0, value = 0x0}, {type = 0, value = 0x0}, {type = 0, value = 0x0}, {type = 0, 
>             value = 0x0}, {type = 0, value = 0x0}, {type = 0, value = 0x0}}
>
>
> As a workaround, it's necessary to install SElinux policy
>
> toolbox$ sudo dnf install selinux-policy-targeted
> toolbox$ $ matchpathcon /abc                       
> /abc    system_u:object_r:etc_runtime_t:s0
>
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=2295428

