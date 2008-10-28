Subject: Re: 2.6.26 Debian kernel panic
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Paul Menzel <paul.menzel@web.de>
In-Reply-To: <200810281410.45041.russell@coker.com.au>
References: <200810281410.45041.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 28 Oct 2008 08:21:57 -0400
Message-Id: <1225196517.5266.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-10-28 at 14:10 +1100, Russell Coker wrote:
> Below are the syslog messages from a kernel panic when running 2.6.26.  To 
> trigger it I ran "semodule -i sendmail.pp" on a machine with the exim policy 
> loaded (not something that you expect people to do - but not something you 
> expect to cause a problem either) and load_policy went into an infinite loop 
> (100% CPU use - strace reported no syscalls being made).  At that 
> stage "kill -9" seemed like the right solution, killing load_policy gave the 
> following result.

Can you make a tarball of your /etc/selinux directory prior to inserting
sendmail.pp available somewhere, and a copy of that sendmail.pp file?

> I've tried to reproduce it but have been unsuccessful.  The machine in 
> question is a Xen DomU, I believe that the hardware has ECC RAM and is of 
> generally good quality.
> 
> Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
> redcape kernel: [399681.381737] Eeek! page_mapcount(page) went negative! (-1)
> 
> Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
> redcape kernel: [399681.381755]   page pfn = 3
> 
> Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
> redcape kernel: [399681.381760]   page->flags = 400
> 
> Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
> redcape kernel: [399681.381766]   page->count = 1
> 
> Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
> redcape kernel: [399681.381770]   page->mapping = 0000000000000000
> 
> Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
> redcape kernel: [399681.381780]   vma->vm_ops = 0x0
> 
> Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
> redcape kernel: [399681.381799] ------------[ cut here ]------------
> 
> Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
> redcape kernel: [399681.381811] invalid opcode: 0000 [1] SMP
> 
> Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
> redcape kernel: [399681.381828] Code: 80 e8 3c 0c fd ff 48 8b 85 90 00 00 00 
> 48                                                                                                                                                     
> 85 c0 74 19 48 8b 40 20 48 85 c0 74 10 48 8b 70 58 48 c7 c7 66 52 4b 80 e8 17 
> 0c                                                                                                                                                     
> fd ff <0f> 0b eb fe 8b 77 18 41 58 5b 5d 83 e6 01 f7 de 83 c6 04 e9 6c
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
