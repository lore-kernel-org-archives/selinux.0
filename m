Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1OEHoD4027216
	for <selinux@tycho.nsa.gov>; Fri, 24 Feb 2012 09:17:51 -0500
Message-ID: <4F479C0A.6070102@tresys.com>
Date: Fri, 24 Feb 2012 09:17:46 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Harry Ciao <qingtao.cao@windriver.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] role_fix_callback skips out-of-scope roles during
 expansion.
References: <1330067550-9744-1-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1330067550-9744-1-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/24/12 02:12, Harry Ciao wrote:
> If a role identifier is out of scope it would be skipped over during
> expansion, accordingly, be it a role attribute, it should be skipped
> over as well when role_fix_callback tries to propagate its capability
> to all its sub-roles.
> 
> BTW, it's worthwhile to note that the symtab and rules of an optional
> block in a loadable module will be written to its pp. However, for the
> base module the entire optional block will be omitted if its exterior
> dependency cannot be properly satisfied.

This doesn't sound correct.  If optionals don't exist in the base module, then that would be a significant problem for current policy.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
