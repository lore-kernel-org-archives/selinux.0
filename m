Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA19498
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 10:05:01 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA00471
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 15:04:02 GMT
Received: from fw2.amc.af.mil (amcuxfw802.amc.af.mil [131.9.254.188])
        by jazzband.ncsc.mil  with ESMTP id PAA00467 for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 15:04:02 GMT
Received: from fw2.amc.af.mil (root@localhost)
	by fw2.amc.af.mil with ESMTP id g1KF5oL26197
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 09:05:50 -0600 (CST)
Received: from amcw2av808.amc.ds.af.mil (amcw2av808.amc.af.mil [131.9.19.137])
	by fw2.amc.af.mil with SMTP id g1KF5hl25893
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 09:05:47 -0600 (CST)
Received: from amcw2ms872.amc.ds.af.mil ([131.9.19.110])
 by amcw2av808.amc.ds.af.mil (NAVGW 2.5.1.18) with SMTP id M2002022008555423158
 for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 08:55:54 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ftp long time connection
Date: Wed, 20 Feb 2002 08:55:50 -0600
Message-ID: <1BF4DDD78DDA5D4EB0769BEA7F158E5A011BB22E@amcw2ms812.amc.ds.af.mil>
From: "Flood Randy Capt AFCA/TCAA" <randy.flood@scott.af.mil>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Actually, even if you ftp or telnet to a machine using its ip address,
often times the client will nslookup the ip address.  Likewise, the
server will often do a reverse lookup on the client (for logging
purposes).  I have also seen this sort of behavior if you use host names
rather than ip addresses in /etc/hosts.allow and /etc/hosts.deny.  Try
fixing DNS and then see if you still have the problem.

   

-----Original Message-----
From: Ben McGinnes [mailto:ben-mcginnes@iname.com]
Sent: Wednesday, February 20, 2002 8:39 AM
To: selinux@tycho.nsa.gov
Cc: Flood Randy Capt AFCA/TCAA; Lonnie Cumberland
Subject: Re: ftp long time connection


Flood Randy Capt AFCA/TCAA(randy.flood@scott.af.mil)@Tue, Feb 19, 2002
at 01:55:17PM -0600:
> 
> Do you have reverse DNS entries for your server and client and is DNS
> configured correctly?
> 
> If DNS is not set up properly you can get results like that.

True, DNS errors will do that, as others here have pointed out.  The
original query, however, also mentioned that accessing the host directly
by its IP was attempted with the same results.  So while there may be
some 
DNS-related delays as well, it cannot be a complete explanation.  I also

doubt SE Linux is the cause here either since it's a fairly generic kind

of problem.

I'd try attempting other protocols such as SSH, telnet (if enabled),
SMTP 
and probably SCP too.  To both hostname and IP address.  See if it is 
affecting all protocols or just one or two, also try telnetting to the 
machine on port 21 and see exactly what point at which it slows to a
crawl 
or breaks.

Chances are the cause (and shortly thereafter, the solution) will leap
out 
during this process.


Regards,
Ben

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
