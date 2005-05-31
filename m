Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VLJTgA009602
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 17:19:29 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VLDBpZ009201
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 21:13:11 GMT
Date: Tue, 31 May 2005 22:22:10 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
Subject: Re: smaller memory footprint for 'strict' policy - helping gentoo as well
Message-ID: <20050531212210.GG11815@lkcl.net>
References: <20050531012824.GI28006@lkcl.net> <429BCDDD.8080106@gentoo.org> <20050531110947.GB4131@lkcl.net> <200505311410.j4VEAecr028211@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200505311410.j4VEAecr028211@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 31, 2005 at 10:10:40AM -0400, Valdis.Kletnieks@vt.edu wrote:

> in there that *my* config totally doesn't need).  I suspect the reason I saw
> such big savings is because some of the stuff in macros/program generates a
> *lot* of $USER_foo_t types unnecessarily (thus the need for more ifdefs to
> suppress that).
> 
> I'll make up a proper patch later this week when I have more time...

 GREAT! the less, the merrier :)



-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
