Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBP62OIi010744
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 01:02:25 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBP60Zmu022027
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 06:00:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: zia.syed@smartweb.rgu.ac.uk
Subject: Re: fedora core 3, httpd and PHP exec()
Date: Sat, 25 Dec 2004 17:02:14 +1100
Cc: selinux@tycho.nsa.gov
References: <41CCEEB5.3040200@gmail.com>
In-Reply-To: <41CCEEB5.3040200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412251702.17953.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 25 December 2004 15:38, Zia Syed <zia.chacho@gmail.com> wrote:
> I'm running PHP in safe mode, and trying to run system command (uptime)
> in exec() statement. When i turn off the selinux (via firewall settings
> in KDE), the script works fine, but when its enabled, i get the
> following error in /var/log/messages
>
> Dec 25 04:15:26 melville kernel: audit(1103948126.072:0): avc:  denied
> { read }
>  for  pid=5926 exe=/usr/sbin/httpd name=sh dev=hda2 ino=670441
> scontext=root:sys
> tem_r:httpd_t tcontext=system_u:object_r:bin_t tclass=lnk_file
> Dec 25 04:17:46 melville kernel: audit(1103948266.882:0): avc:  denied
> { read }
>  for  pid=5944 exe=/usr/sbin/httpd name=sh dev=hda2 ino=670441
> scontext=root:sys
> tem_r:httpd_t tcontext=system_u:object_r:bin_t tclass=lnk_file

We should allow it to read such sym-links.

Probably the best thing to do for executing programs via system(3) (as it 
seems PHP is doing) is to have a domain_auto_trans() rule.

Maybe domain_auto_trans(httpd_t, shell_exec_t, httpd_sys_script_t)?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
