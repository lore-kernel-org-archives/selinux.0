MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: setting up new test user domain?
Date: Wed, 19 Dec 2001 13:18:14 -0600
Message-ID: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F3893@amcw2ms812.amc.ds.af.mil>
From: "Flood Randy Capt AFCA/TCAA" <randy.flood@scott.af.mil>
To: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


But, under certain circumstances, chrooted jails can be broken out of.
Right?  

For example, see:

http://www.bpfh.net/simes/computing/chroot-break.html

Is this information dated?  Is chroot really more reliable now?  Isn't
the whole concept of type enforcement to give an additional layer of
security in such cases?  



-----Original Message-----
From: Gary Lowder [mailto:gary@lowder.com]
Sent: Wednesday, December 19, 2001 11:56 AM
To: SELinux@tycho.nsa.gov
Subject: Re: setting up new test user domain?


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
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
