Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1RIDo2D000827
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 13:13:50 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1RIDmgc003871
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 18:13:48 GMT
Subject: policycaps implementation in checkmodule
From: Eric Paris <eparis@redhat.com>
To: Tmiller@tresys.com
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 27 Feb 2008 13:12:22 -0500
Message-Id: <1204135942.3206.37.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So I started playing with poliycaps today and it just isn't compiling.
And lets start off by saying I haven't seen lex or yacc in years.  And
could be so far off base here it is unbelievable.  Here is my module:

****
module capabilities 0.0.1;

policycap network_peer_controls;
policycap open_perms;
****

First thing someone is going to say is that these only work in the base
module, which is all fine and good, I'm not talking about these actually
doing anything, I'm talking about these just getting through the
compiler.  So don't bring that up yet out of the blue.  Here's what I
get:

[root@dhcp231-146 checkpolicy-2.0.9]# ./checkmodule -M -m -o /root/caps/capabilities.mod /root/caps/capabilities.te
./checkmodule:  loading policy configuration from /root/caps/capabilities.te
/root/caps/capabilities.te:3:ERROR 'syntax error' at token 'policycap' on line 3:

policycap network_peer_controls;
./checkmodule:  error(s) encountered while parsing configuration

So I started playing around adding fprintf all over the place.  We are
hitting the lexer for policycaps but we are never hitting the stuff in
the yacc file.  So I looked at it and we have policycap_def listed under
te_rbac_decl.  Now I have no idea what a te_rbac_decl is but it seemed a
very odd name to have stuck this under.  I moved it under te_decl and
all of the sudden it stopped giving me that syntax error and started to
just tell me "open_perms" wasn't valid.  Which is fine, it isn't valid,
but at least we are getting network_peer_controls through the compiler
and bombing on something we should.

So, someone who know lex/yacc please review this patch, explain to me
why it was wrong, why this works and let us all know what actually
should be the fix...

Thanks
-Eric 'doesn't know squat about the tool chain' Paris

diff -Naupr checkpolicy-2.0.9/Makefile checkpolicy-2.0.9.new/Makefile
--- checkpolicy-2.0.9/Makefile	2008-02-04 12:19:31.000000000 -0500
+++ checkpolicy-2.0.9.new/Makefile	2008-02-27 12:46:08.000000000 -0500
@@ -10,7 +10,7 @@ TARGETS = checkpolicy checkmodule
 
 YACC = bison -y
 
-CFLAGS ?= -g -Wall -Werror -O2 -pipe -fno-strict-aliasing
+CFLAGS ?= -g -Wall -O2 -pipe -fno-strict-aliasing
 
 override CFLAGS += -I. -I${INCLUDEDIR}
 
diff -Naupr checkpolicy-2.0.9/policy_parse.y checkpolicy-2.0.9.new/policy_parse.y
--- checkpolicy-2.0.9/policy_parse.y	2008-02-04 12:19:31.000000000 -0500
+++ checkpolicy-2.0.9.new/policy_parse.y	2008-02-27 12:46:22.000000000 -0500
@@ -311,7 +311,6 @@ te_rbac_decl		: te_decl
 			| rbac_decl
                         | cond_stmt_def
 			| optional_block
-			| policycap_def
 			| ';'
                         ;
 rbac_decl		: role_type_def
@@ -327,6 +326,7 @@ te_decl			: attribute_def
                         | transition_def
                         | range_trans_def
                         | te_avtab_def
+			| policycap_def
 			;
 attribute_def           : ATTRIBUTE identifier ';'
                         { if (define_attrib()) return -1;}



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
