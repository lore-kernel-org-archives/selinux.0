Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB9CEDRb021881
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 07:14:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB9CECRV021129
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 12:14:12 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
        by jazzband.ncsc.mil  with ESMTP id hB9CEBta021122 for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 12:14:11 GMT
Message-ID: <3FD5BC93.2040805@diyab.net>
Date: Tue, 09 Dec 2003 07:14:11 -0500
From: Timothy Wood <timothy@diyab.net>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Basic question on policy design
References: <000401c3ba6a$ad593430$8100a8c0@columbia.tresys.com> <3FCF968B.3050504@diyab.net> <200312051104.34261.russell@coker.com.au>
In-Reply-To: <200312051104.34261.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

> On Fri, 5 Dec 2003 07:18, Diyab <diyab@diyab.net> wrote:
> 
>>require the ability to speak to one another.  So for process to process
>>you might end up with something like:
> 
> 
> can_tcp_connect(httpd_t, postgresql_t)
> 

I was not aware that existed.  It does seem to exactly what is needed. 
Thanks for pointing that out Russell.

Timothy,



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
