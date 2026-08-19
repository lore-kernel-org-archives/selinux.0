Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43833440659
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163501; cv=pass; b=SDEV+F1UrpmtLSKW695J2Le9P0RgnepuiutKQXS4cnoaqFg/HyNhbZBET6goPtMhz4il1ogZxt0p9tdJGfgTusNdWukbkBahpXl+txGy37PqRP7fxR3VPhLTKZqsBS4HpyPikjMLpRaRYUcB+5dz2Fuh3X3P6IzfFgaYFjnSvD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163501; c=relaxed/simple;
	bh=84Pv0c2fUBeXVvMCpTChl1c621/b0xPopTLZk3Xj9/Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bgRwM9AV0SpbFBFOloYBcgUkHckYDhXcYYQAqHlbV+Zvx471368oSROyWDE/fTYCzzEfodTL3m0ZxnvAItJiSNaWT3Oz6pJTIy+j218ihRk88xPauAvnr+UkL6qvCCiuTL3MYOYVLpyvn4tBZ+CHOOjJjAibR6//XwDiFwgL2Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaKwau4h; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaKwau4h"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-448de0cc236so976163fac.2
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 11:18:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787163499; cv=none;
        d=google.com; s=arc-20260327;
        b=ElY9qQSArqpfHFkoTsmzVhA4+hT8XaHbXOFXzZqZcg8ErKrk+XS0LSGxNDqB6YDKiA
         MvCPUC+d5BUUDNgsZgcCrNaHk0b5nmVx+aXR5tuLDGru63YZgx4nqbq9cRU1LAIShczl
         5Sp8G+YVvPuJ9n+n0UjpjPwnxvJwe8VNqd9sVy8NjIq9vY8bDnoOQM4nOIFHgAzBW3HS
         axWQVzfQVvekC6ulGQuXa5gm4Js6RIfkGpZbZ9fP00UcqbhfQtowAOh05pkH+2fD2g6m
         4/+8yLOwKGtff/ZpmF9RDNIg48nXdFYSi+cjM8RBIKwGyqx5aVSQFlSPmfOdlPTp10To
         A5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=JtJOxrHUCY6UwpZfZIAUykMhkxkGVkqEL4Yi1x/wFek=;
        fh=3TiWXtFdwe5yukVw6OixALhXYfDtjbp6PLxueakgLUs=;
        b=EesxHnElXNKWfvdJBZBfTFn85MPqV8uRv82qPc6s8mbKv8cd9fpM80MK96goYhIUMj
         NENgbJp/+YAXJainOLomgvJ9yBTOS2SCnP5b2Q7s/nlybMB+dBOa+SG65p8ytBok108Q
         9YbLO19jQGF/JMpnnx01uYA8iIXyAGihcXs82juGbu9XuWwEMDl3Eqi19DC1OfVKjbyj
         Guicz7oXGT0eG7wmZCtaVkXWZyun+xVVpGhEGCMAbtVSn4CsRE4Nzmgpfy5m92OPnw05
         fj2d/7Xr8uj4ArhbE1udUD8eZjcpLK663Bgnekf1P5SaHiXTFypasL9gUBrl4RanJPk4
         SI/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787163499; x=1787768299; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JtJOxrHUCY6UwpZfZIAUykMhkxkGVkqEL4Yi1x/wFek=;
        b=ZaKwau4hStC9PZPX8tj5ZIrLvM9SsL25fSX/eQj7/lOKN5DPkYMGRYBQlsatewx3Ik
         +cgSZu8CFSm9frvfXu2g9VlodnIZnvJGow48zMjEcugmRIV/gWPjnWuGB4VONDMaZA4H
         TXz7dW47ZnqjLUFiNqx9ow2PkbdNNxIgkk9RG1BA4T+H/8xdXC76DpadN6aDOUrj3BPk
         zGo8U03T5nQ9urSH5srPbHBP070xL8q0IgwM8T3TUSA7NvWWgu3zPi8Cxhs4pPg1WVha
         FCX0b9suUxAMdNBuvlWJ48NrgLny4/8TajH9/+XxFAU24G3mF4oE10JF3GLzFy0Vdatz
         fxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787163499; x=1787768299;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JtJOxrHUCY6UwpZfZIAUykMhkxkGVkqEL4Yi1x/wFek=;
        b=SQO+AhauiNDwDblBrOw8/8JJYotoaue9GawRGRnKmF1qFRKyyQlOVBw+4WSpqp0X20
         kpX2URwrlXDr3h2AVqBshuuIv4NFh3vYN/wkuEWfv2AiTHt9PB+uQEl3SDEXHDyCiGhP
         hm4qM13DQy8ivFE5y3S4Rn0QyNoEx5i02/16alaav2G49ED8iUlqQGBvQ+fGEJ0O7tzd
         /azseNa+TIw0p7JNUCCxh2nE+ykk1H7k4Dmdj8Wuf9/wTPUMw5bjrKN7ZrZ7pCa9o7tE
         ex+brS2wruejrI1r1HoYhF8UYetw++WkqQOxRncGH2JIvzcBYaKVFFDS+2mA58a9ax0r
         vJQw==
