Subject: Re: Question about "rootcontext=" mount option on /dev
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <SNT139-w3339B55C06590028402BACABAE0@phx.gbl>
References: <1280434836.813159.22406.nullmailer@UDistro.exmeritus.com.>
	 ,<1280752804.8704.33.camel@moss-pluto.epoch.ncsc.mil>
	 <SNT139-w3339B55C06590028402BACABAE0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 Aug 2010 08:47:48 -0400
Message-ID: <1280839668.31604.11.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-08-03 at 09:44 +0000, TaurusHarry wrote:
> Hi SELinux experts,
> 
> I have run into a file context label problem on the 2.6.34 kernel.
> After logging in, I can see the tmpfs is mounted on /dev
> by /sbin/start_udev with the "rootcontext" option:
> 
> none /dev tmpfs
> rw,rootcontext=system_u:object_r:device_t:s0,seclabel,relatime,mode=755 0 0
> 
> However, the /sbin/start_udev passes no such rootcontext option when
> calling the mount command:
> 
>         mount -n -o mode=0755 -t devtmpfs none "$udev_root"
> 2>/dev/null \
>         || mount -n -o mode=0755 -t tmpfs none "$udev_root"
>         if [ -n "$selinuxfs" -a -x /sbin/restorecon ]; then
>                 /sbin/restorecon -R /dev
>         fi
> 
> Which resulting in some device nodes in /dev/ maybe inappropriately
> labeled, for example, the /! dev/null will be labeled as "device_t"
> rather than "null_device_t", and I will run into below error messages
> after logging in:
> ...
> -sh: /dev/null: Permission denied
> -sh: /dev/null: Permission denied
> root@localhost:/root> dmesg | grep avc
> ...
> type=1400 audit(1280386917.802:171): avc:  denied  { write } for
> pid=932 comm="sh" name="null" dev=tmpfs ino=5012
> scontext=root:sysadm_r:sysadm_t:s0-s15:c0.c255
> tcontext=system_u:object_r:device_t:s0
> ...
> 
> I guess the rootcontext=xxx:device_t option will block the tmpfs
> mounted on /dev/ to be properly labeled, am I right? Is the SELinux
> kernel driver appends such option by default? (since I couldn't find
> such mount option in any of system initscripts) and how could I stop
> it being used? BTW, such problem doesn't exist on 2.6.27 kernel, the
> tmpfs will be mounted onto /dev without the rootcontext option so that
> the successive call of " /sbin/restorecon -R /dev" could fix /dev/*
> labels properly.! 
> 
> Any comment is greatly appreciated.

The rootcontext= mount option is added by /sbin/mount.tmpfs; see
https://bugzilla.redhat.com/show_bug.cgi?id=476964

That ensures that the root directory of the tmpfs mount is labeled
consistently with wherever it is mounted.  It does not prevent
restorecon from working.  So something else is preventing the restorecon
from executing or succeeding.

Are you sure this worked on 2.6.27 with a tmpfs mount, and not with a
devtmpfs mount?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
