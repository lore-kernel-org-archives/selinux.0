Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NIDIrT011531
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 14:13:18 -0400 (EDT)
Received: from mail.mvalent.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NICDv8006171
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 18:12:19 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: bash_profile: Permission denied
Date: Thu, 23 Sep 2004 14:13:03 -0400
Message-ID: <E6E16A6D4277CD459BBDE6713766033CB71F9E@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is the right way to deal with this issue?  When root logs in should
they automatically be in the sysadm_r role or should these files be
labeled with staff_r?


Do I need to change this in /etc/security/selinux/file_contexts ?

This is what I have in file_contexts:
#
# User-specific file contexts
#
/root           -d      root:object_r:sysadm_home_dir_t
/root/.+                        root:object_r:sysadm_home_t
/root/\.ssh(/.*)?               root:object_r:sysadm_home_ssh_t
/root/.default_contexts --      system_u:object_r:default_context_t
/root/.ccache(/.*)?             system_u:object_r:sysadm_ccache_t


Thanks,
James
-----Original Message-----
From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
Sent: Thursday, September 23, 2004 1:31 PM
To: James R. Marcus
Cc: selinux@tycho.nsa.gov
Subject: Re: bash_profile: Permission denied

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
then do the newrole -r sysadm_r and see if you have access to the
directory.

Dan

>
>
>
>
>--
>This message was distributed to subscribers of the selinux mailing
list.
>If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
