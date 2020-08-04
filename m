Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0931BC433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E900020781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="TIcMzG8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgHDBee (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBed (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:34:33 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5628C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:34:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so29777047qtm.10
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=KFRyEWJ+SnU8Mx6RM6SDQB0INLWMQvW1g/imwXTTYjA=;
        b=TIcMzG8DFSdpxX52ttGrBdP+7jHZzXtjJAcutfDlKSOVbdFwIbdUAtIrnJw21W9Zob
         Jy58aU5mh2RQKr6pYTdA+JDm32r+JogdoDt8qAH62IKePyQ40LlA9hh52cFSZ8BtDyqt
         1qsIfoo2mCBdjvxillXyxFBMDhZz8AHzHFpv3WwnqwCC9rmGXY/QKcz8d8QCaYGo0hIl
         xIrlzmknzQv/cwDRr746d0FS39iDWE+pD797jCmsUlFp1xRHRxrydB0b8xb8S2JsloHQ
         gXnaKiWdNn7kFh2sHb1SnXb6FxTC1LeZAQqV7YB0TQV19DXumZlSBryFD2VDMwONlYGO
         D52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KFRyEWJ+SnU8Mx6RM6SDQB0INLWMQvW1g/imwXTTYjA=;
        b=icrBBji0LBMZ6ZfukidyNHii2xDKkk5nq/GipVdXWcShe6icWJ/At/YKphDVS7jCzy
         iQ1CPUpB4/9w/X7+yuq2IQsqmRG5DWLjaa0Qxq/BBRxNFMK+poP7wJzx66XchzD7GpW1
         FcIvoIrDYyvhgVFMSwuWWaIyuocHL8j3ZJq+kf76OW1WGoYxweBoORkusaBrqaBpSkEE
         UxODFxeegY7hkKC1w4QBOBGNGpBh3p0OWVy433x/oLGcnJrKsNhfAJU4S1jjCJEw/4c/
         LGZ/BgFCJYL9vyc2oMmyD6jHLEZI1F1cRWrBlLpTdxpId3rLVx7OHqs9hNzokOzT0jfT
         T7uQ==
X-Gm-Message-State: AOAM533gHxoX8KmwpdDws0k6RYjGcKZfHiTXvoxcfdn3vcoqhXg10ORJ
        OdvzNZif9tVrTDMQ7gc494jzg1t9+g6j
X-Google-Smtp-Source: ABdhPJw+RO0rrBO027oJD1hLP2fHKQAtyLkx2NrKi4vtsumWDBYuaqHwRKm4La1dvErv8NTleKZ4vg==
X-Received: by 2002:aed:2793:: with SMTP id a19mr19773030qtd.168.1596504869538;
        Mon, 03 Aug 2020 18:34:29 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id s30sm24245678qtc.87.2020.08.03.18.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:34:28 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 11/18] postgresql: update PostgreSQL
 SELinux Support section
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:34:27 -0400
Message-ID: <159650486774.8961.2667775016658143771.stgit@sifl>
In-Reply-To: <159650470076.8961.12721446818345626943.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Richard Haines <richard_c_haines@btinternet.com>

Removed image 24 and replaced with a table, also reformatted to use
only markdown.

Added a section index to see if useful.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/images/24-database-table.png |  Bin
 src/postgresql.md                |  141 +++++++++++++++-----------------------
 2 files changed, 57 insertions(+), 84 deletions(-)
 delete mode 100644 src/images/24-database-table.png

diff --git a/src/images/24-database-table.png b/src/images/24-database-table.png
deleted file mode 100644
index f1d81fcb0c6852be8d252c7fd94a1445b38f3b34..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 44747
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
LL*0CB+u;8I<hGLf

diff --git a/src/postgresql.md b/src/postgresql.md
index 4721891..f7ab1e6 100644
--- a/src/postgresql.md
+++ b/src/postgresql.md
@@ -1,5 +1,13 @@
 # PostgreSQL SELinux Support
 
