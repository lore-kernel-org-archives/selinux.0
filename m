Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1M7YEdW021123
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 02:34:16 -0500 (EST)
Received: from oe-im1.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1M7VuZE018243
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 07:32:00 GMT
Subject: Re: What is typealias and typeattribute
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <4219E45B.2020501@kaigai.gr.jp>
References: <4219E45B.2020501@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 21 Feb 2005 11:56:30 -0500
Message-Id: <1109004990.3073.85.camel@selinux>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-02-21 at 22:38 +0900, KaiGai Kohei wrote:
> I noticed some sentence structures not to understand the meaning well,
> when I read policy_parse.y in checkpolicy.tgz.
> 
> I think we can replace 'typealias' and 'typeattribute' with
> 'type ...' sentence structure completely.
> So, It's not writen in 'Configuring the SELinux Policy', orz.
> 
> Is it historical syntax? or does it have another purpose?
> Please tell me.

Typealias and typeattribute are recent additions, added since that
document was written.  The original syntax only allowed applying an
alias or an attribute on the type statement, as described in that doc.
For example:

type etc_dhcp_t alias { etc_dhcpc_t etc_dhcpd_t }, file_type, sysadmfile;

However this is problematic if this is type statement is inside a macro,
since you might not want to add aliases and attributes in general, or
there are many types declared in the macro.  So typealias and
typeattribute were created so aliases and attributes could be added
outside the type statement.  If we wanted to add an alias and an
attribute to a type created by the tmpfs_domain macro, it would look
like this:

tmpfs_domain(foo)
typealias foo_tmpfs_t alias foo_shm_t;
typeattribute foo_tmpfs_t myattribute;

We do want to keep both syntaxes, since both are used in the policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
