Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7DL0DrT026596
	for <selinux@tycho.nsa.gov>; Fri, 13 Aug 2004 17:00:13 -0400 (EDT)
Received: from mail.mvalent.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7DKxZUu000548
	for <selinux@tycho.nsa.gov>; Fri, 13 Aug 2004 20:59:35 GMT
Subject: RE: vsftpd and security labels
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 13 Aug 2004 17:00:13 -0400
Message-ID: <E6E16A6D4277CD459BBDE6713766033CA50DF8@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: "Joshua Brindle" <jbrindle@tresys.com>,
   "Stephen Smalley" <sds@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>
Cc: "Joshua Brindle" <jbrindle@snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Does that mean there is a bug?

James

-----Original Message-----
From: Joshua Brindle [mailto:jbrindle@tresys.com] 
Sent: Friday, August 13, 2004 4:52 PM
To: Stephen Smalley
Cc: James R. Marcus; Joshua Brindle
Subject: Re: vsftpd and security labels

A quick glance over the ftpd.te shows that you are right, there is no 
transition from initrc_t to ftpd_t, the only auto_trans specified in 
ftpd.te (which I believe I got from the nsa policy) is from inetd_t and 
tcpd_t.

Joshua Brindle

Stephen Smalley wrote:

> On Fri, 2004-08-13 at 16:30, James R. Marcus wrote:
> 
>>ftp root # audit2allow -l -d -v
>>ftp root # /etc/init.d/vsftpd restart
>>Authenticating root.
>>Password: 
>> * Stopping vsftpd...
>>[ ok ]
>> * Starting vsftpd...
>>[ ok ]
>>ftp root # ps -eZ | grep vsftpd
>>29019 system_u:system_r:initrc_t               /usr/sbin/vsftpd
>>/etc/vsftpd/vsftpd.conf
>>ftp root #
>>
>>ftp root # ls -Z /usr/sbin/vsftpd 
>>-rwxr-xr-x  root root system_u:object_r:ftpd_exec_t /usr/sbin/vsftpd
>>ftp root #
>>
>>I was planning to write up some documentation once resolved.
>>Should I send these emails to the SElinux list?
> 
> 
> So, vsftpd is labeled correctly, but /etc/init.d/vsftpd restart is not
> putting it into the correct domain (ftpd_t).  Is the type transition
> rule defined in your policy, e.g.
> 	grep 'type_transition initrc_t ftpd_exec_t' policy.conf
> 
> If it is, then try restarting via run_init by hand,
> 	run_init /etc/init.d/vftpd restart
> 
> That shouldn't be necessary on Gentoo, since run_init is directly
> integrated, but might be worth trying.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
