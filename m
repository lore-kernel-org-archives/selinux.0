Subject: Re: [BUG] Segfault on duplicate require of sensitivity
From: Caleb Case <ccase@tresys.com>
To: B Topscher <bryan@jennandbryan.com>
Cc: selinux@tycho.nsa.gov, dgoeddel@TrustedCS.com, method@manicmethod.com,
        Stephen Smalley <sds@tycho.nsa.gov>, kmacmillan@mentalrootkit.com
In-Reply-To: <8b4cbe570704190829m67daa55di8c21a51408987b89@mail.gmail.com>
References: <8b4cbe570704190829m67daa55di8c21a51408987b89@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 15 May 2007 10:16:13 -0400
Message-Id: <1179238573.25191.24.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It turns out that level_datum_t is not defined as an actual datum:

/* Sensitivity attributes */
typedef struct level_datum {
        mls_level_t *level;     /* sensitivity and associated categories
*/
        unsigned char isalias;  /* is this sensitivity an alias for
another? */
        unsigned char defined;
} level_datum_t;

All *_datum_t should have the form:

typedef struct *_datum {
        symtab_datum_t s;
        *
} *_datum_t;

This assumption causes problems in module_compiler.c:require_symbol when
the symbol is a duplicate (retval == 1 means duplicate symbol):

int require_symbol(uint32_t symbol_type,
                   hashtab_key_t key, hashtab_datum_t datum,
                   uint32_t * dest_value, uint32_t * datum_value)
{

<snip>

        if (retval == 1) {
                symtab_datum_t *s =
                    (symtab_datum_t *) hashtab_search(policydbp->

symtab[symbol_type].table,
                                                      key);
                assert(s != NULL);
                *dest_value = s->value;
        } else if (retval == -2) {

<snip>

}

Which results in *dest_value being the address of level_datum->level and
not the value of the sens (which would be level_datum->level->sens.  See
module_compiler.c:require_sens for more context.

The options I see here are not good.  One option: the level_datum_t
should be changed into a conforming *_datum_t and the fallout of this
change handled in the rest of the code which expects to see a
level_datum_t->level.  Second option: level_datum_t is treated specially
in require_symbol (using the symbol_type as the switch).

On Thu, 2007-04-19 at 11:29 -0400, B Topscher wrote:
> When I have sensitivity required in two different locations I get
> segmentation faults when I try and load the module.  For example,
> because s0 and s15 are already declared on other files if I require
> them in the TE file I get a segfault.  I looked in the module.tmp file
> that was created on build and saw that s0 and s15 are declared
> somewhere.  However, if I comment out my require in the TE file it
> loads the module fine.  
> 
> 
> if in the TE I have:
> 
> require { 
>       sensitivity s0;
> }
> 
> function( domain_t )
> 
> and the IF I have 
> 
> interface(`function',`
>               gen_require(`
>                           sensitivity s0;
>                           ') 
>               .......
> ')
> 
> When I build and then semodule -i module.pp,  I get a segfault when
> committing changes (according to semodule -v).  
> 
> Thank you
> Bryan 
-- 
Caleb Case
Tresys Technology
410-290-1411 x144

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
