Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53268C43613
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 15:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9567206B7
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 15:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="lH+O5lP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfFUP6t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:58:49 -0400
Received: from rgout0301.bt.lon5.cpcloud.co.uk ([65.20.0.207]:60355 "EHLO
        rgout03.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbfFUP6t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 11:58:49 -0400
X-OWM-Source-IP: 31.49.56.40 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrtdeigdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlqdeimdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledrheeirdegtdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehiedrgedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrtdeigdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlqdeimdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledrheeirdegtdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehiedrgedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrtdeigdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlqdeimdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledrheeirdegtdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehiedrgedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
Received: from localhost.localdomain (31.49.56.40) by rgout03.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5C90B6EC08A79988; Fri, 21 Jun 2019 16:40:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1561132728; 
        bh=lB+2pOdFpIrY2mDUeQGRxIrsmC1XDKctu7X4SiBHv6U=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=lH+O5lP+92AXRSK3cA42fzPGsv35fkmuOdDTLMPnWdUGvPgTH6/J2xeSwRwFLqooHeD6sKhkjG01QcSXMOXppgg3DmXPpYHvrCkHBLSsWKzvAAr5jR4UI+0XLk0jgV774noRn8McMyAP2xhN9fSaWo9aNzTJZqLfMjKlZ7u5HF4=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 2/2] selinux: Update manpages after removing legacy boolean and user code
Date:   Fri, 21 Jun 2019 16:40:53 +0100
Message-Id: <20190621154053.19792-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove and update all relevant manpages.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/man/man3/security_load_booleans.3  | 12 +--
 .../man/man3/selinux_binary_policy_path.3     |  7 +-
 libselinux/man/man3/selinux_booleans_path.3   |  1 -
 libselinux/man/man5/booleans.5                | 80 ------------------
 libselinux/man/man5/local.users.5             | 68 ---------------
 libselinux/man/ru/man5/booleans.5             | 83 -------------------
 libselinux/man/ru/man5/local.users.5          | 72 ----------------
 libsepol/man/man3/sepol_genbools.3            | 30 -------
 libsepol/man/man3/sepol_genusers.3            | 54 ------------
 policycoreutils/man/man5/selinux_config.5     | 15 +---
 policycoreutils/man/ru/man5/selinux_config.5  | 11 +--
 11 files changed, 8 insertions(+), 425 deletions(-)
 delete mode 100644 libselinux/man/man3/selinux_booleans_path.3
 delete mode 100644 libselinux/man/man5/booleans.5
 delete mode 100644 libselinux/man/man5/local.users.5
 delete mode 100644 libselinux/man/ru/man5/booleans.5
 delete mode 100644 libselinux/man/ru/man5/local.users.5
 delete mode 100644 libsepol/man/man3/sepol_genbools.3
 delete mode 100644 libsepol/man/man3/sepol_genusers.3

diff --git a/libselinux/man/man3/security_load_booleans.3 b/libselinux/man/man3/security_load_booleans.3
index 3b0bbeaf..25922f1a 100644
--- a/libselinux/man/man3/security_load_booleans.3
+++ b/libselinux/man/man3/security_load_booleans.3
@@ -1,13 +1,11 @@
 .TH "security_get_boolean_names" "3" "15 November 2004" "dwalsh@redhat.com" "SELinux API Documentation"
 .SH "NAME"
-security_load_booleans, security_set_boolean, security_commit_booleans, 
+security_set_boolean, security_commit_booleans,
 security_get_boolean_names, security_get_boolean_active,
 security_get_boolean_pending \- routines for manipulating SELinux boolean values
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
-.sp
-.BI "int security_load_booleans(char *" path ");"
 .sp 
 .BI "int security_get_boolean_names(char ***" names ", int *" len ");"
 .sp
@@ -30,10 +28,6 @@ policy without having to load a new policy.
 The SELinux API allows for a transaction based update. So you can
 set several boolean values and then commit them all at once.
 
