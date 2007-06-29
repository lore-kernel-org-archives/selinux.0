Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5TJRgwV010727
	for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2007 15:27:42 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5TJRKHt022882
	for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2007 19:27:20 GMT
Subject: Re: [PATCH] Initial policyrep patch v2
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46855B72.7050502@manicmethod.com>
References: <f71c0f396608e6e362ed.1183040619@localhost.localdomain>
	 <46855B72.7050502@manicmethod.com>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 15:26:30 -0400
Message-Id: <1183145190.12803.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-29 at 15:20 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > +	
> > +	AVRule* define_avrule(AVRule::Type type, IdSet* src_types,
> > +			      IdSet* tgt_types, IdSet* classes,
> > +			      IdSet* perms, Parser& driver)
> > +	{
> > +		AVRule* x = new AVRule(type);
> > +		
> > +		x->src_types().ids().insert(src_types->ids().begin(), src_types->ids().end());
> > +		x->src_types().set_compl(src_types->get_compl());
> > +		delete src_types;
> > +
> >   
> I don't see - (subtraction) handling here,

The ids are inserted with the "-" - e.g., "-foo_t".

>  also compliments are not 
> allowed in type sets for any rules except neverallows (which also allows 
> *),

Oh yeah - totally forgot.

>  also how do you handle * in permissions?
> 

They just show up as the string "*". Both * and - are simply deferred
for later processing. We can certainly discuss leaving these strings in
- it is simply how I did it in sepolgen. FWIW it worked pretty well
there and makes policy generation a bit easier. It makes this
representation almost purely syntactic.

The reason I pull out complement is because it is global to the set, but
I would be fine with sticking in "~" if people think that is more
consistent. Alternatively I could pull out * for the perms. Handling
subtraction specially requires that id's be something other than
std::string. That ends up being a real PITA because the stl doesn't
support inheritance (don't ask - it's better just to accept and move on
however irritating that is).

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
