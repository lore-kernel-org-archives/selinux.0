Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i895c9rT009656
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 01:38:09 -0400 (EDT)
In-Reply-To: <1094646254.20215.42.camel@moss-spartans.epoch.ncsc.mil>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Re: PAM in suse9.1 (Re: SuSE 9.1 SELinux)
From: Takuya Mishina <TMISHINA@jp.ibm.com>
Message-ID: <OFC58E16A0.3A91101C-ON49256F0A.000830A1-49256F0A.001EE78D@jp.ibm.com>
Date: Thu, 9 Sep 2004 14:37:44 +0900
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, 


Stephen Smalley <sds@epoch.ncsc.mil> wrote on 2004/09/08 21:24:14:
> Did you look at Thomas Bleher's SELinux packages (and policy) for SuSE
> 9.0?  Available from  http://www.cip.ifi.lmu.de/~bleher/selinux/suse/.

Thanks, I've seen this page, but most packages are older than SuSE 9.1 
default packages.
(e.g., checkpolicy 1.8-17 vs. 1.8-1)

SuSE 9.1 RPM packages are older than Fedora Core 2 or patched version in 
nsa.gov. But many problems with SuSE are caused by the conflict between 
SuSE's software behavior and SELinux's assumption. (authentication, etc.) 
I've felt that a little modification of policy and some authentication 
configuration leads SuSE to SELinux-enable distribution.


---
Takuya MISHINA
IBM Research, Tokyo Research Laboratory





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
