Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9OJ8TWt016665
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 15:08:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9OJ8RIE009656
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 19:08:27 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
        by jazzband.ncsc.mil  with ESMTP id h9OJ8O1J009637 for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 19:08:25 GMT
Date: Fri, 24 Oct 2003 21:08:12 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] libselinux-3
Message-ID: <20031024190812.GA10572@wavehammer.waldi.eu.org>
References: <20031023215434.GA24235@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <20031023215434.GA24235@wavehammer.waldi.eu.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

updated patch.

bastian

-- 
What kind of love is that?  Not to be loved; never to have shown love.
		-- Commissioner Nancy Hedford, "Metamorphosis",
		   stardate 3219.8

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=libselinux-3

--- src/get_context_list.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/get_context_list.c	(.../trunk/libselinux)	(revision 62)
@@ -36,13 +36,13 @@
 	       an entry is found, and a 1 is returned otherwise.
 */
 static int find_line (FILE *infile, security_context_t con, char *line, 
-                      int length)
+                      size_t length)
 {
     char *current_line;
     char *ptr, *ptr2 = NULL;
     int found = 0;
     char *cc_str = 0;
-    int cc_len = 0;
+    size_t cc_len = 0;
 
     /* Skip the user field. */
     cc_str = index(con, ':');
@@ -53,12 +53,12 @@
     if (!cc_len)
 	    return -1;
 
-    current_line = (char *) malloc (length);
+    current_line = malloc (length);
     if (!current_line)
 	    return (-1);
 
     while (!feof (infile)) {
 	if (!fgets(current_line, length, infile)) {
 		free(current_line);
 		return -1;
 	}
@@ -119,9 +119,9 @@
                              int pri_length)
 {
     char *ptr, *ptr2;
-    int length;
+    size_t length;
     security_context_t current_context;
-    int current_context_len;
+    size_t current_context_len;
     int count = 0;
 
     ptr = instr;
@@ -205,7 +205,7 @@
 {
     FILE *config_file;    /* The configuration file                    */
     char *fname = 0;      /* The name of the user's configuration file */
-    int fname_len;        /* The length of fname                       */
+    size_t fname_len;     /* The length of fname                       */
     struct passwd *pwd;   /* The user's passwd structure               */
     int retval;           /* The return value                          */
 
@@ -218,7 +218,7 @@
             return -1;
         }
         fname_len = strlen (pwd->pw_dir) + 20;
-        fname = (char *) malloc (fname_len);
+        fname = malloc (fname_len);
         if (!fname)
         {
             return -1;
@@ -366,13 +366,13 @@
 	if (!ptr)
 		return -1;
 	plen = strlen(ptr);
-	if (buf[plen-1] == '\n') 
+	if (plen > 1 && buf[plen-1] == '\n') 
 		buf[plen-1] = 0;
 
 	nlen = strlen(user)+1+plen+1;
 	*newcon = malloc(nlen);
 	rc = snprintf(*newcon, nlen, "%s:%s", user, ptr);
-	if (rc < 0 || rc >= nlen) {
+	if (rc < 0 || (size_t) rc >= nlen) {
 		free(*newcon);
 		*newcon = 0;
 		return -1;
Index: src/fgetfilecon.c
===================================================================
--- src/fgetfilecon.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/fgetfilecon.c	(.../trunk/libselinux)	(revision 62)
@@ -10,7 +10,7 @@
 int fgetfilecon(int fd, security_context_t *context)
 {
 	char *buf;
-	ssize_t size;
+	size_t size;
 	ssize_t ret;
 
 	size = INITCONTEXTLEN+1;
@@ -23,11 +23,11 @@
 	if (ret < 0 && errno == ERANGE) {
 		char *newbuf;
 
-		size = fgetxattr(fd, XATTR_NAME_SELINUX, NULL, 0);
-		if (size < 0)
+		ret = fgetxattr(fd, XATTR_NAME_SELINUX, NULL, 0);
+		if (ret < 0)
 			goto out;
 
-		size++;
+		size = ret + 1;
 		newbuf = realloc(buf, size);
 		if (!newbuf)
 			goto out;
Index: src/lgetfilecon.c
===================================================================
--- src/lgetfilecon.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/lgetfilecon.c	(.../trunk/libselinux)	(revision 62)
@@ -10,7 +10,7 @@
 int lgetfilecon(const char *path, security_context_t *context)
 {
 	char *buf;
-	ssize_t size;
+	size_t size;
 	ssize_t ret;
 
 	size = INITCONTEXTLEN+1;
@@ -23,11 +23,11 @@
 	if (ret < 0 && errno == ERANGE) {
 		char *newbuf;
 
-		size = lgetxattr(path, XATTR_NAME_SELINUX, NULL, 0);
-		if (size < 0)
+		ret = lgetxattr(path, XATTR_NAME_SELINUX, NULL, 0);
+		if (ret < 0)
 			goto out;
 
-		size++;
+		size = ret + 1;
 		newbuf = realloc(buf, size);
 		if (!newbuf)
 			goto out;
Index: src/Makefile
===================================================================
--- src/Makefile	(.../upstream/current/libselinux)	(revision 62)
+++ src/Makefile	(.../trunk/libselinux)	(revision 62)
@@ -11,8 +11,9 @@
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
-CFLAGS = -Wall
-override CFLAGS += -I../include 
+CFLAGS = -Wall -W -Werror -O2 -pipe
+override CFLAGS += -I../include
+LDFLAGS =
 
 all: $(LIBA) $(LIBSO)
 
@@ -25,10 +26,10 @@
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c
-	$(CC) -o $@ -c $(CFLAGS) $<
+	$(CC) $(CFLAGS) -c -o $@ $<
 
 %.lo:  %.c
-	$(CC) -o $@ -c -fPIC $(CFLAGS) $<
+	$(CC) $(CFLAGS) -fPIC -c -o $@ $<
 
 install: all
 	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
Index: src/fsetfilecon.c
===================================================================
Index: src/compute_av.c
===================================================================
--- src/compute_av.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/compute_av.c	(.../trunk/libselinux)	(revision 62)
@@ -16,7 +16,7 @@
 			struct av_decision *avd)
 {
 	char *buf;
-	unsigned int len;
+	size_t len;
 	int fd, ret;
 
 	fd = open(SELINUXMNT "access", O_RDWR);
Index: src/helpers.c
===================================================================
--- src/helpers.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/helpers.c	(.../trunk/libselinux)	(revision 62)
@@ -23,7 +23,7 @@
 
 security_class_t string_to_security_class(const char *s)
 {
-	int val;
+	unsigned int val;
 
 	if (isdigit(s[0])) {
 		val = atoi(s);
@@ -45,7 +45,7 @@
 {
         char          **common_pts = 0;
         access_vector_t common_base = 0;
-        int             i, i2, perm;
+        unsigned int             i, i2, perm;
  
  
         if (av == 0) {
Index: src/lsetfilecon.c
===================================================================
Index: src/compute_user.c
===================================================================
--- src/compute_user.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/compute_user.c	(.../trunk/libselinux)	(revision 62)
@@ -16,8 +16,8 @@
 	char **ary;
 	char *buf, *ptr;
 	size_t size;
-	int fd, ret, i;
-	unsigned int nel;
+	int fd, ret;
+	unsigned int i, nel;
 
 	fd = open(SELINUXMNT "user", O_RDWR);
 	if (fd < 0)
Index: src/getfilecon.c
===================================================================
--- src/getfilecon.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/getfilecon.c	(.../trunk/libselinux)	(revision 62)
@@ -10,7 +10,7 @@
 int getfilecon(const char *path, security_context_t *context)
 {
 	char *buf;
-	ssize_t size;
+	size_t size;
 	ssize_t ret;
 
 	size = INITCONTEXTLEN+1;
@@ -23,11 +23,11 @@
 	if (ret < 0 && errno == ERANGE) {
 		char *newbuf;
 
-		size = getxattr(path, XATTR_NAME_SELINUX, NULL, 0);
-		if (size < 0)
+		ret = getxattr(path, XATTR_NAME_SELINUX, NULL, 0);
+		if (ret < 0)
 			goto out;
 
-		size++;
+		size = ret + 1;
 		newbuf = realloc(buf, size);
 		if (!newbuf)
 			goto out;
Index: src/get_default_type.c
===================================================================
--- src/get_default_type.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/get_default_type.c	(.../trunk/libselinux)	(revision 62)
@@ -29,7 +29,7 @@
 {
     char buf[250];
     char *ptr = "", *end, *t;
-    int len;
+    size_t len;
     int found = 0;
 
     len = strlen(role);
Index: src/context.c
===================================================================
--- src/context.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/context.c	(.../trunk/libselinux)	(revision 62)
@@ -93,14 +93,15 @@
 context_str(context_t context)
 {
         context_private_t *n = context->ptr;
-        int i, total;
+        int i;
+        size_t total = 0;
         conditional_free(&n->current_str);
-        for ( i = total = 0; i < 4; i++ ) {
+        for ( i = 0; i < 4; i++ ) {
                 if ( n->component[i] ) {
                         total += strlen(n->component[i])+1;
                 }
         }
-        n->current_str = (char*) malloc(total);
+        n->current_str = malloc(total);
         if ( n->current_str != 0 ) {
                 strcpy(n->current_str,n->component[0]);
                 strcat(n->current_str,":");

--tKW2IUtsqtDRztdT--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
