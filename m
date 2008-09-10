Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8A43PNd017759
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 00:03:26 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8A43NvB020129
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 04:03:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: semodule memory use
Date: Wed, 10 Sep 2008 14:03:13 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200809101150.15440.russell@coker.com.au> <48C72A87.9030009@manicmethod.com>
In-Reply-To: <48C72A87.9030009@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809101403.15762.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 10 September 2008 12:01, Joshua Brindle <method@manicmethod.com> 
wrote:
> Russell Coker wrote:
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=495786
> >
> > I've received the above bug report against the Debian policy packages. 
> > The operation in question is "semodule -b" followed by "semodule -i".
> >
> > I haven't had time to work on this (and won't until well after Lenny is
> > released).  But if anyone has any quick ideas of how to reduce memory use
> > by semodule then I would be interested to hear them.
>
> how big is the policy in terms of rules? if it is even close to the size of
> fedora's there is no chance of it running in under 32 meg.

Debian's policy is probably slightly larger than Fedora's, and is it uses 
modules more it probably requires more memory while it's processing.

Fortunately the machines in question have swap space, but it's apparently 
excessively slow.

> You'll need a significantly smaller policy to reduce the memory usage.
> There is no quick answer, we've already picked most of the low hanging
> fruit (releasing modules earlier, consuming the linked policy while
> expanding, reducing the size of the type datum, etc).

For at least four years I've been meaning to reduce the size of the Postfix 
policy.  I expect that I can reduce it quite a bit without reducing the 
protection, when I first wanted to do this there were no tools to analyse the 
policy so it seemed unreasonably difficult.

One thing we can do in the long-term is to set up a way of using a big machine 
to generate policy that can be used on a smaller machine.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
