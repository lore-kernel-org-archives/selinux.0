Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NHVWrT011067
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 13:31:35 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NHUWv8002912
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 17:30:33 GMT
Message-ID: <41530866.4020306@redhat.com>
Date: Thu, 23 Sep 2004 13:31:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "James R. Marcus" <jmarcus@mvalent.net>
CC: selinux@tycho.nsa.gov
Subject: Re: bash_profile: Permission denied
References: <E6E16A6D4277CD459BBDE6713766033CB71F3E@exchange.mvalent.local>
In-Reply-To: <E6E16A6D4277CD459BBDE6713766033CB71F3E@exchange.mvalent.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James R. Marcus wrote:

>When I login in enforced mode I get this error as root:
>-bash: /root/.bash_profile: Permission denied
>ftp root # pwd       
>/root
>ftp root # ls -aZ
>ls: .: Permission denied
>ftp root #
>
>I thought it might be a labeling issue so I ran this command:
>ftp domains # newrole -r sysadm_r
>Authenticating root.
>Password: 
>ftp domains # cd /
>ftp / # setfiles /etc/security/selinux/file_contexts /root/
>setfiles:  read 575 specifications
>setfiles:  labeling files under /root/
>setfiles:  hash table stats: 5 elements, 5/65536 buckets used, longest
>chain length 1
>setfiles:  Done.
>
>I'm not getting any messages in /var/log/messages when I avc_toggle.
>
>
>Am I on the right track?
>
>James
>  
>
The problem is probably that you are logging as staff_r and the 
directory is sysadm_r.
At login do an id -Z to see what context you have,
then do the newrole -r sysadm_r and see if you have access to the directory.

Dan

>
>
>
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
