Subject: Re: fc3 - password change problem - syslog and portmapper
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jayendren@mweb.co.za
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200502220809.40631.jayendren@hivsa.com>
References: <200502220809.40631.jayendren@hivsa.com>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 08:04:09 -0500
Message-Id: <1109077449.2256.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-22 at 08:09 +0200, Jayendren Anand Maduray wrote:
> Got FC3 running SELINUX in enforcing mode.
> 
> 1. however when i try to change my password, i get the ffg error:
> SystemError: couldn't get security context of `/etc/passwd': No data available
> 
> 2. also, when i boot up, syslogd, and portmap cannot start, so i disabled it 
> in SELinux. i would like to get this to work, though.
> 
> i am running kernel Linux shiva 2.6.10-1.741_FC3smp

The most likely scenario is that you never labeled your filesystems, or
that you ran with SELinux disabled for some period of time and thus
ended up with some files without security labels.  Touch /.autorelabel
and reboot, or run /sbin/fixfiles relabel and reboot.  BTW, this kind of
question belongs on fedora-selinux-list, not here, IMHO.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
