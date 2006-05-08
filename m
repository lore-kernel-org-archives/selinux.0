Subject: Re: [PATCH] fix warnings in selinux-usr
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>,
        selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <1147101370.32719.30.camel@jackjack.columbia.tresys.com>
References: <1146845884.2208.15.camel@jackjack.columbia.tresys.com>
	 <1147092580.23640.15.camel@moss-spartans.epoch.ncsc.mil>
	 <1147094001.32719.12.camel@jackjack.columbia.tresys.com>
	 <1147101370.32719.30.camel@jackjack.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 11:50:03 -0400
Message-Id: <1147103403.23640.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-08 at 11:16 -0400, Karl MacMillan wrote:
> Looks like I cut-and-paste from the wrong window. Attached is a patch to
> revert this change until we have had a chance to test it for
> side-effects.

Ok, reverted.  Note that we originally resolved this problem by changing
checkpolicy to move role/user requires processing to the 2nd pass.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
