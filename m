Subject: Re: Issue on labeling a packet? (was Re: Issue on getting security
	context of socket and message)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20041230184046.93768.qmail@web51501.mail.yahoo.com>
References: <20041230184046.93768.qmail@web51501.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1104760514.16598.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 Jan 2005 08:55:14 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-30 at 13:40, Park Lee wrote:
> I've seen them, and know how/where these special
> kernel socket are labeled now.
> 
> Let's suppose that when a packet is sending out
> (through XFRM architecture), how can we decide whether
> the packet is associated with a kernel socket or a
> user socket?

kernel sockets have the kernel SID.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
