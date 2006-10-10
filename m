Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AJqakA027763
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 15:52:36 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AJpKvk020647
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 19:51:21 GMT
Message-ID: <452BF9EF.6050808@hp.com>
Date: Tue, 10 Oct 2006 15:52:15 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [RFC 1/2] Reference policy: NetLabel policy additions
References: <20061010171524.936739000@hp.com>	 <20061010172154.448485000@hp.com> <1160503804.20774.82.camel@sgc>
In-Reply-To: <1160503804.20774.82.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2006-10-10 at 13:15 -0400, paul.moore@hp.com wrote:
> 
>>plain text document attachment (netlabel-refpolicy_core)
>>This patch adds basic NetLabel support to the reference policy.
>  
> The main problem is that there are references to types that are not
> owned by this module.  These have to be changed to use interfaces that
> are provided by the modules that own the types.

Thanks for the comments.  I'll work on making the changes and post the updated
patches.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
