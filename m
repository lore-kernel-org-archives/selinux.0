Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAKEtIi023141
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 15:14:55 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAKEvR8011043
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 20:14:58 GMT
Subject: Re: patch: various stuff
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041209180342.GB8179@jmh.mhn.de>
References: <20041209180342.GB8179@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1102709848.5654.42.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 15:17:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Thu, 2004-12-09 at 13:03, Thomas Bleher wrote:
> Some stuff that got forgotten from my previous patches. A few comments:
> 
> * hostname.te: sysadm_t should run hostname directly, it has the
>   necessary privs and makes many things easier (eg redirections in
>   scripts). The can_resolve() was necessary because (at least on SuSE)
>   hostname does some dns-lookups. If noone else sees this it could be
>   put inside an ifdef(`distro_suse',).
> 
> * checkpolicy.fc: These labels are unnecessary and just cause
>   unnecessary relabels.
> 
> * user_macros.te: This may need some discussion. netstat needs to access
>   /proc/net in order to work. Not sure if we want to allow this. Maybe a
>   boolean?
> 
> Thomas
>   
> --
> http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
> GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
