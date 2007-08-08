From: "Kim Lawson-Jenkins" <lawson@itd.nrl.navy.mil>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>,
        "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "'Daniel J Walsh'" <dwalsh@redhat.com>
References: <001b01c7d9bc$9d227a70$c301000a@PC05> <1186580710.6916.85.camel@moss-spartans.epoch.ncsc.mil>
Subject: RE: Migrating older SELinux policies to new Linux releases
Date: Wed, 8 Aug 2007 10:20:03 -0500
Message-ID: <002001c7d9cf$97e8e9f0$c301000a@PC05>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <1186580710.6916.85.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You're correct.  I am porting from a policy based on example policy to a
policy based on the reference policy.  I already have the SELinux Reference
policy strict base module on RHEL5 and as a next step will look at adding a
loadable policy module as you suggested.  Thanks for a response.  And thank
you Chris for the location of the macro conversion guide.

Kim

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Wednesday, August 08, 2007 8:45 AM
To: Kim Lawson-Jenkins
Cc: selinux@tycho.nsa.gov; Christopher J. PeBenito; Daniel J Walsh
Subject: Re: Migrating older SELinux policies to new Linux releases

On Wed, 2007-08-08 at 08:04 -0500, Kim Lawson-Jenkins wrote:
>  
> 
> I'm migrating application software from Fedora Core 3 to RHEL5.  The
> SELinux strict policy was used for Fedora Core 3 and as a first step I
> only want to migrate the existing policy to RHEL5.  (Later I plan to
> make changes to the policy using the newer SELinux development
> tools.)  I've seen several books and whitepapers that discuss
> generating new policies using the current SELinux tools but I have
> seen no whitepapers, examples, or guidelines on how to, say, migrate
> older strict policies to the new reference policy.  Are there any such
> guidelines or suggestions documented somewhere?

I'm not aware of anything specific, although there is certainly
documentation of the refpolicy
(http://oss.tresys.com/projects/refpolicy/wiki/Documentation) and the
SELinux by Example book provides examples of writing both kinds of
policies.  Looking at an example .te file from the refpolicy is always
helpful too.  SLIDE is an Eclipse plugin for working with refpolicy if
you like that sort of thing.

I was thinking that there was a mapping from example policy macros to
refpolicy interfaces at one time, but I don't see it now.

Just to clarify, what you are actually doing is porting from a policy
based on example policy to a policy based reference policy.  Both
policies have a "strict" form and a "targeted" form.  If your changes
are localized, then you might be able to just create and build a
loadable policy module and then add that to the existing strict policy
in RHEL5 (selinux-policy-strict) without needing to rebuild the full
reference policy.

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
