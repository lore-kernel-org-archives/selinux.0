Subject: Re: Making libselinux depend on libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118947182.28244.10.camel@celtics.boston.redhat.com>
References: <1118944064.28244.4.camel@celtics.boston.redhat.com>
	 <1118944751.30202.62.camel@moss-spartans.epoch.ncsc.mil>
	 <1118945030.28244.8.camel@celtics.boston.redhat.com>
	 <1118947036.30202.81.camel@moss-spartans.epoch.ncsc.mil>
	 <1118947182.28244.10.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 14:55:54 -0400
Message-Id: <1118948154.30202.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-16 at 14:39 -0400, Ivan Gyurdiev wrote:
> That part I want to leave out. I'm thinking of the useradd case,
> where useradd will construct the map, using this new function,
> and then invoke sepol functions to add users to it (and the file),
> and then load it separately.

Hmmm...ok, keeping in mind that eventually we want to migrate to
funnelling all policy changes through the policy daemon/server being
developed by Tresys, and only needing to authorize it to load policy
into the kernel.  Also using the binary/loadable module support for such
policy changes.

In any event, how do you intend to deal with the user-specified path to
load_policy(8)?  If you don't want to pass it to your new function, then
load_policy needs to check whether it matches the expected value (i.e.
prefix match against selinux_binary_policy_path()) and abort in that
case.  It actually doesn't make much sense to pass just that path to
your function, as you'd really want the policy root in order to use a
consistent prefix for the binary policy file, the booleans file, and the
users directory.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
