Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72D8vrT011868
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 09:08:57 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72D8OXV017535
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 13:08:25 GMT
Subject: Re: selinux-policy-default 1.14 is missing _stacks_ of stuff
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408012254.15553.russell@coker.com.au>
References: <20040801103252.GC7384@lkcl.net>
	 <200408012254.15553.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1091452092.23449.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 09:08:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-08-01 at 08:54, Russell Coker wrote:
> There is no support for targeted in Debian, only strict and it has the 
> directory name "." .
> 
> > so, i can't use run_init because targeted/contexts/initrc_context
> > doesn't exist.
> 
> Your /etc/selinux/config file should have the following line:
> SELINUXTYPE=.

What does this mean for supporting multiple policies in Debian?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
