Subject: Re: Newrole in targeted mode
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: jsingh@ensim.com
Cc: kwade@redhat.com, Matthew Leinhos <leinhos@lamar.colostate.edu>,
   nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1104729116.8446.9.camel@jsingh>
References: <1104259373.22401.0.camel@hawaii.grays-systems.com>
	 <1104259847.21391.107.camel@moss-spartans.epoch.ncsc.mil>
	 <1104388628.3140.4.camel@jsingh>  <1104665427.9831.13.camel@erato.phig.org>
	 <1104729116.8446.9.camel@jsingh>
Content-Type: text/plain
Message-Id: <1104761692.16598.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 Jan 2005 09:14:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-03 at 00:11, Jaspreet Singh wrote:
> I understand that .. But does the system makes *any* assumptions about
> the target or strict policies ??

No, the enforcement mechanism is the same, only the policy differs.  But
the policies differ substantially, including boot-time definitions like
initial SID contexts that cannot be changed without a reboot, and they
differ structurally, e.g. targeted policy has nothing set up for user
roles at present.  It should be easier to take strict policy and strip
down the set of program domains than to add user roles to targeted
policy, IMHO.

> So, i can just borrow code from strict policy to add more domains and
> roles to target policy.
> 
> I am right ??

Strictly speaking, yes.  But strict policy already gives you what you
want structurally, i.e. user roles and domains as well as program
domains, and you can strip down the set of program domains.  In
contrast, targeted policy only gives you program domains and nothing for
users, so you have to do more work to do what you describe (IMHO).

> And Also how can i make the selinux understand a policy tree
> *intermediate* under /etc/selinux/  and load policy from there ....

Just create the directory, populate it with your policy files, and set
SELINUXTYPE to it in /etc/selinux/config.  Then reboot to single-user
mode (with enforcing=0) and relabel against your policy, and reboot
again.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
