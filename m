Subject: Re: Policy building and loading problems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shaz <shazalive@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>,
        Security Engineering Archive <groupsecurityengineering@gmail.com>
In-Reply-To: <7b740b700904142351i6eb6078bq862a181b168694b5@mail.gmail.com>
References: <7b740b700904142351i6eb6078bq862a181b168694b5@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 15 Apr 2009 08:33:33 -0400
Message-Id: <1239798813.27560.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-04-15 at 11:51 +0500, Shaz wrote:
> Hi everyone,
> 
> I have some problem with loading policy. The device is in enabled and
> permissive mode.
> 
> ----------------
> 
> root@some-device:/etc/selinux/targeted# make load
> make: Warning: File `/usr/bin/checkpolicy' has modification time 1.6e
> +07 s in the future
> Compiling policy ...
> /usr/bin/checkpolicy  -o /etc/selinux/targeted/policy/policy.23
> policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> /usr/bin/checkpolicy:  policy configuration loaded
> /usr/bin/checkpolicy:  writing binary representation (version 23)
> to /etc/selinux/targeted/policy/policy.23
> /usr/bin/checkpolicy  -c 19 -o /etc/selinux/targeted/policy/policy.19
> policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> /usr/bin/checkpolicy:  policy configuration loaded
> /usr/bin/checkpolicy:  writing binary representation (version 19)
> to /etc/selinux/targeted/policy/policy.19
> Loading Policy ...
> /usr/bin/load_policy /etc/selinux/targeted/policy/policy.19
> BusyBox v1.10.1 (2009-04-07 15:36:44 PKT) multi-call binary
> 
> Usage: load_policy

As the usage message says, load_policy doesn't take a policy file
argument anymore (it always loads policy from the standard location and
selects the appropriate version).  So just modify your Makefile to omit
the policy file or run load_policy by hand with no arguments.

> 
> 
> 
> make: * [tmp/load] Error 1
> 
> ---------------------------------
> 
> I also had a clock skew warning at every build step of policy
> building. Does it matter? How to solve it easily?

That just means that the timestamps on the files are in the future of
your current clock setting.  Check your system clock and/or the
timestamps on the files.

>  Where did policy 23 come from?

That's the latest policy version supported by the version of checkpolicy
you have.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
