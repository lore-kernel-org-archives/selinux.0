Subject: RE: How to configure and reload selinux policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Jin, Yihua" <yihua.jin@intel.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, SELinux@tycho.nsa.gov
In-Reply-To: <117E3EB5059E4E48ADFF2822933287A40176C6BF@pdsmsx404.ccr.corp.intel.com>
References: 
	 <117E3EB5059E4E48ADFF2822933287A40176C6BF@pdsmsx404.ccr.corp.intel.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 14:45:52 -0400
Message-Id: <1158950752.7748.253.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 09:28 +0800, Jin, Yihua wrote:
> This policy has no Boolean allow_execmem defined initially and I add
> this Boolean switch. after reload, this Boolean appears
> in /selinux/Booleans, but not in /etc/selinux/targeted/booleans file,
> I don't know what is the relationship between these two locations 
> Actually, what I want to know is how to make a modified policy take effect.

/selinux/booleans shows you the runtime state of the booleans in the
currently loaded policy, so if the boolean appears there, you have
successfully loaded your new policy into the kernel.   You can cat that
file or run 'getsebool allow_execmem' to see the current runtime value
of the boolean. 

> For this problem, I've update kernel to 2.6.11.7 and confirm the kernel has such check.

Then I'd again note that if any other allow rule in the policy allows
execmem permission, it will still be allowed regardless of this boolean,
since allow rules are additive, and you would need to modify the
unconfined_domain() macro as I said in my other message to completely
eliminate execmem from unconfined_t there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