X-Forwarded-Encrypted: i=1; AHgh+RrEZN5G0lViyNGEd8Xuqs6D3Hak42HwauqzjohBz4q2GBemMScEEy3eTkzcqECTNrXBIIphBmE2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyxt4DyOoLYrk1mlQNu/+doIKoia12ZuSo6VFM9hkpariInsdv
	YgE7d+rM4vPV/BGzZjghk8MDEglHAg2benYgdFuLX+3HVoDu7b4wt/xGdDx8mT4EUktzkB2YiEn
	HKtpCkd77qW75dR2Q03FU4aPXPNO7LzXz9fbF
X-Gm-Gg: AR+sD11QpIhIQY6fva0hKxKxqYY4dSvtTRmgTa/HuwmdFSdOpH2Mnuy/q3ts8q+f/oq
	+RqbcTZZQwI0RajVf1PDyF2CmmcPs2gk1DlzvhHGfwt33GwHudmUZISnw4z+gyEZ0Div/m+aVgD
	zz0Gf+VF71ORYZ5DonlxAHJjUVh/BL9Ou8VJBg1Kr2KxmxLY0dDanGXSOu7OHuefCYR37OTJwoO
	f1H+okWj/b00Zr1GQuUvwOQ081ZOK2wgpZ5bWCi0KPM7IBljuMdZMt5cFlwFum8OGk38w8HwBvY
	hayclOSd9Us/d9xbhTkDeZHVgh/JxwKhItA1mnIgms+G
X-Received: by 2002:a05:6870:6281:b0:455:e2d8:179b with SMTP id
 586e51a60fabf-462f68367a6mr6305958fac.7.1787163498959; Wed, 19 Aug 2026
 11:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Aug 2026 14:18:08 -0400
X-Gm-Features: AcwNN1UI62etHM7hGEbPXnNo_DSswCz4gM_P_vSBX6D_BmFtV2Oofvi54j6QVmM
Message-ID: <CAEjxPJ5i7G79aw6d7L_fnvr8zgsxPnmW8bFEJ6NCXWerrSvvYA@mail.gmail.com>
Subject: selinux:selabel_file_text-fuzzer: Null-dereference READ in selabel_file_text-fuzzer
To: Petr Matyas <p.matyas13@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, James Carter <jwcart2@gmail.com>, 
	Jason Zaman <jason@perfinion.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008319bf06596a6d60"

--0000000000008319bf06596a6d60
Content-Type: text/plain; charset="UTF-8"

This is oss-fuzz issue 547975134. Crash stacktrace below and
reproducer attached.

Last Tested Stacktrace on revision
728eab370eb3b9fea0ac577f0cca18efac29d238 (19 lines)
+----------------------------------------Release Build
Stacktrace----------------------------------------+
Command: /mnt/scratch0/clusterfuzz/resources/platform/linux/unshare -c
-n /mnt/scratch0/clusterfuzz/bot/builds/clusterfuzz-builds-afl_selinux_32ddf78d9f476617df7a8f4cf22b4d9340aef874/revisions/selabel_file_text-fuzzer
/mnt/scratch0/clusterfuzz/bot/inputs/fuzzer-testcases/crash
Time ran: 0.021557331085205078
AddressSanitizer:DEADLYSIGNAL
=================================================================
==250==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000
(pc 0x79f00f1efc0b bp 0x75f00d5d0920 sp 0x7ffe4c7c1e30 T0)
==250==The signal is caused by a READ memory access.
==250==Hint: address points to the zero page.
    #0 0x79f00f1efc0b  (<unknown module>)
