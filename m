Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E4F1F427E
	for <selinux@vger.kernel.org>; Tue,  3 Dec 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234945; cv=none; b=IkYUoc+E80Dbxh+TbFIr7WokfxsDdiZcDVXtGoNk6ZGOCCR26XBub/st+HgMV584gEaY+QR2k8P/8e+tCHCbnqsm45TVQ7DhRHaDXVPEJKMvLUZnFIz3IpWar+dP1UXlz+AWQA2aVNhKBveXm/0U2krtEx7r7XJT07IQR0GPwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234945; c=relaxed/simple;
	bh=X7dWRoVdR9rto08jMsxEIEpvZFD5i8mdJ4t7XHGAbcs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MWukmNBliObzDRX5YKHCdSY1napxgmtzm+PbR1dMa5DR3D2mW5GiyYSscpMgQzpuHHdw6QvQHEkWjKAN86E2MLxiYlt7AYupoC9GjlSe5hjjPwJ1q/Wzkbi1eZLbEXApW2pTDVbjqy95UBivb6pQ2KGWy4FX8cR4DoxWrHh9HWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DedEATeM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DedEATeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733234942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfADRCwjDIrUGKvaU+Zid01XR6nLOXWe7Yfl2oojqCs=;
	b=DedEATeMLRQCdegKq75vEkosgx5vwu5X3Y5/P1FjMMt/+Iw+Oq4/dxYW9RgFxszttkAKOM
	RGxEJkaYOjJYxP6tx1YUwkQJjC+tlaGkPvq6npgb7MjK3ULwhFrJed94umdT1tjfnJtTQ5
	Ss4VJxymTZ3dYupVXmxRMq9v3Px9xiA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-iFlBK3anN0OLX-ymBZuXqw-1; Tue,
 03 Dec 2024 09:09:01 -0500
X-MC-Unique: iFlBK3anN0OLX-ymBZuXqw-1
X-Mimecast-MFC-AGG-ID: iFlBK3anN0OLX-ymBZuXqw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F36F1944DD9;
	Tue,  3 Dec 2024 14:09:00 +0000 (UTC)
Received: from localhost (unknown [10.45.224.66])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB20C1956054;
	Tue,  3 Dec 2024 14:08:59 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org, Christian =?utf-8?Q?G=C3=B6ttsche?=
 <cgzones@googlemail.com>
Subject: Re: Regression in 92306daf5219 ("libselinux: rework selabel_file(5)
 database")
In-Reply-To: <87jzchqck5.fsf@redhat.com>
References: <87jzchqck5.fsf@redhat.com>
Date: Tue, 03 Dec 2024 15:08:58 +0100
Message-ID: <87h67krh8l.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Petr Lautrbach <lautrbach@redhat.com> writes:

> Hi,
>
> with the current 3.8-rc1 release:
>
> [root@default-0 selinux]# semanage fcontext -a -t user_home_dir_t /tmp/te=
st_dir
> [root@default-0 selinux]# semanage fcontext -l -C
> SELinux fcontext                                   type               Con=
text
>
> /tmp/test_dir                                      all files          sys=
tem_u:object_r:user_home_dir_t:s0=20
> [root@default-0 selinux]# semanage fcontext -D
> sefcontext_compile: sefcontext_compile.c:206: write_sidtab: Assertion `si=
ds[0].id =3D=3D 1' failed.
> libsemanage.semanage_exec_prog: Child process /usr/sbin/sefcontext_compil=
e did not exit cleanly.
> libsemanage.sefcontext_compile: sefcontext_compile returned error code -1=
. Compiling /var/lib/selinux/final/targeted/contexts/files/file_contexts.lo=
cal
> OSError: Error


[root@default-0 ~]# touch file_contexts

[root@default-0 ~]# sefcontext_compile -r file_contexts=20
sefcontext_compile: sefcontext_compile.c:206: write_sidtab: Assertion `sids=
[0].id =3D=3D 1' failed.
Aborted (core dumped)


[root@default-0 ~]# cat > file_contexts <<EOF
# This file is auto-generated by libsemanage
# Do not edit directly.

/tmp/test_dir    system_u:object_r:user_home_dir_t:s0
EOF

[root@default-0 ~]# sefcontext_compile -r file_contexts=20
[root@default-0 ~]#=20





>
> According to `git bisect` the first bad commit is:
>
> commit 92306daf5219e73f6e8bc9fc7699399457999bcd (HEAD)
> Author: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Date:   Tue Nov 5 19:33:16 2024 +0100
>
>     libselinux: rework selabel_file(5) database
>
>
> [root@default-0 selinux]# git checkout 92306daf5219e73f6e8bc9fc7699399457=
999bcd~
> Previous HEAD position was 92306daf libselinux: rework selabel_file(5) da=
tabase
> HEAD is now at 90b1c237 libselinux: sidtab updates
>
> [root@default-0 selinux]# make clean; make distclean; make LIBDIR=3D/usr/=
lib64 SHLIBDIR=3D/lib64 install install-pywrap relabel
> [root@default-0 selinux]# semanage fcontext -a -t user_home_dir_t /tmp/te=
st_dir
> [root@default-0 selinux]# semanage fcontext -l -C
> SELinux fcontext                                   type               Con=
text
>
> /tmp/test_dir                                      all files          sys=
tem_u:object_r:user_home_dir_t:s0=20
> [root@default-0 selinux]# semanage fcontext -D
> [root@default-0 selinux]#
>
>
> PTAL
>
> Petr

