Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA17804
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2001 11:13:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA00387
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2001 15:13:25 GMT
Received: from johnny-cash.uhmc.sunysb.edu (johnny-cash.uhmc.sunysb.edu [129.49.145.145])
	by jazzband.ncsc.mil  with ESMTP id PAA00383
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2001 15:13:25 GMT
Received: from uhmc-chalfont.epo.som.sunysb.edu (laptop.anesthes.sunysb.edu [129.49.151.192])
	by johnny-cash.uhmc.sunysb.edu (8.10.2/8.10.2) with ESMTP id f3IFDWS18515
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2001 11:13:32 -0400 (EDT)
Message-Id: <5.0.2.1.0.20010418111107.00a8fec0@informatics.informatics.sunysb.edu>
Date: Wed, 18 Apr 2001 11:13:37 -0400
To: selinux@tycho.nsa.gov
From: "John S. Gage" <jgage@epo.som.sunysb.edu>
Subject: Re: security enhancements outside of flask model
In-Reply-To: <Pine.SOL.3.95.1010417131729.15065d-100000@clipper.gw.tisla
 bs.com>
References: <LMEJJDOADCLJPCBCJHFKMEIMCAAA.bernstein.46@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
>The document available at http://www.nsa.gov/selinux/slinux-abs.html
>describes the current set of controls provided by SELinux.

Here is a response to the above from an anonymous source (not me):

"What surprises me sometimes is that this is all old news, stuff I heard
years ago from Farber and Crocker and the other Arpanet buzzards, as they
call themselves. But somehow our OSes never seem to end up with this nice
stuff inside, and the buzzards got sick of tilting at windmills, and they
all know the Orange book is a joke anyway. So they gave up. So, here we
are in the year 2001, and we have more and more programs on our OSes that
use the setuid bit, and many NT users have admin priveleges cause it's
such a headache to work with NT otherwise. ACK!

Anyway, I can't say I saw anything new or that people haven't known for at
least 25 years. I guess the main point is that we're much more vulnerable
than ever, because a lot of naive code out there thinks you can get
security without a secure OS (e.g. Java). But for whatever reason, we
don't build things this way, even though we know about it. The mandatory
security they speak of is nice, but if you talk to anyone who's had to run
these things you'll find it's an amazing lot of work to administer even
one machine. Maybe the problem is not that people don't care, but the
"fine grained access" and "type enforcement" is so hard to set up, so hard
to keep set up, and so easy to screw up, that people just don't want to
deal with it.

For the record, the first secure Unix (at least I know of) was done by IBM
Federal about 20 years ago -- I think it was "secure Xenix". A friend
worked on it. They once decided to turn on all the logging to see what
would happen on an idle system. They went to lunch. They got back and
found a 2 MB syslog, one hour later. How do you figure out what happened?
How do you tell, somewhere in 2 MB of log, if there's something going
wrong?

They're certainly right about Java though. That security is not in the
right place, and will always be insecure.

Anyway, just my two cents on this paper, they have a good point, but
they're pushing the Same Old Stuff, and I think we need some Different New
Stuff instead. It's not like the Same Old Stuff wasn't tried; it was. It
proved to be very, very hard to admin correctly."

This last point about extreme administration difficulty should probably be 
addressed by NSA people on this list.

John



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
