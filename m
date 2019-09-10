Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8E4C49ED7
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 16:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E48720872
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 16:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfIJQVE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:21:04 -0400
Received: from ithil.bigon.be ([163.172.57.153]:39924 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394113AbfIJQVE (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 10 Sep 2019 12:21:04 -0400
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 6F91220059;
        Tue, 10 Sep 2019 18:21:01 +0200 (CEST)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id fGxDV6i1N-43; Tue, 10 Sep 2019 18:21:01 +0200 (CEST)
Received: from [10.40.0.155] (unknown [193.53.238.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA;
        Tue, 10 Sep 2019 18:21:01 +0200 (CEST)
To:     924716@bugs.debian.org, Russell Coker <russell@coker.com.au>
References: <155273036154.15358.7183530710711818912.reportbug@xev>
 <155273036154.15358.7183530710711818912.reportbug@xev>
Subject: Re: cron: SE Linux support uses obsolete API and gets wrong results
Cc:     selinux@vger.kernel.org
From:   Laurent Bigonville <bigon@debian.org>
Autocrypt: addr=bigon@debian.org; keydata=
 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
Message-ID: <d706a78c-d6d0-13bb-c9af-7ec4365b9b44@debian.org>
Date:   Tue, 10 Sep 2019 18:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <155273036154.15358.7183530710711818912.reportbug@xev>
Content-Type: multipart/mixed;
 boundary="------------8507290B549B7E12AEF5507E"
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------8507290B549B7E12AEF5507E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Mar 2019 20:59:21 +1100 Russell Coker <russell@coker.com.au>=20
wrote:

Hello,

 >
 > Mar 16 20:36:39 xev cron[14032]: (rjc) ENTRYPOINT FAILED (crontabs/rjc=
)
 > Mar 16 20:36:39 xev cron[14032]: (torrent) ENTRYPOINT FAILED=20
(crontabs/torrent)
 > Mar 16 20:36:39 xev cron[14032]: (test) ENTRYPOINT FAILED (crontabs/te=
st)
 >
 > When I restart crond (or run crontab for a user) on a system with the =

"strict"
 > configuration of SE Linux policy (user roles other than unconfined_r) =

I see
 > the above in the cron log.
 >
 > In file included from user.c:34:
 > /usr/include/selinux/flask.h:5:2: warning: #warning "Please remove=20
any #include's of this header in your source code." [-Wcpp]
 > #warning "Please remove any #include's of this header in your source=20
code."
 > ^~~~~~~
 > /usr/include/selinux/flask.h:6:2: warning: #warning "Instead, use=20
string_to_security_class() to map the class name to a value." [-Wcpp]
 > #warning "Instead, use string_to_security_class() to map the class=20
name to a value."
 > ^~~~~~~
 > In file included from user.c:35:
 > /usr/include/selinux/av_permissions.h:1:2: warning: #warning "Please=20
remove any #include of this header in your source code." [-Wcpp]
 > #warning "Please remove any #include of this header in your source cod=
e."
 > ^~~~~~~
 > /usr/include/selinux/av_permissions.h:2:2: warning: #warning=20
"Instead, use string_to_av_perm() to map the permission name to a=20
value." [-Wcpp]
 > #warning "Instead, use string_to_av_perm() to map the permission name =

to a value."
 > ^~~~~~~
 >
 > When I compile the cron package I see the above. The above is the=20
cause of
 > the incorrect processing of entry points.
 >
 > The following patch fixes these problems.
 >
 > Please note that the bug means that when the cron package that is=20
currently in
 > testing is run with the SE Linux libraries in testing it checks for
 > execute_no_trans permission not entrypoint. It is unlikely that a host=
ile
 > party could create a crontab file with a context for which=20
execute_no_trans is
 > allowed without having the ability to get elevated privileges in=20
other ways,
 > but it can't be theoretically impossible.
 >
 > I can't be certain that there are no security implications of the bug =

so I

 > think that getting this fix into Buster is important.

Please find here an other patch based on Russell's one.

The changes compared to the original patch are the fact that I'm=20
cleaning context_list in case of error and I'm also using=20
security_deny_unknown() to check whether we should allow the access in=20
case the class or the permission is not defined.

Russel do you think you could check if this is still OK?

Are there any other comment?

Kind regards,

Laurent Bigonville


--------------8507290B549B7E12AEF5507E
Content-Type: text/x-patch; charset=UTF-8;
 name="924716.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="924716.patch"

diff -u cron-3.0pl1/user.c cron-3.0pl1/user.c
--- cron-3.0pl1/user.c
+++ cron-3.0pl1/user.c
@@ -31,8 +31,6 @@
 #ifdef WITH_SELINUX
 #include <selinux/context.h>
 #include <selinux/selinux.h>
-#include <selinux/flask.h>
-#include <selinux/av_permissions.h>
 #include <selinux/get_context_list.h>
=20
 static int get_security_context(char *name, int crontab_fd, security_con=
text_t
@@ -108,13 +106,35 @@
 	* permission check for this purpose.
 	*/
=20
+	security_class_t tclass =3D string_to_security_class("file");
+	if (!tclass) {
+		log_it(name, getpid(), "Failed to translate security class file", tabn=
ame);
+		freeconary(context_list);
+		if (security_deny_unknown() =3D=3D 0) {
+			return 0;
+		} else {
+			return -1;
+		}
+	}
+
+	access_vector_t bit =3D string_to_av_perm(tclass, "entrypoint");
+	if (!bit) {
+		log_it(name, getpid(), "Failed to translate av perm entrypoint", tabna=
me);
+		freeconary(context_list);
+		if (security_deny_unknown() =3D=3D 0) {
+			return 0;
+		} else {
+			return -1;
+		}
+	}
+
 	for (i =3D 0; i < list_count; i++) {
 		retval =3D security_compute_av(context_list[i],
 						 file_context,
-						 SECCLASS_FILE,
-						 FILE__ENTRYPOINT,
+						 tclass,
+						 bit,
 						 &avd);
-		if (!retval && ((FILE__ENTRYPOINT & avd.allowed) =3D=3D FILE__ENTRYPOI=
NT)) {
+		if(!retval && ((bit & avd.allowed) =3D=3D bit)) {
 			*rcontext =3D strdup(context_list[i]);
 			freecon(file_context);
 			freeconary(context_list);

--------------8507290B549B7E12AEF5507E--
