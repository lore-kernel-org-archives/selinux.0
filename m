Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7AEjCrT003312
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 10:45:12 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7AEiaET028356
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 14:44:36 GMT
Subject: RE: Now that SELinux supports booleans should we replace
	tunableswith booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux-dev@tresys.com
In-Reply-To: <200408101429.i7AET6Sf010692@gotham.columbia.tresys.com>
References: <200408101429.i7AET6Sf010692@gotham.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1092149035.6094.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 10 Aug 2004 10:43:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-10 at 10:29, Karl MacMillan wrote:
> Another question is what happens if you change the default value in the
> policy source? Under this suggestion, the new default would not take effect
> until a reboot and then only if the config file doesn't specify the boolean
> value. Not certain if this is a problem, but it is kind of strange and
> potentially surprising to policy authors.

Given the nature of booleans, policy authors can't assume anything about
default settings, or force a change in them; they are entirely up to the
system administrator.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
