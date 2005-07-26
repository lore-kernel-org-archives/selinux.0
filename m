Subject: Re: console param in kernel boot string causes deadlock
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yevheniy Yevtushenko <keeper@keeper.org.ua>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42DE6997.6060704@keeper.org.ua>
References: <42DE6997.6060704@keeper.org.ua>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 15:20:14 -0400
Message-Id: <1122405614.4470.128.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-07-20 at 18:11 +0300, Yevheniy Yevtushenko wrote:
> Hello!
> 
> I have faced problem with kernel boot log redirect. I tried to add 
> 'console=/dev/tty8 selinux=1 enforcing=1' and got immediate kernel hung 
> up. It looks like deadlock or endless loop. There is no difference what 
> value is in parameter ( /dev/tty0, /dev/console, /dev/null or whatever 
> else). There is no output besides of grub boot message.
> I have tried with FC3 kernel and FC4 kernel. There is no difference. But 
> in permissive mode system boots up. And output goes to tty8. There is no 
> corresponding avc messages in logs. make enableaudit does not show 
> anything useful.
> Have anybody either faced with it? Is this anything known?

No, I haven't seen this problem, and I have successfully booted with a
serial console (e.g. console=ttyS0) without difficulty.

Can you enable NMI watchdog and reproduce?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
