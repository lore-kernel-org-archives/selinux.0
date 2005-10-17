Subject: Re: Kernel woes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Unix Admin <unix@cobalt-financial.com>
Cc: James Morris <jmorris@namei.org>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <43537A09.5080005@cobalt-financial.com>
References: <43537A09.5080005@cobalt-financial.com>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 10:45:12 -0400
Message-Id: <1129560312.26309.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-17 at 10:16 +0000, Unix Admin wrote:
> Greetings all. After a recent reboot to one of my servers, the kernel 
> began showing the following errors:
> 
> [root@odin logs]# uname -a
> Linux odin 2.6.9-11.ELsmp #1 SMP Wed Jun 8 17:54:20 CDT 2005 i686 i686 
> i386 GNU/Linux
> 
> Oct 17 09:01:05 odin kernel: post_create:  setxattr failed, rc=28 
> (dev=sda1 ino=8339458)

errno 28 is ENOSPC, i.e. the filesystem is out of space so it cannot set
the extended attribute on the newly created file properly.  This means
that sda1 is out of space.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
