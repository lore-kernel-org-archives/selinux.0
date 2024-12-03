Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EEB1E22EE
	for <selinux@vger.kernel.org>; Tue,  3 Dec 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222130; cv=none; b=TQdt+5AD9Qt7Idk+f00BUaW4FrI40FmbWptZ7GdKqdZ3sSQJ5LqMh7SutoQGQJF/nm1fSiDvBwrrV6xnTqi5jpTsOiyas+TWQPXfDrkhIolCH852p06zFmYNMMPqJWm0BNGzz4kFe1vve0r2SR4ZhHDsb1VOcQF3HEdRNHVk1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222130; c=relaxed/simple;
	bh=TAy5TVJSmA+7JYde3rrFgONLd3EEQd8SyN12spUmSqM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ShQEcOwLemFMUyKgBcR0n/yDvatLvZvb1QO3cYNheUm1fp7M44mGpxqDibjTd9vFGjH2Im+ajSew9Yr3k64lV+WioWN6153g0Lgzta01LMDThh+PTLBb+ZyaL2aRohct8pWVRiSCRs26IaYDbsggwoie60eJ4sUeSb2+UCW+9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFu3SVGR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFu3SVGR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733222126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wvn/cEabJSKs+gJDAgRRSeAKuTuZBnLi2LVopbTMqe8=;
	b=WFu3SVGR12FIkmwug3Bafv3ElCWinkTMnEHiiHKp0N6YUSUrh/V3nL6wbiwTlUUo3KNeye
	JfiRVDG3WBCgzGKQhtMafgbNBlFdbgJwRNAVRaVA6OcX3kYAzuKYGGrUT0+c3qaqxK8W+Q
	RsybSNiReSjq6fugnSfFAQanx8Mx7C4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-A4I8uI_FM1uB1etmoRwrPw-1; Tue,
 03 Dec 2024 05:35:24 -0500
X-MC-Unique: A4I8uI_FM1uB1etmoRwrPw-1
X-Mimecast-MFC-AGG-ID: A4I8uI_FM1uB1etmoRwrPw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 012EC1955E80;
	Tue,  3 Dec 2024 10:35:24 +0000 (UTC)
Received: from localhost (unknown [10.45.224.66])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7352D1956089;
	Tue,  3 Dec 2024 10:35:23 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org, Christian =?utf-8?Q?G=C3=B6ttsche?=
 <cgzones@googlemail.com>
Subject: Regression in 92306daf5219 ("libselinux: rework selabel_file(5)
 database")
Date: Tue, 03 Dec 2024 11:35:22 +0100
Message-ID: <87jzchqck5.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi,

with the current 3.8-rc1 release:

[root@default-0 selinux]# semanage fcontext -a -t user_home_dir_t /tmp/test=
_dir
[root@default-0 selinux]# semanage fcontext -l -C
SELinux fcontext                                   type               Conte=
xt

/tmp/test_dir                                      all files          syste=
m_u:object_r:user_home_dir_t:s0=20
[root@default-0 selinux]# semanage fcontext -D
sefcontext_compile: sefcontext_compile.c:206: write_sidtab: Assertion `sids=
[0].id =3D=3D 1' failed.
libsemanage.semanage_exec_prog: Child process /usr/sbin/sefcontext_compile =
did not exit cleanly.
libsemanage.sefcontext_compile: sefcontext_compile returned error code -1. =
Compiling /var/lib/selinux/final/targeted/contexts/files/file_contexts.local
OSError: Error

According to `git bisect` the first bad commit is:

commit 92306daf5219e73f6e8bc9fc7699399457999bcd (HEAD)
Author: Christian G=C3=B6ttsche <cgzones@googlemail.com>
Date:   Tue Nov 5 19:33:16 2024 +0100

    libselinux: rework selabel_file(5) database


[root@default-0 selinux]# git checkout 92306daf5219e73f6e8bc9fc769939945799=
9bcd~
Previous HEAD position was 92306daf libselinux: rework selabel_file(5) data=
base
HEAD is now at 90b1c237 libselinux: sidtab updates

[root@default-0 selinux]# make clean; make distclean; make LIBDIR=3D/usr/li=
b64 SHLIBDIR=3D/lib64 install install-pywrap relabel
[root@default-0 selinux]# semanage fcontext -a -t user_home_dir_t /tmp/test=
_dir
[root@default-0 selinux]# semanage fcontext -l -C
SELinux fcontext                                   type               Conte=
xt

/tmp/test_dir                                      all files          syste=
m_u:object_r:user_home_dir_t:s0=20
[root@default-0 selinux]# semanage fcontext -D
[root@default-0 selinux]#


PTAL

Petr

