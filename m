Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j03L21Ii020020
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 16:02:01 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j03L0AFS023886
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 21:00:10 GMT
Subject: Re: howl and modutil
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200412250432.55521.russell@coker.com.au>
References: <200412250432.55521.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1104786252.14157.6.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 Jan 2005 16:04:12 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged both.

On Fri, 2004-12-24 at 12:32, Russell Coker wrote:
> Attached are patches for howl and modutil.
> 
> The howl patch allows the latest version of howl in rawhide to work correctly.
> 
> The modutil patch allows insmod_t to do everything it wants to do on my system 
> including access to memory_device_t.  insmod_t has ultimate access anyway so 
> this doesn't seem to be a problem.
> 
> One thing I have been idly considering regarding modprobe is to re-write it to 
> not use system(3) so it doesn't need access to shell_exec_t and thus can have 
> assert_execute().
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
