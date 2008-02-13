Subject: RE: Accurately setting Security Context of a  user when ssh-ing in
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D045B7B01@de01exm68.ds.mot.com>
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
	 <1202393788.27371.225.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D045B7963@de01exm68.ds.mot.com>
	 <1202842666.24250.112.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D045B7B01@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Wed, 13 Feb 2008 09:38:19 -0500
Message-Id: <1202913499.16038.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-12 at 18:01 -0500, Hasan Rezaul-CHR010 wrote:
> Hi Stephen,
> 
> Here are the outputs of the commands you asked for...
> 
> Before restarting sshd, while the problem is exhibited: 
> ------------------------------------------------------------------------------
> 
> root@hapWibbSc2:/> cat /selinux/booleans/ssh_sysadm_login 
> 0 0
> 
> root@hapWibbSc2:/> grep
> ssh /etc/selinux/strict/contexts/default_contexts 
> system_r:sshd_t:s0              user_r:user_t:s0 staff_r:staff_t:s0
> sysadm_r:sysadm_t:s0
> 
> 
> root@hapWibbSc2:/> ps -eZ | grep sshd 
> system_u:system_r:kernel_t:s0    1095 ?        00:00:00 sshd

So here sshd never transitioned into its domain, likely because the
filesystem wasn't labeled at the time /sbin/init started.

> 
> 
> And after restarting sshd from the console, where I am
> root:sysadm_r:sysadm_t:s0 
> --------------------------------------------------------------------------------------------------------------------------
> 
> root@hapWibbSc2:/> cat /selinux/booleans/ssh_sysadm_login 
> 0 0
> 
> root@hapWibbSc2:/> grep
> ssh /etc/selinux/strict/contexts/default_contexts 
> system_r:sshd_t:s0              user_r:user_t:s0 staff_r:staff_t:s0
> sysadm_r:sysadm_t:s0
> 
> root@hapWibbSc2:/> ps -eZ | grep sshd 
> root:system_r:sshd_t:s0          4819 ?        00:00:00 sshd

And here it is running in the correct context, or close enough (ideally
it would be system_u).  If you restarted it with
run_init /etc/init.d/sshd restart, then that should happen.

> Just in case, under the  /etc/selinux/strict/contexts/users/
> directory, I only have one file called "root", and that contains:
> 
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
> system_r:local_login_t:s0  sysadm_r:sysadm_t:s0 staff_r:staff_t:s0
> user_r:user_t:s0 
> system_r:crond_t:s0     sysadm_r:sysadm_crond_t:s0
> staff_r:staff_crond_t:s0 user_r:user_crond_t:s0 
> staff_r:staff_su_t:s0   sysadm_r:sysadm_t:s0 staff_r:staff_t:s0
> user_r:user_t:s0 
> sysadm_r:sysadm_su_t:s0 sysadm_r:sysadm_t:s0 staff_r:staff_t:s0
> user_r:user_t:s0 
> user_r:user_su_t:s0     sysadm_r:sysadm_t:s0 staff_r:staff_t:s0
> user_r:user_t:s0 
> # 
> # Uncomment if you want to automatically login as sysadm_r 
> # 
> #system_r:sshd_t:s0 sysadm_r:sysadm_t:s0 staff_r:staff_t:s0
> user_r:user_t:s0
> 
> 
> *** So given this info, we can see that in the problematic case,
> context of sshd is   system_u:system_r:kernel_t:s0,  but restarting
> sshd on the console, we get  root:system_r:sshd_t:s0. And after this,
> everything works nicely...
> 
> So how can I programmatically (e.g. through a script) get sshd to
> start in the right context, or force sshd to change context to
> sshd_t ?
> 
> Thanks again for all your help as always  :-)

Well, I suspect that not only sshd but all of your system processes are
running in the wrong domain because init never transitioned out of
kernel_t into init_t.

Ideally you'd label the filesystem before you perform that first boot of
the new system image.  Should be possible to do, modulo differences
between the file types defined by the old and new policies.  If you can
at least get most of the files labeled, then init will transition
properly and the daemons will follow course.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
