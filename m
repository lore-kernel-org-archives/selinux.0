Subject: Re: [PATCH 3/2] update return code checks for callers of
	expand_*rule_helper
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Jeremy A. Mowery" <jmowery@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <1154625684.12897.52.camel@Bishop.columbia.tresys.com>
References: <1154625684.12897.52.camel@Bishop.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 15:07:14 -0400
Message-Id: <1154632034.4205.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-03 at 13:21 -0400, Jeremy A. Mowery wrote:
> This patch applies over the previous two and replaces the hard coded 
> expand_*rule_helper() != 1 with a check for EXPAND_RULE_SUCCESS.
> 

Please post the entire patch set with the changes mentioned in the
comment. Reviewing incremental diffs without context is very difficult.
Adding a revision number to the patch set subject will also help.

Thanks,

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
