Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C94155C83
	for <selinux@vger.kernel.org>; Tue,  9 Jul 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520143; cv=none; b=a8n1XJ34KVRKHFcO0Hb5ca+dDU0t25eutf6xdKTNj1frk2UTEcL+GY4gsho8i5j84TtE8v+HgxaKkIA9Oi2ClH7n976ZNcPHtfgY4AncvRkGf1t9lafSkcyFtrTrEuW/TFzTG3Rhe2x+6DZjinu+Ysc2eVTFEj9QNBeBnBehF/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520143; c=relaxed/simple;
	bh=NYEMZsheqyS+Hiri90XW+05gHoYPc9gZ2b2J8kCY2RI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UVyUCv19K48QfkEB605ikBZNCjmc81WHKqe2411idMWoRmsLdaSHVSUux0P3P7BaKSLXOBAbRVBkLEClevVreXCcBH5D6TUT7NXSbX+2nRxY7PDA+BkUolFocWAiOyZo8+8o/My2PIEmOICTAZx9uKpbNlRgle/gpDjF4TMrsBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmSs18hX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmSs18hX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720520141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=k2fQMezNNcMpWttKCJJsz3EwezxV+KFYOrs2IUSB3Ck=;
	b=MmSs18hXUokSggV6rR7aEHaUGeI9pDszax6SyvWw7canp/gPHELb+MiRwdJGk9+ESJv9ky
	hbrc377k5OZ3+TmEiDok6Q/GPpeIRkZ6miapkuUjEMAPOUC4mIB4gX6U4+nhb3PS/MOssi
	ccOQxHHjIryAn95W2nNirrV7NQkKAGY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-ROfiDAhfOC-zoNxtXg4iqA-1; Tue,
 09 Jul 2024 06:15:38 -0400
X-MC-Unique: ROfiDAhfOC-zoNxtXg4iqA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89BF519560BA
	for <selinux@vger.kernel.org>; Tue,  9 Jul 2024 10:15:36 +0000 (UTC)
Received: from localhost (unknown [10.45.225.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C59F819560AA
	for <selinux@vger.kernel.org>; Tue,  9 Jul 2024 10:15:35 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: Regression in 5876aca0484f ("libselinux: free data on selabel open
 failure")
Date: Tue, 09 Jul 2024 12:15:28 +0200
Message-ID: <875xte98hr.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello,

Katerina Koukiou https://bugzilla.redhat.com/show_bug.cgi?id=2295428
discovered a regression in libselinux [1] which can be demonstrated by
running `matchpathcon` on a system with SELinux disabled and without any
SELinux policy installed.

Fedora reproducer:

$ toolbox create
$ toolbox enter
toolbox$ matchpatchcon /abc

Before 5876aca0484f:

$ matchpathcon /abc
  Error while opening file contexts database: No such file or directory

After 5876aca0484f:

$ matchpathcon /abc
[1]    761709 segmentation fault (core dumped)  matchpathcon /abc

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7f9a7b8 in closef (rec=0x405a10) at label_file.c:915
warning: Source file is more recent than executable.
915                     free(spec->lr.ctx_trans);
(gdb) bt full
#0  0x00007ffff7f9a7b8 in closef (rec=0x405a10) at label_file.c:915
        data = 0x405a80
        area = 0x6ffffdf48
        last_area = 0x7fffffffdc90
        spec = 0x405
        stem = 0x2
        i = 0
#1  0x00007ffff7f968b7 in selabel_close (rec=0x405a10) at label.c:364
No locals.
#2  0x00007ffff7f9648d in selabel_open (backend=0, opts=0x7fffffffdd80, nopts=6) at label.c:228
        rec = 0x405a10
#3  0x00000000004015e7 in main (argc=2, argv=0x7fffffffdf48) at matchpathcon.c:131
        i = 32767
        force_mode = 0
        header = 1
        opt = -1
        verify = 0
        notrans = 0
        error = 0
        quiet = 0
        hnd = 0x7fffffffde20
        options = {{type = 0, value = 0x0}, {type = 0, value = 0x0}, {type = 0, value = 0x0}, {type = 0, 
            value = 0x0}, {type = 0, value = 0x0}, {type = 0, value = 0x0}}


As a workaround, it's necessary to install SElinux policy

toolbox$ sudo dnf install selinux-policy-targeted
toolbox$ $ matchpathcon /abc                       
/abc    system_u:object_r:etc_runtime_t:s0


[1] https://bugzilla.redhat.com/show_bug.cgi?id=2295428

