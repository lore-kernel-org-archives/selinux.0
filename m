Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p42IftRV001475
	for <selinux@tycho.nsa.gov>; Mon, 2 May 2011 14:41:56 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p42IfsOB002438
	for <selinux@tycho.nsa.gov>; Mon, 2 May 2011 18:41:55 GMT
Message-ID: <4DBEFB34.5070905@tresys.com>
Date: Mon, 2 May 2011 14:43:00 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Chad Sellers <csellers@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Checkpolicy patch to allow version of single digit.
References: <4D125518.8030405@redhat.com>
In-Reply-To: <4D125518.8030405@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/22/2010 02:44 PM, Daniel J Walsh wrote:
> Currently policy will not build if I define a module as 1
> 
> policy_module(dan,1) Fails
> 
> 
> policy_module(dan,1.0) works
> 
> The attached patch makes the first one work.
> 

Applied in checkpolicy-2.0.25

Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
