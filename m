Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAB5dYIi004791
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2004 00:39:34 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAB5c9q2024562
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2004 05:38:10 GMT
Subject: [patch] Improved D-BUS SELinux mediation
From: Colin Walters <walters@verbum.org>
To: dbus@freedesktop.org
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-Ben5c85UaOJiYIiiTXQn"
Date: Thu, 11 Nov 2004 00:39:31 -0500
Message-Id: <1100151571.4877.15.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Ben5c85UaOJiYIiiTXQn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

The attached patch improves on the previous patch sent to the D-BUS list
for also having D-BUS check service labels for the send_msg permission.
One problem I ran into is that send_msg also mediates reply messages; so
in order to have a domain just reply to a sent message, it needs the
general send_msg back to the sender domain, as well as the service
domain.   The solution is to add a separate "reply" access vector.  
D-BUS will check that permission if a message is in reply to a known
sent message, otherwise it will use "send_msg".

While I was changing the access vectors, I thought I would go ahead and
add an "activate_svc" vector too (and add the requisite check in the D-
BUS code).  The long term plan I think is to use D-BUS for system
service activation too, and it seems undesirable for e.g. CUPS to have
the permission to activate your mail server (which could have other side
effects like binding to ports, etc).

The patch to D-BUS is first, and the patch to the Flask access_vectors
follows.

I'll be working on a patch to update the policy itself to handle these
new changes soon, along with labeling all the services we currently use.


--=-Ben5c85UaOJiYIiiTXQn
Content-Disposition: attachment; filename=dbus-selinux-more-mediation.patch
Content-Type: text/x-patch; name=dbus-selinux-more-mediation.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

? dbus-0.22.tar.gz
cvs diff: Diffing .
Index: configure.in
===================================================================
RCS file: /cvs/dbus/dbus/configure.in,v
retrieving revision 1.100
diff -u -d -r1.100 configure.in
--- configure.in	29 Oct 2004 19:17:57 -0000	1.100
+++ configure.in	11 Nov 2004 05:32:17 -0000
@@ -698,13 +698,13 @@
     AC_CHECK_LIB(selinux, is_selinux_enabled, 
                  have_selinux=yes, have_selinux=no)
 
