Subject: RE: Accurately setting Security Context of a  user when ssh-ing in
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D045B6D09@de01exm68.ds.mot.com>
References: <4784EFE8.9050106@redhat.com>
	 <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>
	 <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>
	 <478670A8.5080902@redhat.com> <1199995291.3707.15.camel@vogon>
	 <47877F43.5030401@redhat.com>
	 <1200065528.29816.66.camel@moss-spartans.epoch.ncsc.mil>
	 <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil>
	 <4787BF20.1050105@redhat.com> <47A08F44.20308@redhat.com>
	 <D06FE0A2807BC145B0D38744789D4F5D0451FF16@de01exm68.ds.mot.com>
	 <1201739450.24702.488.camel@moss-terrapins.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D04568692@de01exm68.ds.mot.com>
	 <1202216499.27371.2.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D045B6D09@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 09:16:28 -0500
Message-Id: <1202393788.27371.225.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-06 at 23:13 -0500, Hasan Rezaul-CHR010 wrote:
> Understood  :-)
> 
> Ques: At the end of the day when we reboot, and the machine comes back
> up, its basically running a whole bunch of scripts and commands. So isnt
> there some command(s) that I can manually run without doing an actual
> reboot, to achieve what the reboot would otherwise do ?

Depends how disruptive the change in your policy is.  For common policy
changes, you don't have to reboot at all - just reload policy and
relabel any files whose labels have changed under the new policy.  You
only have to restart processes when the change in policy would lead to
the process running in a different context, and then you have to
identify and restart all processes that are running under the wrong
context.  That would just use the conventional mechanisms for restarting
the affected processes, e.g. /sbin/service sshd restart, telinit, etc.
If you are dropping in an extremely different policy or when you first
go from no-policy to a policy, then you may need to restart everything
from /sbin/init downward to get them into the right security contexts.

> Lets just say I cant afford to do a reboot, due to downtime/availability
> restrictions. I have a certain collection of policies on a machine. I
> need to be able to replace policy with a new set of policies with
> minimal downtime. Hence, I cant afford a reboot. Is there any way
> whatsoever I can run commands/scripts manually to avoid the reboot ?

Depends on the nature of the change in policy, as above.  BTW, while you
can do wholesale replacement of the entire policy tree, modular/managed
policy is oriented to letting you make selective changes via semodule
and semanage on the end system instead.  However, you still need to
relabel files whose types have changed and you still need to restart
processes that you want to run in a different context in either case.

> By the way, what file should I play with to control what context a user
> gets when login at the console VS the context a user should get after
> ssh-ing in ?

/etc/selinux/$SELINUXTYPE/contexts/default_contexts
and/or /etc/selinux/$SELINUXTYPE/contexts/users/$SEUSER.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
