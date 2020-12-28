Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44649C433DB
	for <selinux@archiver.kernel.org>; Mon, 28 Dec 2020 18:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FB7229EF
	for <selinux@archiver.kernel.org>; Mon, 28 Dec 2020 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgL1SJW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Dec 2020 13:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgL1SJW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Dec 2020 13:09:22 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D02AC061793
        for <selinux@vger.kernel.org>; Mon, 28 Dec 2020 10:08:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u19so10520023edx.2
        for <selinux@vger.kernel.org>; Mon, 28 Dec 2020 10:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dh6J3O9I2apnVwd1f3ysFfoozH9h7XYWivnmsNg37SI=;
        b=DuIvhQwV5dFvto9RYkCAs8sGHOlotBjvz+l3mIxOfDm1eq51Vx1xfQ2qLb9TYh/T3h
         7xzAT3xvzidLCYX8qsCV0SLGSeu6g9YDvWqv1YLODwnv86t1ZAyHHh7Cy23hYZAvcyhq
         ntXzkU/FKi+s9ol7xNmMdlk6bu9sBhNATKkaVAchTVAgaqzttxocSESDbyl/ZlC6KM3I
         W1Efpu/q+bNxvsWT2q+0R80k/K0KHViNfYBn8pJilSQ5DYwgwdprSF06ngAvIvHodKNc
         RK7zAKefjTxgTyz/LA/b1SE0QorMpyKAYvoEtEN8UEx31yZwhnG4dylGZGbLPp/bbh6S
         nMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dh6J3O9I2apnVwd1f3ysFfoozH9h7XYWivnmsNg37SI=;
        b=Ym26pPeCkhDfL7tdPcHOtMlZ9T62Tkc+m6gVfAU6oMKHAiFLroEPqshVHWBR1nXRAM
         U33beY2l/mvedtazkOLTd4TZUsVjKPHvrTARQkRm5T3B2/yM10iNRr1nqDs9aMwiRgbs
         7Odesen0ZUskzaGEf9oP6Ftl24vT55FQZS3THzjzsn66CZNmhw80EQV1w2DiVoun3lz7
         xGA3kQOXtPqnBuwKyyws06pQ4ba5g/P8THtwsgZ7rBevTmGytIg0uETS9wXiMvEiyEOC
         uUnWL6tivir42jdMxzFlkrS0dImS2++dIVf8ZZwOkhn+K/CxaZEAz/WjkO8HJbGrLBsi
         dLvA==
X-Gm-Message-State: AOAM531L5cE8akDLwPOowBxWVV9QVla7RhLBq5e3MVbkEgTOyPKCnxOA
        q4BBWIq7RwmEy0K+FlqDdQPTA9p38jY=
X-Google-Smtp-Source: ABdhPJy6OQKAg2zabxBw6iaQFlsIIqMj5seG5V9XhjaLeS0GWgVTrsgTaQxfYXvYkBVPx+VcdyjnFA==
X-Received: by 2002:a05:6402:746:: with SMTP id p6mr43509918edy.313.1609178920059;
        Mon, 28 Dec 2020 10:08:40 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-166-133.77.10.pool.telefonica.de. [77.10.166.133])
        by smtp.gmail.com with ESMTPSA id b7sm17311131ejz.4.2020.12.28.10.08.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 10:08:39 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC DBUS PATCH] selinux: add option to control checking of reply messages
Date:   Mon, 28 Dec 2020 19:08:32 +0100
Message-Id: <20201228180832.490838-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.30.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently all reply messages are checked with the same SELinux
permission as request messages ("send_mesg").
Add an option <replycheck> to be able to use a distinc SELinux
permission for reply messages.

Upstream Merge Request: https://gitlab.freedesktop.org/dbus/dbus/-/merge_requests/199
---
 bus/bus.c                               | 26 +++++++++++++
 bus/bus.h                               |  1 +
 bus/config-parser-common.c              |  6 +++
 bus/config-parser-common.h              |  1 +
 bus/config-parser-trivial.c             | 29 ++++++++++++++
 bus/config-parser.c                     | 50 ++++++++++++++++++++++++-
 bus/config-parser.h                     |  1 +
 bus/selinux.c                           | 39 ++++++++++++++++++-
 bus/selinux.h                           |  3 ++
 doc/busconfig.dtd                       |  4 +-
 doc/dbus-daemon.1.xml.in                | 21 ++++++++++-
 test/data/valid-config-files/basic.conf |  1 +
 12 files changed, 177 insertions(+), 5 deletions(-)

