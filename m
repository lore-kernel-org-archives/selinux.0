Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA07856
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 07:21:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA29394
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 11:19:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA29390 for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 11:19:14 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "luiztizei" <luiztizei@terra.com.br>, "selinux" <selinux@tycho.nsa.gov>
Subject: Re: What to do next?
Date: Wed, 9 Oct 2002 13:20:54 +0200
References: <H3OGTT$0A7DBB13E9FF323A8AA0A7184811E6BA@terra.com.br>
In-Reply-To: <H3OGTT$0A7DBB13E9FF323A8AA0A7184811E6BA@terra.com.br>
MIME-Version: 1.0
Message-Id: <200210091320.54708.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 8 Oct 2002 21:29, luiztizei wrote:
>   I have succefully installed selinux kernel lsm-2.4 to my RH7.3
> distro. I want to continue to explore this system. What should I do
> next? Get the patches you are releasing and try them?
>   I am simply a newbie to the subject, but with time I might help :)

You need a kernel compiled with SE Linux (I'm not sure from your message if 
you compiled the support in).

Then you need to run patched versions of essential programs, this means login, 
crond, and logrotate as the most important ones, procps, psmisc, fileutils, 
and shellutils are optional.

Finally you need to install a SE Linux policy.  Both my policy and the CVS 
policy are reasonable options, but the release version on the NSA site will 
work too.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
