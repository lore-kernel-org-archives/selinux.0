Message-ID: <425AE087.7090001@trustedcs.com>
Date: Mon, 11 Apr 2005 15:39:35 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Subject: Re: policy hierarchy patch
References: <1112631282.19526.18.camel@localhost>	 <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil>	 <1112643447.19527.30.camel@localhost>  <4251BA1E.9040406@trustedcs.com>	 <1112709782.19531.39.camel@localhost> <425320BD.5050207@trustedcs.com>	 <425456F1.5000905@trustedcs.com>	 <1112877155.27110.15.camel@moss-spartans.epoch.ncsc.mil>	 <42556015.6090405@trustedcs.com> <1112907833.19565.9.camel@localhost>	 <4255A62F.80405@trustedcs.com> <1112984816.10298.5.camel@localhost>
In-Reply-To: <1112984816.10298.5.camel@localhost>
Content-Type: multipart/mixed;
 boundary="------------040101060300010805060006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040101060300010805060006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Joshua Brindle wrote:
> On Thu, 2005-04-07 at 16:29 -0500, Darrel Goeddel wrote:
> 
>>Joshua Brindle wrote:
>>
>>>On Thu, 2005-04-07 at 11:30 -0500, Darrel Goeddel wrote:
>>>
>>>
>>>>Stephen Smalley wrote:
>>
>>>>>The original hierarchy patch also collapsed the identifier and
>>>>>user_identifier together, thereby allowing "-" to occur in any
>>>>>identifier.  As a result, if someone specifies s0-s9 in the policy
>>>>>without whitespace, it will be incorrectly interpreted as an attempt to
>>>>>specify a level named "s0-s9".  Further, nothing prevents someone from
>>>>>defining a level or category name that includes a "-" presently.
>>>>>Options are to revert the change from the original patch that collapsed
>>>>>identifier and user_identifier together (only adding "." to identifier,
>>>>>not "-") or to add further handling to the action routines to deal with
>>>>>it.
>>>>>
>>>
>>>
> 
> Ok, here is a patch against cvs (includes Darrel's MLS changes). It
> builds MLS and non-MLS policies with and without type and role
> hierarchies so this should be good to go, let me know if there are any
> other problems.
> 
> Joshua

Thanks for merging my changes into the main patch.  I have a few additions in 
the attached patch, which is relative to your latest patch.

I had a possible double free in define_category.  I added back the declaration 
for is_valid_identifier in policy_scan.l to avoid a warning.  I also removed 
including '-' as a valid character in the standard IDENTIFIER (this is what we 
were after, right?).  There are a few tweaks to the policy Makefile.  The first 
is changing "s9 : c0.c127" to "s9:c0.c127" - I thought that was a bit more 
readable.  The second is changing MLS=n to MLS=y in the makefile when running 
the mlsconvert target.

-- 

Darrel

--------------040101060300010805060006
Content-Type: text/x-patch;
 name="hier-mls-suppl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hier-mls-suppl.patch"

diff -ruNp hier2/checkpolicy/policy_parse.y hier2-dgo/checkpolicy/policy_parse.y
--- hier2/checkpolicy/policy_parse.y	2005-04-11 14:22:07.964067426 -0500
+++ hier2-dgo/checkpolicy/policy_parse.y	2005-04-11 14:32:19.078544643 -0500
@@ -1325,7 +1325,6 @@ static int define_category(void)
 
 	while ((id = queue_remove(id_queue))) {
 		if (id_has_dot(id)) {
-			free(id);
 			yyerror("category aliases may not contain periods");
 			goto bad_alias;
 		}
diff -ruNp hier2/checkpolicy/policy_scan.l hier2-dgo/checkpolicy/policy_scan.l
--- hier2/checkpolicy/policy_scan.l	2005-04-11 14:22:07.965067174 -0500
+++ hier2-dgo/checkpolicy/policy_scan.l	2005-04-11 14:40:20.299361117 -0500
@@ -25,6 +25,7 @@
 static char linebuf[2][255];
 static unsigned int lno = 0;
 int yywarn(char *msg);
+static int is_valid_identifier(char *id);
 
 char source_file[255];
 unsigned long source_lineno = 1;
@@ -185,7 +186,7 @@ H1				{ return(H1); }
 h2 |
 H2				{ return(H2); }
 "/"({letter}|{digit}|_|"."|"-"|"/")*	{ return(PATH); }
-{letter}({letter}|{digit}|_|"."|"-")*({letter}|{digit})	{ if (is_valid_identifier(yytext)) 
+{letter}({letter}|{digit}|_|".")*({letter}|{digit})	{ if (is_valid_identifier(yytext)) 
 						return(IDENTIFIER); 
 					  else 
 					  	REJECT;
diff -ruNp hier2/policy/Makefile hier2-dgo/policy/Makefile
--- hier2/policy/Makefile	2005-04-11 14:22:07.969066167 -0500
+++ hier2-dgo/policy/Makefile	2005-04-11 14:31:14.108728717 -0500
@@ -327,8 +327,11 @@ mlsconvert: 
 	done
 	@for file in $(USER_FILES); do \
 		echo "Converting $$file"; \
-		sed -e 's/;/ level s0 range s0 - s9 : c0.c127;/' $$file > $$file.new && \
+		sed -e 's/;/ level s0 range s0 - s9:c0.c127;/' $$file > $$file.new && \
 		mv $$file.new $$file; \
 	done
-	@sed -e '/sid kernel/s/s0/s0 - s9 : c0.c127/' initial_sid_contexts > initial_sid_contexts.new && mv initial_sid_contexts.new initial_sid_contexts
+	@sed -e '/sid kernel/s/s0/s0 - s9:c0.c127/' initial_sid_contexts > initial_sid_contexts.new && mv initial_sid_contexts.new initial_sid_contexts
+	@echo "Enabling MLS in the Makefile"
+	@sed "s/MLS=n/MLS=y/" Makefile > Makefile.new
+	@mv Makefile.new Makefile
 	@echo "Done"

--------------040101060300010805060006--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
