Subject: RE: Accurately setting Security Context of a  user when ssh-ing in
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D04602916@de01exm68.ds.mot.com>
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
	 <1! 202913499 .16038.3.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D04602916@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Wed, 13 Feb 2008 15:23:05 -0500
Message-Id: <1202934185.16038.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-13 at 15:02 -0500, Hasan Rezaul-CHR010 wrote:
> Hi Stephen,
> 
> As part of my software_upgrade procedure, after populating the new
> policies and selinuxfs on the  /inactive side, I did  "touch
> /inactive/.autorelabel"
> 
> Then reboot my Linux Card. So now when the Card was booting up from the
> new side...
> 
> kernel detected new policies, 
> loaded new policies, 
> kernel also detected the .autorelabel file

kernel doesn't do that - it is handled by /etc/rc.sysinit (at least in
Fedora).

> So it invoked automatic "Re-Label" of the filesystem
> Kernel then FORCED another Automatic REBOOT
> And then the Card booted up all the way.
> 
> Now when I do  "ps -eZ | grep sshd",  I get  
>  
> root@hapWibbSc2:/root> ps -eZ | grep sshd
> system_u:system_r:init_t:s0      3971 ?        00:00:00 sshd

Ok, normally, /sbin/init runs in init_t, then it transitions to initrc_t
upon executing the /etc/rc.d/ and /etc/init.d scripts, and then initrc_t
transitions to sshd_t upon executing /usr/sbin/sshd.

So now your problem is that you aren't transitioning to initrc_t.
What's the label on /etc/rc.d and /etc/init.d, i.e. ls
-Z /etc/rc.d /etc/init.d?

If init directly invokes sshd in your setup, then you need a type
transition rule added for it since that isn't the usual case.

> So this way, we've made sure that the filesystem was labeled correctly,
> before the init processes were started!
> You mentioned that ideally, this is the sequence we want, correct ???

Yes.  You could also label the /inactive tree _before_ booting from it
if the file types haven't changed from the old policy, ala:
# setfiles -r /inactive /inactive/etc/selinux/$SELINUXTYPE/contexts/file_contexts /inactive
 
The -r option tells setfiles to use an alternate root path, for labeling a separate
tree like this.

> *BUT*, how even after re-labeling the filesystem, and starting sshd, the
> context became =  system_u:system_r:init_t  ??

Apparently it isn't transitioning out of init_t into initrc_t before
reaching sshd.

> Now when I ssh in as "Admin", or "Reza"  I still get the wrong context !
> :-(
> 
> 
> Things actually seem to work properly when the sshd process is running
> in context =   root:system_r:sshd_t:s0
> 
> In my normal setup, I DON'T create an  /.autorelabel file, and I do the
> re-labeling manually via a script using restorecon. The problem with
> that approach is that, init processes like 'sshd' already get started in
> the wrong context  BEFORE my script gets a chance to run.
> 
> But if I restart sshd from the console, my ssh headaches get resolved.
> So how can I restart ssh in the correct context  (system_r:sshd_t)  via
> a script? You mentioned something about the "runcon" command...  Can I
> use 'runcon' in my script to restart sshd and force sshd to run it in
> the correct context ??
> 
> You're right that other init processes may be running in the wrong
> context/domain as well, but they're not bothering me as much. But I need
> to at least get around this ssh problem...  Any suggestions ?... Thanks,

You can use runcon (if permitted by policy), but I think we can fix this
w/o doing that.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
