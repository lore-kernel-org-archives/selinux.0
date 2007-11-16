Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAGK5FFA018098
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:05:15 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id lAGK5DeW028963
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 20:05:14 GMT
Subject: Re: Trouble with mounted /home
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Hal <hal_bg@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <216051.28052.qm@web32210.mail.mud.yahoo.com>
References: <216051.28052.qm@web32210.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:04:57 -0500
Message-Id: <1195243497.16660.4.camel@gorn>
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

Does /home have the right label?  Are you sure the DAC permissions
(regular unix perms) are correct?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
