Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE42BC2BA19
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 16:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E52320678
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 16:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbgDMQYk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:24:40 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:55388 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731410AbgDMQYj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 12:24:39 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5B64956466B
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 18:24:35 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] restorecond: migrate to GDbus API provided by glib-gio
Date:   Mon, 13 Apr 2020 18:24:11 +0200
Message-Id: <20200413162413.1161803-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Apr 13 18:24:35 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=955940 states:

    dbus-glib is a deprecated D-Bus library with some significant design
    flaws, and is essentially unmaintained.

restorecond uses dbus-glib in order to spawn as a D-Bus service on the
session bus of users. This makes restorecond stays so long as the user
session exists.

Migrate from dbus-glib to GDbus API for the implementation of this
feature.

Moreover restorecond currently uses a D-Bus signal to trigger starting
the service. This is quite inappropriate, as stated for example in
https://dbus.freedesktop.org/doc/dbus-tutorial.html#members

    Methods are operations that can be invoked on an object, with
    optional input (aka arguments or "in parameters") and output (aka
    return values or "out parameters"). Signals are broadcasts from the
    object to any interested observers of the object; signals may
    contain a data payload.

Implementing a method is more appropriate. It appears that all D-Bus
users can implement method Ping from interface org.freedesktop.DBus.Peer
(https://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-peer)
and that calling this method is enough to trigger the launch of the
service. This can be tested in a shell by running:

    gdbus call --session --dest=org.selinux.Restorecond \
        --object-path=/ --method=org.freedesktop.DBus.Peer.Ping

As this method is automatically provided, there is no need to implement
its handling in the service.

Fixed: https://github.com/SELinuxProject/selinux/issues/217

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 restorecond/Makefile |   8 +--
 restorecond/user.c   | 140 ++++++++++++++++++++++++-------------------
 2 files changed, 82 insertions(+), 66 deletions(-)

diff --git a/restorecond/Makefile b/restorecond/Makefile
index 12452cd2f8e1..50702c661aeb 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -13,13 +13,13 @@ autostart_DATA = sealertauto.desktop
 INITDIR ?= /etc/rc.d/init.d
 SELINUXDIR = /etc/selinux
 
-DBUSFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags dbus-glib-1)
-DBUSLIB = $(shell $(PKG_CONFIG) --libs dbus-glib-1)
+GIO_CFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags gio-2.0)
+GIO_LIBS = $(shell $(PKG_CONFIG) --libs gio-2.0)
 
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += $(DBUSFLAGS)
+override CFLAGS += $(GIO_CFLAGS)
 
-override LDLIBS += -lselinux $(DBUSLIB)
+override LDLIBS += -lselinux $(GIO_LIBS)
 
 all: restorecond
 
diff --git a/restorecond/user.c b/restorecond/user.c
index 8f9323077a26..f940fd4e6678 100644
--- a/restorecond/user.c
+++ b/restorecond/user.c
@@ -2,6 +2,7 @@
  * restorecond
  *
  * Copyright (C) 2006-2009 Red Hat
+ * Copyright (C) 2020 Nicolas Iooss
  * see file 'COPYING' for use and warranty information
  *
  * This program is free software; you can redistribute it and/or
@@ -21,7 +22,7 @@
  *
  * Authors:
  *   Dan Walsh <dwalsh@redhat.com>
- *
+ *   Nicolas Iooss <nicolas.iooss@m4x.org>
 */
 
 #define _GNU_SOURCE
@@ -33,73 +34,75 @@
 #include <string.h>
 #include <unistd.h>
 #include <ctype.h>
+#include <sys/file.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <syslog.h>
 #include <limits.h>
 #include <fcntl.h>
 
+#include <selinux/selinux.h>
+
 #include "restorecond.h"
 #include "stringslist.h"
 #include <glib.h>
-#ifdef HAVE_DBUS
-#include <dbus/dbus.h>
-#include <dbus/dbus-glib.h>
-#include <dbus/dbus-glib-lowlevel.h>
 
-static DBusHandlerResult signal_filter (DBusConnection *connection, DBusMessage *message, void *user_data);
+static int local_lock_fd = -1;
 
-static const char *PATH="/org/selinux/Restorecond";
-//static const char *BUSNAME="org.selinux.Restorecond";
-static const char *INTERFACE="org.selinux.RestorecondIface";
-static const char *RULE="type='signal',interface='org.selinux.RestorecondIface'";
+#ifdef HAVE_DBUS
+#include <gio/gio.h>
 
-static int local_lock_fd = -1;
+static const char *DBUS_NAME = "org.selinux.Restorecond";
 
-static DBusHandlerResult
-signal_filter (DBusConnection *connection  __attribute__ ((__unused__)), DBusMessage *message, void *user_data)
+static void on_name_acquired(GDBusConnection *connection G_GNUC_UNUSED,
+			     const gchar *name,
+			     gpointer user_data G_GNUC_UNUSED)
 {
-  /* User data is the event loop we are running in */
-  GMainLoop *loop = user_data;
+	if (debug_mode)
+		g_print("D-Bus name acquired: %s\n", name);
+}
 
