Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k46G7jtv010044
	for <selinux@tycho.nsa.gov>; Sat, 6 May 2006 12:07:45 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k46G7iAD029204
	for <selinux@tycho.nsa.gov>; Sat, 6 May 2006 16:07:44 GMT
Message-ID: <445CC9C5.3050603@gentoo.org>
Date: Sat, 06 May 2006 12:07:33 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: selinux@tycho.nsa.gov
Subject: Re: Reference policy documentation
References: <Pine.LNX.4.64.0605061056310.13769@d.namei>
In-Reply-To: <Pine.LNX.4.64.0605061056310.13769@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> Is there some canonical documentation on reference policy and related 
> infrastructure?
>
> Something which fully describes the format of the source policy modules, 
> for example, so I know what to do about:
>
>   ERROR 'This block has no require section.' at token ''
>
> I'm sure I saw something once, but can't remember where.
>
>
>
> - James
>   
http://serefpolicy.sourceforge.net/index.php?page=documentation has 
refpolicy docs but the error above is the module grammar, and there 
isn't much documentation about it. The error above is saying that there 
is no require { } block in the main section of the module (which is 
required). If you are writing ref policy modules the first line should 
be something like policy_module(foo,1.0) which will take care of that.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
