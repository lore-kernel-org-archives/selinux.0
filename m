Subject: Re: reserved_port_type attribute
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1127758842.19016.163.camel@moss-spartans.epoch.ncsc.mil>
References: <1127757038.32172.22.camel@sgc.columbia.tresys.com>
	 <1127758842.19016.163.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 14:28:56 -0400
Message-Id: <1127759336.19016.167.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-26 at 14:20 -0400, Stephen Smalley wrote:
> If checkpolicy were enhanced to prune unnecessary auditallow and
> dontaudit rules after collecting all allow rules, then it would do no
> harm to add reserved_port_t to the attribute.  At present, you'll bloat
> the policy slightly by doing it because checkpolicy isn't smart enough
> to drop the extraneous dontaudit rule for the allowed case.

Except that in this case, since the rules are in terms of an attribute,
it shouldn't matter much in policy.20.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
