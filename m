Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA10548
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 08:48:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA25251
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 13:45:17 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id NAA25247
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 13:45:17 GMT
Message-Id: <200302271356.IAA16143@moss-shockers.ncsc.mil>
Date: Thu, 27 Feb 2003 08:56:03 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Core policy, second pass
To: selinux@tycho.nsa.gov, wsalamon@tislabs.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Wayne Salamon wrote:
> Here's a list of policy files I used:
> 
> atd.te          dhcpc.te     ldconfig.te     newrole.te     su.te
> automount.te    fsadm.te     load_policy.te  sxid.te
> bootloader.te   getty.te     login.te        passwd.te      syslogd.te
> checkpolicy.te  ifconfig.te  logrotate.te    ping.te        tmpreaper.te
> chkpwd.te       inetd.te     lpd.te          portmap.te
> crond.te        initrc.te    lpr.te          rpm.te         useradd.te
> crontab.te      init.te      modutil.te      selopt.te      utempter.te
> ipchains.te     mount.te     setfiles.te
> devfsd.te       klogd.te     netutils.te     ssh.te

atd.te is really just a stub; notice that there is no corresponding
domain for the client.  For safe usage of atd, I think that you really
need an equivalent to the crond patch and a policy similar to the
crond/crontab policies.  Since the man page for atd specifically mentions
that its functionality should be merged into cron, I'm not sure whether
it is worthwhile to work on such a patch and policy for it.

It isn't clear to me that automount.te, ipchains.te, dhcpc.te,
lp[rd].te, sxid.te, or utempter.te should really be included in this
list.  Nothing specific against them, just not clear that they are "core".

I'd recommend disabling devfsd.te by default, as a number of users will
not be using it at all, and since the existing devfsd domain is granted
a number of sensitive permissions and is given rather permissive access
to many types.  Of course, the last part can be addressed by a careful
audit and reduction, but the first two points would still remain.

I think that the rpm.te file is presently only used for the associated
cron job.  When run by sysadm_t, rpm remains in the calling domain, and
sysadm_t has the necessary permissions at present to perform package
management.  If you wanted to use rpm_t for general administrator use
of rpm, you would have to grant it far more permissions (at which point
you really want a separate domain for the cron job, which is much more
limited in scope).  In any event, rpm.te doesn't need to be core.

I'd suggest that selopt.te be disabled by default, since the corresponding
kernel option is experimental and disabled by default (in 2.4).

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
