Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8FGtrK8025337
	for <selinux@tycho.nsa.gov>; Sun, 15 Sep 2013 12:55:53 -0400
Received: by mail-qa0-f42.google.com with SMTP id cm18so585126qab.8
        for <selinux@tycho.nsa.gov>; Sun, 15 Sep 2013 09:55:23 -0700 (PDT)
Message-ID: <5235E660.2040602@quarksecurity.com>
Date: Sun, 15 Sep 2013 12:54:56 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: Is this a bug in sesearch, or ...?
References: <1379263465.20256.6.camel@d30>
In-Reply-To: <1379263465.20256.6.camel@d30>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dominick Grift wrote:
> I was explaining the concept of (type) attributes using the domain type
> attribute as an example on IRC, and a sharp person embarrassed me by
> noting that the following rule returns nothing where he would have
> expected something:
>
> sesearch -A -d -s domain -c process -p fork
>
> Why does this not return anything? Is is because the target is "self"?

"self" is resolved by the compiler, it isn't present in the kernel binary.

You specified -d "do not search for type's attributes" and then gave an 
attribute as the source. I'm not sure what the intended behavior was but 
excluding the -d gave me back a large set of rules.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
