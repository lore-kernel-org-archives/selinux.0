Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA25355
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 10:33:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA17175
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 15:33:21 GMT
Received: from bladestorm.com ([216.205.134.102])
	by jazzband.ncsc.mil  with ESMTP id PAA17171
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 15:33:21 GMT
Date: Fri,  9 Feb 2001 10:41:55 -0500
Message-Id: <200102091041.AA654180630@bladestorm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "paul " <paul@bladestorm.com>
Reply-To: <paul@bladestorm.com>
To: Dale Amon  <amon@vnl.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: Selinux kernel patches
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

I have seen a lot of these test and it is very hard to learn anything from these.  People have a lot of different definitions for "getting in" which usually includes "if you can't get into your own system then we win", meaning that you see a lot of things attack everything around the system, including the logging system and the routers, along with any firewalls or IDS system that might be present.

Yes, you learn, but what you often learn is not what you are looking to learn.  These kind of tests is like handing out 2,000 can openers to 2,000 15-year-olds and telling them to all be the first to open a can of pea soup.

The security community titans, such as Bruce Schneier, have constantly said that these kind of tests are just a publicity stunt and a waste of time.

If you want to see how good this is, set up a lab, eliminate variables such as someone attacking a border router, and have a few people that know what they are doing bang on the software internally and externally.  You will get much better results and something you can analyze right away.


---------- Original Message ----------------------------------
From: Dale Amon <amon@vnl.com>
Date: Fri, 9 Feb 2001 15:22:25 +0000

>On Fri, Feb 09, 2001 at 10:14:09AM -0500, paul  wrote:
>> These kind of shows never real mount to anything since the "hackers" 
>> will typically attack everything around the box as well, including 
>> the routers.  Besides, these things are more of a publicity stunt 
>> than a bona fide test of the operating system.
>> 
>
>PR or not, if someone does get in, you have learned something. And
>the reason I said "external" for the test was that very reason. I'd
>not want the machine under test to be anywhere *near* anything that
>was really important.
>
>> Our company is working with the findings here and integrating them 
>> into our own distribution, and our plan is to basically bang on it 
>> as much as we can in-house and then bite the bullet and put it out, 
>> patching and upgrading as problems are exposed.
>> 
>
>Which comes down to the resources you have as a company, or
>that I have as a company. I don't think it is such a bad
>idea to have some more impersonal baseline outside of
>ourselves.
>
>At the end of the day, proving security is like proving
>aliens don't exist. If a flying saucer lands in London, you've 
>proven they do; but no matter how much you spend you can 
>never absolutely guarantee the negation. You can only 
>add 9's to your statistical confidence in that conclusion.
>
>-- 
>------------------------------------------------------
>Use Linux: A computer        Dale Amon, CEO/MD
>is a terrible thing          Village Networking Ltd
>to waste.                    Belfast, Northern Ireland
>------------------------------------------------------
>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