==250==Register values:
rax = 0x00007ffe4c7c1e30  rbx = 0x000076100e6e0031  rcx =
0x0000000000000001  rdx = 0x0000000000000000
rdi = 0x000076100e6e002f  rsi = 0x0000000000000000  rbp =
0x000075f00d5d0920  rsp = 0x00007ffe4c7c1e30
 r8 = 0x000079f00f1efbe3   r9 = 0x00007fffffffff01  r10 =
0x00007fffffffff01  r11 = 0x00000ed881cd4001
r12 = 0x000075f00d5d0920  r13 = 0x0000000000989680  r14 =
0x000075f00ddd0020  r15 = 0x000075f00ddd8030
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV (<unknown module>)
==250==ABORTING
Original Stacktrace on revision
eeebedb36cfe60837e6e81d28a346510fdca1541 (26 lines)
[Environment] ASAN_OPTIONS=exitcode=77
+----------------------------------------Release Build
Stacktrace----------------------------------------+
Command: /mnt/scratch0/clusterfuzz/resources/platform/linux/unshare -c
-n /mnt/scratch0/clusterfuzz/bot/builds/clusterfuzz-builds_selinux_32ddf78d9f476617df7a8f4cf22b4d9340aef874/revisions/selabel_file_text-fuzzer
-runs=100 /mnt/scratch0/clusterfuzz/bot/inputs/fuzzer-testcases/871230c698ec205c1c7a8f90fc46ae5a6de6d92db2c1dd129429d61e78dcrash
Time ran: 0.040129899978637695
INFO: Running with entropic power schedule (0xFF, 100).
INFO: Seed: 4049782056
INFO: Loaded 1 modules   (32641 inline 8-bit counters): 32641
[0x5ca6bf693fe0, 0x5ca6bf69bf61),
INFO: Loaded 1 PC tables (32641 PCs): 32641 [0x5ca6bf69bf68,0x5ca6bf71b778),
/mnt/scratch0/clusterfuzz/bot/builds/clusterfuzz-builds_selinux_32ddf78d9f476617df7a8f4cf22b4d9340aef874/revisions/selabel_file_text-fuzzer:
Running 1 inputs 100 time(s) each.
Running: /mnt/scratch0/clusterfuzz/bot/inputs/fuzzer-testcases/871230c698ec205c1c7a8f90fc46ae5a6de6d92db2c1dd129429d61e78dcrash
AddressSanitizer:DEADLYSIGNAL
=================================================================
==1228==ERROR: AddressSanitizer: SEGV on unknown address
0x000000000000 (pc 0x7b2302c42c0b bp 0x7723010d0920 sp 0x7ffd3a6f1390
T0)
==1228==The signal is caused by a READ memory access.
==1228==Hint: address points to the zero page.
    #0 0x7b2302c42c0b  (<unknown module>)
==1228==Register values:
rax = 0x00007ffd3a6f1390  rbx = 0x00007743021e00b1  rcx =
0x0000000000000001  rdx = 0x0000000000000000
rdi = 0x00007743021e00af  rsi = 0x0000000000000000  rbp =
0x00007723010d0920  rsp = 0x00007ffd3a6f1390
 r8 = 0x00007b2302c42be3   r9 = 0x00007fffffffff01  r10 =
0x00007fffffffff01  r11 = 0x00000efee0434001
r12 = 0x00007723010d0920  r13 = 0x0000000000989680  r14 =
0x00007723018d0020  r15 = 0x00007723018d8030
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV (<unknown module>)
==1228==ABORTING

--0000000000008319bf06596a6d60
Content-Type: application/octet-stream; 
	name=clusterfuzz-testcase-minimized-selabel_file_text-fuzzer-5721256067137536
Content-Disposition: attachment; 
	filename=clusterfuzz-testcase-minimized-selabel_file_text-fuzzer-5721256067137536
Content-Transfer-Encoding: base64
Content-ID: <f_mt0ez8tx0>
X-Attachment-Id: f_mt0ez8tx0

Bih8KD8wKDEpKSkrK2N8ID/erb7vIA==
--0000000000008319bf06596a6d60--
