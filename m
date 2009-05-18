Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4IIKf7K030984
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:20:41 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4IIKjup020970
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 18:20:48 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4IIKTsr009588
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:20:29 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4IIKSbw009719
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:20:28 -0400
Received: from localhost.localdomain (vpn-10-81.bos.redhat.com [10.16.10.81])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4IIKR5l003827
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:20:28 -0400
Message-ID: <4A11A6EE.3070903@redhat.com>
Date: Mon, 18 May 2009 14:20:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: This patch add seusers support to SELinux
Content-Type: multipart/mixed;
 boundary="------------010908030609040103080308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010908030609040103080308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The idea here is to break the seusers file up into lots of little 
seusers file that can be user specific, also adds the service field to 
be used by tools like pam_selinux to choose which is the correct context 
to log a user in as.

Patch was added to facilitate IPA handing out SELinux content for 
selection of roles at login.


--------------010908030609040103080308
Content-Type: text/plain;
 name="libselinux_seusers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux_seusers.patch"

--- nsalibselinux/include/selinux/selinux.h	2009-04-08 09:06:23.000000000 -0400
+++ libselinux-2.0.81/include/selinux/selinux.h	2009-05-18 14:04:07.000000000 -0400
@@ -544,6 +547,14 @@
    Caller must free the returned strings via free. */
 extern int getseuserbyname(const char *linuxuser, char **seuser, char **level);
 
+/* Get the SELinux username and level to use for a given Linux username and service. 
+   These values may then be passed into the get_ordered_context_list*
+   and get_default_context* functions to obtain a context for the user.
+   Returns 0 on success or -1 otherwise.
+   Caller must free the returned strings via free. */
+extern int getseuser(const char *username, const char *service, 
+		     char **r_seuser, char **r_level);
+
 /* Compare two file contexts, return 0 if equivalent. */
 int selinux_file_context_cmp(const security_context_t a,
 			     const security_context_t b);
--- nsalibselinux/src/seusers.c	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.81/src/seusers.c	2009-05-18 14:04:07.000000000 -0400
@@ -243,3 +243,67 @@
 	*r_level = NULL;
 	return 0;
 }
+
+int getseuser(const char *username, const char *service, 
+	      char **r_seuser, char **r_level) {
+	int ret = -1;
+	int len = 0;
+	char *seuser = NULL;
+	char *level = NULL;
+	char *buffer = NULL;
+	size_t size = 0;
+	size_t lineno = 0;
+	char *rec = NULL;
+	char *path=NULL;
+	if (asprintf(&path,"%s/logins/%s", selinux_policy_root(), username) <  0)
+		goto err;
+	FILE *fp = fopen(path, "r");
+	free(path);
+	if (fp == NULL) goto err;
+	__fsetlocking(fp, FSETLOCKING_BYCALLER);
+	while (getline(&buffer, &size, fp) > 0) {
+		++lineno;
+
+		if (strncmp(buffer, "*:", 2) == 0) {
+			free(rec);
+			rec = strdup(buffer);
+			continue;
+		}
+		len = strlen(service);
+		if ((strncmp(buffer, service, len) == 0) &&
+		    (buffer[len] == ':')) {
+			free(rec);
+			rec = strdup(buffer);
+			break;
+		}
+	}
+
+	if (! rec)  goto err;
+	seuser = strchr(rec, ':');
+	if (! seuser) goto err;
+
+	seuser++;
+	level = strchr(seuser, ':');
+	*level = 0;
+	level++;
+	*r_seuser = strdup(seuser);
+	if (! *r_seuser) goto err;
+
+	len = strlen(level);
+	if (len && level[len-1] == '\n')
+		level[len-1] = 0;
+
+	*r_level = strdup(level);
+	if (! *r_level) {
+		free(*r_seuser);
+		goto err;
+	}
+	ret = 0;
+
+	err:
+	free(buffer);
+	if (fp) fclose(fp);
+	free(rec);
+
+	return (ret ? getseuserbyname(username, r_seuser, r_level) : ret);
+}

--------------010908030609040103080308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
