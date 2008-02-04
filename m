Subject: Re: su problems again
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1202151733.2801.116.camel@bluejay.goodinassociates.com>
References: <1202151733.2801.116.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Mon, 04 Feb 2008 14:11:58 -0500
Message-Id: <1202152318.3070.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-04 at 13:02 -0600, Jeremiah Jahn wrote:
> Is there some way to turn of the dontaudit  w/ the refpolicy and a
> module policy build. make enableaudit seems to only change the base
> policy, and not any of the policies that actually do anything. 
> 
> This is with the refpolicy selinux-refpolicy-sources-20071214-1 running
> on RHEL5. 
> 
> For some reason, when the policy is enforced, I can't su  from a staff_r
> user, yet when I try with enforcing=0 I don't get any audit messages,
> and I'm not really comfortable modifying every user oriented admin
> modules to remove the dontaudit rules. doing so in su.te helped find a
> few things, but I'm not sure what's blocking it now. 

If using a recent semodule, you can do semodule -DB to strip the entire
policy of dontaudit rules and load the result, then semodule -B to
revert to the original policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
