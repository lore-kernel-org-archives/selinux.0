Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAC10aIi008377
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2004 20:00:36 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAC0x9q4009711
	for <selinux@tycho.nsa.gov>; Fri, 12 Nov 2004 00:59:12 GMT
Message-ID: <41940B2E.10303@redhat.com>
Date: Thu, 11 Nov 2004 20:00:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: How come security_get_boolean_pending returns true when a	boolean
 is on.
References: <419373C8.8050701@redhat.com> <1100206422.28882.15.camel@selinux>
In-Reply-To: <1100206422.28882.15.camel@selinux>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

>On Thu, 2004-11-11 at 09:14 -0500, Daniel J Walsh wrote:
>  
>
>>getsebool -a
>>mozilla_writehome --> active: 1 pending: 1
>>named_write_master_zones --> active: 0 pending: 0
>>nfs_export_all_ro --> active: 0 pending: 0
>>nfs_export_all_rw --> active: 0 pending: 0
>>read_default_t --> active: 1 pending: 1
>>run_ssh_inetd --> active: 0 pending: 0
>>secure_mode --> active: 0 pending: 0
>>spamassasin_can_network --> active: 0 pending: 0
>>ssh_sysadm_login --> active: 1 pending: 1
>>staff_read_sysadm_file --> active: 1 pending: 1
>>    
>>
>
>The active and pending should be the same unless someone is intending to
>change it, but hasn't committed the changes.  So in this example:
>
>  
>
>>Shouldn't this be
>>staff_read_sysadm_file --> active: 1 pending: 0
>>    
>>
>
>this would mean that someone has done a
>security_set_boolean("staff_read_sysadm_file",0), but hasn't done a
>security_commit_booleans() yet.  After you commit it, the bool will be
>active 0, pending 0.  Then subsequent commits will not change the value
>since the pending is the same as the active.  If active and pending were
>always opposite, you'd be toggling all of the booleans on every
>security_commit_booleans().
>
>  
>
That is what I figured out after I sent the mail.  So I have changed 
getsebool to report.

allow_xserver_home_fonts --> inactive
allow_ypbind --> inactive
cron_can_relabel --> inactive
disable_games --> inactive pending --> avtive
(active and pending differ)
ftp_home_dir --> active
ftpd_is_daemon --> active
httpd_enable_cgi --> active
httpd_enable_homedirs --> active
httpd_ssi_exec --> active  pending --> inactive


Which I think is much more understandable.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
