Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7DL8NrT026669
	for <selinux@tycho.nsa.gov>; Fri, 13 Aug 2004 17:08:23 -0400 (EDT)
Received: from mail.mvalent.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7DL8LRl025078
	for <selinux@tycho.nsa.gov>; Fri, 13 Aug 2004 21:08:22 GMT
Subject: RE: vsftpd and security labels
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 13 Aug 2004 17:08:23 -0400
Message-ID: <E6E16A6D4277CD459BBDE6713766033CA50DFB@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "Joshua Brindle" <jbrindle@snu.edu>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ftp policy # pwd
/etc/security/selinux/src/policy
ftp policy # grep 'type_transition initrc_t ftpd_exec_t' policy.conf
type_transition initrc_t ftpd_exec_t:process ftpd_t;
ftp policy #

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil] 
Sent: Friday, August 13, 2004 4:40 PM
To: James R. Marcus
Cc: Joshua Brindle
Subject: RE: vsftpd and security labels

On Fri, 2004-08-13 at 16:30, James R. Marcus wrote:
> ftp root # audit2allow -l -d -v
> ftp root # /etc/init.d/vsftpd restart
> Authenticating root.
> Password: 
>  * Stopping vsftpd...
> [ ok ]
>  * Starting vsftpd...
> [ ok ]
> ftp root # ps -eZ | grep vsftpd
> 29019 system_u:system_r:initrc_t               /usr/sbin/vsftpd
> /etc/vsftpd/vsftpd.conf
> ftp root #
> 
> ftp root # ls -Z /usr/sbin/vsftpd 
> -rwxr-xr-x  root root system_u:object_r:ftpd_exec_t /usr/sbin/vsftpd
> ftp root #
> 
> I was planning to write up some documentation once resolved.
> Should I send these emails to the SElinux list?

So, vsftpd is labeled correctly, but /etc/init.d/vsftpd restart is not
putting it into the correct domain (ftpd_t).  Is the type transition
rule defined in your policy, e.g.
	grep 'type_transition initrc_t ftpd_exec_t' policy.conf

If it is, then try restarting via run_init by hand,
	run_init /etc/init.d/vftpd restart

That shouldn't be necessary on Gentoo, since run_init is directly
integrated, but might be worth trying.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
