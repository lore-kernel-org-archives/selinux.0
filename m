Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAOINAU7027371
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2008 13:23:10 -0500
Received: from wf-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAOILCj8001042
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2008 18:21:12 GMT
Received: by wf-out-1314.google.com with SMTP id 28so3032556wff.30
        for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2008 10:23:09 -0800 (PST)
Subject: Re: Problem Setting Policy To Enforcing Mode
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: erahul29@yahoo.com
Cc: sds@tycho.nsa.gov, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <250575.6402.qm@web50204.mail.re2.yahoo.com>
References: <250575.6402.qm@web50204.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 24 Nov 2008 10:23:05 -0800
Message-Id: <1227550985.3191.4.camel@LiNuX>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-11-24 at 09:37 -0800, Rahul Jain wrote:
> Hi All,
>  
> Thanks you all, for your kind support. After your suggestion I was
> able to fix all my problems. So to put my policy in enforcing mode I
> deleted the "dontaudit" rule using "make enableaudit' . Then I did the
> fixes. My syslogd was taking long time to start because there were
> still some avc messages left, I fixed them and issue got resolved.  I
> was able to come back to permissive by adjusting the DAC permissions
> of the /etc/selinux/config file. My initial context on login was
> root:sysadm_r:sysadm_t. I checked the "sestatus" to see that my policy
> got loaded and that it is enforcing mode.
>  
> So finally my policy is up and running. 
>  
> Thanks and Regards
> Rahul 
>  
> 

Cool, glad you're up and running.

regards;


-- 
Justin P. Mattock <justinmattock@gmail.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
