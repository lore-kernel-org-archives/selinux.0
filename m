Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UJxYrT026438
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 15:59:35 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UJwQng008154
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 19:58:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Karl MacMillan" <kmacmillan@tresys.com>
Subject: Re: apol suggestions
Date: Fri, 1 Oct 2004 05:59:28 +1000
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>,
   "'Selinux-Dev'" <selinux-dev@tresys.com>
References: <200409301650.i8UGo4Sf029987@gotham.columbia.tresys.com>
In-Reply-To: <200409301650.i8UGo4Sf029987@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410010559.28332.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Oct 2004 02:50, "Karl MacMillan" <kmacmillan@tresys.com> wrote:
> > Note that I didn't put getattr in the read group because often getattr
> > access
> > is granted just to quiet ls or to satisfy other checks when no other read
> > access is granted.  We can't rely on people selecting 10 items correctly
> > from
> > a list if performing repetitive operations.
>
> The best interface might be to allow users to create their own groupings of
> permissions named whatever they want, because as you point out the
> semantics are not always clear or universally applicable. For the overt

Good point.

However having some default values such as the ones I suggested would be good.  
Also a ~/.apol configuration directory for these things would be handy.

> information flow search you are doing, excluding getattr certainly seems
> appropriate because you are only concerned about the flow of the data
> contained in the file. For other situations that might be less appropriate,
> and providing a canned grouping for users might lead them to inappropriate
> conclusions. I'll add this to the todo list.

Thanks.

> It seems that you are using the plain rule search - any reason you are not
> using one of the information flow analysis modules? The query you seem to
> be doing is really a direct information flow analysis, which has a very
> nice interface (the permission map editor) for specifying what is a read or

I haven't got to working with that area of functionality.  I'll have to look 
at it.

> > Also is a batch interface to apol planned?  I would like to have
> > #!/usr/sbin/apol at the start of scripts...
>
> I agree and this is something that we are actively working on. The first
> step will be the creation of a higher level language for stating
> information flow properties and checking whether a policy exhibits those
> properties. This is useful for regression testing a policy for example.

Yes, that's the idea.

> As far a general scripting interface, I'm not certain if or when that might
> happen. For the time being it is possible to write fairly short C programs
> that link to libapol. The libapol interface, though not well documented,
> will allow you to do any of the analysis that is possible with apol. See
> the test directory in the setools package to get some ideas.

OK, but I don't want to write C programs to do policy analysis.  Some people 
who want to analyse policy may not even know C.

> > My search of shadow_t access showed that there are 12 domains granted
> > access
> > directly and 9 granted through posession of the "auth" attribute.  Even
> > when
> > two lists are so small it's difficult to determine which entries overlap
> > (especially when they can't both be fully displayed on the screen at the
> > same
> > time).  If the "Type Enforcement Rules Display" box could be made to fill
> > the
> > entire screen then it would be a little easier for some analysis tasks.
>
> It is not entirely obvious so I'm not certain whether you noticed, but you
> can resize the display, though not to take up the entire display. I think

I noticed.  But on a 1024x768 display the maximum size that I could make it 
was not adequate for my needs.  I think that there are few people who have 
displays large enough to get the viewing area that they are likely to desire 
for this.  I doubt that any laptop on the market is really up to it.

> the best option might be allow the result tabs to be detached. We'll see

Sounds good.

> > Also
> > if there was some way of displaying the domains that can do the access
> > through the auth attribute as well as through direct policy rules in the
> > one
> > list then it would solve this entire problem for me.
>
> Checking "include indirect matches" will do this and the information flow
> analysis does this by default.

(3120) allow  auth  shadow_t : file  { getattr read }; 
(65452) allow  anaconda_t  file_type : { dir file lnk_file sock_file fifo_file 
chr_file blk_file } * ; 

Above is part of the results of a policy analysis.  I searched on "read" and 
"write" access to "file" class of type shadow_t.  When I didn't select 
"Include Indirect Matches" the anaconda_t entry was not included in the 
results.

However what I am really after is to have a list of what matches the attribute 
"auth" which seems to be impossible under setools 1.4.1.  Something like 
"Include Indirect Matches" for the source context would solve this (the 
button is there but it's always disabled).

> Thanks for the feedback,

This is only the beginning, I'll be using apol a lot in the near future...  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
