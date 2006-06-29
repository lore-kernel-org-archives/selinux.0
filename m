MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] remove te rule conflict checking from parser
Date: Thu, 29 Jun 2006 12:37:43 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015882980C6@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Thu, 2006-06-29 at 12:22 -0400, Stephen Smalley wrote:
> > On Wed, 2006-06-28 at 16:40 -0400, Joshua Brindle wrote:
> > > This patch removes the te rule conflict checking from the parser.
> > > Duplicate te rules in different scopes (eg., conditional and
> > > unconditional) are now fatal and the parser doesn't have enough 
> > > information to know if the te rules have the same conditional 
> > > expression if they are in different optional blocks. The expander 
> > > correctly checks for te rule duplicates and conflicts; 
> unfortunately 
> > > this means the errors can't be caught until link/expand time (the 
> > > base gets linked and expanded during compilation for 
> validation) and 
> > > can't be caught at all in modules until they are linked in.
> > 
> > Manually adding a duplicate TE rule to my policy.conf and 
> rebuilding 
> > with this patch applied to checkpolicy:
> > 
> > $ grep 'type_transition initrc_t acct_exec_t' policy.conf
> >         type_transition initrc_t acct_exec_t:process acct_t;
> >         type_transition initrc_t acct_exec_t:process acct_t; $ make 
> > Compiling refpolicy policy.20 /usr/bin/checkpolicy -M 
> policy.conf -o 
> > policy.20
> > /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> > /usr/bin/checkpolicy:  policy configuration loaded
> > /usr/bin/checkpolicy:  writing binary representation 
> (version 20) to 
> > policy.20
> > 
> > Appears to have silently dropped the duplicate from the output.
> 
> Actually, I suppose that isn't new to this patch.
> 

Are those duplicates in the same scope? If so they are correctly being
dropped silently (they are just redundant), if they are in different
scopes a dupe is fatal. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
