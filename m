Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA19435
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 10:00:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA18410
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 14:59:43 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id OAA18406
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 14:59:42 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A106C52C80@csoc-mail-box.csoconline.com>
From: "Walker, Jason" <Jason.Walker@csoconline.com>
To: "'Ben McGinnes'" <ben-mcginnes@iname.com>, selinux@tycho.nsa.gov
Cc: Flood Randy Capt AFCA/TCAA <randy.flood@scott.af.mil>,
        Lonnie Cumberland <lonnie@outstep.com>
Subject: RE: ftp long time connection
Date: Wed, 20 Feb 2002 09:00:42 -0600
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that the DNS configuration will affect ftp connections, even if the
client is trying to FTP to the IP address of the server.  

What they're talking about is the reverse DNS lookup, where the SERVER does
a reverse lookup on the address of the CLIENT to see who's trying to
connect, for logging and authentication purposes.  If the Server doesn't
know the name associated with the Client IP address, it will take some extra
time before the server gives up and simply logs the client IP address
instead of hostname.

Make sure that the client system is listed in DNS, that the server is using
the appropriate DNS server, or that the server has a HOSTS file listing the
client.  From the server, try doing an nslookup against the client IP
address and see if it correctly returns the client name.

Jason Walker
Lockheed Martin CSOC
(281) 218-2569


-----Original Message-----
From: Ben McGinnes [mailto:ben-mcginnes@iname.com]
Sent: Wednesday, February 20, 2002 8:39 AM
To: selinux@tycho.nsa.gov
Cc: Flood Randy Capt AFCA/TCAA; Lonnie Cumberland
Subject: Re: ftp long time connection


Flood Randy Capt AFCA/TCAA(randy.flood@scott.af.mil)@Tue, Feb 19, 2002 at
01:55:17PM -0600:
> 
> Do you have reverse DNS entries for your server and client and is DNS
> configured correctly?
> 
> If DNS is not set up properly you can get results like that.

True, DNS errors will do that, as others here have pointed out.  The
original query, however, also mentioned that accessing the host directly
by its IP was attempted with the same results.  So while there may be some 
DNS-related delays as well, it cannot be a complete explanation.  I also 
doubt SE Linux is the cause here either since it's a fairly generic kind 
of problem.

I'd try attempting other protocols such as SSH, telnet (if enabled), SMTP 
and probably SCP too.  To both hostname and IP address.  See if it is 
affecting all protocols or just one or two, also try telnetting to the 
machine on port 21 and see exactly what point at which it slows to a crawl 
or breaks.

Chances are the cause (and shortly thereafter, the solution) will leap out 
during this process.


Regards,
Ben

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
