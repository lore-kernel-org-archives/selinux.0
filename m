Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OKxVsj029623
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 15:59:31 -0500 (EST)
Message-ID: <41F561B3.5090907@redhat.com>
Date: Mon, 24 Jan 2005 15:59:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: libselinux rpm_execon should not fail in permissive mode.
References: <41F03552.90806@redhat.com>	 <1106596929.3298.9.camel@moss-lions.epoch.ncsc.mil>	 <41F55E02.6090302@redhat.com> <1106599610.19246.255.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1106599610.19246.255.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2005-01-24 at 15:43, Daniel J Walsh wrote:
>  
>
>>diff --exclude-from=exclude -N -u -r nsalibselinux/src/rpm.c libselinux-1.21.1/src/rpm.c
>>--- nsalibselinux/src/rpm.c	2004-11-09 09:13:54.000000000 -0500
>>+++ libselinux-1.21.1/src/rpm.c	2005-01-24 15:24:33.000000000 -0500
>>@@ -41,8 +41,10 @@
>> 	rc = setexeccon(newcon);
>> 	if (rc < 0) 
>> 		goto out;
>>-	rc = execve(filename, argv, envp);
>> out:
>>+	if ( ( rc == 0 ) || 
>>+	     (security_getenforce() == 0 ))
>>+	  rc = execve(filename, argv, envp);
>> 	context_free(con);
>> 	freecon(newcon);
>> 	freecon(fcon);
>>    
>>
>
>What failure are you encountering in permissive mode?  Possibly the file
>might lack a context and we should handle that more cleanly, but I
>wouldn't recommend this patch.  The setexeccon() shouldn't fail in
>permissive mode.
> 
>  
>
Basically running rpm --root

Bugzilla %145770


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
