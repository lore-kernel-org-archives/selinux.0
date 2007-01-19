Message-ID: <45B1433F.4030605@mentalrootkit.com>
Date: Fri, 19 Jan 2007 17:16:31 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: vin@netwosix.org
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov
Subject: Re: installation from scratch problems
References: <1169207960.8700.19.camel@zeroKnowledge>	 <1169210930.22731.478.camel@moss-spartans.epoch.ncsc.mil>	 <1169243300.26086.5.camel@zeroKnowledge>	 <45B1400F.2010908@mentalrootkit.com> <1169244939.26086.12.camel@zeroKnowledge>
In-Reply-To: <1169244939.26086.12.camel@zeroKnowledge>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vincenzo Ciaglia wrote:
> Il giorno ven, 19/01/2007 alle 17.02 -0500, Karl MacMillan ha scritto:
> 
>> Just a warning. Upstream selinux doesn't treat warnings as errors so 
>> occasionally they creep in. You should back out whatever caused -Werror 
>> to be added to your compile flags.
> 
> I used the cvs repo package. So, just for trying, i download the same
> package (policycoreutils-1.32) from the NSA's pages and it does the
> trick. No warning and no errors. 
> 
> Is it the same package and can i use it without problems ?
> 

Depends on which cvs repo you mean. If it is from a distro there are 
likely to be a few extra patches.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
