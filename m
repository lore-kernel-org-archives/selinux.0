Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5DFReAD029954
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 11:27:40 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k5DFRdCd007175
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 15:27:40 GMT
Message-ID: <448ED97B.7060706@gentoo.org>
Date: Tue, 13 Jun 2006 11:27:55 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Mario Fanelli <mario.fanelli@gmail.com>
CC: SeLinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: PaX and SELinux
References: <448ed4f8.6359f250.6649.5416@mx.gmail.com>
In-Reply-To: <448ed4f8.6359f250.6649.5416@mx.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mario Fanelli wrote:
> I found a PaX security class in refpolicy but I have a little doubt..If I
> compile a kernel with SELinux, at the same time the kernel has installed PaX
> system (pax.grsecurity.net)? 
> So I can set pax flag using this security class?
>   
This object class was used to control pax options before other memory 
protections were available to SELinux. The patch hasn't been used or 
available for quite some time so the object class is more or less 
deprecated.

However, if you have pax enabled on the system the SELinux memory 
permissions (execstack, execmem, etc) should be enforced by pax. Address 
space randomization and other pax options aren't available in policy 
anymore though.

Joshua


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
