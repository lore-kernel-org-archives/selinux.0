Subject: Re: How should I run genfscon in my module?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dawid Gajownik <gajownik@gmail.com>, Joshua Brindle <jbrindle@tresys.com>,
        fedora-selinux-list@redhat.com, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1162387933.32614.188.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885146CC@exchange.columbia.tresys.com>
	 <454509C2.7080008@gmail.com>
	 <1162316975.32614.146.camel@moss-spartans.epoch.ncsc.mil>
	 <1162331334.4147.6.camel@localhost.localdomain>
	 <1162387933.32614.188.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=utf-8
Date: Wed, 01 Nov 2006 10:21:54 -0500
Message-Id: <1162394514.29617.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-01 at 08:32 -0500, Stephen Smalley wrote:
> On Tue, 2006-10-31 at 16:48 -0500, Karl MacMillan wrote:
> > On Tue, 2006-10-31 at 12:49 -0500, Stephen Smalley wrote:
> > > On Sun, 2006-10-29 at 21:06 +0100, Dawid Gajownik wrote:
> > > > Dnia 10/29/2006 06:33 PM, Użytkownik Joshua Brindle napisał:
> > > > > Right, that's a hard fix I think, dashes aren't allowed in
> > > > > identifiers and they are treated specially for use in MLS ranges..
> > > > 
> > > > Oh, that's really bad :( Without that line files on ntfs-3g filesystem 
> > > > have unlabeled_t type and I would need to give to many privileges to 
> > > > mount_t domain.
> > > > 
> > > > So there is no hope to fix it in the clean way?
> > > 
> > > File it as a bug against checkpolicy.  
> > 
> > I looked at fixing this by changing genfscon to use user_identifier
> > instead of identifier (they are the same except user_identifier includes
> > "-"). This made checkpolicy generate a syntax error for all genfscon
> > statements - haven't tracked down what the problem is. The grammer still
> > seems to be unambiguous.
> 
> Use "user_id" instead.  Otherwise, you'll get a syntax error when the
> token is classified as an IDENTIFIER (first match) and the grammar says
> that it must be a USER_IDENTIFIER.  

Right as usual.

Index: trunk/checkpolicy/policy_parse.y
===================================================================
--- trunk/checkpolicy/policy_parse.y	(revision 2076)
+++ trunk/checkpolicy/policy_parse.y	(working copy)
@@ -679,11 +679,11 @@
 genfs_contexts          : genfs_context_def
                         | genfs_contexts genfs_context_def
                         ;
-genfs_context_def	: GENFSCON identifier path '-' identifier security_context_def
+genfs_context_def	: GENFSCON user_id path '-' identifier security_context_def
 			{if (define_genfs_context(1)) return -1;}
-			| GENFSCON identifier path '-' '-' {insert_id("-", 0);} security_context_def
+			| GENFSCON user_id path '-' '-' {insert_id("-", 0);} security_context_def
 			{if (define_genfs_context(1)) return -1;}
-                        | GENFSCON identifier path security_context_def
+                        | GENFSCON user_id path security_context_def
 			{if (define_genfs_context(0)) return -1;}
 			;
 ipv4_addr_def		: number '.' number '.' number '.' number


Signed-off by: Karl MacMillan <kmacmillan@mentalrootkit.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