-  /* A signal from the bus saying we are about to be disconnected */
-  if (dbus_message_is_signal
-        (message, INTERFACE, "Stop")) {
+static void on_name_lost(GDBusConnection *connection G_GNUC_UNUSED,
+			 const gchar *name,
+			 gpointer user_data)
+{
+	/* Exit when the D-Bus connection closes */
+	GMainLoop *loop = user_data;
 
-      /* Tell the main loop to quit */
-      g_main_loop_quit (loop);
-      /* We have handled this message, don't pass it on */
-      return DBUS_HANDLER_RESULT_HANDLED;
-  }
-  /* A Ping signal on the com.burtonini.dbus.Signal interface */
-  else if (dbus_message_is_signal (message, INTERFACE, "Start")) {
-    DBusError error;
-    dbus_error_init (&error);
-    g_print("Start received\n");
-    return DBUS_HANDLER_RESULT_HANDLED;
-  }
-  return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	if (debug_mode)
+		g_print("D-Bus name lost (%s), exiting\n", name);
+	g_main_loop_quit(loop);
 }
 
-static int dbus_server(GMainLoop *loop) {
-    DBusConnection *bus;
-    DBusError error;
-    dbus_error_init (&error);
-    bus = dbus_bus_get (DBUS_BUS_SESSION, &error);
-    if (bus) {
-	dbus_connection_setup_with_g_main (bus, NULL);
-
-	/* listening to messages from all objects as no path is specified */
-	dbus_bus_add_match (bus, RULE, &error); // see signals from the given interfacey
-	dbus_connection_add_filter (bus, signal_filter, loop, NULL);
+/**
+ * Try starting a D-Bus server on the session bus.
+ * Returns -1 if the connection failed, so that a local server can be launched
+ */
+static int dbus_server(GMainLoop *loop)
+{
+	GDBusConnection *bus;
+	guint client_id;
+
+	bus = g_bus_get_sync(G_BUS_TYPE_SESSION, NULL, NULL);
+	if (!bus)
+		return -1;
+
+	client_id = g_bus_own_name_on_connection(
+		bus,
+		DBUS_NAME,
+		G_BUS_NAME_OWNER_FLAGS_NONE,
+		on_name_acquired,
+		on_name_lost,
+		loop,
+		NULL);
+	g_object_unref(bus);
+	if (client_id == 0)
+		return -1;
+
 	return 0;
-    }
-    return -1;
 }
 
 #endif
-#include <selinux/selinux.h>
-#include <sys/file.h>
 
 /* size of the event structure, not counting name */
 #define EVENT_SIZE  (sizeof (struct inotify_event))
@@ -167,29 +170,42 @@ io_channel_callback
 
 int start() {
 #ifdef HAVE_DBUS
-	DBusConnection *bus;
-	DBusError error;
-	DBusMessage *message;
+	GDBusConnection *bus;
+	GError *err = NULL;
+	GVariant *result;
 
 	/* Get a connection to the session bus */
-	dbus_error_init (&error);
-	bus = dbus_bus_get (DBUS_BUS_SESSION, &error);
+	bus = g_bus_get_sync(G_BUS_TYPE_SESSION, NULL, &err);
 	if (!bus) {
 		if (debug_mode)
-			g_warning ("Failed to connect to the D-BUS daemon: %s", error.message);
-		dbus_error_free (&error);
+			g_warning("Failed to connect to the D-BUS daemon: %s", err->message);
+		g_error_free(err);
 		return 1;
 	}
 
-
-	/* Create a new signal "Start" on the interface,
-	 * from the object  */
-	message = dbus_message_new_signal (PATH,
-					   INTERFACE, "Start");
-	/* Send the signal */
-	dbus_connection_send (bus, message, NULL);
-	/* Free the signal now we have finished with it */
-	dbus_message_unref (message);
+	/* Start restorecond D-Bus service by pinging its bus name
+	 *
+	 * https://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-peer
+	 */
+	result = g_dbus_connection_call_sync(bus,
+					     DBUS_NAME, /* bus name */
+					     "/", /* object path */
+					     "org.freedesktop.DBus.Peer", /* interface */
+					     "Ping", /* method */
+					     NULL, /* parameters */
+					     NULL, /* reply_type */
+					     G_DBUS_CALL_FLAGS_NONE,
+					     -1, /* timeout_msec */
+					     NULL,
+					     &err);
+	if (!result) {
+		g_object_unref(bus);
+		if (debug_mode)
+			g_warning("Failed to start %s: %s", DBUS_NAME, err->message);
+		g_error_free(err);
+		return 1;
+	}
+	g_object_unref(bus);
 #endif /* HAVE_DBUS */
 	return 0;
 }
-- 
2.26.0

