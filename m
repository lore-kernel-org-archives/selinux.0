Subject: Re: Another libselinux patch fixing memory leaks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <475744.80462.qm@web51512.mail.yahoo.com>
References: <475744.80462.qm@web51512.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 22 Feb 2007 09:01:32 -0500
Message-Id: <1172152892.14363.349.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 07:13 -0800, Steve G wrote:
> Hi,
> 
> I was running restorecond through valgrind to figure out why it consumes so much
> memory. It seemed to point to matchpathcon as a possible leak. I looked at the
> functions and saw that there are some potentially uninitialized pointers that
> could get freed when jumping to finish and a couple allocations that appear to be
> leaked.
> 
> Patch is attached.

Thanks, merged into -trunk and -stable.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
