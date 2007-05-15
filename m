Subject: Re: [BUG] Segfault on duplicate require of sensitivity
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Caleb Case <ccase@tresys.com>
Cc: B Topscher <bryan@jennandbryan.com>, selinux@tycho.nsa.gov,
        dgoeddel@TrustedCS.com, method@manicmethod.com,
        Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1179238573.25191.24.camel@localhost>
References: <8b4cbe570704190829m67daa55di8c21a51408987b89@mail.gmail.com>
	 <1179238573.25191.24.camel@localhost>
Content-Type: text/plain
Date: Tue, 15 May 2007 10:39:33 -0400
Message-Id: <1179239973.5130.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-15 at 10:16 -0400, Caleb Case wrote:
> It turns out that level_datum_t is not defined as an actual datum:
> 

[...]

> 
> The options I see here are not good.  One option: the level_datum_t
> should be changed into a conforming *_datum_t and the fallout of this
> change handled in the rest of the code which expects to see a
> level_datum_t->level.  Second option: level_datum_t is treated specially
> in require_symbol (using the symbol_type as the switch).
> 

Making it a _datum_t seems to be the right choice - what is your concern
about following that path?

Karl

> On Thu, 2007-04-19 at 11:29 -0400, B Topscher wrote:
> > When I have sensitivity required in two different locations I get
> > segmentation faults when I try and load the module.  For example,
> > because s0 and s15 are already declared on other files if I require
> > them in the TE file I get a segfault.  I looked in the module.tmp file
> > that was created on build and saw that s0 and s15 are declared
> > somewhere.  However, if I comment out my require in the TE file it
> > loads the module fine.  
> > 
> > 
> > if in the TE I have:
> > 
> > require { 
> >       sensitivity s0;
> > }
> > 
> > function( domain_t )
> > 
> > and the IF I have 
> > 
> > interface(`function',`
> >               gen_require(`
> >                           sensitivity s0;
> >                           ') 
> >               .......
> > ')
> > 
> > When I build and then semodule -i module.pp,  I get a segfault when
> > committing changes (according to semodule -v).  
> > 
> > Thank you
> > Bryan 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
