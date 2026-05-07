Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA83C3BED
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146437; cv=none; b=hdCA23EVIT4qHl+fpIJlzCIHNBmtIS6Ndogkgxe0sLnctzPsoCkOgTPI6FvLbfq+78fqGvFrRFIeJgy840XHkmvEgD2HSjvkpPQQfhWIT0X6v2pDiqYMv4jDiw5FWnwMOfjNbE11fAXxdGQ/xI7vmwK6EpMRSQLreGwseLFoTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146437; c=relaxed/simple;
	bh=xq2xI5xzSWcEABH9xoR7CekpUSu/Qmhly2A0IJSS3H4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S89+46CdN+IvJBo0yiq5guaA81Xd0kwmuYj6yukps/4NUZP/GNXpuHoO8whhc7aIMKY7/rybCHem93lyKmFjfyL7n14jFdfd4g5U1DSE3xs7BKj3g6QCYOu0EgiVn1bpdu55GEb/3joib4NorSyIocu/Imncc/6mvLcEU9YBKEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flqKWfdR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flqKWfdR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778146434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IU7ylZl/g21JR76xnSdwRjb1E9k+H7LNOhkftLIMqIo=;
	b=flqKWfdRK3HwZvC2gj5r4FppJbGK71do+sTIopXi+i15w5BehDl5O+svJCPHedo9cu+aeP
	QgecYimCa1j3JpJcW8W1eqB2GHLcdsTDIVxjldg0EVVwtDiJl18aeOIdOmC8HoL6Grgb3R
	Yko2e30l3PdWe4QTHycLCUN84NdvJ8U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-BN1YAFrZNimX9JCZ_9PNjg-1; Thu,
 07 May 2026 05:33:52 -0400
X-MC-Unique: BN1YAFrZNimX9JCZ_9PNjg-1
X-Mimecast-MFC-AGG-ID: BN1YAFrZNimX9JCZ_9PNjg_1778146432
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6F55180034A;
	Thu,  7 May 2026 09:33:51 +0000 (UTC)