diff --git a/bus/bus.c b/bus/bus.c
index db20bbbc..3f4c1ef6 100644
--- a/bus/bus.c
+++ b/bus/bus.c
@@ -57,6 +57,7 @@ struct BusContext
   char *config_file;
   char *type;
   char *servicehelper;
+  char *replycheck_verb;
   char *address;
   char *pidfile;
   char *user;
@@ -568,6 +569,7 @@ process_config_every_time (BusContext      *context,
   DBusList **dirs;
   char *addr;
   const char *servicehelper;
+  const char *replycheck_verb;
   char *s;
 
   dbus_bool_t retval;
@@ -664,6 +666,21 @@ process_config_every_time (BusContext      *context,
       context->servicehelper = s;
     }
 
+  /* and the replycheck */
+  replycheck_verb = bus_selinux_convert_replycheck_option (bus_config_parser_get_replycheck (parser));
+
+  s = _dbus_strdup(replycheck_verb);
+  if (s == NULL && replycheck_verb != NULL)
+    {
+      BUS_SET_OOM (error);
+      goto failed;
+    }
+  else
+    {
+      dbus_free(context->replycheck_verb);
+      context->replycheck_verb = s;
+    }
+
   /* Create activation subsystem */
   if (context->activation)
     {
@@ -1222,6 +1239,7 @@ bus_context_unref (BusContext *context)
       dbus_free (context->address);
       dbus_free (context->user);
       dbus_free (context->servicehelper);
+      dbus_free (context->replycheck_verb);
 
       if (context->pidfile)
 	{
@@ -1264,6 +1282,12 @@ bus_context_get_servicehelper (BusContext *context)
   return context->servicehelper;
 }
 
+const char*
+bus_context_get_replycheck_verb (BusContext *context)
+{
+    return context->replycheck_verb;
+}
+
 dbus_bool_t
 bus_context_get_systemd_activation (BusContext *context)
 {
@@ -1677,6 +1701,8 @@ bus_context_check_security_policy (BusContext     *context,
        * go on with the standard checks.
        */
       if (!bus_selinux_allows_send (sender, proposed_recipient,
+                                    requested_reply,
+                                    bus_context_get_replycheck_verb (context),
                                     dbus_message_type_to_string (dbus_message_get_type (message)),
                                     dbus_message_get_interface (message),
                                     dbus_message_get_member (message),
diff --git a/bus/bus.h b/bus/bus.h
index 99625ca3..5c8d8dcf 100644
--- a/bus/bus.h
+++ b/bus/bus.h
@@ -100,6 +100,7 @@ dbus_bool_t       bus_context_get_id                             (BusContext
 const char*       bus_context_get_type                           (BusContext       *context);
 const char*       bus_context_get_address                        (BusContext       *context);
 const char*       bus_context_get_servicehelper                  (BusContext       *context);
+const char*       bus_context_get_replycheck_verb                (BusContext       *context);
 dbus_bool_t       bus_context_get_systemd_activation             (BusContext       *context);
 BusRegistry*      bus_context_get_registry                       (BusContext       *context);
 BusConnections*   bus_context_get_connections                    (BusContext       *context);
diff --git a/bus/config-parser-common.c b/bus/config-parser-common.c
index 627c9013..ec069bf3 100644
--- a/bus/config-parser-common.c
+++ b/bus/config-parser-common.c
@@ -115,6 +115,10 @@ bus_config_parser_element_name_to_type (const char *name)
     {
       return ELEMENT_ASSOCIATE;
     }
+  else if (strcmp (name, "replycheck") == 0)
+    {
+        return ELEMENT_REPLYCHECK;
+    }
   else if (strcmp (name, "syslog") == 0)
     {
       return ELEMENT_SYSLOG;
@@ -179,6 +183,8 @@ bus_config_parser_element_type_to_name (ElementType type)
       return "selinux";
     case ELEMENT_ASSOCIATE:
       return "associate";
+    case ELEMENT_REPLYCHECK:
+        return "replycheck";
     case ELEMENT_SYSLOG:
       return "syslog";
     case ELEMENT_KEEP_UMASK:
diff --git a/bus/config-parser-common.h b/bus/config-parser-common.h
index 1c601e97..b2e58579 100644
--- a/bus/config-parser-common.h
+++ b/bus/config-parser-common.h
@@ -45,6 +45,7 @@ typedef enum
   ELEMENT_CONFIGTYPE,
   ELEMENT_SELINUX,
   ELEMENT_ASSOCIATE,
+  ELEMENT_REPLYCHECK,
   ELEMENT_STANDARD_SESSION_SERVICEDIRS,
   ELEMENT_STANDARD_SYSTEM_SERVICEDIRS,
   ELEMENT_KEEP_UMASK,
diff --git a/bus/config-parser-trivial.c b/bus/config-parser-trivial.c
index 9a2087cf..8d74f6bc 100644
--- a/bus/config-parser-trivial.c
+++ b/bus/config-parser-trivial.c
@@ -40,6 +40,7 @@ struct BusConfigParser
   DBusString user;                  /**< User the dbus-daemon runs as */
   DBusString bus_type;              /**< Message bus type */
   DBusString service_helper;        /**< Location of the setuid helper */
+  DBusString replycheck;            /**< SELinux checking of reply messages */
   DBusList *service_dirs;           /**< Directories to look for services in */
 };
 
@@ -101,11 +102,15 @@ bus_config_parser_new (const DBusString             *basedir,
     goto failed_type;
   if (!_dbus_string_init (&parser->service_helper))
     goto failed_helper;
+  if (!_dbus_string_init (&parser->replycheck))
+    goto failed_reply;
 
   /* woot! */
   return parser;
 
 /* argh. we have do do this carefully because of OOM */
+failed_reply:
+  _dbus_string_free (&parser->service_helper);
 failed_helper:
   _dbus_string_free (&parser->bus_type);
 failed_type:
@@ -121,6 +126,7 @@ bus_config_parser_unref (BusConfigParser *parser)
 {
   _dbus_string_free (&parser->user);
   _dbus_string_free (&parser->service_helper);
+  _dbus_string_free (&parser->replycheck);
   _dbus_string_free (&parser->bus_type);
   _dbus_list_clear_full (&parser->service_dirs, dbus_free);
   dbus_free (parser);
@@ -142,6 +148,7 @@ bus_config_parser_start_element (BusConfigParser   *parser,
     case ELEMENT_SERVICEHELPER:
     case ELEMENT_USER:
     case ELEMENT_CONFIGTYPE:
+    case ELEMENT_REPLYCHECK:
       /* content about to be handled */
       break;
 
@@ -284,6 +291,28 @@ bus_config_parser_content (BusConfigParser   *parser,
       }
       break;
 
+    case ELEMENT_REPLYCHECK:
+      {
+        const char* content_string;
+        if (!_dbus_string_copy (&content_sane, 0, &parser->replycheck, 0))
+          {
+            BUS_SET_OOM (error);
+            goto out_content;
+          }
+
+          content_string = _dbus_string_get_const_data (&content_sane);
+          if (strcmp(content_string, "none") != 0 &&
+            strcmp(content_string, "send") != 0 &&
+            strcmp(content_string, "reply_with_fallback") != 0 &&
+            strcmp(content_string, "reply") != 0)
+            {
+              dbus_set_error (error, DBUS_ERROR_FAILED,
+                              "Element <replycheck> has invalid content %s", content_string);
+              goto out_content;
+            }
+      }
+      break;
+
     case ELEMENT_NONE:
     case ELEMENT_BUSCONFIG:
     case ELEMENT_INCLUDE:
diff --git a/bus/config-parser.c b/bus/config-parser.c
index f9b70477..39b673cd 100644
--- a/bus/config-parser.c
+++ b/bus/config-parser.c
@@ -115,6 +115,8 @@ struct BusConfigParser
 
   DBusHashTable *service_context_table; /**< Map service names to SELinux contexts */
 
+  char *replycheck;      /**< What permission verb to use on message replies */
+
   unsigned int fork : 1; /**< TRUE to fork into daemon mode */
 
   unsigned int syslog : 1; /**< TRUE to enable syslog */
@@ -402,6 +404,13 @@ merge_included (BusConfigParser *parser,
       included->servicehelper = NULL;
     }
 
+  if (included->replycheck != NULL)
+    {
+      dbus_free (parser->replycheck);
+      parser->replycheck = included->replycheck;
+      included->replycheck = NULL;
+    }
+
   while ((link = _dbus_list_pop_first_link (&included->listen_on)))
     _dbus_list_append_link (&parser->listen_on, link);
 
@@ -585,6 +594,7 @@ bus_config_parser_unref (BusConfigParser *parser)
       dbus_free (parser->servicehelper);
       dbus_free (parser->bus_type);
       dbus_free (parser->pidfile);
+      dbus_free (parser->replycheck);
 
       _dbus_list_clear_full (&parser->listen_on, dbus_free);
       _dbus_list_clear_full (&parser->service_dirs,
@@ -1977,6 +1987,19 @@ start_selinux_child (BusConfigParser   *parser,
 					   own_copy, context_copy))
         goto oom;
 
+      return TRUE;
+    }
+  else if (strcmp (element_name, "replycheck") == 0)
+    {
+      if (!check_no_attributes (parser, "replycheck", attribute_names, attribute_values, error))
+          return FALSE;
+
+      if (push_element (parser, ELEMENT_REPLYCHECK) == NULL)
+        {
+          BUS_SET_OOM (error);
+          return FALSE;
+        }
+
       return TRUE;
     }
   else
@@ -2277,6 +2300,7 @@ bus_config_parser_end_element (BusConfigParser   *parser,
     case ELEMENT_SERVICEHELPER:
     case ELEMENT_INCLUDEDIR:
     case ELEMENT_LIMIT:
+    case ELEMENT_REPLYCHECK:
       if (!e->had_content)
         {
           dbus_set_error (error, DBUS_ERROR_FAILED,
@@ -2870,6 +2894,20 @@ bus_config_parser_content (BusConfigParser   *parser,
                        e->d.limit.name);
       }
       break;
+
+    case ELEMENT_REPLYCHECK:
+      {
+        char *s;
+
+        e->had_content = TRUE;
+
+        if (!_dbus_string_copy_data (content, &s))
+            goto nomem;
+
+        dbus_free (parser->replycheck);
+        parser->replycheck = s;
+      }
+      break;
     }
 
   _DBUS_ASSERT_ERROR_IS_CLEAR (error);
@@ -2977,6 +3015,12 @@ bus_config_parser_get_servicehelper (BusConfigParser   *parser)
   return parser->servicehelper;
 }
 
+const char *
+bus_config_parser_get_replycheck (BusConfigParser   *parser)
+{
+    return parser->replycheck;
+}
+
 BusPolicy*
 bus_config_parser_steal_policy (BusConfigParser *parser)
 {
@@ -3371,6 +3415,7 @@ elements_equal (const Element *a,
     case ELEMENT_CONFIGTYPE:
     case ELEMENT_SELINUX:
     case ELEMENT_ASSOCIATE:
+    case ELEMENT_REPLYCHECK:
     case ELEMENT_STANDARD_SESSION_SERVICEDIRS:
     case ELEMENT_STANDARD_SYSTEM_SERVICEDIRS:
     case ELEMENT_KEEP_UMASK:
@@ -3501,7 +3546,7 @@ config_parsers_equal (const BusConfigParser *a,
 
   if (!lists_of_service_dirs_equal (a->service_dirs, b->service_dirs))
     return FALSE;
-  
+
   /* FIXME: compare policy */
 
   /* FIXME: compare service selinux ID table */
@@ -3512,6 +3557,9 @@ config_parsers_equal (const BusConfigParser *a,
   if (!strings_equal_or_both_null (a->pidfile, b->pidfile))
     return FALSE;
 
+  if (!strings_equal_or_both_null (a->replycheck, b->replycheck))
+    return FALSE;
+
   if (! bools_equal (a->fork, b->fork))
     return FALSE;
 
diff --git a/bus/config-parser.h b/bus/config-parser.h
index 7f4d2f47..7a79d698 100644
--- a/bus/config-parser.h
+++ b/bus/config-parser.h
@@ -65,6 +65,7 @@ dbus_bool_t bus_config_parser_get_syslog       (BusConfigParser *parser);
 dbus_bool_t bus_config_parser_get_keep_umask   (BusConfigParser *parser);
 const char* bus_config_parser_get_pidfile      (BusConfigParser *parser);
 const char* bus_config_parser_get_servicehelper (BusConfigParser *parser);
+const char* bus_config_parser_get_replycheck   (BusConfigParser *parser);
 DBusList**  bus_config_parser_get_service_dirs (BusConfigParser *parser);
 DBusList**  bus_config_parser_get_conf_dirs    (BusConfigParser *parser);
 BusPolicy*  bus_config_parser_steal_policy     (BusConfigParser *parser);
diff --git a/bus/selinux.c b/bus/selinux.c
index 42017e7a..8672e083 100644
--- a/bus/selinux.c
+++ b/bus/selinux.c
@@ -378,6 +378,7 @@ error:
  * granted from the connection to the message bus or to another
  * optionally supplied security identifier (e.g. for a service
  * context).  Currently these permissions are either send_msg or
+ * reply_msg (depending in the replycheck configuration) or
  * acquire_svc in the dbus class.
  *
  * @param sender_sid source security context
@@ -534,6 +535,8 @@ bus_selinux_allows_acquire_service (DBusConnection     *connection,
 dbus_bool_t
 bus_selinux_allows_send (DBusConnection     *sender,
                          DBusConnection     *proposed_recipient,
+			 dbus_bool_t        requested_reply,
+			 const char         *replycheck_verb,
 			 const char         *msgtype,
 			 const char         *interface,
 			 const char         *member,
@@ -557,6 +560,10 @@ bus_selinux_allows_send (DBusConnection     *sender,
   if (activation_entry)
     return TRUE;
 
+  /* Skip check on reply messages. */
+  if (requested_reply && !replycheck_verb)
+    return TRUE;
+
   if (!sender || !dbus_connection_get_unix_process_id (sender, &spid))
     spid = 0;
   if (!proposed_recipient || !dbus_connection_get_unix_process_id (proposed_recipient, &tpid))
@@ -631,10 +638,10 @@ bus_selinux_allows_send (DBusConnection     *sender,
   else
     recipient_sid = BUS_SID_FROM_SELINUX (bus_sid);
 
-  ret = bus_selinux_check (sender_sid, 
+  ret = bus_selinux_check (sender_sid,
 			   recipient_sid,
 			   "dbus",
-			   "send_msg",
+			   requested_reply ? replycheck_verb : "send_msg",
 			   &auxdata);
 
   _dbus_string_free (&auxdata);
@@ -1004,3 +1011,31 @@ bus_selinux_shutdown (void)
     }
 #endif /* HAVE_SELINUX */
 }
+
+/**
+ * Convert the replycheck configuraion string into the SELinux permission verb.
+ */
+const char*
+bus_selinux_convert_replycheck_option(const char *replycheck_option)
+{
+#ifdef HAVE_SELINUX
+    security_class_t security_class;
+
+    if (replycheck_option && strcmp (replycheck_option, "none") == 0)
+      return NULL;
+
+    if (replycheck_option && strcmp (replycheck_option, "send") == 0)
+      return "send_msg";
+
+    if (replycheck_option && strcmp (replycheck_option, "reply") == 0)
+      return "reply_msg";
+
+    security_class = string_to_security_class ("dbus");
+    if (security_class != 0 && string_to_av_perm (security_class, "reply_msg") != 0)
+      return "reply_msg";
+
+    return "send_msg";
+#else
+    return NULL;
+#endif /* HAVE_SELINUX */
+}
diff --git a/bus/selinux.h b/bus/selinux.h
index 471f2629..f6b8e43d 100644
--- a/bus/selinux.h
+++ b/bus/selinux.h
@@ -55,6 +55,8 @@ dbus_bool_t bus_selinux_allows_acquire_service (DBusConnection *connection,
 
 dbus_bool_t bus_selinux_allows_send            (DBusConnection *sender,
                                                 DBusConnection *proposed_recipient,
+						dbus_bool_t    requested_reply,
+						const char     *replycheck_verb,
 						const char     *msgtype, /* Supplementary audit data */
 						const char     *interface,
 						const char     *member,
@@ -66,4 +68,5 @@ dbus_bool_t bus_selinux_allows_send            (DBusConnection *sender,
 BusSELinuxID* bus_selinux_init_connection_id (DBusConnection *connection,
                                               DBusError      *error);
 
+const char* bus_selinux_convert_replycheck_option(const char *replycheck_option);
 #endif /* BUS_SELINUX_H */
diff --git a/doc/busconfig.dtd b/doc/busconfig.dtd
index 8c5ac334..d8855b1e 100644
--- a/doc/busconfig.dtd
+++ b/doc/busconfig.dtd
@@ -59,11 +59,13 @@
 <!ELEMENT limit (#PCDATA)>
 <!ATTLIST limit name CDATA #REQUIRED>
 
-<!ELEMENT selinux (associate)*>
+<!ELEMENT selinux (associate|
+                   replycheck)*>
 <!ELEMENT associate EMPTY>
 <!ATTLIST associate
           own CDATA #REQUIRED
           context CDATA #REQUIRED>
+<!ELEMENT replycheck (#PCDATA)>
 
 <!ELEMENT apparmor EMPTY>
 <!ATTLIST apparmor
diff --git a/doc/dbus-daemon.1.xml.in b/doc/dbus-daemon.1.xml.in
index a9c0b5d5..62c3e334 100644
--- a/doc/dbus-daemon.1.xml.in
+++ b/doc/dbus-daemon.1.xml.in
@@ -1154,6 +1154,7 @@ More details below.</para>
 <itemizedlist remap='TP'>
 
   <listitem><para><emphasis remap='I'>&lt;associate&gt;</emphasis></para></listitem>
+  <listitem><para><emphasis remap='I'>&lt;replycheck&gt;</emphasis></para></listitem>
 
 
 </itemizedlist>
@@ -1187,6 +1188,23 @@ Right now the default will be the security context of the bus itself.</para>
 <para>If two &lt;associate&gt; elements specify the same name, the element
 appearing later in the configuration file will be used.</para>
 
+
+<para>The &lt;replycheck&gt; element controls how reply messages are checked.
+There are four options:</para>
+<literallayout remap='.nf'>
+      "send"                       : the same SELinux permission as for request
+                                     messages is used (the previous default)
+      "none"                       : reply messages are not checked
+      "reply"                      : reply messages are checked with a distinct
+                                     SELinux permission
+      "reply_with_fallback"        : reply messages are checked with a distinct
+                                     SELinux permission, if this permission is
+                                     defined in the loaded SELinux policy.
+                                     Otherwise the same permission as for request
+                                     messages is used
+</literallayout> <!-- .fi -->
+
+
 <itemizedlist remap='TP'>
 
   <listitem><para><emphasis remap='I'>&lt;apparmor&gt;</emphasis></para></listitem>
@@ -1425,7 +1443,8 @@ that class.</para>
 <para>First, any time a message is routed from one connection to another
 connection, the bus daemon will check permissions with the security context of
 the first connection as source, security context of the second connection
-as target, object class "dbus" and requested permission "send_msg".</para>
+as target, object class "dbus" and requested permission "send_msg" or "reply_msg",
+depending on the message type and the &lt;replycheck&gt; setting.</para>
 
 
 <para>If a security context is not available for a connection
diff --git a/test/data/valid-config-files/basic.conf b/test/data/valid-config-files/basic.conf
index 5297097d..de68caaf 100644
--- a/test/data/valid-config-files/basic.conf
+++ b/test/data/valid-config-files/basic.conf
@@ -27,6 +27,7 @@
          context="my_selinux_context_t"/>
         <associate own="org.freedesktop.BlahBlahBlah"
          context="foo_t"/>
+        <replycheck>reply_with_fallback</replycheck>
   </selinux>
 
 </busconfig>
-- 
2.30.0.rc2

