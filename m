Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OKiisj029374
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 15:44:45 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0OKgfsm022044
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 20:42:41 GMT
Subject: Re: [patch] ddclient
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Greg Norris <haphazard@kc.rr.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050121222914.GA2208@yggdrasil.localdomain>
References: <20050121222914.GA2208@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1106596969.3298.11.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 Jan 2005 15:02:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Fri, 2005-01-21 at 17:29, Greg Norris wrote:
> The attached patches fix a few ddclient problems.  Please apply.
> 
> ddclient.fc
>   * Make `ddclient_var_t' match the `/var/cache/ddclient' directory, 
>     rather than just the files therein.
> 
> ddclient.te
>   * Allow execution of bin_t programs.
>   * Allow client-level access to TCP networking, instead of UDP only.
>   * Allow ddclient to create it's cache file if necessary.
> 
> Thanx!
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
