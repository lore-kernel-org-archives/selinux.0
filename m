Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAKEVIi023113
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 15:14:31 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAKEYR8011034
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 20:14:34 GMT
Subject: Re: patch: stricter /tmp handling
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041209171333.GD5074@jmh.mhn.de>
References: <20041209171333.GD5074@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1102709824.5654.40.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 15:17:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

I had to make a change to the xfs part.  It needed to be tmp_domain(xfs,
`', `{dir sock_file}') for /tmp/.font-unix

On Thu, 2004-12-09 at 12:13, Thomas Bleher wrote:
> This patches uses my latest changes to file_type_auto_trans() to make
> /tmp more strict.
> Right now, any process with tmp_domain() can create any file type under
> /tmp except chr_file and blk_file. But most domains only need file and
> dir.
> This patch changes tmp_domain() so that normally, only file and dir
> access is allowed. It also adds a third parameter to the macro, so
> domains which need more access can get it.
> I have run this patch for a few weeks on all my machines so most things
> should work, but I don't have any server machines running SELinux ATM,
> so some daemons probably need additional permissions.
> This patch also removes the tmpfile attribute from tetex_data_t, since
> these are not really tmpfiles.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
