Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9HAZQWt008207
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 06:35:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9HAZPmR008913
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 10:35:25 GMT
Received: from mail2.iitk.ac.in ([203.197.196.2])
        by jazzband.ncsc.mil  with ESMTP id h9HAZLjp008906 for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 10:35:24 GMT
Received: from antivirus.cc.iitk.ac.in (antivirus.cc.iitk.ac.in [172.31.1.102])
	by mail2.iitk.ac.in (8.12.8/8.12.8) with SMTP id h9HAohoO009657
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 16:20:55 +0530
Received: from iitk.ac.in ([172.31.77.127])
 by antivirus.cc.iitk.ac.in (NAVGW 2.5.2.12) with SMTP id M2003101716044112422
 for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 16:04:41 +0530
Message-ID: <3F8FC612.2090105@iitk.ac.in>
Date: Fri, 17 Oct 2003 16:06:02 +0530
From: kamal <kamalnee@iitk.ac.in>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: process context
References: <3F8EEA16.8090908@ipen.br> <200310171327.31980.russell@coker.com.au>
In-Reply-To: <200310171327.31980.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>I guess that at boot time the init process (usually /sbin/init) was not 
>labeled with init_exec_t, that caused init to be run in kernel_t.
>  
>
But why does this happen? I also had the same problem, and because getty 
process is not labeled properly, login fails to get default context.

Output of "ls --context /sbin/init" is:
-rwxr-xr-x  root     root     system_u:object_r:init_exec_t    /sbin/init



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
