Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72CZZrT011527
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 08:35:36 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72CZYKV008658
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 12:35:34 GMT
Subject: Re: policy version jumped to 18
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040731120634.GK3378@lkcl.net>
References: <20040731120634.GK3378@lkcl.net>
Content-Type: text/plain
Message-Id: <1091449366.23449.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 08:34:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-07-31 at 08:06, Luke Kenneth Casson Leighton wrote:
> policy version being reported by the kernel i am using is 17.
> 
> checkpolicy is being a pain and reporting that it does version 18.
> 
> therefore, a make install does this:
> 
> creates a policy.conf file, and creates a .17 file (somewhere) because
> that's what the kernel supports.
> 
> checkpolicy is then used to find what to check, which says "i do version 18".
> 
> consequently, i don't get anywhere.

checkpolicy -c n will generate policy version n (-c for compatibility).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
