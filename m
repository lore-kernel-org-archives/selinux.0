Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8ULF9rT027209
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 17:15:09 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8ULE0ng013032
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 21:14:04 GMT
Message-Id: <200409302114.i8ULEuSf031983@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <russell@coker.com.au>
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>,
   "'Selinux-Dev'" <selinux-dev@tresys.com>
Subject: RE: apol suggestions
Date: Thu, 30 Sep 2004 17:14:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200410010559.28332.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au]
> Sent: Thursday, September 30, 2004 3:59 PM
> To: Karl MacMillan
> Cc: 'SE Linux'; 'Selinux-Dev'
> Subject: Re: apol suggestions
> 
> 
> > > Also is a batch interface to apol planned?  I would like to have
> > > #!/usr/sbin/apol at the start of scripts...
> >
> > I agree and this is something that we are actively working on. The first
> > step will be the creation of a higher level language for stating
> > information flow properties and checking whether a policy exhibits those
> > properties. This is useful for regression testing a policy for example.
> 
> Yes, that's the idea.
> 
> > As far a general scripting interface, I'm not certain if or when that
> might
> > happen. For the time being it is possible to write fairly short C
> programs
> > that link to libapol. The libapol interface, though not well documented,
> > will allow you to do any of the analysis that is possible with apol. See
> > the test directory in the setools package to get some ideas.
> 
> OK, but I don't want to write C programs to do policy analysis.  Some
> people
> who want to analyse policy may not even know C.
> 

I know, but that is the interface that is available now. Also, I think that
people are more likely to want an easy to use special purpose language than
a general language binding for libapol. Libapol reflects the complexities of
the policy fairly directly and gives back lots of information - not
necessarily what a policy analyst wants to think about. How about this - as
you run into cases where you really want a scripting interface let me know
the details so I can get a better idea of the types of things you are
wanting to do. 

> > > My search of shadow_t access showed that there are 12 domains granted
> > > access
> > > directly and 9 granted through posession of the "auth" attribute.
> Even
> > > when
> > > two lists are so small it's difficult to determine which entries
> overlap
> > > (especially when they can't both be fully displayed on the screen at
> the
> > > same
> > > time).  If the "Type Enforcement Rules Display" box could be made to
> fill
> > > the
> > > entire screen then it would be a little easier for some analysis
> tasks.
> >
> > It is not entirely obvious so I'm not certain whether you noticed, but
> you
> > can resize the display, though not to take up the entire display. I
> think
> 
> I noticed.  But on a 1024x768 display the maximum size that I could make
> it
> was not adequate for my needs.  I think that there are few people who have
> displays large enough to get the viewing area that they are likely to
> desire
> for this.  I doubt that any laptop on the market is really up to it.
> 

I agree, but there is a limit to what we can do. We will continue to try to
keep space efficiency in mind.

> > the best option might be allow the result tabs to be detached. We'll see
> 
> Sounds good.
> 
> > > Also
> > > if there was some way of displaying the domains that can do the access
> > > through the auth attribute as well as through direct policy rules in
> the
> > > one
> > > list then it would solve this entire problem for me.
> >
> > Checking "include indirect matches" will do this and the information
> flow
> > analysis does this by default.
> 
> (3120) allow  auth  shadow_t : file  { getattr read };
> (65452) allow  anaconda_t  file_type : { dir file lnk_file sock_file
> fifo_file
> chr_file blk_file } * ;
> 
> Above is part of the results of a policy analysis.  I searched on "read"
> and
> "write" access to "file" class of type shadow_t.  When I didn't select
> "Include Indirect Matches" the anaconda_t entry was not included in the
> results.
> 
> However what I am really after is to have a list of what matches the
> attribute
> "auth" which seems to be impossible under setools 1.4.1.  Something like
> "Include Indirect Matches" for the source context would solve this (the
> button is there but it's always disabled).
> 

OK - I understand. Include indirect matches is disabled when attrib is
checked, but it shouldn't be - what you want is to see all the rules that
reference auth or any type in auth in the source type. I'll add this to the
todo list as well.

Just another plug for the information flow analysis - if you had have used
direct information flow analysis you would have seen all of the types that
can read/write shadow_t directly, without having to worry about specific
permissions or attributes.

> > Thanks for the feedback,
> 
> This is only the beginning, I'll be using apol a lot in the near future...
> ;)
> 

Great - I'm glad to hear that you will be using apol. We always try to
respond to suggestions as much as our resources and internal priorities
allow.

Karl

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
