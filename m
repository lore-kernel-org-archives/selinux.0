Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rADG0biX003987
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2013 11:00:37 -0500
Received: from roary.micron.com (roary.uk.virtensys.com [86.15.121.9])
	(authenticated bits=0)
	by goalkeeper.city-fan.org (8.14.7/8.14.7) with ESMTP id rADG0XTs031604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2013 16:00:33 GMT
Message-ID: <5283A220.2080305@city-fan.org>
Date: Wed, 13 Nov 2013 16:00:32 +0000
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SELinux Coloring book?
References: <52839664.1080600@redhat.com>
In-Reply-To: <52839664.1080600@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 13/11/13 15:10, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> New article on opensource.com describing SELinux enforcement in simple terms.
>   Check it out.
>
> http://opensource.com/business/13/11/selinux-policy-guide

SELinux was in RHEL 4, not just since RHEL 6. We still have an EL4 box 
on extended life support here with SELinux enforcing.

# sestatus
SELinux status:		enabled
SELinuxfs mount:	/selinux
Current mode:		enforcing
Mode from config file:	enforcing
Policy version:		18
Policy from config file:targeted

Policy booleans:
allow_syslog_to_console	inactive
allow_ypbind		inactive
dhcpd_disable_trans	inactive
httpd_builtin_scripting	active
httpd_disable_trans	inactive
httpd_enable_cgi	active
httpd_enable_homedirs	active
httpd_ssi_exec		active
httpd_tty_comm		inactive
httpd_unified		active
mysqld_disable_trans	inactive
named_disable_trans	inactive
named_write_master_zonesinactive
nscd_disable_trans	inactive
ntpd_disable_trans	inactive
pegasus_disable_trans	inactive
portmap_disable_trans	inactive
postgresql_disable_transinactive
snmpd_disable_trans	inactive
squid_disable_trans	inactive
syslogd_disable_trans	inactive
use_nfs_home_dirs	inactive
use_samba_home_dirs	inactive
use_syslogng		inactive
winbind_disable_trans	inactive
ypbind_disable_trans	inactive
# cat /etc/redhat-release
Red Hat Enterprise Linux ES release 4 (Nahant Update 9)

Of course, things have changed quite a bit since EL4...

Paul.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
