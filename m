Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2PNh4x6014128
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 18:43:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2PNh3R1005846
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 23:43:04 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h2PNgwj9005838 for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 23:42:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "david caplan" <dac@tresys.com>, "SE Linux" <selinux@tycho.nsa.gov>
Subject: Re: usermod
Date: Wed, 26 Mar 2003 00:42:33 +0100
References: <GBEAJBKHFOBIBBJBCGAGAEOACKAA.dac@tresys.com>
In-Reply-To: <GBEAJBKHFOBIBBJBCGAGAEOACKAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303260042.33489.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Mar 2003 21:18, david caplan wrote:
> Was there a reason usermod was not wrapped similar to useradd/userdel?

I never use that program and it seems that the other people involved in 
writing the wrappers don't use it either.

> On a similar note, what about the gpasswd/group[add|mod|del] family?  As
> they are all sbin_t, they do not have permission, when run by sysadm_t, to
> open /etc/gshadow (which is shadow_t).

Once again, it's not something that apparently gets used much.  Also you 
forgot to mention vigr which is another program in need of a wrapper.

It's been on my todo list to fix this for a while but I haven't got around to 
it.  I'm sure that if you send Steve a patch to address this then it'll get 
in the next release.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
