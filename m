Subject: Re: System hangup after installing glibc-rpms
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: sMoTo <smoto@gmx.de>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <000001c377c8$79b670f0$02000a0a@lady>
References: <000001c377c8$79b670f0$02000a0a@lady>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1063219880.14458.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 10 Sep 2003 14:51:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-10 at 14:22, sMoTo wrote:
> I have installed the source-rpms provided by
> selinux-usr-2003081307.tgz. On a single Processor machine I have built
> the glibc-* rpms for i386 (Redhat 9). 
> 
> I installed them and got an error that says: %post install error.
> Further on I rebooted the machine, but while shuting down, the
> runlevel-scripts can’t be accessed. When starting up the kernel boots
> and the root partion can be accessed, but when it comes to start the
> first runlevel the system hangs and says: ID X respawning too fast.
>
> How can I slove this problem? I can’t find a hint what is running
> wrong. I thought the selinux-glibc should be compatible to the
> original one.

Same issue arises for RH9 errata glibc, see https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=88456.

You should have built glibc with --target=i686 as well as --target=i386,
then installed the i686 glibc RPM along with the other i386 glibc-*
RPMS, excluding the i386 glibc RPM.  If you can boot from rescue, you
may be able to delete /lib/i686 on the disk and get it working
again...it is trying to use the old i686 libs since they weren't deleted
by the upgrade.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
