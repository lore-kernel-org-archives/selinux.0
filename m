Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NI6IgA029278
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 14:06:18 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NHuQNa004142
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 17:56:27 GMT
Message-Id: <200506231756.j5NHuGqc029984@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "=?iso-8859-1?Q?'Lorenzo_Hern=E1ndez_Garc=EDa-Hierro'?=" <lorenzo@gnu.org>
Cc: "'antoine'" <antoine@nagafix.co.uk>,
   "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
   "'Colin Walters'" <walters@verbum.org>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>
Subject: RE: ANN: SELinux Reference Policy Release
Date: Thu, 23 Jun 2005 13:56:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <1119407487.27105.93.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Lorenzo Hernández García-Hierro [mailto:lorenzo@gnu.org]
> Sent: Tuesday, June 21, 2005 10:31 PM
> To: Karl MacMillan
> Cc: 'antoine'; 'Christopher J. PeBenito'; 'Colin Walters'; 'SELinux Mail List'
> Subject: RE: ANN: SELinux Reference Policy Release
> 
> El mar, 21-06-2005 a las 21:47 -0400, Karl MacMillan escribió:
> > See below for my thoughts on the format. If you are interested in helping we
> > would be happy for any contributions. The sf cvs is updated nightly. We
> should
> > get what we view as the task list up on the website soon and welcome any
> > suggestions for what should be accomplished in the near or long term.
> 
> I will be glad to help during this summer for sure, just lemme know
> about the group of people going to work over it and we can try to
> organize a common schedule for it, as it seems a huge job which needs a
> well organized development and deployment process. (Well, some are
> getting paid for it ;) ).
> 
> The road-map in http://serefpolicy.sourceforge.net/ doesn't look
> meaningful to me though.
>

Ok - not certain what is not meaningful about the roadmap. I am working on a
more detailed schedule that I will post on the website.

 
> > I think that we can make this more readable without punting on the xml
> (which I
> > actually think is easier to read than the javadoc style @ tags). We are
> going to
> > trim down the XML to look more like:
> >
> > ##
> > ## <description>
> > ##	Allows the caller to get the mode of policy enforcement
> > ## </description>
> > ##
> > ## <param name="domain">
> > ## 	The process type to allow to get the enforcing mode.
> > ## </param>
> > ##
> 
> So, we strip out the '##', then parse each "chain" (should we
> concatenate it and thus making an only one XML file with the whole
> reference?), and then use the proper style-sheet to run the formatting?
> 
> It makes sense but a per-file basis approach would be more easy to
> deploy, anyways, more challenge, more fun.
> 

Not certain what you mean - the plan is to generate a single XML file that
represents the entire policy. From that point it can be manipulated however we
want. The current tool for generating the docs will continue to work with minor
changes to convert this to html.

> > That means that the interface name will be derived from the actual interface
> > declaration, which should probably be changed to a macro for declaring
> > interfaces. The final xml file that is output won't change, we will just
> > generate some of the tags. Thoughts?
> 
>  - for each file (.te, .fc, ...) we strip out the commented XML
>    - we dump it in a xml/dir/file.extension
>      - we concatenate each file.{fc, te, ...}
>       - we produce a single XML file
>         - we're done for parsing and doing any formatting on top of the
>           source XML file.
> 
> Though It's not the best time to think about it, will give it a further
> look later.
> 
> How it looks to you?
> 

Again - not certain what you mean. We are only processing .if files (interfaces)
to produce a single policy.xml file that has the information from each .if file.

> > Not yet - if you want the parsing code I can release it though.
> 
> It would be good to have all-in-place. With single, separated pieces we
> can't do it, either we have everything clear and well exposed in the
> proper place or we have nothing.
> 

Not to repeat myself, but I'm not certain what you are getting at. Is this a
request for the code to be released?

Thanks,

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> I'm new around this (the ref. policy) and also on the policy itself, I'm
> still not too familiar with it (hadn't enough time to deal with it
> properly), so, I may be wrong, then please give advice and I'll try to
> make it going smooth and straight forward ;).
> 
> Cheers,
> --
> Lorenzo Hernández García-Hierro <lorenzo@gnu.org>
> [1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
