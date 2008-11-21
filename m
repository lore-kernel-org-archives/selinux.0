Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mALFk401005248
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2008 10:46:04 -0500
Received: from wf-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mALFi9av019948
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2008 15:44:10 GMT
Received: by wf-out-1314.google.com with SMTP id 28so1309617wff.30
        for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2008 07:46:03 -0800 (PST)
Subject: Re: Problem Setting Policy To Enforcing Mode
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: erahul29@yahoo.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <459507.37401.qm@web50206.mail.re2.yahoo.com>
References: <459507.37401.qm@web50206.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Fri, 21 Nov 2008 07:45:59 -0800
Message-Id: <1227282359.3138.1.camel@LiNuX>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-11-21 at 06:59 -0800, Rahul Jain wrote:
> Hi All,
>  
> This is the first time I am writing to this mailing list in hope of
> receiving help. I am trying to port reference policy by tresys on
> Montavista. I am able to run the policy well in permmisive mode with
> no avc messages in audit log, kern.log or messages. But when I put the
> policy into enforcing mode my system fails to boot, reason seems to
> be problem with init process. I am not able to debug the problem
> because no avc messages are generated for the same, probably because
> the issue comes up even before logging deamons start. Is there anyway
> I can debug my policy and log the avc messages from the very beginning
> of the system startup.
>  
> Rahul Jain
> Rahul Jain  
> 

Have you tyied the command "make enableaudit"
should open the policy up more and generate avc's.
regards;

-- 
Justin P. Mattock <justinmattock@gmail.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
