Message-Id: <200509301347.j8UDlcYs007177@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Ivan Gyurdiev'" <ivg2@cornell.edu>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: RE: [PATCH] semanage-functionality 4/17
Date: Fri, 30 Sep 2005 09:47:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <433D377E.6090700@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Friday, September 30, 2005 9:03 AM
> To: Stephen Smalley
> Cc: Karl MacMillan; selinux@tycho.nsa.gov; 'Joshua Brindle'
> Subject: Re: [PATCH] semanage-functionality 4/17
> 
> 
> >Yes, and I'm dubious that such elimination is practically useful; you
> >still have to audit the code for correct usage and in any case where it
> >affects an exposed interface, you have the whole stable API/ABI issue to
> >deal with.
> >
> >
> Struct pointer typedefs eliminated in favor of consistency.  See patches.
> 
> >
> >
> >>Then we'll have to type struct everywhere...
> >>
> >>
> >
> >Yes, I see it as a benefit to be able to easily see from the code
> >whether a function (and the code) is dealing with a pointer or a struct
> >without needing to look up a separate type definition.  Think in terms
> >of long term code maintainability / readability, particularly for
> >patches.  Besides, typing "struct foobahblaz" isn't so much worse than
> >typing "foobahblaz_t".  The kernel maintainers are right on the issue of
> >typedefs...
> >
> >
> Todo. I am less excited about removing the _t types - I don't like
> typing struct... You can now see whether you are dealing with a pointer
> or struct...because there are no more pointer typedefs...so there's a
> star everywhere, meaning pointer. I'm not sure that was a good idea, but
> at least it's consistent, which is much better than being inconsistent
> (of course, we could have tried to go the other way instead too...).

I agree with Steve here - the more information the user of a type is aware
of the better. In my experience, typedef pointers just become confusing and
hard to maintain. Typedef's are useful when the type will change (e.g.,
uint23_t) but not to simply obscure type information.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
