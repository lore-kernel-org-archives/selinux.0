Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA20666
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 12:28:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA27057
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 17:27:05 GMT
Received: from torpid.com (infoblox.com [64.39.15.22])
	by jazzswing.ncsc.mil  with SMTP id RAA27051
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 17:27:04 GMT
Date: Wed, 20 Feb 2002 11:28:02 -0600 (CST)
From: Ivan Pulleyn <ivan@torpid.com>
To: Ben McGinnes <ben-mcginnes@iname.com>
cc: selinux@tycho.nsa.gov,
        Flood Randy Capt AFCA/TCAA <randy.flood@scott.af.mil>,
        Lonnie Cumberland <lonnie@outstep.com>
Subject: OT: Re: ftp long time connection
In-Reply-To: <20020221013905.B20971@mail.enternet.com.au>
Message-ID: <Pine.LNX.4.10.10202201124190.24117-100000@norway.torpid.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Thu, 21 Feb 2002, Ben McGinnes wrote:

> True, DNS errors will do that, as others here have pointed out.  The
> original query, however, also mentioned that accessing the host directly
> by its IP was attempted with the same results.  So while there may be some 
> DNS-related delays as well, it cannot be a complete explanation.  I also 

Yes, it *can* be an explanation. Quite a few services (telnet, web,
ftp, etc) look up the source address. So if you are on host 'foo' and
you type 'ftp 192.168.1.1', there's no DNS query, but the server has
to lookup 192.168.1.100 (the address of foo) to determine it's
name. This is the lookup that is most likely causing the problem. If
telnet hangs for 180 seconds, then prints 'login:', I bet a dollar
it's reverse DNS.

Ivan...




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