-.BR security_load_booleans ()
-loads policy boolean settings. Path may be NULL, in which case the
-booleans are loaded from the active policy boolean configuration file.
-
 .BR security_get_boolean_names ()
 provides a list of boolean names, currently supported by the loaded policy.
 
@@ -47,7 +41,9 @@ returns the active value for boolean or \-1 on failure.
 sets the pending value for boolean 
 
 .BR security_set_boolean_list ()
-saves a list of booleans in a single transaction.
+saves a list of booleans in a single transaction. Note that the
+.BI int " permanent "
+flag is deprecated and should be set to zero.
 
 .BR security_commit_booleans ()
 commits all pending values for the booleans.
diff --git a/libselinux/man/man3/selinux_binary_policy_path.3 b/libselinux/man/man3/selinux_binary_policy_path.3
index edaa3b8b..01538688 100644
--- a/libselinux/man/man3/selinux_binary_policy_path.3
+++ b/libselinux/man/man3/selinux_binary_policy_path.3
@@ -4,7 +4,7 @@ selinux_path, selinux_policy_root, selinux_binary_policy_path, selinux_current_p
 selinux_failsafe_context_path, selinux_removable_context_path,
 selinux_default_context_path, selinux_user_contexts_path,
 selinux_file_context_path, selinux_media_context_path,
-selinux_contexts_path, selinux_booleans_path \- These functions return the paths to the active SELinux policy configuration
+selinux_contexts_path \- These functions return the paths to the active SELinux policy configuration
 directories and files
 .
 .SH "SYNOPSIS"
@@ -40,8 +40,6 @@ directories and files
 .B const char *selinux_securetty_types_path(void);
 .sp
 .B const char *selinux_contexts_path(void);
-.sp
-.B const char *selinux_booleans_path(void);
 .
 .SH "DESCRIPTION"
 These functions return the paths to the active policy configuration
@@ -104,9 +102,6 @@ returns the directory containing all of the context configuration files.
 .sp
 .BR selinux_securetty_types_path ()
 returns the defines tty types for newrole securettys.
-.sp
-.BR selinux_booleans_path ()
-returns the initial policy boolean settings.
 .
 .SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
