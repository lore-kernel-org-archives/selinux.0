Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D514FC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 22:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9174C2082E
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 22:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="C/UuO7p8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgAaWKW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:10:22 -0500
Received: from sonic315-22.consmr.mail.bf2.yahoo.com ([74.6.134.196]:34761
        "EHLO sonic315-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726264AbgAaWKW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jan 2020 17:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580508619; bh=vXCjKMv9qU2tHcuhjflVGajWhJOaqvQB+bdIeXiDg6c=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=C/UuO7p8sjskBrUvSLa090N0M4z/TQDqkBgEZTe+SIq8TKHOM3M45/S90wBwUyQSU2jFHYCF7cZHfy42KOkGzan1chWKGZxNfHa6e9lB9B5xn8Fd0C+CPKidtEw4i0dVGaFMkgarUqHDCfb4NZ1jySjhD4GlIKH+aMwofdh64m5irU9Qhtszf5sbzArN3HZov6grdO9Q+LEk3Xi8izrkLyznLIb6yslxFoueRgxUpaf75DIWSSmqY8lbNMePZeDaaoBZS113TpsGMVX1d4j/pZcGklIVB+0WvxQLVwXS2CfFjSWoykMJto00x/F4NGKmAUbB/gOJJTwAmnDHuu781A==
X-YMail-OSG: C.CuN5IVM1n7TAtP5LNYukmb0QMzjmtN8A.0nUtFBBubCpJcyiFG0bZupO_tg5S
 pVVk2DwAK4uuH4Th4t202MtLrhgQDCBz4Jyi3QiOQpvSsuYIQW5IoBnD0CUhDnPbqb6zZPj9LotB
 AlQlJ2F04imHrUC4Xk1e3v99z9uBGi7raLiZjjtm6Y5cn6TTRI1jKff0EJ_3Xo50D9X7JYNXrlZQ
 YSNecSpXvbsDO0SA3X7FPy93r6vriWKHDzVxGHHC3bNf4shJYunHo9fKDnj4u2AJxIv0XS2Ip4Fu
 A5bPwZI2V2wpNzFDJMWS3pe0cn8dQLFUbkd61oIAugoLME3eq2TrBBsVTOd3eZK03kUSAay1kIzq
 kbxyLuj1LTxvpl4G1tHSRX2viytZ9Fg.Qx6CGMUXZflKW8ONpOiMDM6YZ4GeNx1kTVsu6eEO61cv
 Z7Vr.r901o.JMv74.VZFCoFNPDrZR6Is88hMJP38TewK7r3V84RltrD7yqWBbkJgspXEgZ40VwUe
 11c9R8rFk2eChX7CzdTB7qOAwZtHbBto.6838Ej8o_2N502mua3OGrut6hkElHoFIHJqzp6dQcqK
 Tg4ihr2W64zM7rZGeROO2loLJw3fVYslV1sYDwJTZtQ6TAU7MHbU82JrSAcR8Kh1rEO1fkamNGAG
 .Q7KiPlAQTYfx3dnaieZ4qwAPY_QHQ5uMBxH9cCjSsaQyRtk_nQOWJzI8KIfyGXfMReO6nQHaifF
 WovtR.vl2hNyB6lsoi5pkGH_eeUKhL6EPO8.7a3CD7AizChtuTQe1KjPOtADxw20G9D3yLnYZ3Bv
 UWNsDM79IXTLYw0NsxNrcaelsz_CnbfgQei_keNnuVXsewmncBgrMB2CY0XgbGfRGWqC9GGCfxDQ
 QwBKB69U8afWPM2uCNsfpLLebUCGPF_wCUaL5qyzwOgh1AyroWnTDBAju9eKO88zTHwOdHE0pYSB
 D._WJoysQ9kkG3VvldFKH7rpjntyjyw5YqnClvkSHU32u1BZWg1ZmeRbWKdhTmU1TQ77Qo355zsC
 L91WdWeLCP_zrDmnUD0PhXgoT247fXfsPGUXfZKwavYiJP_8WcCTGrAXJio8qXUUXHuojyfL4Cxw
 ng7hF3Gd1TON9jTbl3YQ8raX36.qtDGifSfss6ku40jGPKLODsnqvAJm2KkXG3LpQaB0sQhl_ysP
 BxvFPIHZY5coAKL9pcv03PEi4eqBcDZj6l1Ml79Yd7ke6A3Z61QlkoNR.r1EiBftmo2OgzTNiEQS
 SlHW8Ju9sLpcP8gdyTCTheoFI_AGx4.XV5.KLs49wUNWq6bvAt.StauL7uR6EDgNyOG2RZ0GPUQB
 76KdOYNoPVdIsIWUz9wTitGkVSidLqZsrhNJKjQ0TRUB01ug.dVoTHV8y.FTd_5WpReSg5JShTFh
 R8xfGDj1mueLx6tuHb.ajhVKdz1BOp2tZDfJej7S6RKAAjb2G4nuNFP2sz4HqFg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 Jan 2020 22:10:19 +0000
Received: by smtp410.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 49e2041f0d7e075429eded9f7d35865c;
          Fri, 31 Jan 2020 22:10:14 +0000 (UTC)
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
Date:   Fri, 31 Jan 2020 14:10:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15149 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/24/2020 12:16 PM, Stephen Smalley wrote:
> On 1/24/20 2:28 PM, Casey Schaufler wrote:
>> On 1/24/2020 8:20 AM, Stephen Smalley wrote:
>>> On 1/24/20 9:42 AM, Stephen Smalley wrote:
>>>> On 1/23/20 7:23 PM, Casey Schaufler wrote:
>>>>> Add an entry /proc/.../attr/context which displays the full
>>>>> process security "context" in compound format:'
>>>>>           lsm1\0value\0lsm2\0value\0...
>>>>> This entry is not writable.
>>>>>
>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>> Cc: linux-api@vger.kernel.org
>>>>
>>>> As previously discussed, there are issues with AppArmor's implementation of getprocattr() particularly around the trailing newline that dbus-daemon and perhaps others would like to see go away in any new interface.  Hence, I don't think we should implement this new API using the existing getprocattr() hook lest it also be locked into the current behavior forever.
>>>
>>> Also, it would be good if whatever hook is introduced to support /proc/pid/attr/context could also be leveraged by the SO_PEERCONTEXT implementation in the future so that we are guaranteed a consistent result between the two interfaces, unlike the current situation for /proc/self/attr/current versus SO_PEERSEC.
>>
>> I don't believe that a new hook is necessary, and that introducing one
>> just to deal with a '\n' would be pedantic. We really have two rational
>> options. AppArmor could drop the '\n' from their "context". Or, we can
>> simply document that the /proc/pid/attr/context interface will trim any
>> trailing whitespace. I understand that this would be a break from the
>> notion that the LSM infrastructure does not constrain what a module uses
>> for its own data. On the other hand, we have been saying that "context"s
>> are strings, and ignoring trailing whitespace is usual behavior for
>> strings.
>
> Well, you can either introduce a new common underlying hook for use by /proc/pid/attr/context and SO_PEERCONTEXT to produce the string that is to be returned to userspace (in order to guarantee consistency in format and allowing them to be directly compared, which I think is what the dbus maintainers wanted), or you can modify every security module to provide that guarantee in its existing getprocattr and getpeersec* hook functions (SELinux already provides this guarantee; Smack and AppArmor produce slightly different results with respect to \0 and/or \n), or you can have the framework trim the values it gets from the security modules before composing them.  But you need to do one of those things before this interface gets merged upstream.
>
> Aside from the trailing newline and \0 issues, AppArmor also has a whitespace-separated (mode) field that may or may not be present in the contexts it presently returns, ala "/usr/sbin/cupsd (enforce)".  Not sure what they want for the new interfaces.
>
From c4085435215653b7c4d07a35a9df308120441d79 Mon Sep 17 00:00:00 2001
From: Casey Schaufler <casey@schaufler-ca.com>
Date: Fri, 31 Jan 2020 13:57:23 -0800
Subject: [PATCH v14] LSM: Move "context" format enforcement into security
 modules

Document in lsm_hooks.h what is expected of a security module that
supplies the "context" attribute.  Add handling of the "context"
attribute to SELinux, Smack and AppArmor security modules. The
AppArmor implementation provides a different string for "context"
than it does for other attributes to conform with the "context"
format.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h            |  6 ++++++
 security/apparmor/include/procattr.h |  2 +-
 security/apparmor/lsm.c              |  8 ++++++--
 security/apparmor/procattr.c         | 11 +++++++----
 security/security.c                  |  2 +-
 security/selinux/hooks.c             |  2 +-
 security/smack/smack_lsm.c           |  2 +-
 7 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2bf82e1cf347..61977a33f2c3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1321,6 +1321,12 @@
  *	@pages contains the number of pages.
  *	Return 0 if permission is granted.
  *
+ * @getprocattr:
+ *	Provide the named process attribute for display in special files in
+ *	the /proc/.../attr directory.  Attribute naming and the data displayed
+ *	is at the discretion of the security modules.  The exception is the
+ *	"context" attribute, which will contain the security context of the
+ *	task as a nul terminated text string without trailing whitespace.
  * @ismaclabel:
  *	Check if the extended attribute specified by @name
  *	represents a MAC label. Returns 1 if name is a MAC
diff --git a/security/apparmor/include/procattr.h b/security/apparmor/include/procattr.h
index 31689437e0e1..03dbfdb2f2c0 100644
--- a/security/apparmor/include/procattr.h
+++ b/security/apparmor/include/procattr.h
@@ -11,7 +11,7 @@
 #ifndef __AA_PROCATTR_H
 #define __AA_PROCATTR_H
 
-int aa_getprocattr(struct aa_label *label, char **string);
+int aa_getprocattr(struct aa_label *label, char **string, bool newline);
 int aa_setprocattr_changehat(char *args, size_t size, int flags);
 
 #endif /* __AA_PROCATTR_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 37d003568e82..07729c28275e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -593,6 +593,7 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	const struct cred *cred = get_task_cred(task);
 	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
+	bool newline = true;
 
 	if (strcmp(name, "current") == 0)
 		label = aa_get_newest_label(cred_label(cred));
@@ -600,11 +601,14 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 		label = aa_get_newest_label(ctx->previous);
 	else if (strcmp(name, "exec") == 0 && ctx->onexec)
 		label = aa_get_newest_label(ctx->onexec);
-	else
+	else if (strcmp(name, "context") == 0) {
+		label = aa_get_newest_label(cred_label(cred));
+		newline = false;
+	} else
 		error = -EINVAL;
 
 	if (label)
-		error = aa_getprocattr(label, value);
+		error = aa_getprocattr(label, value, newline);
 
 	aa_put_label(label);
 	put_cred(cred);
diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index c929bf4a3df1..1098bca3d0e4 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -20,6 +20,7 @@
  * aa_getprocattr - Return the profile information for @profile
  * @profile: the profile to print profile info about  (NOT NULL)
  * @string: Returns - string containing the profile info (NOT NULL)
+ * @newline: Should a newline be added to @string.
  *
  * Returns: length of @string on success else error on failure
  *
@@ -30,7 +31,7 @@
  *
  * Returns: size of string placed in @string else error code on failure
  */
-int aa_getprocattr(struct aa_label *label, char **string)
+int aa_getprocattr(struct aa_label *label, char **string, bool newline)
 {
 	struct aa_ns *ns = labels_ns(label);
 	struct aa_ns *current_ns = aa_get_current_ns();
@@ -60,11 +61,13 @@ int aa_getprocattr(struct aa_label *label, char **string)
 		return len;
 	}
 
-	(*string)[len] = '\n';
-	(*string)[len + 1] = 0;
+	if (newline) {
+		(*string)[len] = '\n';
+		(*string)[++len] = 0;
+	}
 
 	aa_put_ns(current_ns);
-	return len + 1;
+	return len;
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index fdd0c85df89e..5a4d90256fd7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2111,7 +2111,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	if (!strcmp(name, "context")) {
 		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
 				     list) {
-			rc = hp->hook.getprocattr(p, "current", &cp);
+			rc = hp->hook.getprocattr(p, "context", &cp);
 			if (rc == -EINVAL || rc == -ENOPROTOOPT)
 				continue;
 			if (rc < 0) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index cd4743331800..1f53a0c66a46 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6281,7 +6281,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9ce67e03ac49..834b6e886e7b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3487,7 +3487,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 	char *cp;
 	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
 		return -EINVAL;
 
 	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-- 
2.24.1


