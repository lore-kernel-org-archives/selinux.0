Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hACJ7YSf014777
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 14:07:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hACJ77Bb020248
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 19:07:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hACJ764o020241
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 19:07:06 GMT
Subject: Re: Oops in old SELinux + 2.4.21
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Paul Dwerryhouse <paul@dwerryhouse.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031110184221.GA27862@localhost>
References: <20031110184221.GA27862@localhost>
Content-Type: text/plain
Message-Id: <1068664046.32532.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Nov 2003 14:07:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-11-10 at 13:42, Paul Dwerryhouse wrote:
> Hi all,
> 
> We have a fairly heavily loaded machine running the "old" SELinux, patched
> against a vanilla 2.4.21 kernel, which is periodically oopsing and then locking
> up. I don't know an awful lot about oops messages, but since it mentions
> selinux_d_instantiate in there, I guess it has something to do with
> SELinux.

You applied the separate SELinux patch on top of the LSM patch?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