-    # see if we have the SELinux header with the new D-BUS stuff in it
+    # see if we have the SELinux header with new enough D-BUS stuff in it
     if test x$have_selinux = xyes ; then
         AC_MSG_CHECKING([for DBUS Flask permissions in selinux/av_permissions.h])
 	AC_TRY_COMPILE([#include <selinux/av_permissions.h>],
-			[#ifdef DBUS__ACQUIRE_SVC return 0;
+			[#ifdef DBUS__ACTIVATE_SVC return 0;
 			 #else
-			 #error DBUS__ACQUIRE_SVC not defined
+			 #error DBUS__ACTIVATE_SVC not defined
 			 #endif],
                         have_selinux=yes, have_selinux=no)
 	AC_MSG_RESULT($have_selinux)
cvs diff: Diffing bus
Index: bus/activation.c
===================================================================
RCS file: /cvs/dbus/dbus/bus/activation.c,v
retrieving revision 1.36
diff -u -d -r1.36 activation.c
--- bus/activation.c	10 Aug 2004 03:06:59 -0000	1.36
+++ bus/activation.c	11 Nov 2004 05:32:17 -0000
@@ -25,6 +25,7 @@
 #include "activation.h"
 #include "desktop-file.h"
 #include "services.h"
+#include "selinux.h"
 #include "test.h"
 #include "utils.h"
 #include <dbus/dbus-internals.h>
@@ -1297,6 +1298,8 @@
   BusPendingActivationEntry *pending_activation_entry;
   DBusMessage *message;
   DBusString service_str;
+  BusSELinuxID *service_sid;
+  BusRegistry *bus_registry;
   char *argv[2];
   dbus_bool_t retval;
   DBusHashIter iter;
@@ -1319,14 +1322,16 @@
   if (!entry) 
     return FALSE;
 
+  bus_registry = bus_context_get_registry (activation->context);
+  _dbus_string_init_const (&service_str, service_name);
+
   /* Bypass the registry lookup if we're auto-activating, bus_dispatch would not
    * call us if the service is already active.
    */
   if (!auto_activation)
     {
       /* Check if the service is active */
-      _dbus_string_init_const (&service_str, service_name);
-      if (bus_registry_lookup (bus_context_get_registry (activation->context), &service_str) != NULL)
+      if (bus_registry_lookup (bus_registry, &service_str) != NULL)
         {
           _dbus_verbose ("Service \"%s\" is already active\n", service_name);
       
@@ -1361,6 +1366,18 @@
         }
     }
 
+  service_sid = bus_registry_get_service_selinux_id (bus_registry, &service_str);
+  if (!bus_selinux_allows_activate_service (connection, service_sid,
+					    service_name))
+    {
+      dbus_set_error (error, DBUS_ERROR_ACCESS_DENIED,
+		      "SELinux policy prevents this sender "
+		      "from activating the service %s",
+		      service_name);
+      _dbus_verbose ("SELinux security check denying activation\n");
+      return FALSE;
+    }
+
   pending_activation_entry = dbus_new0 (BusPendingActivationEntry, 1);
   if (!pending_activation_entry)
     {
Index: bus/bus.c
===================================================================
RCS file: /cvs/dbus/dbus/bus/bus.c,v
retrieving revision 1.59
diff -u -d -r1.59 bus.c
--- bus/bus.c	9 Nov 2004 06:11:33 -0000	1.59
+++ bus/bus.c	11 Nov 2004 05:32:17 -0000
@@ -492,17 +492,24 @@
 			 DBusError *error)
 {
   DBusHashTable *service_context_table;
+  char          *unlabeled_service_context;
+  dbus_bool_t    ret; 
 
   service_context_table = bus_config_parser_steal_service_context_table (parser);
+  unlabeled_service_context = bus_config_parser_steal_unlabeled_service_context (parser);
   if (!bus_registry_set_service_context_table (context->registry,
+					       unlabeled_service_context,
 					       service_context_table))
     {
       BUS_SET_OOM (error);
-      return FALSE;
+      ret = FALSE;
     }
+  else
+    ret = TRUE;
 
   _dbus_hash_table_unref (service_context_table);
-  return TRUE;
+  dbus_free (unlabeled_service_context);
+  return ret;
 }
 
 BusContext*
@@ -1127,36 +1134,6 @@
   
   if (sender != NULL)
     {
-      const char *dest;
-
-      dest = dbus_message_get_destination (message);
-	
-      /* First verify the SELinux access controls.  If allowed then
-       * go on with the standard checks.
-       */
-      if (!bus_selinux_allows_send (sender, proposed_recipient,
-				    dbus_message_type_to_string (dbus_message_get_type (message)),
-				    dbus_message_get_interface (message),
-				    dbus_message_get_member (message),
-				    dbus_message_get_error_name (message),
-				    dest ? dest : DBUS_SERVICE_ORG_FREEDESKTOP_DBUS))
-        {
-          dbus_set_error (error, DBUS_ERROR_ACCESS_DENIED,
-                          "An SELinux policy prevents this sender "
-                          "from sending this message to this recipient "
-                          "(rejected message had interface \"%s\" "
-                          "member \"%s\" error name \"%s\" destination \"%s\")",
-                          dbus_message_get_interface (message) ?
-                          dbus_message_get_interface (message) : "(unset)",
-                          dbus_message_get_member (message) ?
-                          dbus_message_get_member (message) : "(unset)",
-                          dbus_message_get_error_name (message) ?
-                          dbus_message_get_error_name (message) : "(unset)",
-                          dest ? dest : DBUS_SERVICE_ORG_FREEDESKTOP_DBUS);
-          _dbus_verbose ("SELinux security check denying send to service\n");
-          return FALSE;
-        }
-       
       if (bus_connection_is_active (sender))
         {
           sender_policy = bus_connection_get_policy (sender);
@@ -1255,6 +1232,62 @@
   _dbus_assert ((proposed_recipient != NULL && recipient_policy != NULL) ||
                 (proposed_recipient != NULL && sender == NULL && recipient_policy == NULL) ||
                 (proposed_recipient == NULL && recipient_policy == NULL));
+
+  if (sender != NULL && !requested_reply)
+    {
+      /* This is a new message, and not from the bus */
+      BusSELinuxID *service_sid;
+      DBusString dest_str;
+      const char *dest;
+
+      dest = dbus_message_get_destination (message);
+      if (!dest)
+	dest = DBUS_SERVICE_ORG_FREEDESKTOP_DBUS;
+
+      _dbus_string_init_const (&dest_str, dest);
+      service_sid = bus_registry_get_service_selinux_id (context->registry, &dest_str);
+      
+      if (!bus_selinux_allows_send (sender, service_sid,
+				    proposed_recipient,
+				    dbus_message_type_to_string (dbus_message_get_type (message)),
+				    dbus_message_get_interface (message),
+				    dbus_message_get_member (message),
+				    dest ? dest : DBUS_SERVICE_ORG_FREEDESKTOP_DBUS))
+        {
+          dbus_set_error (error, DBUS_ERROR_ACCESS_DENIED,
+                          "SELinux policy prevents this sender "
+                          "from sending this message to this recipient "
+                          "(rejected message had interface \"%s\" "
+                          "member \"%s\" error name \"%s\" destination \"%s\")",
+                          dbus_message_get_interface (message) ?
+                          dbus_message_get_interface (message) : "(unset)",
+                          dbus_message_get_member (message) ?
+                          dbus_message_get_member (message) : "(unset)",
+                          dbus_message_get_error_name (message) ?
+                          dbus_message_get_error_name (message) : "(unset)",
+                          dest ? dest : DBUS_SERVICE_ORG_FREEDESKTOP_DBUS);
+          _dbus_verbose ("SELinux security check denying send to service\n");
+          return FALSE;
+        }
+    }
+  else if (sender != NULL && requested_reply)
+    {
+      if (!bus_selinux_allows_reply (sender,
+				     proposed_recipient,
+				     dbus_message_type_to_string (dbus_message_get_type (message)),
+				     dbus_message_get_error_name (message)))
+        {
+          dbus_set_error (error, DBUS_ERROR_ACCESS_DENIED,
+                          "SELinux policy prevents this sender "
+                          "from sending this message to this recipient "
+                          "(rejected message error name \"%s\")",
+                          dbus_message_get_error_name (message) ?
+                          dbus_message_get_error_name (message) : "(unset)");
+          _dbus_verbose ("SELinux security check denying reply\n");
+          return FALSE;
+	}
+    }
+       
   
   if (sender_policy &&
       !bus_client_policy_check_can_send (sender_policy,
Index: bus/config-parser.c
===================================================================
RCS file: /cvs/dbus/dbus/bus/config-parser.c,v
retrieving revision 1.39
diff -u -d -r1.39 config-parser.c
--- bus/config-parser.c	7 Nov 2004 17:05:19 -0000	1.39
+++ bus/config-parser.c	11 Nov 2004 05:32:18 -0000
@@ -89,7 +89,7 @@
       char *name;
       long value;
     } limit;
-    
+
   } d;
 
 } Element;
@@ -125,6 +125,8 @@
 
   DBusHashTable *service_context_table; /**< Map service names to SELinux contexts */
 
+  char *unlabeled_service_context;  /**< The security context used for services not explicitly labeled */
+
   unsigned int fork : 1; /**< TRUE to fork into daemon mode */
 
   unsigned int is_toplevel : 1; /**< FALSE if we are a sub-config-file inside another one */
@@ -290,6 +292,13 @@
       return FALSE;
     }
   
+  if (included->unlabeled_service_context != NULL)
+    {
+      dbus_free (parser->unlabeled_service_context);
+      parser->unlabeled_service_context = included->unlabeled_service_context;
+      included->unlabeled_service_context = NULL;
+    }
+
   if (included->user != NULL)
     {
       dbus_free (parser->user);
@@ -958,8 +967,7 @@
     }
   else if (strcmp (element_name, "selinux") == 0)
     {
-      if (!check_no_attributes (parser, "selinux", attribute_names, attribute_values, error))
-        return FALSE;
+      const char *unlabeled_service_context;
 
       if (push_element (parser, ELEMENT_SELINUX) == NULL)
         {
@@ -967,6 +975,26 @@
           return FALSE;
         }
 
+      if (!locate_attributes (parser, "selinux",
+                              attribute_names,
+                              attribute_values,
+                              error,
+                              "unlabeled", &unlabeled_service_context,
+                              NULL))
+        return FALSE;
+
+      if (unlabeled_service_context)
+	{
+	  if (parser->unlabeled_service_context)
+	    dbus_free (parser->unlabeled_service_context);
+	  parser->unlabeled_service_context = _dbus_strdup (unlabeled_service_context);
+	  if (parser->unlabeled_service_context == NULL)
+	    {
+	      BUS_SET_OOM (error);
+	      return FALSE;
+	    }
+	}
+
       return TRUE;
     }
   else
@@ -2406,6 +2434,22 @@
   return table;
 }
 
+char *
+bus_config_parser_steal_unlabeled_service_context (BusConfigParser *parser)
+{
+  char *context;
+  
+  /* We allow the user not to specify an unlabeled context */
+  if (parser->unlabeled_service_context == NULL)
+    return NULL;
+    
+  context = parser->unlabeled_service_context;
+
+  parser->unlabeled_service_context = NULL;
+
+  return context;
+}
+
 #ifdef DBUS_BUILD_TESTS
 #include <stdio.h>
 
Index: bus/config-parser.h
===================================================================
RCS file: /cvs/dbus/dbus/bus/config-parser.h,v
retrieving revision 1.17
diff -u -d -r1.17 config-parser.h
--- bus/config-parser.h	7 Nov 2004 17:05:19 -0000	1.17
+++ bus/config-parser.h	11 Nov 2004 05:32:18 -0000
@@ -71,7 +71,8 @@
 void        bus_config_parser_get_limits       (BusConfigParser *parser,
                                                 BusLimits       *limits);
 
-DBusHashTable* bus_config_parser_steal_service_context_table (BusConfigParser *parser);
+DBusHashTable*   bus_config_parser_steal_service_context_table      (BusConfigParser *parser);
+char         *   bus_config_parser_steal_unlabeled_service_context  (BusConfigParser *parser);
 
 /* Loader functions (backended off one of the XML parsers).  Returns a
  * finished ConfigParser.
Index: bus/selinux.c
===================================================================
RCS file: /cvs/dbus/dbus/bus/selinux.c,v
retrieving revision 1.12
diff -u -d -r1.12 selinux.c
--- bus/selinux.c	9 Nov 2004 06:11:33 -0000	1.12
+++ bus/selinux.c	11 Nov 2004 05:32:19 -0000
@@ -42,6 +42,12 @@
 #define BUS_SID_FROM_SELINUX(sid)  ((BusSELinuxID*) (sid))
 #define SELINUX_SID_FROM_BUS(sid)  ((security_id_t) (sid))
 
+struct BusSELinuxData
+{
+  security_id_t default_sid;
+  DBusHashTable *service_mapping;
+};
+
 #ifdef HAVE_SELINUX
 /* Store the value telling us if SELinux is enabled in the kernel. */
 static dbus_bool_t selinux_enabled = FALSE;
@@ -363,21 +369,11 @@
                    BusSELinuxID        *override_sid,
                    security_class_t     target_class,
                    access_vector_t      requested,
-		   unsigned long        spid,
-		   unsigned long        tpid,
 		   DBusString          *auxdata)
 {
   if (!selinux_enabled)
     return TRUE;
 
-  if (auxdata)
-    {
-      if (spid && _dbus_string_append (auxdata, " spid="))
-	_dbus_string_append_uint (auxdata, spid);
-      if (tpid && _dbus_string_append (auxdata, " tpid="))
-	_dbus_string_append_uint (auxdata, tpid);
-    }
-  
   /* Make the security check.  AVC checks enforcing mode here as well. */
   if (avc_has_perm (SELINUX_SID_FROM_BUS (sender_sid),
                     override_sid ?
@@ -393,12 +389,65 @@
 }
 #endif /* HAVE_SELINUX */
 
+#ifdef HAVE_SELINUX
+static DBusString *
+create_audit_data (DBusConnection   *sender,
+		   DBusConnection   *proposed_recipient,
+		   const char       *service_name,
+		   const char       *msgtype,
+		   const char       *interface,
+		   const char       *member,
+		   const char       *error_name,
+		   const char       *destination)
+{
+  DBusString *auxdata;
+  unsigned long spid, tpid;
+
+  if (!dbus_connection_get_unix_process_id (sender, &spid))
+    spid = 0;
+  if (proposed_recipient == NULL ||
+      !dbus_connection_get_unix_process_id (proposed_recipient, &tpid))
+    tpid = 0;
+
+  auxdata = dbus_new0 (DBusString, 1);
+  if (auxdata != NULL)
+    {
+      if (!_dbus_string_init (auxdata))
+	{
+	  dbus_free (auxdata);
+	  return NULL;
+	}
+      else
+	{
+	  if (spid && _dbus_string_append (auxdata, " spid="))
+	    _dbus_string_append_uint (auxdata, spid);
+	  if (tpid && _dbus_string_append (auxdata, " tpid="))
+	    _dbus_string_append_uint (auxdata, tpid);
+	  if (service_name && _dbus_string_append (auxdata, " service="))
+	    _dbus_string_append (auxdata, service_name);
+	  if (msgtype && _dbus_string_append (auxdata, " msgtype="))
+	    _dbus_string_append (auxdata, msgtype);
+	  if (interface && _dbus_string_append (auxdata, " interface="))
+	    _dbus_string_append (auxdata, interface);
+	  if (member && _dbus_string_append (auxdata, " member="))
+	    _dbus_string_append (auxdata, member);
+	  if (error_name && _dbus_string_append (auxdata, " error_name="))
+	    _dbus_string_append (auxdata, error_name);
+	  if (destination && _dbus_string_append (auxdata, " dest="))
+	    _dbus_string_append (auxdata, destination);
+	}
+    }
+  return auxdata;
+}
+#endif
+
 /**
  * Returns true if the given connection can acquire a service,
  * assuming the given security ID is needed for that service.
  *
  * @param connection connection that wants to own the service
  * @param service_sid the SID of the service from the table
+ * @param service_name the name of the service, used for auditing purposes
  * @returns #TRUE if acquire is permitted.
  */
 dbus_bool_t
@@ -408,34 +457,60 @@
 {
 #ifdef HAVE_SELINUX
   BusSELinuxID *connection_sid;
-  unsigned long spid;
   DBusString *auxdata;
   
   if (!selinux_enabled)
     return TRUE;
 
   connection_sid = bus_connection_get_selinux_id (connection);
-  if (!dbus_connection_get_unix_process_id (connection, &spid))
-    spid = 0;
 
-  auxdata = dbus_new0 (DBusString, 1);
-  if (auxdata)
-    {
-      if (!_dbus_string_init (auxdata))
-	{
-	  dbus_free (auxdata);
-	  auxdata = NULL;
-	}
-      else if (_dbus_string_append (auxdata, "service="))
-	_dbus_string_append (auxdata, service_name);
-    }
-  
+  auxdata = create_audit_data (connection, NULL,
+			       service_name, NULL,
+			       NULL, NULL,
+			       NULL, NULL);
+
   return bus_selinux_check (connection_sid,
 			    service_sid,
 			    SECCLASS_DBUS,
 			    DBUS__ACQUIRE_SVC,
-			    spid,
-			    0,
+			    auxdata);
+#else
+  return TRUE;
+#endif /* HAVE_SELINUX */
+}
+
+/**
+ * Returns true if the given connection can activate a service,
+ * assuming the given security ID is needed for that service.
+ *
+ * @param connection connection that wants to activate the service
+ * @param service_sid the SID of the service from the table
+ * @param service_name the name of the service, used for auditing purposes
+ * @returns #TRUE if acquire is permitted.
+ */
+dbus_bool_t
+bus_selinux_allows_activate_service (DBusConnection     *connection,
+				     BusSELinuxID       *service_sid,
+				     const char         *service_name)
+{
+#ifdef HAVE_SELINUX
+  BusSELinuxID *connection_sid;
+  DBusString *auxdata;
+  
+  if (!selinux_enabled)
+    return TRUE;
+
+  connection_sid = bus_connection_get_selinux_id (connection);
+
+  auxdata = create_audit_data (connection, NULL,
+			       service_name, NULL,
+			       NULL, NULL,
+			       NULL, NULL);
+
+  return bus_selinux_check (connection_sid,
+			    service_sid,
+			    SECCLASS_DBUS,
+			    DBUS__ACTIVATE_SVC,
 			    auxdata);
 #else
   return TRUE;
@@ -449,65 +524,105 @@
  * addressed recipient, it could be an "eavesdropper"
  *
  * @param sender the sender of the message.
+ * @param service_sid the SID of the addressed service
  * @param proposed_recipient the connection the message is to be sent to.
+ * @param msgtype a string, the message type, used for auditing
+ * @param interface the message interface, used for auditing
+ * @param member the message member (if a method call), used for auditing
+ * @param destination the message destination, used for auditing
  * @returns whether to allow the send
  */
 dbus_bool_t
 bus_selinux_allows_send (DBusConnection     *sender,
+			 BusSELinuxID       *service_sid,
                          DBusConnection     *proposed_recipient,
 			 const char         *msgtype,
 			 const char         *interface,
 			 const char         *member,
-			 const char         *error_name,
 			 const char         *destination)
 {
 #ifdef HAVE_SELINUX
   BusSELinuxID *recipient_sid;
   BusSELinuxID *sender_sid;
-  unsigned long spid, tpid;
   DBusString *auxdata;
+  DBusString *auxdata_copy;
 
   if (!selinux_enabled)
     return TRUE;
 
-  if (!dbus_connection_get_unix_process_id (sender, &spid))
-    spid = 0;
-  if (!dbus_connection_get_unix_process_id (proposed_recipient, &tpid))
-    tpid = 0;
-
-  auxdata = dbus_new0 (DBusString, 1);
-  if (auxdata)
-    {
-      if (!_dbus_string_init (auxdata))
-	{
-	  dbus_free (auxdata);
-	  auxdata = NULL;
-	}
-      else
-	{
-	  if (_dbus_string_append (auxdata, "msgtype="))
-	    _dbus_string_append (auxdata, msgtype);
-	  if (interface && _dbus_string_append (auxdata, " interface="))
-	    _dbus_string_append (auxdata, interface);
-	  if (member && _dbus_string_append (auxdata, " member="))
-	    _dbus_string_append (auxdata, member);
-	  if (error_name && _dbus_string_append (auxdata, " error_name="))
-	    _dbus_string_append (auxdata, error_name);
-	  if (destination && _dbus_string_append (auxdata, " dest="))
-	    _dbus_string_append (auxdata, destination);
-	}
-    }
+  auxdata = create_audit_data (sender, proposed_recipient,
+			       NULL, msgtype, interface, member,
+			       NULL, destination);
+  auxdata_copy = create_audit_data (sender, proposed_recipient,
+				    NULL, msgtype, interface,
+				    member, NULL,
+				    destination);
 
   sender_sid = bus_connection_get_selinux_id (sender);
+
+  /* First, check if the sender can send to the service SID */
+  if (!bus_selinux_check (sender_sid, service_sid,
+			  SECCLASS_DBUS, DBUS__SEND_MSG,
+			  auxdata))
+    return FALSE;
+
   /* A NULL proposed_recipient means the bus itself. */
   if (proposed_recipient)
     recipient_sid = bus_connection_get_selinux_id (proposed_recipient);
   else
     recipient_sid = BUS_SID_FROM_SELINUX (bus_sid);
 
+  /* Next, check if the sender can send to the SID of the recipient
+   * domain */
   return bus_selinux_check (sender_sid, recipient_sid,
                             SECCLASS_DBUS, DBUS__SEND_MSG,
-			    spid, tpid, auxdata);
+			    auxdata_copy);
+#else
+  return TRUE;
+#endif /* HAVE_SELINUX */
+}
+
+/**
+ * Check if SELinux security controls allow a reply message to be sent
+ * to a particular connection based on the security context of the
+ * sender and that of the receiver.
+ *
+ * @param sender the sender of the message.
+ * @param proposed_recipient the connection the message is to be sent to.
+ * @param msgtype a string, the message type, used for auditing
+ * @param error_name the message error name (if an error reply), used for auditing
+ * @returns whether to allow the send
+ */
+dbus_bool_t
+bus_selinux_allows_reply (DBusConnection     *sender,
+			  DBusConnection     *proposed_recipient,
+			  const char         *msgtype,
+			  const char         *error_name)
+{
+#ifdef HAVE_SELINUX
+  BusSELinuxID *recipient_sid;
+  BusSELinuxID *sender_sid;
+  DBusString *auxdata;
+
+  if (!selinux_enabled)
+    return TRUE;
+
+  auxdata = create_audit_data (sender, proposed_recipient,
+			       NULL, msgtype, NULL,
+			       NULL, error_name,
+			       NULL);
+
+  sender_sid = bus_connection_get_selinux_id (sender);
+
+  /* A NULL proposed_recipient means the bus itself. */
+  if (proposed_recipient)
+    recipient_sid = bus_connection_get_selinux_id (proposed_recipient);
+  else
+    recipient_sid = BUS_SID_FROM_SELINUX (bus_sid);
+
+  return bus_selinux_check (sender_sid, recipient_sid,
+                            SECCLASS_DBUS, DBUS__REPLY,
+			    auxdata);
 #else
   return TRUE;
 #endif /* HAVE_SELINUX */
@@ -617,33 +732,60 @@
 }
 
 /**
- * Creates a new table mapping service names to security ID.
- * A security ID is a "compiled" security context, a security
- * context is just a string.
+ * Creates a new SELinux structure which contains a default context
+ * and mapping from service names to security IDs.  A security ID is a
+ * "compiled" security context, a security context is just a string.
  *
- * @returns the new table or #NULL if no memory
+ * @param unlabeled_context the default context to use for unmatched services
+ * @returns the new structure, otherwise #NULL if no memory, or if unlabeled_context is invalid
  */
-DBusHashTable*
-bus_selinux_id_table_new (void)
+BusSELinuxData *
+bus_selinux_data_new (const char *unlabeled_context) 
 {
-  return _dbus_hash_table_new (DBUS_HASH_STRING,
-                               (DBusFreeFunction) dbus_free,
-                               (DBusFreeFunction) bus_selinux_id_table_free_value);
+  BusSELinuxData *data;
+
+  data = dbus_new0 (BusSELinuxData, 1);
+  if (!data)
+    return NULL;
+  data->service_mapping = _dbus_hash_table_new (DBUS_HASH_STRING,
+						(DBusFreeFunction) dbus_free,
+						(DBusFreeFunction) bus_selinux_id_table_free_value);
+  if (!data->service_mapping)
+    return NULL;
+  
+  if (unlabeled_context)
+    {
+      if (avc_context_to_sid ((char*) unlabeled_context,
+			      &data->default_sid) < 0)
+	{
+	  if (errno != ENOMEM)
+	    _dbus_warn ("Error getting SID from context \"%s\": %s\n",
+			unlabeled_context,
+			_dbus_strerror (errno));
+	  _dbus_hash_table_unref (data->service_mapping);
+	  dbus_free (data);
+	  return NULL;
+	}
+    }
+  else
+    data->default_sid = SECSID_WILD; 
+
+  return data;
 }
 
 /** 
- * Hashes a service name and service context into the service SID
- * table as a string and a SID.
+ * Adds a service name to context mapping into the SELinux
+ * structure as a mapping from service name to SID.
  *
  * @param service_name is the name of the service.
  * @param service_context is the context of the service.
  * @param service_table is the table to hash them into.
- * @return #FALSE if not enough memory
+ * @return #FALSE if not enough memory, or if service_context is invalid
  */
 dbus_bool_t
-bus_selinux_id_table_insert (DBusHashTable *service_table,
-                             const char    *service_name,
-                             const char    *service_context)
+bus_selinux_data_insert_service (BusSELinuxData *selinux_data,
+				 const char     *service_name,
+				 const char     *service_context)
 {
 #ifdef HAVE_SELINUX
   dbus_bool_t retval;
@@ -662,15 +804,14 @@
   
   if (avc_context_to_sid ((char *) service_context, &sid) < 0)
     {
-      if (errno == ENOMEM)
-        return FALSE;
-      _dbus_warn ("Error getting SID from context \"%s\": %s\n",
-		  (char *) service_context,
-                  _dbus_strerror (errno));
+      if (errno != ENOMEM)
+	_dbus_warn ("Error getting SID from context \"%s\": %s\n",
+		    (char *) service_context,
+		    _dbus_strerror (errno));
       goto out;
     }
 
-  if (!_dbus_hash_table_insert_string (service_table,
+  if (!_dbus_hash_table_insert_string (selinux_data->service_mapping,
                                        key,
                                        BUS_SID_FROM_SELINUX (sid)))
     goto out;
@@ -701,36 +842,37 @@
 
 /**
  * Find the security identifier associated with a particular service
- * name.  Return a pointer to this SID, or #NULL/SECSID_WILD if the
- * service is not found in the hash table.  This should be nearly a
- * constant time operation.  If SELinux support is not available,
- * always return NULL.
+ * name.  Return a pointer to this SID, or the unlabeled service
+ * context if the service is not found in the hash table.  This should
+ * be nearly a constant time operation.  If SELinux support is not
+ * available, always return NULL.
  *
- * @param service_table the hash table to check for service name.
+ * @param selinux_data the SELinux structure
  * @param service_name the name of the service to look for.
  * @returns the SELinux ID associated with the service
  */
 BusSELinuxID*
-bus_selinux_id_table_lookup (DBusHashTable    *service_table,
-                             const DBusString *service_name)
+bus_selinux_data_lookup_service (const BusSELinuxData   *selinux_data,
+				 const DBusString       *service_name)
 {
 #ifdef HAVE_SELINUX
   security_id_t sid;
 
-  sid = SECSID_WILD;     /* default context */
-
   if (!selinux_enabled)
     return NULL;
   
   _dbus_verbose ("Looking up service SID for %s\n",
                  _dbus_string_get_const_data (service_name));
 
-  sid = _dbus_hash_table_lookup_string (service_table,
+  sid = _dbus_hash_table_lookup_string (selinux_data->service_mapping,
                                         _dbus_string_get_const_data (service_name));
 
   if (sid == SECSID_WILD)
-    _dbus_verbose ("Service %s not found\n", 
-                   _dbus_string_get_const_data (service_name));
+    {
+      _dbus_verbose ("Service %s not found\n", 
+		     _dbus_string_get_const_data (service_name));
+      sid = selinux_data->default_sid;
+    }
   else
     _dbus_verbose ("Service %s found\n", 
                    _dbus_string_get_const_data (service_name));
@@ -740,6 +882,15 @@
   return NULL;
 }
 
+void
+bus_selinux_data_free (BusSELinuxData  *selinux_data)
+{
+  _dbus_hash_table_unref (selinux_data->service_mapping);
+  if (selinux_data->default_sid != SECSID_WILD)
+    sidput (selinux_data->default_sid);
+  dbus_free (selinux_data);
+}
+
 /**
  * Get the SELinux policy root.  This is used to find the D-BUS
  * specific config file within the policy.
@@ -758,7 +909,7 @@
  * For debugging:  Print out the current hash table of service SIDs.
  */
 void
-bus_selinux_id_table_print (DBusHashTable *service_table)
+bus_selinux_data_print_services (BusSELinuxData  *selinux_data)
 {
 #ifdef DBUS_ENABLE_VERBOSE_MODE
 #ifdef HAVE_SELINUX
@@ -768,7 +919,7 @@
     return;
   
   _dbus_verbose ("Service SID Table:\n");
-  _dbus_hash_iter_init (service_table, &iter);
+  _dbus_hash_iter_init (selinux_data->service_mapping, &iter);
   while (_dbus_hash_iter_next (&iter))
     {
       const char *key = _dbus_hash_iter_get_string_key (&iter);
Index: bus/selinux.h
===================================================================
RCS file: /cvs/dbus/dbus/bus/selinux.h,v
retrieving revision 1.7
diff -u -d -r1.7 selinux.h
--- bus/selinux.h	9 Nov 2004 06:11:33 -0000	1.7
+++ bus/selinux.h	11 Nov 2004 05:32:19 -0000
@@ -27,6 +27,8 @@
 #include <dbus/dbus-connection.h>
 #include "services.h"
 
+typedef struct BusSELinuxData BusSELinuxData;
+
 dbus_bool_t bus_selinux_pre_init (void);
 dbus_bool_t bus_selinux_full_init(void);
 void        bus_selinux_shutdown (void);
@@ -36,26 +38,33 @@
 void bus_selinux_id_ref    (BusSELinuxID *sid);
 void bus_selinux_id_unref  (BusSELinuxID *sid);
 
-DBusHashTable* bus_selinux_id_table_new    (void);
-BusSELinuxID*  bus_selinux_id_table_lookup (DBusHashTable    *service_table,
-                                            const DBusString *service_name);
-dbus_bool_t    bus_selinux_id_table_insert (DBusHashTable    *service_table,
-                                            const char       *service_name,
-                                            const char       *service_context);
-void           bus_selinux_id_table_print  (DBusHashTable    *service_table);
-const char*    bus_selinux_get_policy_root (void);
-
+BusSELinuxData* bus_selinux_data_new            (const char             *default_context);
+BusSELinuxID*   bus_selinux_data_lookup_service (const BusSELinuxData   *data,
+						 const DBusString       *service_name);
+dbus_bool_t     bus_selinux_data_insert_service (BusSELinuxData         *selinux_data,
+						 const char             *service_name,
+						 const char             *service_context);
+void            bus_selinux_data_print_services (BusSELinuxData         *selinux_data);
+void            bus_selinux_data_free           (BusSELinuxData         *selinux_data);
+const char*     bus_selinux_get_policy_root     (void);
 
 dbus_bool_t bus_selinux_allows_acquire_service (DBusConnection *connection,
                                                 BusSELinuxID   *service_sid,
 						const char     *service_name);
+dbus_bool_t bus_selinux_allows_activate_service(DBusConnection *connection,
+                                                BusSELinuxID   *service_sid,
+						const char     *service_name);
 dbus_bool_t bus_selinux_allows_send            (DBusConnection *sender,
+						BusSELinuxID   *service_sid,
                                                 DBusConnection *proposed_recipient,
 						const char     *msgtype, /* Supplementary audit data */
 						const char     *interface,
 						const char     *member,
-						const char     *error_name,
 						const char     *destination);
+dbus_bool_t bus_selinux_allows_reply           (DBusConnection *sender,
+                                                DBusConnection *proposed_recipient,
+						const char     *msgtype, /* Supplementary audit data */
+						const char     *error_name);
 
 BusSELinuxID* bus_selinux_init_connection_id (DBusConnection *connection,
                                               DBusError      *error);
Index: bus/services.c
===================================================================
RCS file: /cvs/dbus/dbus/bus/services.c,v
retrieving revision 1.27
diff -u -d -r1.27 services.c
--- bus/services.c	9 Nov 2004 06:11:33 -0000	1.27
+++ bus/services.c	11 Nov 2004 05:32:19 -0000
@@ -54,7 +54,7 @@
   DBusHashTable *service_hash;
   DBusMemPool   *service_pool;
 
-  DBusHashTable *service_sid_table;
+  BusSELinuxData *selinux_data;
 };
 
 BusRegistry*
@@ -79,7 +79,7 @@
   if (registry->service_pool == NULL)
     goto failed;
 
-  registry->service_sid_table = NULL;
+  registry->selinux_data = NULL;
   
   return registry;
 
@@ -109,8 +109,8 @@
         _dbus_hash_table_unref (registry->service_hash);
       if (registry->service_pool)
         _dbus_mem_pool_free (registry->service_pool);
-      if (registry->service_sid_table)
-        _dbus_hash_table_unref (registry->service_sid_table);
+      if (registry->selinux_data)
+        bus_selinux_data_free (registry->selinux_data);
       
       dbus_free (registry);
     }
@@ -307,8 +307,8 @@
   /* Note that if sid is #NULL then the bus's own context gets used
    * in bus_connection_selinux_allows_acquire_service()
    */
-  sid = bus_selinux_id_table_lookup (registry->service_sid_table,
-                                     service_name);
+  sid = bus_selinux_data_lookup_service (registry->selinux_data,
+					 service_name);
 
   if (!bus_selinux_allows_acquire_service (connection, sid,
 					   _dbus_string_get_const_data (service_name)))
@@ -419,14 +419,15 @@
 }
 
 dbus_bool_t
-bus_registry_set_service_context_table (BusRegistry   *registry,
-					DBusHashTable *table)
+bus_registry_set_service_context_table (BusRegistry      *registry,
+					const char       *unlabeled_context,
+					DBusHashTable    *table)
 {
-  DBusHashTable *new_table;
+  BusSELinuxData *new_data;
   DBusHashIter iter;
   
-  new_table = bus_selinux_id_table_new ();
-  if (!new_table)
+  new_data = bus_selinux_data_new (unlabeled_context);
+  if (!new_data)
     return FALSE;
 
   _dbus_hash_iter_init (table, &iter);
@@ -435,18 +436,26 @@
       const char *service = _dbus_hash_iter_get_string_key (&iter);
       const char *context = _dbus_hash_iter_get_value (&iter);
 
-      if (!bus_selinux_id_table_insert (new_table,
-					service,
-					context))
+      if (!bus_selinux_data_insert_service (new_data,
+					    service,
+					    context))
 	return FALSE;
     }
-  
-  if (registry->service_sid_table)
-    _dbus_hash_table_unref (registry->service_sid_table);
-  registry->service_sid_table = new_table;
+
+  if (registry->selinux_data)
+    bus_selinux_data_free (registry->selinux_data);
+  registry->selinux_data = new_data;
   return TRUE;
 }
 
+BusSELinuxID *
+bus_registry_get_service_selinux_id (BusRegistry        *registry,
+				     const DBusString   *service_name)
+{
+  return bus_selinux_data_lookup_service (registry->selinux_data,
+					  service_name);
+}
+
 static void
 bus_service_unlink_owner (BusService      *service,
                           DBusConnection  *owner)
Index: bus/services.h
===================================================================
RCS file: /cvs/dbus/dbus/bus/services.h,v
retrieving revision 1.13
diff -u -d -r1.13 services.h
--- bus/services.h	7 Nov 2004 17:05:19 -0000	1.13
+++ bus/services.h	11 Nov 2004 05:32:19 -0000
@@ -57,7 +57,10 @@
                                            BusTransaction              *transaction,
                                            DBusError                   *error);
 dbus_bool_t  bus_registry_set_service_context_table (BusRegistry           *registry,
+						     const char            *unlabeled_service,
 						     DBusHashTable         *table);
+BusSELinuxID*bus_registry_get_service_selinux_id    (BusRegistry           *registry,
+						     const DBusString      *service_name);
 
 BusService*     bus_service_ref                      (BusService     *service);
 void            bus_service_unref                    (BusService     *service);
cvs diff: Diffing dbus
cvs diff: Diffing doc
Index: doc/busconfig.dtd
===================================================================
RCS file: /cvs/dbus/dbus/doc/busconfig.dtd,v
retrieving revision 1.5
diff -u -d -r1.5 busconfig.dtd
--- doc/busconfig.dtd	18 Oct 2004 04:04:12 -0000	1.5
+++ doc/busconfig.dtd	11 Nov 2004 05:32:19 -0000
@@ -55,6 +55,8 @@
 <!ATTLIST limit name CDATA #REQUIRED>
 
 <!ELEMENT selinux (associate)*>
+<!ATTLIST selinux
+          default_context CDATA #IMPLIED>
 <!ELEMENT associate EMPTY>
 <!ATTLIST associate
           own CDATA #REQUIRED
cvs diff: Diffing gcj
cvs diff: Diffing gcj/org
cvs diff: Diffing gcj/org/freedesktop
cvs diff: Diffing gcj/org/freedesktop/dbus
cvs diff: Diffing glib
cvs diff: Diffing mono
cvs diff: Diffing mono/DBusType
cvs diff: Diffing mono/doc
cvs diff: Diffing mono/doc/en
cvs diff: Diffing mono/doc/en/DBus
cvs diff: Diffing mono/doc/en/DBus.DBusType
cvs diff: Diffing mono/example
cvs diff: Diffing python
cvs diff: Diffing python/examples
cvs diff: Diffing python/tests
cvs diff: Diffing qt
cvs diff: Diffing server
cvs diff: Diffing test
cvs diff: Diffing test/data
cvs diff: Diffing test/data/auth
cvs diff: Diffing test/data/equiv-config-files
cvs diff: Diffing test/data/equiv-config-files/basic
cvs diff: Diffing test/data/equiv-config-files/basic/basic.d
cvs diff: Diffing test/data/equiv-config-files/entities
cvs diff: Diffing test/data/equiv-config-files/entities/basic.d
cvs diff: Diffing test/data/incomplete-messages
cvs diff: Diffing test/data/invalid-config-files
cvs diff: Diffing test/data/invalid-messages
cvs diff: Diffing test/data/sha-1
cvs diff: Diffing test/data/valid-config-files
cvs diff: Diffing test/data/valid-config-files/basic.d
cvs diff: Diffing test/data/valid-config-files/system.d
cvs diff: Diffing test/data/valid-introspection-files
cvs diff: Diffing test/data/valid-messages
cvs diff: Diffing test/data/valid-service-files
cvs diff: Diffing test/glib
cvs diff: Diffing tools

--=-Ben5c85UaOJiYIiiTXQn
Content-Disposition: attachment; filename=selinux-dbus-access-vectors.patch
Content-Type: text/x-patch; name=selinux-dbus-access-vectors.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- access_vectors~	2004-11-11 00:22:52.274844171 -0500
+++ access_vectors	2004-11-10 23:05:41.000000000 -0500
@@ -559,6 +559,8 @@
 {
 	acquire_svc
 	send_msg
+	activate_svc
+	reply
 }
 
 # Define the access vector interpretation for controlling

--=-Ben5c85UaOJiYIiiTXQn--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
