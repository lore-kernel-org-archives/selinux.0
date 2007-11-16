Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAGMiFGs006728
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 17:44:15 -0500
Received: from web32210.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAGMiCsk010216
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 22:44:13 GMT
Date: Fri, 16 Nov 2007 14:44:03 -0800 (PST)
From: Hal <hal_bg@yahoo.com>
Subject: Re: Trouble with mounted /home
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243497.16660.4.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <527346.11275.qm@web32210.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "Christopher J. PeBenito" <cpebenito@tresys.com> wrote:

> On Thu, 2007-11-15 at 15:28 -0800, Hal wrote:
> > hi all
> > I have problem with Selinux targeted policy and mounted user home dirs on
> F8.
> > 
> > What I did was:
> > # mkfs -t ext3 /dev/sdb1
> > # mount /dev/sdb1 /home
> > 
> > # useradd test1
> > # passwd test1
> > 
> > # useradd -Z xguest_u test2 
> > # passwd test2
> > 
> > # vi /etc/fstab 
> > and added /dev/sdb1 as /home
> > 
> > from the GUI I have set targeted/enforcing and checked relabel on reboot.
> > 
> > # reboot
> > 
> > In the gdm I tried to login as test1 and test2 with no success. A message
> pops
> > up on the screen saying that /home/test1 or /home/test2 does not exist
> > respectively.
> > 
> > when I set permissive no problems at all despite of some avc denials about
> > tomboy and /tmp...
> > 
> > It seems there are no messaages in /var/log/messages in enforcing mode...
> > 
> > So can anybody tell me how to use selinux with a mounted home?
> > 
> > By the way /home/test1 and /home/test2 have the correct labeling.
> 
> Does /home have the right label?  Are you sure the DAC permissions
> (regular unix perms) are correct?

With selinux disabled everything works fine. And the labels look ok just as if
home was a part of the same FS when everything works.



      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
