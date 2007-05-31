Subject: Re: [BUG] Segfault on duplicate require of sensitivity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        B Topscher <bryan@jennandbryan.com>, selinux@tycho.nsa.gov,
        dgoeddel@TrustedCS.com
In-Reply-To: <1180113976.20054.5.camel@localhost>
References: <8b4cbe570704190829m67daa55di8c21a51408987b89@mail.gmail.com>
	 <1179238573.25191.24.camel@localhost>
	 <1179239973.5130.9.camel@localhost.localdomain>
	 <1179248956.25191.41.camel@localhost>  <4649EB49.1070302@manicmethod.com>
	 <1180113976.20054.5.camel@localhost>
Content-Type: text/plain
Date: Thu, 31 May 2007 14:25:44 -0400
Message-Id: <1180635944.3340.330.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-25 at 13:26 -0400, Caleb Case wrote:
> On Tue, 2007-05-15 at 13:18 -0400, Joshua Brindle wrote:
> > Caleb Case wrote:
> > > On Tue, 2007-05-15 at 10:39 -0400, Karl MacMillan wrote:
> > >   
> > >> On Tue, 2007-05-15 at 10:16 -0400, Caleb Case wrote:
> > >>     
> > >>> It turns out that level_datum_t is not defined as an actual datum:
> > >>>
> > >>>       
> > >> [...]
> > >>
> > >>     
> > >>> The options I see here are not good.  One option: the level_datum_t
> > >>> should be changed into a conforming *_datum_t and the fallout of this
> > >>> change handled in the rest of the code which expects to see a
> > >>> level_datum_t->level.  Second option: level_datum_t is treated specially
> > >>> in require_symbol (using the symbol_type as the switch).
> > >>>
> > >>>       
> > >> Making it a _datum_t seems to be the right choice - what is your concern
> > >> about following that path?
> > >>
> > >> Karl
> > >>     
> > >
> > > Mainly I am concerned because level_datum_t is exported in libsepol's
> > > protected headers and will require changes to anything that statically
> > > links to libsepol.
> > >
> > >   
> > Err, I don't think this is the main issue. The level datum references 
> > the sens_datum, which exists independantly of the level_datum. I think 
> > it would cause all sorts of problems to try to change that in the 
> > current code base.
> > 
> > Another option is to just punt on this and it should be handled 
> > naturally in the policyrep branch.
> 
> This is option 2: special case the level_datum_t handling.
> 
> Index: checkpolicy/module_compiler.c
> ===================================================================
> --- checkpolicy/module_compiler.c	(revision 2421)
> +++ checkpolicy/module_compiler.c	(working copy)
> @@ -142,7 +142,12 @@
>  						      symtab[symbol_type].table,
>  						      key);
>  		assert(s != NULL);
> -		*dest_value = s->value;
> +		
> +		if (symbol_type == SYM_LEVELS) {
> +			*dest_value = ((level_datum_t *)s)->level->sens;
> +		} else {
> +			*dest_value = s->value;
> +		}
>  	} else if (retval == -2) {
>  		return -2;
>  	} else if (retval < 0) {
> @@ -496,7 +501,12 @@
>  						      symtab[symbol_type].table,
>  						      key);
>  		assert(s != NULL);
> -		*dest_value = s->value;
> +		
> +		if (symbol_type == SYM_LEVELS) {
> +			*dest_value = ((level_datum_t *)s)->level->sens;
> +		} else {
> +			*dest_value = s->value;
> +		}
>  	} else if (retval == -2) {
>  		/* ignore require statements if that symbol was
>  		 * previously declared and is in current scope */

I'm merging this patch, but it occurs to me that this doesn't fully
solve the bug - it ensures that checkmodule will generate a well-formed
module, but it is still the case that an ill-formed module can cause a
segfault in libsepol at module link time, right?  We should be properly
checking those values during module link in libsepol too.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
