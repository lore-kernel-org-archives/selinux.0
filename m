Subject: RE: How should I run genfscon in my module?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Dawid Gajownik <gajownik@gmail.com>,
        fedora-selinux-list@redhat.com, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158851492D@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158851492D@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 11:09:35 -0500
Message-Id: <1162397375.29617.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-01 at 10:27 -0500, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > 
> > > > I looked at fixing this by changing genfscon to use 
> > user_identifier 
> > > > instead of identifier (they are the same except user_identifier 
> > > > includes "-"). This made checkpolicy generate a syntax 
> > error for all 
> > > > genfscon statements - haven't tracked down what the 
> > problem is. The 
> > > > grammer still seems to be unambiguous.
> > > 
> > > Use "user_id" instead.  Otherwise, you'll get a syntax 
> > error when the 
> > > token is classified as an IDENTIFIER (first match) and the grammar 
> > > says that it must be a USER_IDENTIFIER.
> > 
> > Right as usual.
> > 
> 
> Maybe make user_id more generic as it is no longer only used for users..

Just making generic would make the user related parts of the grammar
harder to read. What about this:

Index: trunk/checkpolicy/policy_parse.y
===================================================================
--- trunk/checkpolicy/policy_parse.y	(revision 2076)
+++ trunk/checkpolicy/policy_parse.y	(working copy)
@@ -605,6 +605,8 @@
 			;
 user_id			: identifier
 			| user_identifier
+                        ;
+dash_id                 : user_id
 			;
 user_def		: USER user_id ROLES names opt_mls_user ';'
 	                {if (define_user()) return -1;}
@@ -679,11 +681,11 @@
 genfs_contexts          : genfs_context_def
                         | genfs_contexts genfs_context_def
                         ;
-genfs_context_def	: GENFSCON identifier path '-' identifier security_context_def
+genfs_context_def	: GENFSCON dash_id path '-' identifier security_context_def
 			{if (define_genfs_context(1)) return -1;}
-			| GENFSCON identifier path '-' '-' {insert_id("-", 0);} security_context_def
+			| GENFSCON dash_id path '-' '-' {insert_id("-", 0);} security_context_def
 			{if (define_genfs_context(1)) return -1;}
-                        | GENFSCON identifier path security_context_def
+                        | GENFSCON dash_id path security_context_def
 			{if (define_genfs_context(0)) return -1;}
 			;
 ipv4_addr_def		: number '.' number '.' number '.' number


Signed-off by: Karl MacMillan <kmacmillan@mentalrootkit.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
