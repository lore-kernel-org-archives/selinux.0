Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i94GAcrT018936
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 12:10:39 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i94GAcs6017001
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 16:10:38 GMT
Subject: Re: where is the modified login program's source code
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040930141837.5407.qmail@web51503.mail.yahoo.com>
References: <20040930141837.5407.qmail@web51503.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1096906078.32008.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 04 Oct 2004 12:07:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-30 at 10:18, Park Lee wrote:
>   I know that login is a modified daemon program. Now, I want to do
> some work with the login program in SELinux. But, Where could I found
> the modified login program's source code? It seems that it isn't
> contained in Fedora Core 2.
>   If you know the matter, please tell me about it.

login now uses pam_selinux rather than a direct patch.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
