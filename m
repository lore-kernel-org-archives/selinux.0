Message-ID: <3C20D492.10504@lowder.com>
Date: Wed, 19 Dec 2001 11:55:30 -0600
From: Gary Lowder <gary@lowder.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: setting up new test user domain?
References: <Pine.GSO.4.33.0112190955150.5056-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Lonnie,

I hate to completely change the direction you're headed but...
Based on what you've said earlier about what you want to accomplish, it 
seems a chroot jail is what you want for your users.  Why reinvent the 
wheel?  Of course you can beat SELinux into doing what you're asking, 
but that's not really what it was designed to directly accomplish.

Largo, Florida, implemented a linux system for it's municipality workers 
to use.  A base link off of which you might find lots of useful 
information is:  http://www.consultingtimes.com/Largo.html
He didn't do exactly what you're talking about, but it's not far off.

Where I would actually start, is a site to help explain and set up a 
chroot jail, one of I'm sure many sites is: 
http://www.gsyc.inf.uc3m.es/~assman/jail/1.html

I'm sure there are others out there.

With a large enough hammer it is entirely possible to beat a square peg 
into a round hole, but it's much easier to just find the round peg.

Hope this helps you accomplish your objectives.

Gary.



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
