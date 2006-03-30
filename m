Subject: Re: [PATCH] typo fix for corenetwork.if.m4
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: James Athey <jathey@tresys.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200603301331.18106.jathey@tresys.com>
References: <200603301331.18106.jathey@tresys.com>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 16:04:37 -0500
Message-Id: <1143752677.13732.64.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-03-30 at 13:31 -0500, James Athey wrote:
> The generated interfaces for netifs in corenetwork.if.m4 have a typo in 
> corenet_raw_sendrecv_$1_if, where
> 
> corenet_raw_send_$1(dollarsone)
> corenet_raw_receive_$1(dollarsone)
> 
> should read
> 
> corenet_raw_send_$1_if(dollarsone)
> corenet_raw_receive_$1_if(dollarsone)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
