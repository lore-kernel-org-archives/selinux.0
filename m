Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA05823
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 13:45:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA08649
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 18:41:50 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA08641
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 18:41:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>, <selinux@tycho.nsa.gov>
Subject: Re: Core policy, second pass
Date: Wed, 26 Feb 2003 19:44:38 +0100
References: <Pine.LNX.4.33.0302260856550.3682-100000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0302260856550.3682-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302261944.38544.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 26 Feb 2003 14:58, Wayne Salamon wrote:
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

sxid probably doesn't belong in a core policy, when running SE Linux you 
aren't so concerned about the presense of SUID binaries anyway.

bootloader should be considered as optional, it is not needed on a Cobalt Qube 
or RaQ for example.

dhcpc, lpr, and lpd can be considered as optional and not required in a core 
policy, most Linux machines don't have lpd, and static IP addresses offer 
benefits for security.

>   I needed to change two of the macros so far (see attached patch). Being

Unfortunately no patch was attached.

>   Comments? Any of the above that are unnecessary? Any not included that
> are necessary? I know rpm.te could probably be removed as well, but if
> users typically query installed packages, I think it's needed.

>From a quick review of the policy it appears that rpm_t is only used for cron 
jobs.  If you just leave /var/lib/rpm labelled as var_lib_t then the user 
should be able to query installed packages.

For Debian you can happily run a system without dpkg.te and users can query 
packages (I haven't actually tested this but if there is any problem in doing 
so I'll consider it a bug - but I'm familiar enough with this policy that I 
don't think there is such a bug).  dpkg.te is only needed for package 
installation, removal, and reconfiguration.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
