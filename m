Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7C2ZGp3007471
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 22:35:16 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7C2ZE8W008675
	for <selinux@tycho.nsa.gov>; Fri, 12 Aug 2011 02:35:15 GMT
Message-ID: <4E449158.1000408@windriver.com>
Date: Fri, 12 Aug 2011 10:35:04 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: <cpebenito@tresys.com>, <method@manicmethod.com>, <selinux@tycho.nsa.gov>
Subject: Re: [v0 PATCH 1/1] Only call role_fix_callback for base.p_roles during
 expansion.
References: <1312279433-2866-1-git-send-email-qingtao.cao@windriver.com> <1312279433-2866-2-git-send-email-qingtao.cao@windriver.com> <4E43E195.5090202@tresys.com>
In-Reply-To: <4E43E195.5090202@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Steve,

Steve Lawrence 写道:
> However, I did find what appears to be an unrelated problem. It looks
> like the role attributes are getting written to the policy db as if they
> were roles. I don't think this will break anything (I think), but
> considering that the kernel doesn't know anything about role_attributes,
> it seems odd to me that they are in the binary.
>
> Note: I found this by looking at a downgraded policy.24 in apol, so this
> could potentially be a downgrade issue. But from looking at the code, I
> believe role attributes are being written as if they're roles.
>
> - Steve
>
>   
>
You are right!

The role attribute's destination would have been fulfilled at the expand
stage when its types.types ebitmap populated to all its sub regular
roles, thus there is no need to write role attribute's role_datum_t to
policy.X at all. This won't cause any harm, but redundant.

We could bail out from role_write() when finding out the current datum
is a role attribute while writing to policy.X. I would send out a patch
later today.

BTW, I'd also noticed role attribute by apol but I didn't realize what
you have realized, so it's always beneficial to have others review your
patches :-)

Thanks!

Cheers,
Harry

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
