Date: Fri, 25 Apr 2003 00:36:14 -0400
From: Dave Dodge <dododge@alpha.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: dododge@alpha.ncsc.mil
Subject: Re: portability patch for char signedness
Message-Id: <20030425003614.6eced04c.dododge@alpha.ncsc.mil>
In-Reply-To: <200304241311.25169.russell@coker.com.au>
References: <200304141459.54596.russell@coker.com.au>
	<20030423180107.79a79184.dododge@alpha.ncsc.mil>
	<200304241311.25169.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Apr 2003 13:11:25 +1000
Russell Coker <russell@coker.com.au> wrote:
> On Thu, 24 Apr 2003 08:01, Dave Dodge wrote:
> > > +  int c_int;
[...]
> > > +    switch ((char)c_int) {
> >
> > A slightly simpler fix is to just change the type of "c" to int
> > without renaming or casting. "getopt" returns an int, all of
> > the case statements are ints, and "c" is not used in any other
> > context.
>
> [...] it's generally considered to be a good idea 
> to have a longer name that can be searched for more easily.

Good point. In that case perhaps it should be renamed something like
"optletter". I'd still leave out the cast to char.

                                           -Dave Dodge/dododge@alpha.ncsc.mil

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
