Date: Wed, 24 Aug 2005 13:08:30 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: serue@us.ibm.com, Jason Tang <jtang@tresys.com>,
   Joshua Brindle <jbrindle@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: fix resource leaks
Message-ID: <20050824180830.GA7291@sergelap.austin.ibm.com>
References: <20050822114602.GC24949@sergelap.austin.ibm.com> <1124729771.3025.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1124729771.3025.75.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Mon, 2005-08-22 at 06:46 -0500, serue@us.ibm.com wrote:
> Looks like we need to free the individual elements as well.  Any reason
> this isn't handled internally by semod_build_modules_list upon an error?

How about the following patch?

thanks,
-serge

--- src/module_store.c.orig	2005-08-24 17:02:10.056307256 -0500
+++ src/module_store.c	2005-08-24 17:13:23.351950760 -0500
@@ -721,13 +721,15 @@ static int semod_build_modules_list (con
         }	
 	if ((*names = (char **) calloc (*len, sizeof (**names))) == NULL ||
             (*versions = (char **) calloc (*len, sizeof (**versions))) == NULL) {
-                return -1;
+                goto err;
 	}
+	memset(names, 0, *len * sizeof(**names));
+	memset(versions, 0, *len * sizeof(**versions));
 	for (i = 0; i < *len; i++) {
                 char *filename, *name, *version;
                 int type;
                 if (asprintf (&filename, "%s/%s", path, namelist[i]->d_name) == -1) {
-                        return -1;
+                        goto err;
                 }
 		if ((pf.fp = fopen (filename, "r")) == NULL) {
                         free (filename);
@@ -748,6 +750,24 @@ static int semod_build_modules_list (con
 	}
         free(namelist);
         return 0;
+
+err:
+	if (*names) {
+		for (i=0; i< *len; i++) {
+			if ((*names)[i])
+				free((*names)[i]);
+		}
+		free(*names);
+	}
+	if (*versions) {
+		for (i=0; i< *len; i++) {
+			if ((*versions)[i])
+				free((*versions)[i]);
+		}
+		free(*versions);
+	}
+
+	return -1;
 }
 
 /********************* accessor functions below *********************/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
