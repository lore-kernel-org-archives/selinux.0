Message-ID: <5272691D.3020503@tycho.nsa.gov>
Date: Thu, 31 Oct 2013 10:28:45 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Subject: Re: SELinux: Update policy version to support constraints info
References: <1382398322.27942.61.camel@localhost> <52716BC7.5070005@tycho.nsa.gov> <1383228520.10830.YahooMailNeo@web87902.mail.ir2.yahoo.com>
In-Reply-To: <1383228520.10830.YahooMailNeo@web87902.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/31/2013 10:08 AM, Richard Haines wrote:
> Here is my go at another kernel patch. I've done most of what you asked
> except I could not work out this  comment:
> 
> "Couldn't we avoid the need for passing down the policydb and checking
> the version just by ensuring e->type_names gets initialized to NULL and
> then the type_set_destroy() and kfree() calls degenerate to no-ops?  I
> suppose this works, but it complicates the code a bit."

In the prior patch, you changed cls_destroy() to extract the policydb
from the void* argument and check the p->policyvers to decide whether or
not to free e->type_names.  I pointed out that if you always initialize
it to NULL (which I think you get for free by virtue of the kazalloc of
the constraint_expr), then you can unconditionally free it.  In this
patch, it appears you switched to unconditionally calling
constraint_expr_destroy() but you still have the change to pass p
(policydb) to the hashtab_map(p->symtab[i].table, destroy_f[i], p);
Which I don't believe you need anymore.  Right?  That was my point.

You can abbreviate if (a != NULL) as if (a).

./scripts/checkpatch.pl has some complaints about your line lengths.
Those aren't mandatory but consider whether you can fix them without
making the code ugly.

Try to post the patch in a fresh message with the patch inlined if
possible or send directly via git-send-email for easier commenting
inline and application.







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
