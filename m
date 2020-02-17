Return-Path: <SRS0=OI58=4F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B68C34022
	for <selinux@archiver.kernel.org>; Mon, 17 Feb 2020 21:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7EE2070B
	for <selinux@archiver.kernel.org>; Mon, 17 Feb 2020 21:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="tsS3B1lB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgBQVgr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:36:47 -0500
Received: from mail.rosalinux.ru ([195.19.76.54]:58394 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbgBQVgr (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 17 Feb 2020 16:36:47 -0500
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2020 16:36:45 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 2BE84D6EBE9D8
        for <selinux@vger.kernel.org>; Tue, 18 Feb 2020 00:27:58 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id njMkhIUWvXOt for <selinux@vger.kernel.org>;
        Tue, 18 Feb 2020 00:27:57 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 7C5D7D6EBE9DA
        for <selinux@vger.kernel.org>; Tue, 18 Feb 2020 00:27:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 7C5D7D6EBE9DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1581974877;
        bh=C7nSG75DsN3zZXbkQ9tbjLhxJVDXwM0n8xybuH6cCGk=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=tsS3B1lBB4W/0VmrtmboNz+zR1U2Q8AC82+DWz+lGeya6bKMeW3st0qS8Jf0ytyp5
         NawuFmot5uIZ8oHiYmtfife3KImRIqsOSpWen5s/0ZroSUZH2ozAKBhJnNmKgRSJao
         P/JM6x64Nn6y6Miif4DjBPl9rtncNPNLp2EqTGumVflvn7RBq6B0s2uJR1OEe69vJe
         KCV3/nMXAxYvSZ3fNkWmk1Vs/nekU119FSNz+kPqkg1tIZPP8kEuthW2Aqr9eLIH1p
         An3oAwaLdgdgYTObpY0kYG2ktdikbdsLApt3A1HHJqIZYeHIYfAWgqt4BQJhimrCax
         CTYCFPtp5YgDg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8bJdX9AeY3qh for <selinux@vger.kernel.org>;
        Tue, 18 Feb 2020 00:27:57 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-70-222.ip.moscow.rt.ru [90.154.70.222])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 54663D6EBE9D8
        for <selinux@vger.kernel.org>; Tue, 18 Feb 2020 00:27:57 +0300 (MSK)
To:     selinux@vger.kernel.org
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Subject: [PATCH] libselinux: Fix Ru translation of failsafe context
Message-ID: <5d97fa0c-8a0d-b6e3-6108-f5e98b8a7078@rosalinux.ru>
Date:   Tue, 18 Feb 2020 00:27:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From failsafe_context(5):
"The failsafe_context file allows SELinux-aware applications such as
PAM(8) to obtain a known valid login context for an administrator if
no valid default entries can be found elsewhere."

"=D0=9D=D0=B0=D0=B4=D1=91=D0=B6=D0=BD=D1=8B=D0=B9" means "reliable", "=D1=
=80=D0=B5=D0=B7=D0=B5=D1=80=D0=B2=D0=BD=D1=8B=D0=B9" means "reserve",
the last variant is much closer to what "failsafe" really does.

Discussed with and approved by previous translators:
https://github.com/SELinuxProject/selinux/pull/203

Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>

---
=C2=A0libselinux/man/ru/man5/failsafe_context.5 | 4 ++--
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/man/ru/man5/failsafe_context.5 b/libselinux/man/r=
u/man5/failsafe_context.5
index 01d6b0ea..54cecf39 100644
--- a/libselinux/man/ru/man5/failsafe_context.5
+++ b/libselinux/man/ru/man5/failsafe_context.5
@@ -1,6 +1,6 @@
=C2=A0.TH "failsafe_context" "5" "28 =D0=BD=D0=BE=D1=8F=D0=B1=D1=80=D1=8F=
 2011" "Security Enhanced Linux" "=D0=9A=D0=BE=D0=BD=D1=84=D0=B8=D0=B3=D1=
=83=D1=80=D0=B0=D1=86=D0=B8=D1=8F SELinux"
=C2=A0.SH "=D0=98=D0=9C=D0=AF"
-failsafe_context \- =D1=84=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=84=D0=
=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D0=BD=D0=B0=D0=B4=D1=91=D0=
=B6=D0=BD=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=
=82=D0=B0 SELinux
+failsafe_context \- =D1=84=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=84=D0=
=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=80=D0=B5=D0=B7=D0=B5=D1=
=80=D0=B2=D0=BD=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=
=81=D1=82=D0=B0 SELinux
=C2=A0.
=C2=A0.SH "=D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95"
=C2=A0=D0=A4=D0=B0=D0=B9=D0=BB
@@ -10,7 +10,7 @@ failsafe_context \- =D1=84=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=
=D0=BD=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D0=BD=D0=B0=
=D0=B4=D1=91=D0=B6=D0=BD=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BD
=C2=A0=D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D1=82=D1=8C =D0=B8=D0=B7=D0=B2=
=D0=B5=D1=81=D1=82=D0=BD=D1=8B=D0=B9 =D0=B4=D0=B5=D0=B9=D1=81=D1=82=D0=B2=
=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D1=8B=D0=B9 =D0=BA=D0=BE=D0=BD=D1=82=
=D0=B5=D0=BA=D1=81=D1=82 =D0=B2=D1=85=D0=BE=D0=B4=D0=B0 =D0=B4=D0=BB=D1=8F=
 =D0=B0=D0=B4=D0=BC=D0=B8=D0=BD=D0=B8=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=
=D1=80=D0=B0, =D0=B5=D1=81=D0=BB=D0=B8 =D0=B2 =D0=B4=D1=80=D1=83=D0=B3=D0=
=B8=D1=85 =D1=80=D0=B0=D1=81=D0=BF=D0=BE=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=
=B8=D1=8F=D1=85 =D0=BE=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D1=
=8E=D1=82 =D0=B4=D0=B5=D0=B9=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=
=8C=D0=BD=D1=8B=D0=B5 =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B8 =D0=BF=D0=BE =D1=
=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=D0=BD=D0=B8=D1=8E.
=C2=A0.sp
=C2=A0.BR selinux_failsafe_context_path "(3) "
-=D0=B2=D0=BE=D0=B7=D0=B2=D1=80=D0=B0=D1=89=D0=B0=D0=B5=D1=82 =D0=BF=D1=83=
=D1=82=D1=8C =D0=B0=D0=BA=D1=82=D0=B8=D0=B2=D0=BD=D0=BE=D0=B9 =D0=BF=D0=BE=
=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=BA =D1=8D=D1=82=D0=BE=D0=BC=D1=83=
 =D1=84=D0=B0=D0=B9=D0=BB=D1=83. =D0=A4=D0=B0=D0=B9=D0=BB =D0=BD=D0=B0=D0=
=B4=D1=91=D0=B6=D0=BD=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=
=BA=D1=81=D1=82=D0=B0 =D0=BF=D0=BE =D1=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=D0=
=BD=D0=B8=D1=8E:
+=D0=B2=D0=BE=D0=B7=D0=B2=D1=80=D0=B0=D1=89=D0=B0=D0=B5=D1=82 =D0=BF=D1=83=
=D1=82=D1=8C =D0=B0=D0=BA=D1=82=D0=B8=D0=B2=D0=BD=D0=BE=D0=B9 =D0=BF=D0=BE=
=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=BA =D1=8D=D1=82=D0=BE=D0=BC=D1=83=
 =D1=84=D0=B0=D0=B9=D0=BB=D1=83. =D0=A4=D0=B0=D0=B9=D0=BB =D1=80=D0=B5=D0=
=B7=D0=B5=D1=80=D0=B2=D0=BD=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0 =D0=BF=D0=BE =D1=83=D0=BC=D0=BE=D0=BB=D1=87=D0=
=B0=D0=BD=D0=B8=D1=8E:
=C2=A0.RS
=C2=A0.I /etc/selinux/{SELINUXTYPE}/contexts/failsafe_context
=C2=A0.RE
--=20
2.20.1

