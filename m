Subject: Re: Trouble with mounted /home
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hal <hal_bg@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <216051.28052.qm@web32210.mail.mud.yahoo.com>
References: <216051.28052.qm@web32210.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 19 Nov 2007 13:03:24 -0500
Message-Id: <1195495404.7546.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-15 at 15:28 -0800, Hal wrote:
> hi all
> I have problem with Selinux targeted policy and mounted user home dirs on F8.
> 
> What I did was:
> # mkfs -t ext3 /dev/sdb1
> # mount /dev/sdb1 /home
> 
> # useradd test1
> # passwd test1
> 
> # useradd -Z xguest_u test2 
> # passwd test2
> 
> # vi /etc/fstab 
> and added /dev/sdb1 as /home
> 
> from the GUI I have set targeted/enforcing and checked relabel on reboot.
> 
> # reboot
> 
> In the gdm I tried to login as test1 and test2 with no success. A message pops
> up on the screen saying that /home/test1 or /home/test2 does not exist
> respectively.
> 
> when I set permissive no problems at all despite of some avc denials about
> tomboy and /tmp...
> 
> It seems there are no messaages in /var/log/messages in enforcing mode...
> 
> So can anybody tell me how to use selinux with a mounted home?
> 
> By the way /home/test1 and /home/test2 have the correct labeling.
> 
> Thanks in advance!  

ls -Zd /home shows what?

No avc messages in /var/log/audit/audit.log or /var/log/messages?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
