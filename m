From: lonnie@outstep.com
To: Gary Lowder <gary@lowder.com>
Subject: Re: setting up new test user domain?
Message-ID: <1008796100.3c2101c42a177@mail.outstep.com>
Date: Wed, 19 Dec 2001 16:08:20 -0500 (EST)
Cc: SELinux@tycho.nsa.gov
References: <Pine.GSO.4.33.0112190955150.5056-100000@raven> <3C20D492.10504@lowder.com>
In-Reply-To: <3C20D492.10504@lowder.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Gary,

One of the main problems that we have found while investigating the "chroot" 
options was that when the system is running in "init 5" (graphical xwindows) 
and the chrooted program is in place then the user cannot move out of their 
directory from a shell. This also work great for "init 3" (text mode).

The fundamental problem is when you start an application once your window 
manager such as kde has been started. If you start Netscape, or OpenOffice for 
example the the user is free to navigate all over the system and effectively 
breaks out of the 'chrooted' environment.

this is why we have been looking to do it from many other possible directions 
although there does not seem to be any easy method for this.

Cheers,
Lonnie

Quoting Gary Lowder <gary@lowder.com>:

> Lonnie,
> 
> I hate to completely change the direction you're headed but...
> Based on what you've said earlier about what you want to accomplish, it
> 
> seems a chroot jail is what you want for your users.  Why reinvent the
> 
> wheel?  Of course you can beat SELinux into doing what you're asking, 
> but that's not really what it was designed to directly accomplish.
> 
> Largo, Florida, implemented a linux system for it's municipality workers
> 
> to use.  A base link off of which you might find lots of useful 
> information is:  http://www.consultingtimes.com/Largo.html
> He didn't do exactly what you're talking about, but it's not far off.
> 
> Where I would actually start, is a site to help explain and set up a 
> chroot jail, one of I'm sure many sites is: 
> http://www.gsyc.inf.uc3m.es/~assman/jail/1.html
> 
> I'm sure there are others out there.
> 
> With a large enough hammer it is entirely possible to beat a square peg
> 
> into a round hole, but it's much easier to just find the round peg.
> 
> Hope this helps you accomplish your objectives.
> 
> Gary.
> 
> 
> 
> --
> You have received this message because you are subscribed to the selinux
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