diff --git a/libselinux/man/man3/selinux_booleans_path.3 b/libselinux/man/man3/selinux_booleans_path.3
deleted file mode 100644
index 175a611a..00000000
--- a/libselinux/man/man3/selinux_booleans_path.3
+++ /dev/null
@@ -1 +0,0 @@
-.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man5/booleans.5 b/libselinux/man/man5/booleans.5
deleted file mode 100644
index 2e9caa71..00000000
--- a/libselinux/man/man5/booleans.5
+++ /dev/null
@@ -1,80 +0,0 @@
-.TH "booleans" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
-.SH "NAME"
-booleans \- The SELinux booleans configuration files
-.
-.SH "DESCRIPTION"
-The \fIbooleans\fR file, if present contains booleans to support a specific distribution.
-.sp
-The \fIbooleans.local\fR file, if present contains locally generated booleans.
-.sp
-Both files contain a list of boolean names and their associated values.
-.sp
-Generally the \fIbooleans\fR and/or \fIbooleans.local\fR files are not present (they have been deprecated). However if there is an SELinux-aware application that uses the libselinux functions listed below, then these files may be present:
-.sp
-.RS
-.BR security_set_boolean_list "(3) "
-.RS
-Writes a \fIbooleans.local\fR file if flag \fIpermanent\fR = \fI1\fR.
-.sp
-.RE
-.RE
-.RS
-.BR security_load_booleans "(3) "
-.RS
-Looks for a \fIbooleans\fR and/or \fIbooleans.local\fR file at \fBselinux_booleans_path\fR(3) unless a specific path is specified as a parameter.
-.RE
-.RE
-.sp
-\fBbooleans\fR(8) has details on booleans and \fBsetsebool\fR(8) describes how booleans can now be set persistent across reboots.
-.sp
-\fBselinux_booleans_path\fR(3) will return the active policy path to these files. The default boolean files are:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/booleans
-.br
-.I /etc/selinux/{SELINUXTYPE}/booleans.local
-.RE
-.sp
-Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
-.
-.SH "FILE FORMAT"
-Both boolean files have the same format and contain one or more boolean names and their value.
-.sp
-The format is:
-.RS
-.I boolean_name
-.I value
-.sp
-.RE
-Where:
-.RS
-.I boolean_name
-.RS
-The name of the boolean.
-.RE
-.I value
-.RS
-The default setting for the boolean. This can be one of the following:
-.RS
-.IR true " | " false " | " 1 " | " 0
-.RE
-.RE
-.RE
-.sp
-Note that if
-.B SETLOCALDEFS
-is set in the SELinux
-.I config
-file (see
-.BR selinux_config "(5)), then " selinux_mkload_policy "(3) will check for a "
-.I booleans.local
-file in the
-.BR selinux_booleans_path (3)
-and also a
-.I local.users
-file (see
-.BR local.users "(5)) in the " selinux_users_path "(3). "
-.
-.SH "SEE ALSO"
-.ad l
-.nh
-.BR selinux "(8), " booleans "(8), " setsebool "(8), " semanage "(8), " selinux_booleans_path "(3), " security_set_boolean_list "(3), " security_load_booleans "(3), " selinux_mkload_policy "(3), " selinux_users_path "(3), " selinux_config "(5), " local.users "(5) "
diff --git a/libselinux/man/man5/local.users.5 b/libselinux/man/man5/local.users.5
deleted file mode 100644
index 94d46735..00000000
--- a/libselinux/man/man5/local.users.5
+++ /dev/null
@@ -1,68 +0,0 @@
-.TH "local.users" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
-.SH "NAME"
-local.users \- The SELinux local users configuration file
-.
-.SH "DESCRIPTION"
-The file contains local user definitions in the form of policy language user statements and is only found on older SELinux systems as it has been deprecated and replaced by the \fBsemange\fR(8) services.
-.sp
-This file is only read by \fBselinux_mkload_policy\fR(3) when \fBSETLOCALDEFS\fR in the SELinux \fIconfig\fR file (see \fBselinux_config\fR(5)) is set to \fI1\fR.
-.sp
-.BR selinux_users_path "(3) "
-will return the active policy path to the directory where this file is located. The default local users file is:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/users/local.users
-.RE
-.sp
-Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
-.
-.SH "FILE FORMAT"
-The file consists of one or more entries terminated with '\fB;\fR', each on a separate line as follows:
-.RS
-\fBuser \fIseuser_id \fBroles \fIrole_id\fR [[\fBlevel \fIlevel\fR] [\fBrange \fIrange\fR]]\fB;\fR
-.RE
-.sp
-Where:
-.RS
-.B user
-.RS
-The user keyword.
-.RE
-.I seuser_id
-.RS
-The SELinux user identifier.
-.RE
-.B roles
-.RS
-The roles keyword.
-.RE
-.I role_id
-.RS
-One or more previously declared role identifiers. Multiple role identifiers consist of a space separated list enclosed in braces '{}'.
-.RE
-.B level
-.RS
-If MLS/MCS is configured, the level keyword.
-.RE
-.I level
-.RS
-The users default security level. Note that only the sensitivity component of the level (e.g. s0) is required.
-.RE
-.B range
-.RS
-If MLS/MCS is configured, the range keyword.
-.RE
-.I range
-.RS
-The current and clearance levels that the user can run. These are separated by a hyphen '\fB-\fR' as shown in the \fBEXAMPLE\fR section.
-.RE
-.RE
-.
-.SH "EXAMPLE"
-# ./users/local.users
-.br
-user test_u roles staff_r level s0 range s0 \- s15:c0.c1023;
-.
-.SH "SEE ALSO"
-.ad l
-.nh
-.BR selinux "(8), " semanage "(8), " selinux_users_path "(3), " selinux_config "(5), " selinux_mkload_policy "(3) "
diff --git a/libselinux/man/ru/man5/booleans.5 b/libselinux/man/ru/man5/booleans.5
deleted file mode 100644
index 1471e58b..00000000
--- a/libselinux/man/ru/man5/booleans.5
+++ /dev/null
@@ -1,83 +0,0 @@
-.TH "booleans" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-booleans \- файлы конфигурации логических переключателей SELinux
-.
-.SH "ОПИСАНИЕ"
-Файл \fIbooleans\fR (если имеется) содержит логические переключатели, обеспечивающие поддержку определённого дистрибутива.
-.sp
-Файл \fIbooleans.local\fR (если имеется) содержит созданные локально логические переключатели.
-.sp
-Оба файла содержат список имён логических переключателей и соответствующих этим именам значений.
-.sp
-Обычно файл \fIbooleans\fR и/или файл \fIbooleans.local\fR отсутствуют (они устарели). Но эти файлы могут присутствовать, если имеется приложение, которое поддерживает SELinux и использует перечисленные далее функции libselinux:
-.sp
-.RS
-.BR security_set_boolean_list "(3) "
-.RS
-Записывает файл \fIbooleans.local\fR, если флаг \fIpermanent\fR = \fI1\fR.
-.sp
-.RE
-.RE
-.RS
-.BR security_load_booleans "(3) "
-.RS
-Выполняет поиск файла \fIbooleans\fR и/или файла \fIbooleans.local\fR по адресу \fBselinux_booleans_path\fR(3) (если в качестве параметра не указан конкретный путь).
-.RE
-.RE
-.sp
-\fBbooleans\fR(8) содержит подробные сведения о логических переключателях, а  \fBsetsebool\fR(8) - описание того, как установить логические переключатели, которые не будут сбрасываться при перезагрузках.
-.sp
-\fBselinux_booleans_path\fR(3) вернёт путь активной политики к этим файлам. Файлы логических переключателей по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/booleans
-.br
-.I /etc/selinux/{SELINUXTYPE}/booleans.local
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.
-.SH "ФОРМАТ ФАЙЛА"
-Оба файла имеют один и тот же формат и содержат одно или несколько имён логических переключателей и их значения.
-.sp
-Формат:
-.RS
-.I boolean_name
-.I value
-.sp
-.RE
-Где:
-.RS
-.I boolean_name
-.RS
-Имя логического переключателя.
-.RE
-.I value
-.RS
-Значение логического переключателя по умолчанию. Может быть одним из следующих:
-.RS
-.IR true " | " false " | " 1 " | " 0
-.RE
-.RE
-.RE
-.sp
-Если 
-.B SETLOCALDEFS
-указано в файле
-.I config
-SELinux (см.
-.BR selinux_config "(5)), то " selinux_mkload_policy "(3) будет проверять наличие файла "
-.I booleans.local
-по адресу
-.BR selinux_booleans_path (3),
-а также файла
-.I local.users
-(см.
-.BR local.users "(5)) по адресу " selinux_users_path "(3). "
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " booleans "(8), " setsebool "(8), " semanage "(8), " selinux_booleans_path "(3), " security_set_boolean_list "(3), " security_load_booleans "(3), " selinux_mkload_policy "(3), " selinux_users_path "(3), " selinux_config "(5), " local.users "(5) "
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/local.users.5 b/libselinux/man/ru/man5/local.users.5
deleted file mode 100644
index ca9f201d..00000000
--- a/libselinux/man/ru/man5/local.users.5
+++ /dev/null
@@ -1,72 +0,0 @@
-.TH "local.users" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-local.users \- файл конфигурации локальных пользователей SELinux
-.
-.SH "ОПИСАНИЕ"
-Файл содержит определения локальных пользователей в виде инструкций пользователей на языке политики. Этот файл имеется только в старых версиях систем SELinux, так как он устарел и был заменён службами \fBsemanage\fR(8).
-.sp
-\fBselinux_mkload_policy\fR(3) выполняет чтение этого файла только тогда, когда для \fBSETLOCALDEFS\fR в файле \fIconfig\fR SELinux (см. \fBselinux_config\fR(5)) установлено значение \fI1\fR.
-.sp
-.BR selinux_users_path "(3) "
-возвращает путь активной политики к каталогу, в котором расположен файл. Файл локальных пользователей по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/users/local.users
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.
-.SH "ФОРМАТ ФАЙЛА"
-Файл состоит из одной или нескольких записей, которые заканчиваются '\fB;\fR', каждая на отдельной строке:
-.RS
-\fBuser \fIseuser_id \fBroles \fIrole_id\fR [[\fBlevel \fIlevel\fR] [\fBrange \fIrange\fR]]\fB;\fR
-.RE
-.sp
-Где:
-.RS
-.B user
-.RS
-Ключевое слово user (пользователь).
-.RE
-.I seuser_id
-.RS
-Идентификатор пользователя SELinux.
-.RE
-.B roles
-.RS
-Ключевое слово roles (роли).
-.RE
-.I role_id
-.RS
-Один или несколько ранее объявленных идентификаторов ролей. Несколько идентификаторов ролей - это разделённый пробелами список, который заключён в скобки '{}'.
-.RE
-.B level
-.RS
-Если настроена система MLS/MCS, ключевое слово level (уровень).
-.RE
-.I level
-.RS
-Уровень безопасности пользователя по умолчанию. Обратите внимание, что обязательным является только компонент конфиденциальности уровня (например, s0).
-.RE
-.B range
-.RS
-Если настроена система MLS/MCS, ключевое слово range (диапазон).
-.RE
-.I range
-.RS
-Текущий уровень и уровень допуска пользователя. Они разделены дефисом '\fB-\fR' (как показано в разделе \fBПРИМЕР\fR).
-.RE
-.RE
-.
-.SH "ПРИМЕР"
-# ./users/local.users
-.br
-user test_u roles staff_r level s0 range s0 \- s15:c0.c1023;
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " semanage "(8), " selinux_users_path "(3), " selinux_config "(5), " selinux_mkload_policy "(3) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libsepol/man/man3/sepol_genbools.3 b/libsepol/man/man3/sepol_genbools.3
deleted file mode 100644
index 53633832..00000000
--- a/libsepol/man/man3/sepol_genbools.3
+++ /dev/null
@@ -1,30 +0,0 @@
-.TH "sepol_genbools" "3" "11 August 2004" "sds@tycho.nsa.gov" "SE Linux binary policy API documentation"
-.SH "NAME"
-sepol_genbools \- Rewrite a binary policy with different boolean settings
-.SH "SYNOPSIS"
-.B #include <sepol/sepol.h>
-.sp
-.BI "int sepol_genbools(void *" data ", size_t "len ", const char *" boolpath );
-.br
-.BI "int sepol_genbools_array(void *" data ", size_t " len ", char **" names ", int *" values ", int " nel );
-
-.SH "DESCRIPTION"
-.B sepol_genbools
-rewrites a binary policy stored in the memory region described by
-(data, len) to use the boolean settings specified in the file named by
-boolpath.  The boolean settings are specified by name=value lines
-where value may be 0 or false to disable or 1 or true to enable.  The
-binary policy is rewritten in place in memory.
-
-.B sepol_genbools_array
-does likewise, but obtains the boolean settings from the parallel arrays
-(names, values) with nel elements each.
-
-.SH "RETURN VALUE"
-Returns 0 on success or \-1 otherwise, with errno set appropriately.
-An errno of ENOENT indicates that the boolean file did not exist.
-An errno of EINVAL indicates that one or more booleans listed in the
-boolean file was undefined in the policy or had an invalid value specified;
-in this case, the binary policy is still rewritten but any invalid
-boolean settings are ignored.
-
diff --git a/libsepol/man/man3/sepol_genusers.3 b/libsepol/man/man3/sepol_genusers.3
deleted file mode 100644
index 1f820ff5..00000000
--- a/libsepol/man/man3/sepol_genusers.3
+++ /dev/null
@@ -1,54 +0,0 @@
-.TH "sepol_genusers" "3" "15 March 2005" "sds@tycho.nsa.gov" "SE Linux binary policy API documentation"
-.SH "NAME"
-sepol_genusers \- Generate a new binary policy image with a customized user configuration
-.SH "SYNOPSIS"
-.B #include <sepol/sepol.h>
-.sp
-.BI "int sepol_genusers(void *" data ", size_t "len ", const char *" usersdir ", void *" newdata ", size_t *" newlen);
-.sp
-.BI "void sepol_set_delusers(int " on ");"
-
-.SH "DESCRIPTION"
-.B sepol_genusers
-generates a new binary policy image from 
-an existing binary policy image stored in the memory region described by
-the starting address
-.I data
-and the length
-.I len
-and a pair of user configuration files named 
-.B system.users 
-and
-.B local.users
-from the directory specified by
-.I usersdir.
-The resulting binary policy is placed into dynamically allocated
-memory and the variables
-.I newdata
-and
-.I newlen
-are set to refer to the new binary image's starting address and length.
-The original binary policy image is not modified.
-
-By default, 
-.B sepol_genusers
-will preserve user entries that are defined in the original binary policy image
-but not defined in the user configuration files.  If such user entries
-should instead by omitted entirely from the new binary policy image, then
-the
-.B sepol_set_delusers
-function may be called with 
-.I on
-set to 1 prior to calling
-.B sepol_genusers
-in order to enable deletion of such users.
-
-.SH "RETURN VALUE"
-Returns 0 on success or \-1 otherwise, with errno set appropriately.
-An errno of ENOENT indicates that one or both of the user
-configuration files did not exist.  An errno of EINVAL indicates that
-either the original binary policy image or the generated one were
-invalid.  An errno of ENOMEM indicates that insufficient memory was
-available to process the original binary policy image or to generate
-the new policy image.  Invalid entries in the user configuration files
-are skipped with a warning.
diff --git a/policycoreutils/man/man5/selinux_config.5 b/policycoreutils/man/man5/selinux_config.5
index dbfec55a..1ffade15 100644
--- a/policycoreutils/man/man5/selinux_config.5
+++ b/policycoreutils/man/man5/selinux_config.5
@@ -11,10 +11,8 @@ The policy enforcement status \- \fIenforcing\fR, \fIpermissive\fR or \fIdisable
 .IP "2." 4
 The policy name or type that forms a path to the policy to be loaded and its supporting configuration files.
 .IP "3." 4
-How local users and booleans will be managed when the policy is loaded (note that this function was used by older releases of SELinux and is now deprecated).
-.IP "4." 4
 How SELinux-aware login applications should behave if no valid SELinux users are configured.
-.IP "5." 4
+.IP "4." 4
 Whether the system is to be relabeled or not.
 .RE
 
@@ -34,8 +32,6 @@ The \fIconfig\fR file supports the following parameters:
 .br
 \fBSELINUXTYPE = \fIpolicy_name\fR
 .br
-\fBSETLOCALDEFS = \fI0\fR | \fI1\fR
-.br
 \fBREQUIREUSERS = \fI0\fR | \fI1\fR
 .br
 \fBAUTORELABEL = \fI0\fR | \fI1\fR
@@ -88,13 +84,6 @@ The binary policy name has by convention the SELinux policy version that it supp
 .RE
 .RE
 .sp
-.B SETLOCALDEFS
-.RS
-This entry is deprecated and should be removed or set to \fI0\fR.
-.sp
-If set to \fI1\fR, then \fBselinux_mkload_policy\fR(3) will read the local customization for booleans (see \fBbooleans\fR(5)) and users (see \fBlocal.users\fR(5)).
-.RE
-.sp
 .B REQUIRESEUSERS
 .RS
 This optional entry can be used to fail a login if there is no matching or default entry in the
@@ -138,4 +127,4 @@ SELINUXTYPE = targeted
 .RE
 
 .SH "SEE ALSO"
-.BR selinux "(8), " sestatus "(8), " selinux_path "(3), " selinux_policy_root_path "(3), " selinux_binary_policy_path "(3), " getseuserbyname "(3), " PAM "(8), " fixfiles "(8), " selinux_mkload_policy "(3), " selinux_getpolicytype "(3), " security_policyvers "(3), " selinux_getenforcemode "(3), " seusers "(5), " booleans "(5), " local.users "(5) "
+.BR selinux "(8), " sestatus "(8), " selinux_path "(3), " selinux_policy_root_path "(3), " selinux_binary_policy_path "(3), " getseuserbyname "(3), " PAM "(8), " fixfiles "(8), " selinux_mkload_policy "(3), " selinux_getpolicytype "(3), " security_policyvers "(3), " selinux_getenforcemode "(3), " seusers "(5) "
diff --git a/policycoreutils/man/ru/man5/selinux_config.5 b/policycoreutils/man/ru/man5/selinux_config.5
index 93dcc582..40039e57 100644
--- a/policycoreutils/man/ru/man5/selinux_config.5
+++ b/policycoreutils/man/ru/man5/selinux_config.5
@@ -34,8 +34,6 @@ config \- файл конфигурации подсистемы SELinux.
 .br
 \fBSELINUXTYPE = \fIpolicy_name\fR
 .br
-\fBSETLOCALDEFS = \fI0\fR | \fI1\fR
-.br
 \fBREQUIREUSERS = \fI0\fR | \fI1\fR
 .br
 \fBAUTORELABEL = \fI0\fR | \fI1\fR
@@ -88,13 +86,6 @@ SELinux отключён, политика не загружена.
 .RE
 .RE
 .sp
-.B SETLOCALDEFS
-.RS
-Эта запись устарела. Следует её удалить или задать для неё значение \fI0\fR.
-.sp
-Если задано значение \fI1\fR, \fBselinux_mkload_policy\fR(3) выполнит чтение логических переключателей (см. \fBbooleans\fR(5)) и пользователей (см. \fBlocal.users\fR(5)) в локальной настройке.
-.RE
-.sp
 .B REQUIRESEUSERS
 .RS
 Эта необязательная запись позволяет сделать попытку входа неудачной, если в файле 
@@ -138,7 +129,7 @@ SELINUXTYPE = targeted
 .RE
 
 .SH "СМОТРИТЕ ТАКЖЕ"
-.BR selinux "(8), " sestatus "(8), " selinux_path "(3), " selinux_policy_root_path "(3), " selinux_binary_policy_path "(3), " getseuserbyname "(3), " PAM "(8), " fixfiles "(8), " selinux_mkload_policy "(3), " selinux_getpolicytype "(3), " security_policyvers "(3), " selinux_getenforcemode "(3), " seusers "(5), " booleans "(5), " local.users "(5) "
+.BR selinux "(8), " sestatus "(8), " selinux_path "(3), " selinux_policy_root_path "(3), " selinux_binary_policy_path "(3), " getseuserbyname "(3), " PAM "(8), " fixfiles "(8), " selinux_mkload_policy "(3), " selinux_getpolicytype "(3), " security_policyvers "(3), " selinux_getenforcemode "(3), " seusers "(5) "
 
 
 .SH АВТОРЫ
-- 
2.21.0

