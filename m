Subject: Re: installation from scratch problems
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov
In-Reply-To: <45B1400F.2010908@mentalrootkit.com>
References: <1169207960.8700.19.camel@zeroKnowledge>
	 <1169210930.22731.478.camel@moss-spartans.epoch.ncsc.mil>
	 <1169243300.26086.5.camel@zeroKnowledge>
	 <45B1400F.2010908@mentalrootkit.com>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 23:15:39 +0100
Message-Id: <1169244939.26086.12.camel@zeroKnowledge>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il giorno ven, 19/01/2007 alle 17.02 -0500, Karl MacMillan ha scritto:

> Just a warning. Upstream selinux doesn't treat warnings as errors so 
> occasionally they creep in. You should back out whatever caused -Werror 
> to be added to your compile flags.

I used the cvs repo package. So, just for trying, i download the same
package (policycoreutils-1.32) from the NSA's pages and it does the
trick. No warning and no errors. 

Is it the same package and can i use it without problems ?

Thank you for your helps. I'll keep you upgraded on the netwosix-selinux
progresses.

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix - <www.netwosix.org>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
