Subject: Re: SELinux policy and performance impacts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Matt Anderson <mra@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <489B81A4.9050007@hp.com>
References: <489B81A4.9050007@hp.com>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 12:30:19 -0400
Message-Id: <1218731419.29535.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-08-07 at 19:13 -0400, Matt Anderson wrote:
> I'm currently looking into the performance impact of SELinux.  Most of 
> what I have seen so far involve testing the system's performance with 
> file creation, open, and exec, but I was hoping to gather some more data 
> before finalizing any conclusions.
> 
> I was wondering if anyone knows of any types of policy rules that when 
> loaded into the kernel are particularly detrimental to system 
> performance.  My understanding is that all policy rules are treated 
> equally once they've been compiled to binary, but I wanted to ask here 
> first in order to confirm that.

In addition to other points raised in this thread, note that using
larger inodes (as done by default in F9) should yield a significant
improvement in file benchmarks by keeping the SELinux security context
inline within the inodes rather than in separate data blocks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
