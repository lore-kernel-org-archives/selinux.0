Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UIRKrT025449
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 14:27:20 -0400 (EDT)
Message-ID: <415C5003.2090500@redhat.com>
Date: Thu, 30 Sep 2004 14:27:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: New policy diff
References: <415AAE8C.5050102@redhat.com> <1096564073.8418.11.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1096564073.8418.11.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:

>Isn't this sufficient?
>
>allow inetd_t ftpd_exec_t:file execute;
>
>
>On Wed, 2004-09-29 at 08:46, Daniel J Walsh wrote:
>  
>
>>Added policy for vpnc.
>>Mailman location on redhat is changing.
>>More fixes for xinetd apps
>>
>>
>>______________________________________________________________________
>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.17.23/domains/program/unused/ftpd.te
>>--- nsapolicy/domains/program/unused/ftpd.te	2004-09-01 11:17:48.000000000 -0400
>>+++ policy-1.17.23/domains/program/unused/ftpd.te	2004-09-28 10:46:55.000000000 -0400
>>@@ -44,6 +44,8 @@
>> rw_dir_create_file(ftpd_t, var_lock_t)
>> allow ftpd_t ftp_port_t:tcp_socket name_bind;
>> can_tcp_connect(userdomain, ftpd_t)
>>+# Allows it to check exec privs on daemon
>>+can_exec(inetd_t, ftpd_exec_t)
>> }
>> ifdef(`inetd.te', `
>> if (!ftpd_is_daemon) {
>>    
>>
>
>  
>
Yes

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
