Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HLBOpe030940
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 17:11:24 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HLBNTM004512
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 21:11:24 GMT
Subject: Re: [POLICYREP] [RFC/PATCH 2/3] policy package implementation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <469D2E2C.5020405@manicmethod.com>
References: <20070717150336.135143158@manicmethod.com>
	 <20070717150431.660417962@manicmethod.com>
	 <1184686730.3833.11.camel@localhost.localdomain>
	 <469CF0EC.8030704@manicmethod.com>
	 <1184697355.3833.28.camel@localhost.localdomain>
	 <469D2B2B.1080704@manicmethod.com>
	 <1184705762.10625.14.camel@localhost.localdomain>
	 <469D2E2C.5020405@manicmethod.com>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 17:11:20 -0400
Message-Id: <1184706680.10625.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2007-07-17 at 17:01 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:

[...]

> 
> It doesn't seem reasonable to essentially reproduce the m4 preprocessing 
> statements just to keep a single parser. just look at a preprocessed 
> module and see how nasty it looks:
> 
> #line 156537 "tmp/all_interfaces.conf"
>        
> #line 1 "policy/modules/services/sendmail.te"
> 
>        
> #line 2
>       
> #line 2
>                 module sendmail 1.3.1;
> #line 2
> 
> #line 2
>                 require {
> #line 2
>                         role system_r;
> #line 2
> 

1) so what?
2) it doesn't have to be that ugly - the repeated line number thing is
an artifact of M4.

> 
> That isn't exactly what I had in mind when I said we'd want to store 
> extra info. We'd also have to add parser support for that mess to the 
> source parser, non-ideal I think when we can path the data in something 
> easily readable (by machine) without loads of junk that isn't necessary.
> 

But the lexer already supports these - it's done. I just can't see
inventing an entirely new file format just because you think this is
"ugly". It works, it's there now, and we can make it prettier.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
