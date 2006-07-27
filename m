MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] clean up datum cast to uint32
Date: Thu, 27 Jul 2006 11:11:12 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832A8E7@exchange.columbia.tresys.com>
In-Reply-To: <44C8D444.5050305@mentalrootkit.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> Joshua Brindle wrote:
> >> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> >>     
> >
> > This has the same fragility that the uint32_t cast had since this 
> > struct has to be first,
> 
> Neither are fragile if the requirement is clearly documented. 
> Adding the struct just reinforces the requirement. The struct 
> layout on which both of these methods depend is clearly 
> guaranteed by the various C standards. The cast is completely 
> legal and safe.

Right, so was the uint32_t one, that doesn't mean it wasn't ugly.

> 
> >  also the way I did it is pretty standard in the library, 
> for example 
> > destroy_f[SYM_NUM]. And is intuitive, a simple function 
> call returns 
> > the value.
> >
> >
> >   
> 
> Indirection through function pointer tables is never 
> intuitive in my opinion. The struct more directly represents 
> the fact that all symtab datums have shared fields.
> 

Except the ones that don't, like level_datum_t. It sounds like you want
to go toward OO anyway, why not put all the function pointers inside the
structs val = foo_type->get_val()


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
