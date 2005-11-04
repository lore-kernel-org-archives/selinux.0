Subject: Re: [ SEMANAGE ] Assert whitespace between records
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <436BA8E6.8030508@cornell.edu>
References: <436BA8E6.8030508@cornell.edu>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 14:22:40 -0500
Message-Id: <1131132160.23420.335.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 13:31 -0500, Ivan Gyurdiev wrote:
> This patch will assert there is whitespace between seuser, boolean, 
> interface, and port records (assert whitespace after each record). This 
> has no effect on ports and interfaces, because they already check for 
> that when looking for where the context ends (added for clarity only). 
> Users don't require a space, because they have a semicolon.
> 
> In the case of seusers, this prevents parser confusion when MLS is 
> disabled, and we encounter an MLS context:
> a:b:c - complain about lack of whitespace, rather than treating the ":" 
> as the next seuser, and saying something like: nonempty string expected, 
> or whatever...
> 
> In the case of booleans, this change will consider a=TRUEb=false or 
> things like that as a parse error.
> 
> This change will succeed on the last record, and at the end of each 
> line, because the terminating '\0' is considered whitespace - it's 
> present on all lines, including the last one. It will not succeed if you 
> called skip_space right before that, because that zeros the buffer on 
> EOF (intentionally).

Ok.  But I think we also want something like the patch below in the
libselinux case to handle an empty seuser or level field as an error
condition.

Index: libselinux/src/seusers.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/seusers.c,v
retrieving revision 1.9
diff -u -p -r1.9 seusers.c
--- libselinux/src/seusers.c	4 Nov 2005 20:06:22 -0000	1.9
+++ libselinux/src/seusers.c	4 Nov 2005 20:11:59 -0000
@@ -54,6 +54,9 @@ static int process_seusers(const char *b
 	seuser = strdup(start);
 	if (!seuser)
 		goto err;
+
+	if (!strcmp(seuser, ""))
+		goto err;
 	
 	/* Skip MLS if disabled, or missing. */
 	if (!mls_enabled || !mls_found)
@@ -68,6 +71,9 @@ static int process_seusers(const char *b
 	if (!level)
 		goto err;
 
+	if (!strcmp(level, ""))
+		goto err;
+
 out:
 	free(newbuf);
 	*luserp = luser;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