Received: from localhost (unknown [10.44.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36E4D3002D2D;
	Thu,  7 May 2026 09:33:50 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux-list
 <selinux@vger.kernel.org>
Subject: Re: SELinux userspace does not build on Fedora 44
In-Reply-To: <afvtC0DVQkt6rtAD@14-5A-FC-31-E8-67>
References: <afvtC0DVQkt6rtAD@14-5A-FC-31-E8-67>
Date: Thu, 07 May 2026 11:33:49 +0200
Message-ID: <878q9v8sxu.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Kalevi Kolttonen <kalevi@kolttonen.fi> writes:

> Hello!
>
> I have problems compiling SELinux userspace on Fedora 44.
> I mean the main branch. The compiler is:
>
> gcc (GCC) 16.1.1 20260501 (Red Hat 16.1.1-1)
> Copyright (C) 2026 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
>
>
> The first error is:
>
> -------------------------------------------------------------------------=
------
> selinux_config.c: In function =E2=80=98selinux_set_policy_root=E2=80=99:
> selinux_config.c:284:29: error: initialization discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>   284 |         char *policy_type =3D strrchr(path, '/');
>       |                             ^~~~~~~
> cc1: all warnings being treated as errors
> make[2]: *** [Makefile:179: selinux_config.o] Error 1
> -------------------------------------------------------------------------=
------
>
> It can be fixed by this:
>
> -------------------------------------------------------------------------=
------
> --- selinux/libselinux/src/selinux_config.c	2026-05-02 01:09:23.084896619=
 +0300
> +++ selinux-buildaus/libselinux/src/selinux_config.c	2026-05-07 03:52:10.=
344519900 +0300
> @@ -281,7 +281,7 @@
>  int selinux_set_policy_root(const char *path)
>  {
>  	int i;
> -	char *policy_type =3D strrchr(path, '/');
> +	const char *policy_type =3D strrchr(path, '/');
>  	if (!policy_type) {
>  		errno =3D EINVAL;
>  		return -1;
> -------------------------------------------------------------------------=
------
>
> The second error is:
>
> -------------------------------------------------------------------------=
------
> direct_api.c: In function =E2=80=98semanage_direct_install_file=E2=80=99:
> direct_api.c:1781:27: error: assignment discards =E2=80=98const=E2=80=99 =
qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>  1781 |                 separator =3D strrchr(filename, '.');
>       |                           ^
> direct_api.c:1791:19: error: assignment discards =E2=80=98const=E2=80=99 =
qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>  1791 |         separator =3D strrchr(filename, '.');
>       |                   ^
> cc1: all warnings being treated as errors
> make[2]: *** [Makefile:114: direct_api.o] Error 1
> -------------------------------------------------------------------------=
------
>
> It can be fixed by this. Note: I did not add 'const' qualifier to
> 'separator' because the string is modified in the function.
>
> -------------------------------------------------------------------------=
------
> --- selinux/libsemanage/src/direct_api.c	2026-05-02 01:09:23.095896604 +0=
300
> +++ selinux-buildaus/libsemanage/src/direct_api.c	2026-05-07 04:01:26.969=
729078 +0300
> @@ -1755,7 +1755,7 @@
>=20=20
>  	int retval =3D -1;
>  	char *path =3D NULL;
> -	const char *filename;
> +	char *filename;
>  	const char *lang_ext =3D NULL;
>  	char *module_name =3D NULL;
>  	char *separator;
> -------------------------------------------------------------------------=
------
>
> The third error is:
>
> -------------------------------------------------------------------------=
------
> semanage_store.c: In function =E2=80=98semanage_exec_prog=E2=80=99:
> semanage_store.c:1307:16: error: variable =E2=80=98a=E2=80=99 might be cl=
obbered by =E2=80=98longjmp=E2=80=99 or =E2=80=98vfork=E2=80=99 [-Werror=3D=
clobbered]
>  1307 |         char **a;
>       |                ^
> semanage_store.c:1265:15: error: variable =E2=80=98new_s=E2=80=99 might b=
e clobbered by =E2=80=98longjmp=E2=80=99 or =E2=80=98vfork=E2=80=99 [-Werro=
r=3Dclobbered]
>  1265 |         char *new_s =3D realloc(s, len + 2);
>       |               ^~~~~
> semanage_store.c:1265:15: error: variable =E2=80=98new_s=E2=80=99 might b=
e clobbered by =E2=80=98longjmp=E2=80=99 or =E2=80=98vfork=E2=80=99 [-Werro=
r=3Dclobbered]
> cc1: all warnings being treated as errors
> make[2]: *** [Makefile:114: semanage_store.o] Error 1
> -------------------------------------------------------------------------=
------
>
> I see a vfork() there I but am unable to determine whether this
> error is for real or not. As temporary work-around I added:
>
>   -Wno-clobbered=20
>
> to the Makefile.
>
>
> -------------------------------------------------------------------------=
------
>
> The fourth error is:
>
> -------------------------------------------------------------------------=
------
>
> utilities.c: In function =E2=80=98semanage_str_replace=E2=80=99:
> utilities.c:248:16: error: assignment discards =E2=80=98const=E2=80=99 qu=
alifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>   248 |         for (p =3D strstr(src, search); p !=3D NULL; p =3D strstr=
(p + slen, search)) {
>       |                ^
> utilities.c:265:16: error: assignment discards =E2=80=98const=E2=80=99 qu=
alifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>   265 |         for (p =3D strstr(src, search); p !=3D NULL; p =3D strstr=
(psrc, search)) {
>       |                ^
> utilities.c:265:52: error: assignment discards =E2=80=98const=E2=80=99 qu=
alifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>   265 |         for (p =3D strstr(src, search); p !=3D NULL; p =3D strstr=
(psrc, search)) {
>       |                                                    ^
> utilities.c: In function =E2=80=98semanage_basename=E2=80=99:
> utilities.c:358:19: error: initialization discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>   358 |         char *p =3D strrchr(filename, '/');
>       |                   ^~~~~~~
>
> -------------------------------------------------------------------------=
------
>
> I did the following to fix:
>
> -------------------------------------------------------------------------=
------
> --- selinux/libsemanage/src/utilities.c 2026-05-02 01:09:23.099896599 +03=
00
> +++ selinux-buildaus/libsemanage/src/utilities.c        2026-05-07 04:24:=
08.992732849 +0300
> @@ -234,7 +234,8 @@
>                            const char *src, size_t lim)
>  {
>         size_t count =3D 0, slen, rlen, newsize;
> -       char *p, *pres, *result;
> +       const char *p;
> +       char *pres, *result;
>         const char *psrc;
>=20=20
>         slen =3D strlen(search);
> @@ -353,8 +354,8 @@
>  #ifdef __GNUC__
>  __attribute__((nonnull))
>  #endif
> -char *semanage_basename(const char *filename)
> +const char *semanage_basename(const char *filename)
>  {
> -       char *p =3D strrchr(filename, '/');
> -       return p ? p + 1 : (char *)filename;
> +       const char *p =3D strrchr(filename, '/');
> +       return p ? p + 1 : filename;
>  }
> -------------------------------------------------------------------------=
------
> --- selinux/libsemanage/src/utilities.h 2026-05-02 01:09:23.099896599 +03=
00
> +++ selinux-buildaus/libsemanage/src/utilities.h        2026-05-07 04:25:=
03.279160082 +0300
> @@ -167,6 +167,6 @@
>  #ifdef __GNUC__
>  __attribute__((nonnull))
>  #endif
> -char *semanage_basename(const char *filename);
> +const char *semanage_basename(const char *filename);
>=20=20
>  #endif
> -------------------------------------------------------------------------=
------
>
> The fifth error:
>
> -------------------------------------------------------------------------=
------
> secon.c: In function =E2=80=98my_getXcon_raw=E2=80=99:
> secon.c:365:29: error: initialization discards =E2=80=98const=E2=80=99 qu=
alifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>   365 |                 char *tmp =3D strchr(ptr, '\n');
>       |                             ^~~~~~
> cc1: all warnings being treated as errors
> make[2]: *** [<builtin>: secon.o] Error 1
> -------------------------------------------------------------------------=
------
>
> Fix:
>
> -------------------------------------------------------------------------=
------
> --- selinux/policycoreutils/secon/secon.c       2026-05-02 01:09:23.15259=
7184 +0300
> +++ selinux-buildaus/policycoreutils/secon/secon.c      2026-05-07 04:30:=
27.330279405 +0300
> @@ -348,7 +348,7 @@
>  {
>         char buf[4096];
>         FILE *fp =3D NULL;
> -       const char *ptr =3D NULL;
> +       char *ptr =3D NULL;
>=20=20
>         snprintf(buf, sizeof(buf), "%s/%ld/attr/%s", "/proc", (long int)p=
id,
>                  val);
> -------------------------------------------------------------------------=
------
>
> After these changes, the build completed, but I am not at all
> sure whether the fixes are correct.
>

Look at these patches and provide Tested-by if they work for you:

https://patchwork.kernel.org/project/selinux/list/?series=3D1086260
https://patchwork.kernel.org/project/selinux/patch/20260427123304.74899-1-l=
autrbach@redhat.com/


As a workaround you set build flags used in Fedora to avoid -Werror:

$ sudo dnf install redhat-rpm-config
$ source <( rpm --eval '%{set_build_flags}' )
$ make DESTDIR=3D/home/user/tmp/obj install install-rubywrap install-pywrap


Petr

