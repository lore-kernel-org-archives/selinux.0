Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j03L2uIi020056
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 16:02:56 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j03L14FS023944
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 21:01:04 GMT
Subject: Re: proc_net_t and mail servers
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200412250510.31249.russell@coker.com.au>
References: <200412250510.31249.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1104786311.14157.10.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 Jan 2005 16:05:11 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged both.

On Fri, 2004-12-24 at 13:10, Russell Coker wrote:
> The attached patches grant postfix access to proc_net_t and dontaudit 
> system_mail_t and sysadm_mail_t access to proc_net_t when sendmail is being 
> used.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
