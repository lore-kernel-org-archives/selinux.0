Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UGraeH007316
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 12:53:36 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3UGrYj8025032
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 16:53:34 GMT
Subject: Re: Patch to cleanup audit handling in policy.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20070430145914.7790.qmail@web51502.mail.re2.yahoo.com>
References: <20070430145914.7790.qmail@web51502.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 16:53:13 +0000
Message-Id: <1177951993.3570.115.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-30 at 07:59 -0700, Steve G wrote:
> >I'm not convinced that these are necessary.
> 
> The audit policy seems very broken. It allows way too much permission to
> applications.

I'm certainly not arguing that excessive permissions shouldn't be fixed.
I was just saying that I didn't agree with the method in this case.

>  The audit_control permission means that they can potentially delete
> audit rules or change the loginuid. That should not be handed out like candy. 

This is not really a compelling argument for assertions as there are far
worse things that have much farther reaching consequences that don't
have assertions, such as writing to shlib_t, bin_t, and shell_exec_t
files.

> The interfaces that Dan created allows the exact kind of permission to be applied
> without having to copy and paste individual permissions which is error prone.
> (There are only 4 use cases of the audit system.) Part of what makes it error
> prone is the naming convention for all the pieces. Example: "audit_write" is that
> for the capability, the netlink interface, or audit logs?

This is the reason policy patterns exist.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
