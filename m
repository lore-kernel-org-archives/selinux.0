Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIK4XIi016028
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 15:04:33 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIK35iM026645
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 20:03:06 GMT
Subject: Re: gentoo policy for dante
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: petre rodan <kaiowas@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4198E94B.8070008@gentoo.org>
References: <4198E94B.8070008@gentoo.org>
Content-Type: text/plain
Message-Id: <1100808438.26930.28.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 18 Nov 2004 15:07:18 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

allow dante_t initrc_var_run_t:file { getattr write };

Why does dante need this?

On Mon, 2004-11-15 at 12:37, petre rodan wrote:
> Hi,
> 
> this must be gentoo-day :)
> 
> policy for dante [1], attached
> 
> [1] http://www.inet.no/dante/
> 
> bye,
> peter
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
