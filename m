Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i715kjrT005329
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 01:46:47 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i715k452016858
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 05:46:13 GMT
Message-ID: <410C83AB.5020305@tresys.com>
Date: Sun, 01 Aug 2004 01:46:19 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Nikolay <nikolay@alexandrov.ws>
CC: selinux@tycho.nsa.gov
Subject: Re: Some ideas and info.
References: <200408010121.i711LUHs013906@mummy.ncsc.mil>
In-Reply-To: <200408010121.i711LUHs013906@mummy.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nikolay wrote:

>Hi. I was wondering if you've thought about implementing non-exec pages and
>stack randomization?
>In case that the user hasn't got the PaX patches it's nice to be protected
>at least a little more isn't it ? I think that at least basic
>implementations of such mechanisms is needed and would help in improving the
>security level.
>I could implement such ideas, if you'd like ofcourse.
>
>(Sorry for my poor english (it's not my native language. I also intend to
>write often here, I like the ideas of your project and I would be glad to
>help you.)
>Best regards,
>Nikolay
>
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>
>  
>
Memory protections are well outside the scope of SELinux (which includes 
only mandatory access control), however the Gentoo (of which I am a 
part) have a patch to integrate PaX flags into SELinux policy, it's 
available if you are interested.

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
