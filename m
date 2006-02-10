Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1AFxiXf010902
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 10:59:45 -0500 (EST)
Received: from e5.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1AFxeTR002970
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 15:59:40 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k1AFxhpq029521
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 10:59:43 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k1AFxfkP193892
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 10:59:43 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k1AFxfoa019487
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 10:59:41 -0500
Date: Fri, 10 Feb 2006 09:59:34 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: seref: trivial patch:
Message-ID: <20060210155933.GA26183@sergelap.austin.ibm.com>
References: <20060209194236.GF10534@sergelap.austin.ibm.com> <1139582505.13925.84.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1139582505.13925.84.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Christopher J. PeBenito (cpebenito@tresys.com):
> On Thu, 2006-02-09 at 13:42 -0600, Serge E. Hallyn wrote:
> > Fix compilation failure for cron with apache=off.
> 
> > --- refpolicy.orig/policy/modules/services/cron.te
> > +++ refpolicy/policy/modules/services/cron.te
> > @@ -208,7 +208,7 @@ ifdef(`TODO',`
> >  # crond tries to search /root.  Not sure why.
> >  allow crond_t sysadm_home_dir_t:dir r_dir_perms;
> >  
> > -ifdef(`apache.te',`
> > +optional_policy(`apache',`
> >  allow system_crond_t httpd_modules_t:lnk_file read;
> >  # Needed for certwatch
> >  can_exec(system_crond_t, httpd_modules_t)
> 
> While this change is correct, I'm surprised that it caused a compile
> failure in the first place, as its in a ifdef(`TODO' block which should
> make this whole section drop out.  Did you define TODO to make the rules
> get included?

No, but then after I sent this out, it started failing to compile
again...  I clearly have some issues with stuff mysteriously staying
around after make clean.  Not bc it started to fail, but bc it ever
succeeded.

A question that's not clear in my mind - if a module, like certwatch.te,
uses the apache_exec_modules() interface, should that call automatically be
defined away to nothing if apache is not defined, or does that call
still need to be inside of a 'optional_policy(`apache'' block?  The
former sounds like preferred behavior to keep policies clean, but that'
not what is happening right now, judging by the otput under tmp/.

For the moment I'm going back to defining all the modules I want as
being part of the base policy - after all I want them always on.  It's
my own policy that I want to compile as modules.

> Merged.  I changed the rules to use the appropriate interface and moved
> them to the appropriate places.

Thanks.

On this theme, appended is a list of place which a quick set of greps
shows may have the same problem:

find policy/modules -name "*.fc" -exec "grep" "-Hn" 'ifdef(`[a-z]*\.te' "{}" \;
policy/modules/services/mta.fc:21:#ifdef(`postfix.te', `', `

find policy/modules -name "*.if" -exec "grep" "-Hn" 'ifdef(`[a-z]*\.te' "{}" \;
policy/modules/admin/su.if:235:	ifdef(`xauth.te', `
policy/modules/admin/su.if:242:	ifdef(`cyrus.te', `
policy/modules/admin/su.if:245:	ifdef(`ssh.te', `
policy/modules/admin/sudo.if:140:	ifdef(`mta.te', `
policy/modules/admin/sudo.if:145:	ifdef(`pam.te', `
policy/modules/apps/gpg.if:208:	ifdef(`xdm.te',`
policy/modules/apps/gpg.if:322:	ifdef(`xdm.te', `
policy/modules/apps/java.if:170:	ifdef(`gnome.te', `
policy/modules/services/cron.if:162:	ifdef(`mta.te', `
policy/modules/services/dbus.if:168:	ifdef(`xdm.te', `
policy/modules/services/mta.if:138:	ifdef(`qmail.te', `
policy/modules/services/mta.if:232:	ifdef(`postfix.te',`
policy/modules/services/ssh.if:348:	ifdef(`xdm.te',`
policy/modules/services/xserver.if:160:		ifdef(`rpm.te', `
policy/modules/services/xserver.if:276:	ifdef(`xdm.te', `
policy/modules/system/userdomain.if:478:	ifdef(`xdm.te', `
policy/modules/system/userdomain.if:492:	ifdef(`gnome.te', `
policy/modules/system/userdomain.if:681:	ifdef(`xdm.te', `
policy/modules/system/userdomain.if:690:	ifdef(`ftpd.te', `
policy/modules/system/userdomain.if:696:	ifdef(`useradd.te', `
policy/modules/system/userdomain.if:725:	ifdef(`syslogd.te', `
policy/modules/system/userdomain.if:928:	ifdef(`xserver.te', `
policy/modules/system/userdomain.if:935:	ifdef(`xdm.te', `
policy/modules/system/userdomain.if:944:	ifdef(`ftpd.te', `can_tcp_connect(ftpd_t, $1_t)')
policy/modules/system/userdomain.if:947:	ifdef(`rshd.te', `can_tcp_connect(rshd_t, $1_t)')

find policy/modules -name "*.te" -exec "grep" "-Hn" 'ifdef(`[a-z]*\.te' "{}" \;
policy/modules/admin/firstboot.te:132:ifdef(`printconf.te', `
policy/modules/admin/firstboot.te:136:ifdef(`userhelper.te', `
policy/modules/admin/firstboot.te:141:ifdef(`xserver.te', `
policy/modules/admin/logrotate.te:202:ifdef(`backup.te', `
policy/modules/services/bluetooth.te:213:ifdef(`xserver.te', `
policy/modules/services/bluetooth.te:219:	ifdef(`xdm.te',`
policy/modules/services/cron.te:432:	ifdef(`mta.te', `
policy/modules/services/portmap.te:136:ifdef(`rpcd.te',`can_udp_send(portmap_t, rpcd_t)')
policy/modules/services/portmap.te:140:ifdef(`lpd.te',`can_udp_send(portmap_t, lpd_t)')
policy/modules/services/remotelogin.te:176:ifdef(`alsa.te', `
policy/modules/services/samba.te:527:ifdef(`cups.te', `
policy/modules/services/squid.te:181:ifdef(`apache.te',`
policy/modules/services/squid.te:185:ifdef(`winbind.te', `
policy/modules/services/ssh.te:165:	ifdef(`xauth.te', `
policy/modules/services/xserver.te:454:ifdef(`rhgb.te', `
policy/modules/system/authlogin.te:247:ifdef(`xdm.te', `
policy/modules/system/init.te:699:	ifdef(`xserver.te', `
policy/modules/system/selinuxutil.te:392:ifdef(`dpkg.te', `
policy/modules/system/sysnetwork.te:181:	ifdef(`unconfined.te', `

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
