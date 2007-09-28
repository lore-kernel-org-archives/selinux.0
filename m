Message-ID: <46FD185E.4050201@redhat.com>
Date: Fri, 28 Sep 2007 11:06:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Todd C. Miller" <tmiller@tresys.com>, selinux@tycho.nsa.gov,
        jbrindle@tresys.com
Subject: Re: [patch 0/4] libsemanage: genhomedircon regressions
References: <20070927200712.950671948@tresys.com>	 <1190986603.22078.1.camel@moss-spartans.epoch.ncsc.mil>	 <1190987098.22078.4.camel@moss-spartans.epoch.ncsc.mil>	 <46FD0870.70801@redhat.com>	 <1190987506.22078.5.camel@moss-spartans.epoch.ncsc.mil> <1190987704.22078.7.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190987704.22078.7.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------010000070806060405070604"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010000070806060405070604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2007-09-28 at 09:51 -0400, Stephen Smalley wrote:
>> On Fri, 2007-09-28 at 09:58 -0400, Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Stephen Smalley wrote:
>>>> On Fri, 2007-09-28 at 09:36 -0400, Stephen Smalley wrote:
>>>>> On Thu, 2007-09-27 at 16:07 -0400, Todd C. Miller wrote:
>>>>>> This patch set fixes several regressions found in the new genhomedircon
>>>>>> replacement.  I've broken things up into their logical parts for easy
>>>>>> reading.  I've also included Dan's do_rebuild_file_context and swigify
>>>>>> patches as a 4th diff.  If we want to treat that completely separately
>>>>>> we can.
>>>>> patch 1/4 yielded a non-buildable tree, so I applied 1/4 and 3/4
>>>>> together as a single commit.
>>>>>
>>>>> 2/4 applied as a bug fix independent of the others.
>>>>>
>>>>> 4/4 dropped except for Makefile swigify target.
>>>>>
>>>>> libsemanage 2.0.10.
>>>> Looking again at the output, the order differs - the libsemanage
>>>> genhomedircon puts the specific user entries first and then the
>>>> generic /home entries, which seems wrong given that later entries take
>>>> precedence for matchpathcon.  genhomedircon script does the opposite.
>>>>
>>> It should be alright because of the specificity is greater.
>>>
>>> /home/dwalsh/.*
>>>
>>> vs
>>>
>>> /home/.*
>> I don't think that works out in all cases, e.g.
>> matchpathcon /home/xguest/.ssh yields a different result.
> 
> Old order (genhomedircon script output):
> # matchpathcon /home/xguest/.ssh
> /home/xguest/.ssh       xguest_u:object_r:xguest_home_t
> 
> New order (latest libsemanage):
> # matchpathcon /home/xguest/.ssh
> /home/xguest/.ssh       system_u:object_r:user_home_ssh_t
> 
> Which did you want it to be?
> 
Yes you are right.

The problem is we need to find the failsafe account before writing the
general account.

How about this patch.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG/RhdrlYvE4MpobMRAqTmAKDCE7++pT4Cyia9otRgxVKDGliybQCeORmj
JjDY5P3SDBwohQRC5uPJwNU=
=HkqG
-----END PGP SIGNATURE-----

--------------010000070806060405070604
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.c libsemanage-2.0.10/src/genhomedircon.c
--- nsalibsemanage/src/genhomedircon.c	2007-09-28 09:48:57.000000000 -0400
+++ libsemanage-2.0.10/src/genhomedircon.c	2007-09-28 10:59:54.000000000 -0400
@@ -575,10 +575,8 @@
 	return STATUS_SUCCESS;
 }
 
