Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBRCwNIi017124
	for <selinux@tycho.nsa.gov>; Mon, 27 Dec 2004 07:58:23 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBRCwQJq025922
	for <selinux@tycho.nsa.gov>; Mon, 27 Dec 2004 12:58:26 GMT
Message-ID: <41D00639.10102@redhat.com>
Date: Mon, 27 Dec 2004 07:55:21 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: zia.syed@smartweb.rgu.ac.uk, selinux@tycho.nsa.gov
Subject: Re: fedora core 3, httpd and PHP exec()
References: <41CCEEB5.3040200@gmail.com> <200412251702.17953.russell@coker.com.au>
In-Reply-To: <200412251702.17953.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Saturday 25 December 2004 15:38, Zia Syed <zia.chacho@gmail.com> wrote:
>  
>
>>I'm running PHP in safe mode, and trying to run system command (uptime)
>>in exec() statement. When i turn off the selinux (via firewall settings
>>in KDE), the script works fine, but when its enabled, i get the
>>following error in /var/log/messages
>>
>>Dec 25 04:15:26 melville kernel: audit(1103948126.072:0): avc:  denied
>>{ read }
>> for  pid=5926 exe=/usr/sbin/httpd name=sh dev=hda2 ino=670441
>>scontext=root:sys
>>tem_r:httpd_t tcontext=system_u:object_r:bin_t tclass=lnk_file
>>Dec 25 04:17:46 melville kernel: audit(1103948266.882:0): avc:  denied
>>{ read }
>> for  pid=5944 exe=/usr/sbin/httpd name=sh dev=hda2 ino=670441
>>scontext=root:sys
>>tem_r:httpd_t tcontext=system_u:object_r:bin_t tclass=lnk_file
>>    
>>
>
>We should allow it to read such sym-links.
>
>Probably the best thing to do for executing programs via system(3) (as it 
>seems PHP is doing) is to have a domain_auto_trans() rule.
>
>Maybe domain_auto_trans(httpd_t, shell_exec_t, httpd_sys_script_t)?
>
>  
>
Reading the policy, it looks like if you set the boolean httpd_ssi_exec 
you get this rule.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
