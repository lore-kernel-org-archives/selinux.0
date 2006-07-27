Subject: Re: [PATCH] clean up datum cast to uint32
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <44C8CCC7.7030703@mentalrootkit.com>
References: <1153914526.19259.25.camel@twoface>
	 <44C8CCC7.7030703@mentalrootkit.com>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 10:35:17 -0400
Message-Id: <1154010917.27604.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-07-27 at 10:25 -0400, Karl MacMillan wrote:
> Joshua Brindle wrote:
> > This patch adds a function to get the symbol value from any datum passed
> > in given the symbol type (SYM_TYPE, SYM_ROLE, etc) and removes the
> > places where a datum was cast to uint32_t* to get the value.
> >
> >   
> 
> I like cleaning this up as that cast was not great. My concern with this 
> patch is that it forces information / functions about many types to be 
> forced into a single place. An alternative is to define a struct that 
> must be included first for all symtab datums, i.e.:
> 
> typedef struct symtab_datum {
>     uint32_t val;
> } symtab_datum_t
> 
> This would be included first in all datums for the symtabs:
> 
> typedef struct comman_datum {
>     symtab_datum_t s;
>     symtab_t permissions;
> }
> 
> This would allow all of the datums to be cast to symtab_datum_t and 
> avoid all of the stub functions for type safety (not to mention the 2 
> function calls required to get the value). That would also allow moving 
> some shared code for managing values into symtab.c/h.
> 
> I can work this patch up, I just wanted to get comments first because it 
> will be a large (but easy) change because of adding references to 
> datum->s.value instead of datum->value.
> 
> Thoughts?

Sounds good.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