+-   [**sepgsql Overview**](#sepgsql-overview)
+-   [**Installing SE-PostgreSQL**](#installing-se-postgresql)
+-   [***SECURITY LABEL* SQL Command**](#security-label-sql-command)
+-   [**Additional SQL Functions**](#additional-sql-functions)
+-   [***postgresql.conf* Entries**](#postgresql.conf-entries)
+-   [**Logging Security Events**](#logging-security-events)
+-   [**Internal Tables**](#internal-tables)
+
 This section gives an overview of PostgreSQL version 11.x with the
 *sepgsql* extension to support SELinux. It assumes some basic knowledge
 of PostgreSQL that can be found at:
@@ -22,23 +30,29 @@ document:
 
 <https://www.postgresql.org/docs/11/sepgsql.html>
 
-
 ## sepgsql Overview
 
 The *sepgsql* extension adds SELinux mandatory access controls (MAC) to
 database objects such as tables, columns, views, functions, schemas and
-sequences. **Figure 24: Database Security Context Information** shows a simple
-database with one table, two columns and three rows, each with their object
-class and associated security context (the [**Internal Tables**](#internal-tables)
+sequences. **Table 1: Database Security Context Information** shows a simple
+database with one table and two columns, each with their object class and
+associated security context (the [**Internal Tables**](#internal-tables)
 section shows these entries from the *testdb* database in the
 [**Notebook sepgsql Example**](notebook-examples/sepgsql/testdb-example.sql).
 The database object classes and permissions are described in
 [**Appendix A - Object Classes and Permissions**](object_classes_permissions.md#database-object-classes).
 
-![](./images/24-database-table.png)
+|       |
+| :---: |
+| **database** (*db_database*) - context = 'unconfined_u:object_r:postgresql_db_t:s0' This context is inherited from the database directory label -  ls -Z /var/lib/pgsql/data |
+| **schema** (*db_schema*) - security_label = 'unconfined_u:object_r:sepgsql_schema_t:s0:c10' |
+| **table** (*db_table*)   - security_label = 'unconfined_u:object_r:sepgsql_table_t:s0:c20'  |
+
+|       |       |
+| :---: | :---: |
+| **column 1** (*db_column*) - security_label = 'unconfined_u:object_r:sepgsql_table_t:s0:c30' | **column 2** - (*db_column*) security_label = 'unconfined_u:object_r:sepgsql_table_t:s0:c40' |
 
-**Figure 24: Database Security Context Information** - *Showing the security
-contexts that can be associated to a schema, table and columns.*
+**Table 1: Database Security Context Information** - *Showing the security contexts that can be associated to a schema, table and columns.*
 
 To use SE-PostgreSQL each Linux user must have a valid PostgreSQL
 database role (not to be confused with an SELinux role). The default
@@ -68,9 +82,7 @@ with AVC audits being logged via the standard PostgreSQL logfile as
 described in the [**Logging Security Events**](#logging-security-events)
 section.
 
-<br>
-
-### Installing SE-PostgreSQL
+## Installing SE-PostgreSQL
 
 The [**https://www.postgresql.org/docs/11/sepgsql.html**](https://www.postgresql.org/docs/11/sepgsql.html)
 page contains all the information required to install the *sepgsql* extension.
@@ -79,7 +91,7 @@ There are also instructions in the
 [**Notebook sepgsql Example - README**](notebook-examples/sepgsql/README.md)
 that describes building the example database used in the sections below.
 
-### *SECURITY LABEL* SQL Command
+## *SECURITY LABEL* SQL Command
 
 The '*SECURITY LABEL*' SQL command has been added to PostgreSQL to allow
 security providers to label or change a label on database objects.
@@ -102,34 +114,32 @@ SECURITY LABEL ON COLUMN test_ns.info.email_addr IS
 'unconfined_u:object_r:sepgsql_table_t:s0:c40';
 ```
 
-### Additional SQL Functions
+## Additional SQL Functions
 
 The following functions have been added:
 
-<table>
-<tbody>
-<tr>
-<td><code>sepgsql_getcon()</code></td>
-<td>Returns the client security context.</td>
-</tr>
-<tr>
-<td><code>sepgsql_mcstrans_in(text con)</code></td>
-<td>Translates the readable <em>range</em> of the context into raw format provided the <em>mcstransd</em> daemon is running.</td>
-</tr>
-<tr>
-<td><code>sepgsql_mcstrans_out(text con)</code></td>
-<td>Translates the raw <em>range</em> of the context into readable format provided the <em>mcstransd</em> daemon is running.</td>
-</tr>
-<tr>
-<td><code>sepgsql_restorecon(text specfile)</code></td>
-<td>Sets security contexts on all database objects (must be superuser) according to the <em>specfile</em>. This is normally used for initialisation of the database by the <em>sepgsql.sql</em> script. If the parameter is NULL, then the default <em>sepgsql_contexts</em> file is used. See <em><strong>selabel_db</strong>(5)</em> details.</td>
-</tr>
-</tbody>
-</table>
-
-<br>
-
-### *postgresql.conf* Entries
+*sepgsql_getcon()*
+
+Returns the client security context.
+
+*sepgsql_mcstrans_in(text con)*
+
+Translates the readable *range* of the context into raw format provided the
+***mcstransd**(8)* daemon is running.
+
+*sepgsql_mcstrans_out(text con)*
+
+Translates the raw *range* of the context into readable format provided the
+***mcstransd**(8)* daemon is running.
+
+*sepgsql_restorecon(text specfile)*
+
+Sets security contexts on all database objects (must be superuser) according
+to the *specfile*. This is normally used for initialisation of the database
+by the *sepgsql.sql* script. If the parameter is NULL, then the default
+*sepgsql_contexts* file is used. See ***selabel_db**(5)* details.
+
+## *postgresql.conf* Entries
 
 The *postgresql.conf* file supports the following additional entries to
 enable and manage SE-PostgreSQL:
@@ -167,9 +177,7 @@ on
 (1 row)
 ```
 
-<br>
-
-### Logging Security Events
+## Logging Security Events
 
 SE-PostgreSQL manages its own AVC audit entries in the standard
 PostgreSQL log normally located within the */var/lib/pgsql/data/pg_log*
@@ -177,9 +185,7 @@ directory and by default only errors are logged (Note that there are no
 SE-PostgreSQL AVC entries added to the standard *audit.log*). The
 '*sepgsql.debug_audit = on*' can be set to log all audit events.
 
-<br>
-
-### Internal Tables
+## Internal Tables
 
 To support the overall database operation PostgreSQL has internal tables
 in the system catalog that hold information relating to databases,
@@ -188,46 +194,15 @@ that holds the security label and other references. The *pg_seclabel*
 is shown in the table below and has been taken from
 <http://www.postgresql.org/docs/11/static/catalog-pg-seclabel.html>.
 
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Name</strong></td>
-<td><strong>Type</strong></td>
-<td><strong>References</strong></td>
-<td><strong>Comments</strong></td>
-</tr>
-<tr>
-<td><code>objoid</code></td>
-<td><code>oid</code></td>
-<td>any OID column</td>
-<td>The OID of the object this security label pertains to.</td>
-</tr>
-<tr>
-<td><code>classoid</code></td>
-<td><code>oid</code></td>
-<td><a href="http://www.postgresql.org/docs/11/static/catalog-pg-class.html">pg_class</a>.oid</td>
-<td>The OID of the system catalog this object appears in.</td>
-</tr>
-<tr>
-<td><code>objsubid</code></td>
-<td>int4</td>
-<td></td>
-<td>For a security label on a table column, this is the column number (the <em>objoid</em> and <em>classoid</em> refer to the table itself). For all other objects this column is zero.</td>
-</tr>
-<tr>
-<td><code>provider</code></td>
-<td>text</td>
-<td></td>
-<td>The label provider associated with this label. Currently only SELinux is supported.</td>
-</tr>
-<tr>
-<td><code>label</code></td>
-<td>text</td>
-<td></td>
-<td>The security label applied to this object.</td>
-</tr>
-</tbody>
-</table>
+
+| **Name** | **Type** | **References** | **Comments** |
+| -------- | -------- | -------------- | ------------ |
+| objoid   |   oid    | any OID column | The OID of the object this security label pertains to. |
+| classoid |   oid    | pg_class.oid   | The OID of the system catalog this object appears in.  |
+| objsubid |  int4    |                | For a security label on a table column, this is the column number (the *objoid* and *classoid* refer to the table itself). For all other objects this column is zero. |
+| provider |  text    |                 | The label provider associated with this label. Currently only SELinux is supported. |
+| label    |  text    |                 | The security label applied to this object. |
+
 
 These are entries taken from a '*SELECT * FROM pg_seclabel;*' command
 that refers to the example *testdb* database built using the
@@ -260,8 +235,6 @@ objoid|classoid|objsubid|objtype|objnamespace|  objname     | provider| label
       |        |        |       |            | email_addr   |         |
 ```
 
-<br>
-
 <!-- %CUTHERE% -->
 
 ---

