Subject: Re: installation from scratch problems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, SELinux@tycho.nsa.gov
In-Reply-To: <1169244939.26086.12.camel@zeroKnowledge>
References: <1169207960.8700.19.camel@zeroKnowledge>
	 <1169210930.22731.478.camel@moss-spartans.epoch.ncsc.mil>
	 <1169243300.26086.5.camel@zeroKnowledge>
	 <45B1400F.2010908@mentalrootkit.com>
	 <1169244939.26086.12.camel@zeroKnowledge>
Content-Type: text/plain
Date: Mon, 22 Jan 2007 08:39:44 -0500
Message-Id: <1169473184.8180.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-19 at 23:15 +0100, Vincenzo Ciaglia wrote:
> Il giorno ven, 19/01/2007 alle 17.02 -0500, Karl MacMillan ha scritto:
> 
> > Just a warning. Upstream selinux doesn't treat warnings as errors so 
> > occasionally they creep in. You should back out whatever caused -Werror 
> > to be added to your compile flags.
> 
> I used the cvs repo package. So, just for trying, i download the same
> package (policycoreutils-1.32) from the NSA's pages and it does the
> trick. No warning and no errors. 
> 
> Is it the same package and can i use it without problems ?

No, use the svn stable branch as I recommended.  It will be the basis
for the next nsa.gov release.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
