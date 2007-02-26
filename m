From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: I think this is equivalent to what we have =?utf-8?q?now=09and=09more=09efficient=2E?=
Date: Mon, 26 Feb 2007 09:44:35 -0500
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <45DDAA80.80603@redhat.com> <200702251436.38681.sgrubb@redhat.com> <1172498136.19041.198.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172498136.19041.198.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200702260944.35571.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 26 February 2007 08:55, Stephen Smalley wrote:
> > What about /selinux/policyvers ? When selinux is disabled, it does not
> > exist. When its enabled, should it tell you the version of policy that
> > was successfully loaded?
>
> Presently it always returns the maximum policy version supported by the
> kernel for use both for the initial policy load by /sbin/init and by
> subsequent policy reloads.

Then I'd say its misnamed. max_policy_version would have been more 
appropriate.

> Changing it to return the actual policy version loaded upon the first policy
> load by /sbin/init would then force all subsequent policy reloads to stay
> with that version even if a newer policy toolchain and policy had been
> installed, until the next reboot.

Agreed not a good solution.

> I think we'd want a separate selinuxfs node for that purpose to avoid
> ambiguity between the presently loaded version and the maximum supported
> one.

Agreed. (I would have thought this capability already existed. Otherwise 
setstatus is just taking a wild guess and not basing its output on fact.) 
What do you want to call this new node? loaded_policy_version?

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
