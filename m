Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QJiE6M024778
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:44:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 1606A1A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:44:14 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HIStFCPXqbHM for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 21:44:11 +0200 (CEST)
Received: from fornost.bigon.be (fornost.bigon.be [IPv6:2001:6f8:303:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id A52C01A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:44:11 +0200 (CEST)
Date: Mon, 26 Mar 2012 21:44:08 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/8] setools -- Fix FTBFS when compiling with
 -Werror=format-security
Message-ID: <20120326214408.6341c418@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

This fix FTBFS when compiling with -Werror=format-security

Cheers,
Laurent Bigonville

Description: Fix FTBFS when compiling with -Werror=format-security
Author: Laurent Bigonville <bigon@debian.org>
Date: Tue, 13 Mar 2012 21:03:51 +0100

--- a/libseaudit/src/bool_message.c
+++ b/libseaudit/src/bool_message.c
@@ -101,7 +101,7 @@ char *bool_message_to_string(const seaud
 		return NULL;
 	}
 	if ((misc_string = bool_message_to_misc_string(boolm)) == NULL ||
-	    apol_str_appendf(&s, &len, misc_string) < 0 || apol_str_append(&s, &len, close_brace) < 0) {
+	    apol_str_appendf(&s, &len, "%s", misc_string) < 0 || apol_str_append(&s, &len, close_brace) < 0) {
 		free(misc_string);
 		return NULL;
 	}
@@ -128,7 +128,7 @@ char *bool_message_to_string_html(const
 		return NULL;
 	}
 	if ((misc_string = bool_message_to_misc_string(boolm)) == NULL ||
-	    apol_str_appendf(&s, &len, misc_string) < 0 || apol_str_appendf(&s, &len, "%s%s<br>", s, close_brace) < 0) {
+	    apol_str_appendf(&s, &len, "%s", misc_string) < 0 || apol_str_appendf(&s, &len, "%s%s<br>", s, close_brace) < 0) {
 		free(misc_string);
 		return NULL;
 	}
--- a/libseaudit/src/filter.c
+++ b/libseaudit/src/filter.c
@@ -1108,7 +1108,7 @@ int seaudit_filter_save_to_file(const se
 	if ((file = fopen(filename, "w")) == NULL) {
 		return -1;
 	}
-	fprintf(file, XML_VER);
+	fprintf(file, "%s", XML_VER);
 	fprintf(file, "<view xmlns=\"http://oss.tresys.com/projects/setools/seaudit-%s/\">\n", FILTER_FILE_FORMAT_VERSION);
 	filter_append_to_file(filter, file, 1);
 	fprintf(file, "</view>\n");
--- a/libseaudit/src/model.c
+++ b/libseaudit/src/model.c
@@ -514,7 +514,7 @@ int seaudit_model_save_to_file(const sea
 	if ((file = fopen(filename, "w")) == NULL) {
 		return -1;
 	}
-	fprintf(file, XML_VER);
+	fprintf(file, "%s", XML_VER);
 	fprintf(file, "<view xmlns=\"http://oss.tresys.com/projects/setools/seaudit-%s/\" name=\"%s\" match=\"%s\" show=\"%s\">\n",
 		FILTER_FILE_FORMAT_VERSION, model->name,
 		model->match == SEAUDIT_FILTER_MATCH_ALL ? "all" : "any",
--- a/sediff/progress.c
+++ b/sediff/progress.c
@@ -115,10 +115,10 @@ int progress_wait(progress_t * progress)
 	}
 	g_mutex_unlock(progress->mutex);
 	if (progress->done < 0) {
-		toplevel_ERR(progress->top, GTK_LABEL(progress->label2)->label);
+		toplevel_ERR(progress->top, "%s", GTK_LABEL(progress->label2)->label);
 		return progress->done;
 	} else if (progress->done > 1) {
-		toplevel_WARN(progress->top, GTK_LABEL(progress->label2)->label);
+		toplevel_WARN(progress->top, "%s", GTK_LABEL(progress->label2)->label);
 		return progress->done - 1;
 	} else {
 		progress->done = 0;
--- a/sediff/toplevel.c
+++ b/sediff/toplevel.c
@@ -453,7 +453,7 @@ static void toplevel_message(toplevel_t
 		ERR(NULL, "%s", strerror(errno));
 		return;
 	}
-	dialog = gtk_message_dialog_new(top->w, GTK_DIALOG_DESTROY_WITH_PARENT, msg_type, GTK_BUTTONS_CLOSE, msg);
+	dialog = gtk_message_dialog_new(top->w, GTK_DIALOG_DESTROY_WITH_PARENT, msg_type, GTK_BUTTONS_CLOSE, "%s", msg);
 	free(msg);
 	gtk_dialog_run(GTK_DIALOG(dialog));
 	gtk_widget_destroy(dialog);
--- a/sediff/utilgui.c
+++ b/sediff/utilgui.c
@@ -31,7 +31,7 @@
 void util_message(GtkWindow * parent, GtkMessageType msg_type, const char *msg)
 {
 	GtkWidget *dialog;
-	dialog = gtk_message_dialog_new(parent, GTK_DIALOG_DESTROY_WITH_PARENT, msg_type, GTK_BUTTONS_CLOSE, msg);
+	dialog = gtk_message_dialog_new(parent, GTK_DIALOG_DESTROY_WITH_PARENT, msg_type, GTK_BUTTONS_CLOSE, "%s", msg);
 	gtk_dialog_run(GTK_DIALOG(dialog));
 	gtk_widget_destroy(dialog);
 }
--- a/seaudit/progress.c
+++ b/seaudit/progress.c
@@ -113,10 +113,10 @@ int progress_wait(progress_t * progress)
 	}
 	g_mutex_unlock(progress->mutex);
 	if (progress->done < 0) {
-		toplevel_ERR(progress->top, GTK_LABEL(progress->label2)->label);
+		toplevel_ERR(progress->top, "%s", GTK_LABEL(progress->label2)->label);
 		return progress->done;
 	} else if (progress->done > 1) {
-		toplevel_WARN(progress->top, GTK_LABEL(progress->label2)->label);
+		toplevel_WARN(progress->top, "%s", GTK_LABEL(progress->label2)->label);
 		return progress->done - 1;
 	} else {
 		progress->done = 0;
--- a/seaudit/toplevel.c
+++ b/seaudit/toplevel.c
@@ -902,7 +902,7 @@ static void toplevel_message(toplevel_t
 		ERR(NULL, "%s", strerror(errno));
 		return;
 	}
-	dialog = gtk_message_dialog_new(top->w, GTK_DIALOG_DESTROY_WITH_PARENT, msg_type, GTK_BUTTONS_CLOSE, msg);
+	dialog = gtk_message_dialog_new(top->w, GTK_DIALOG_DESTROY_WITH_PARENT, msg_type, GTK_BUTTONS_CLOSE, "%s", msg);
 	free(msg);
 	gtk_dialog_run(GTK_DIALOG(dialog));
 	gtk_widget_destroy(dialog);
--- a/seaudit/utilgui.c
+++ b/seaudit/utilgui.c
@@ -30,7 +30,7 @@
 void util_message(GtkWindow * parent, GtkMessageType msg_type, const char *msg)
 {
 	GtkWidget *dialog;
-	dialog = gtk_message_dialog_new(parent, GTK_DIALOG_DESTROY_WITH_PARENT, msg_type, GTK_BUTTONS_CLOSE, msg);
+	dialog = gtk_message_dialog_new(parent, GTK_DIALOG_DESTROY_WITH_PARENT, msg_type, GTK_BUTTONS_CLOSE, "%s", msg);
 	gtk_dialog_run(GTK_DIALOG(dialog));
 	gtk_widget_destroy(dialog);
 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
