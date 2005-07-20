Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6KIscgA019571
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 14:54:38 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6KInO9b017764
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 18:49:24 GMT
Subject: Re: SElinux nss/nscd service
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, selinux@tycho.nsa.gov,
   dwalsh@redhat.com
In-Reply-To: <20050720113015.GO8851@lkcl.net>
References: <1121794572.4780.15.camel@celtics.boston.redhat.com>
	 <200507191825.j6JIPsvx013481@gotham.columbia.tresys.com>
	 <20050719215424.GA8851@lkcl.net>
	 <1121815377.15541.15.camel@localhost.localdomain>
	 <20050720095524.GK8851@lkcl.net>
	 <1121857492.24646.21.camel@localhost.localdomain>
	 <20050720113015.GO8851@lkcl.net>
Content-Type: text/plain
Date: Wed, 20 Jul 2005 14:52:21 -0400
Message-Id: <1121885541.29587.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > Pam modules are for authentication and login issues. 
> > This mapping is used for other purposes as well, and also needs to 
> > be modified from multiple programs and/or shared libraries, which should
> > not replicate the necessary code.
> 
>  then you almost undoubtedly need something like winbindd in
>  order to "centralise" the management of the security "classes",

Management can be centralized just fine with a shared library.

>  and to provide a simple RPC mechanism for communicating over a unix
>  domain socket (or other IPC mechanism - but _please_ don't put dbus
>  on the list of options to explore).

RPC? Before we write something incredibly complex here, please
remember that at the present time we only support flat files,
and we don't even support those very well. Sure, we'd like
that to change, but I'm not sure such extra complexity is 
warranted at the present time.

>  aside from anything, as long as you get the simple RPC
>  mechanism correct and well-defined, you can CHANGE the
>  implementation [of selinux "classes"] behind the RPC mechanism -
>  and it's _not going to matter_.

I think that's true for any well-defined API, regardless
of whether it's a daemon or a shared library.

I also have my doubts about whether we can set an API
in stone and never change it, regardless of where it's placed.
I think that's probably not going to work, and we should
not overdesign things yet. 

>  before you go criticising the reasons why i recommended a
>  winbindd-like solution, can i invite you to examine its source
>  code (or better yet the nss_winbindd source code because it's
>  simpler) and also ask questions about why winbindd was created?

Ok. Why was winbindd created? 

>  aside from anything, a second [and more importantly, redhat-funded]
>  person examining a solution recommended by an external source [who
>  isn't funded to work on selinux] means that this proposed area to
>  explore can be properly evaluated: it might _not_ be a good way
>  forward.

I am confused by this statement - does not quite parse...

>  all i can say is that winbindd in combination with its nsswitch
>  and pam service works _extremely_ well at providing "the holy
>  grail" single-sign-on, in a mixed NT and Unix environment.

That's great, but we're not doing single-sign-on authentication.

The primary question I have is - why should we have a daemon that runs
in the background, when we currently have very few callers that will
be using it, and at particularly rare circumstances (when you're
administering user accounts). So, what's the justification
for using up system resources with a daemon program. 

I see this issue largely equivalent to libuser - we should
do the same thing that libuser does, and put it in libsemanage
(or another library, but not glibc yet).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
