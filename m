Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i827C5rT026966
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 03:12:05 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i827C2v0028977
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 07:12:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: /dev entries which also need to be /.?u?dev'd
Date: Thu, 2 Sep 2004 17:11:59 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040831101602.GB2098@lkcl.net>
In-Reply-To: <20040831101602.GB2098@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409021711.59397.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 31 Aug 2004 20:16, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> the following entries presently marked as /dev need, imo, to also
> be modified to be ":%s/\/dev/\/.?u?dev/g" [in vi].
>
> the reason is as i explained that if someone using udev [with or
> without tmpfs] does a
>
>  setfiles /etc/selinux/src/file_contexts/file_contexsts /.dev
>
> then they are buggered, without the above.

What if a rule such as the following was added at the end?
/\.dev(/.*)? <<none>>

That will work for the short-term.  Long term I think that the correct thing 
to do is to work on the stem-compression code in setfiles and have multiple 
prefixes for the /dev stuff.  However this requires either adding special 
case code to setfiles or adding more configuration information to the config 
file (syntax additions).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
