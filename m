Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EItbWt020718
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 14:55:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9EItT0p009307
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 18:55:29 GMT
Received: from tooheys.dsl.net (tooheys.dsl.net [65.84.81.1])
	by jazzswing.ncsc.mil  with ESMTP id h9EItTr7009301
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 18:55:29 GMT
Message-ID: <3F8C46E4.1030403@tresys.com>
Date: Tue, 14 Oct 2003 14:56:36 -0400
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: specifying groups of types
References: <200310111435.46684.russell@coker.com.au> <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------070401040203030003060307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070401040203030003060307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Russell,

Here's a quick hack that appears to work.  It turns off the type (or 
list of types if used on an attribute) when building the bitmap of types 
for a rule.  The syntax is to use a '-' in front of a type or attribute 
name.

allow some_domain { file_type -shadow_t -null_device_t -exec_type}:...

The proper way to do this is in the yacc parsing section.  All I did was 
allow '-' as the first character of an identifier (policy_scan.l) and 
handle the subtraction of the type/attribute in 
policy_parse.y:set_types().  The danger is that types (and anything 
using the identifier definition) can be declared with '-' as the first 
character and cause problems.  The advantage, in theory, is that 
wherever a list of types/attributes is processed, the '-' notation can 
be used to turn off types.  So, you should also be able to do something 
like:

allow { auth -crond_t } file_type:...

Types/attributes are processed in order, and subsequent allow rules can 
also override the subtraction.

I'd recommend trying this out and if you find it useful change the parse 
rules.  I tested it on some real basic policy, so it may cause other 
unintended problems.  I'm throwing it out more as a starting point 
rather than something intended to be integrated into checkpolicy.

David

Stephen Smalley wrote:
> On Sat, 2003-10-11 at 00:35, Russell Coker wrote:
> 
>>Following a discussion on IRC, it occurs to me that it would be handy to have 
>>the following in the policy language:
>>allow some_domain { file_type !shadow_t }:...
>>
>>So we can specify everything in file_type except for shadow_t.
> 
> 
> Yes, although I'm not sure about the notation; might be better to
> provide a set difference operator, e.g.
> 	file_type - shadow_t
> 
> Are you offering to implement this enhancement to checkpolicy?
> 

-- 
__________________________________

David Caplan     410 290 1411 x105
dac@tresys.com
Tresys Technology, LLC
8840 Stanford Blvd., Suite 2100
Columbia, MD 21045

--------------070401040203030003060307
Content-Type: text/plain;
 name="checkpolicy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="checkpolicy.patch"

diff -ruN checkpolicy.old/policy_parse.y checkpolicy/policy_parse.y
--- checkpolicy.old/policy_parse.y	2003-10-15 07:15:18.431551648 -0400
+++ checkpolicy/policy_parse.y	2003-10-15 07:19:00.550784392 -0400
@@ -1,6 +1,10 @@
 
 /*
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ *
+ * Modified October 14, 2003 David Caplan, <dac@tresys.com>
+ * - allow exclusion of types and attributes in type/attribute lists
+ * 
  */
 
 /* FLASK */
@@ -1660,10 +1664,11 @@
 {
 	type_datum_t *t;
 	int i;
+	int add = TRUE;
 
 	if (strcmp(id, "*") == 0) {
 		/* set all types */
-		for (i = 0; i < policydbp->p_types.nprim; i++) 
+		for (i = 0; i < policydbp->p_types.nprim; i++)
 			ebitmap_set_bit(set, i, TRUE);
 		free(id);
 		return 0;
@@ -1674,14 +1679,27 @@
 		for (i = 0; i < policydbp->p_types.nprim; i++) {
 			if (ebitmap_get_bit(set, i))
 				ebitmap_set_bit(set, i, FALSE);
-			else 
+			else
 				ebitmap_set_bit(set, i, TRUE);
 		}
 		free(id);
 		return 0;
 	}
 
-	t = hashtab_search(policydbp->p_types.table, id);
+	/* see if we want to exclude type/attribute */
+	if (id[0] == '-') {
+	         if (strlen(id) == 1) {
+		      sprintf(errormsg, "illegal identifier %s", id);
+		      yyerror(errormsg);
+		      free(id);
+		      return -1;
+	         }
+	         add = FALSE;
+	         t = hashtab_search(policydbp->p_types.table, id+1);
+	} else {
+	         t = hashtab_search(policydbp->p_types.table, id);
+	}
+
 	if (!t) {
 		sprintf(errormsg, "unknown type %s", id);
 		yyerror(errormsg);
@@ -1693,12 +1711,13 @@
 		/* set all types with this attribute */
 		for (i = ebitmap_startbit(&t->types); i < ebitmap_length(&t->types); i++) {
 			if (!ebitmap_get_bit(&t->types, i)) 
-				continue;		
-			ebitmap_set_bit(set, i, TRUE);
+				continue;
+			/* set or clear bit depending on add */
+			ebitmap_set_bit(set, i, add);
 		}
 	} else {
-		/* set one type */
-		ebitmap_set_bit(set, t->value - 1, TRUE);
+		/* set or clear (depending on add) one type */
+		ebitmap_set_bit(set, t->value - 1, add);
 	}
 
 	free(id);
diff -ruN checkpolicy.old/policy_scan.l checkpolicy/policy_scan.l
--- checkpolicy.old/policy_scan.l	2003-10-15 07:15:18.426552408 -0400
+++ checkpolicy/policy_scan.l	2003-10-15 07:10:39.149009048 -0400
@@ -127,7 +127,7 @@
 t2 |
 T2				{ return(T2); }
 "/"({letter}|{digit}|_|"."|"-"|"/")*	{ return(PATH); }
-{letter}({letter}|{digit}|_)*	{ return(IDENTIFIER); }
+({letter}|"-")({letter}|{digit}|_)*	{ return(IDENTIFIER); }
 {letter}({letter}|{digit}|_|"."|"-")*	{ return(USER_IDENTIFIER); }
 {digit}{digit}*                 { return(NUMBER); }
 #[^\n]*                         { /* delete comments */ }

--------------070401040203030003060307--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
