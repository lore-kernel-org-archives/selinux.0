Subject: Re: Newrole in targeted mode
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: kwade@redhat.com, Matthew Leinhos <leinhos@lamar.colostate.edu>
Cc: nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1104665427.9831.13.camel@erato.phig.org>
References: <1104259373.22401.0.camel@hawaii.grays-systems.com>
	 <1104259847.21391.107.camel@moss-spartans.epoch.ncsc.mil>
	 <1104388628.3140.4.camel@jsingh>  <1104665427.9831.13.camel@erato.phig.org>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 10:41:56 +0530
Message-Id: <1104729116.8446.9.camel@jsingh>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
Thanx matthew and karsten ...

> Everything runs in unconfined_t unless there is a transition specified
> to go to the new domain.  This transition is specified for only a small
> number of daemons.
> Other things are simplified.  In the targeted policy, there are fewer
> rules overall, fewer file contexts, and so forth.

Ok, I realized that after seeing the sources for target and strict
policies... 

> Because processes at all levels, whether spawned by init or a user, run
> in the unconfined_t domain, the role has no meaning.  AIUI, a user does
> not need an elevated role for what they do.

I understand that .. But does the system makes *any* assumptions about
the target or strict policies ??

I mean .. does the system distinguish between target and strict
policies ??? If I am not wrong the system just want some basic security
classes in place which are same for target and strict policies.

So, i can just borrow code from strict policy to add more domains and
roles to target policy.

I am right ??

And Also how can i make the selinux understand a policy tree
*intermediate* under /etc/selinux/  and load policy from there ....

> - Karsten
Thanx and Regards,
Jaspreet
-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