-static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
-					     int *errors)
+static int setup_fallback_user(genhomedircon_settings_t * s)
 {
-	genhomedircon_user_entry_t *head = NULL;
 	semanage_seuser_t **seuser_list = NULL;
 	unsigned int nseusers = 0;
 	semanage_user_t **user_list = NULL;
@@ -587,17 +585,13 @@
 	const char *name = NULL;
 	const char *seuname = NULL;
 	const char *prefix = NULL;
-	struct passwd pwstorage, *pwent = NULL;
 	unsigned int i;
-	long rbuflen;
-	char *rbuf = NULL;
 	int retval;
-
-	*errors = 0;
+	int errors = 0;
 	retval = semanage_seuser_list(s->h_semanage, &seuser_list, &nseusers);
 	if (retval < 0 || (nseusers < 1)) {
 		/* if there are no users, this function can't do any other work */
-		return NULL;
+		return errors;
 	}
 
 	if (semanage_user_list(s->h_semanage, &user_list, &nusers) < 0) {
@@ -607,14 +601,6 @@
 	qsort(user_list, nusers, sizeof(semanage_user_t *),
 	      (int (*)(const void *, const void *))&user_sort_func);
 
-	/* Allocate space for the getpwnam_r buffer */
-	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
-	if (rbuflen <= 0)
-		goto cleanup;
-	rbuf = malloc(rbuflen);
-	if (rbuf == NULL)
-		goto cleanup;
-
 	for (i = 0; i < nseusers; i++) {
 		name = semanage_seuser_get_name(seuser_list[i]);
 		if (strcmp(name, DEFAULT_LOGIN) == 0) {
@@ -630,14 +616,54 @@
 			} else {
 				prefix = name;
 			}
-
 			if (set_fallback_user(s, seuname, prefix) != 0) {
-				*errors = STATUS_ERR;
-				goto cleanup;
+				errors = STATUS_ERR;
 			}
 			break;
 		}
 	}
+	return errors;
+}
+
+static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
+					     int *errors)
+{
+	genhomedircon_user_entry_t *head = NULL;
+	semanage_seuser_t **seuser_list = NULL;
+	unsigned int nseusers = 0;
+	semanage_user_t **user_list = NULL;
+	unsigned int nusers = 0;
+	semanage_user_t **u = NULL;
+	const char *name = NULL;
+	const char *seuname = NULL;
+	const char *prefix = NULL;
+	struct passwd pwstorage, *pwent = NULL;
+	unsigned int i;
+	long rbuflen;
+	char *rbuf = NULL;
+	int retval;
+
+	*errors = 0;
+	retval = semanage_seuser_list(s->h_semanage, &seuser_list, &nseusers);
+	if (retval < 0 || (nseusers < 1)) {
+		/* if there are no users, this function can't do any other work */
+		return NULL;
+	}
+
+	if (semanage_user_list(s->h_semanage, &user_list, &nusers) < 0) {
+		nusers = 0;
+	}
+
+	qsort(user_list, nusers, sizeof(semanage_user_t *),
+	      (int (*)(const void *, const void *))&user_sort_func);
+
+	/* Allocate space for the getpwnam_r buffer */
+	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (rbuflen <= 0)
+		goto cleanup;
+	rbuf = malloc(rbuflen);
+	if (rbuf == NULL)
+		goto cleanup;
 
 	for (i = 0; i < nseusers; i++) {
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
@@ -769,12 +795,10 @@
 		goto done;
 	}
 
-	if (write_gen_home_dir_context(s, out, user_context_tpl,
-				       homedir_context_tpl) != STATUS_SUCCESS) {
+	if (setup_fallback_user(s) != 0) {
 		retval = STATUS_ERR;
 		goto done;
 	}
-
 	for (h = homedirs; h; h = h->next) {
 		Ustr *temp = ustr_dup_cstr(h->data);
 
@@ -811,6 +835,12 @@
 		goto done;
 	}
 
+	if (write_gen_home_dir_context(s, out, user_context_tpl,
+				       homedir_context_tpl) != STATUS_SUCCESS) {
+		retval = STATUS_ERR;
+		goto done;
+	}
+
       done:
 	/* Cleanup */
 	semanage_list_destroy(&homedirs);

--------------010000070806060405070604
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBG/RhdrlYvE4MpobMRAmNAAJ9+fPRqQKwMdvSqiaI1Y12uQPgGwwCg5518gUQyEcuv
Cjh01dxiUUVnuyU=
--------------010000070806060405070604--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
