Subject: Re: Getting the real task name in avc messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050331145313.38541.qmail@web51503.mail.yahoo.com>
References: <20050331145313.38541.qmail@web51503.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 10:00:51 -0500
Message-Id: <1112281251.11216.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-31 at 06:53 -0800, Steve G wrote:
> >Steve, want to take the updated patch to linux-audit?
> 
> Ok. Let me compile it and see what the logs look like first.

Ok.  I built and ran a kernel with it here, and ran some selinux tests,
and it looked good.  It has some side benefits for SELinux even beyond
the comm information, e.g. capturing the exe= upon syscall exit lets us
get it cleanly without having to worry about mmap sem locking by the
caller (which was an issue for mmap/mprotect previously) and moving the
task-related audit handling to syscall exit should avoid having bogus
information included for our networking checks that occur outside of
process context.  Tools like seaudit may need to be updated to get the
task-related info from the subsequent syscall audit record instead of
from the avc-generated record, but they can correlate it based on the
timestamp/serial.

One further change that should be made is to use something like
audit_log_untrustedstring on the comm and on the exe path.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
