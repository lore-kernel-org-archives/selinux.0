Subject: Re: CentOS and SELinux refpolicy trouble
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Filip Bartmann <filbar@centrum.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1164819458.4109.14.camel@localhost>
References: <1164819458.4109.14.camel@localhost>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 12:09:53 -0500
Message-Id: <1164820193.23019.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-29 at 17:57 +0100, Filip Bartmann wrote:
> I try use SELinux refpolicy from oss.tresys.com with CentOS 4.4.
> Refpolicy I configure as targeted, and name ref-targeted. If I load the
> policy into running system, then all is OK, but if I try to boot system
> with this policy, then I have after "Switching to new root" first
> error's, about some Unkown's booleans, then about "Error while
> reading /etc/selinux/ref-targeted/booleans: Invalid argument"
> Then system hangs up with killing init and : "Kernel panic - not
> syncing. Out of memory and no killablable processes ..."
> What I have wrong?

Please identify the precise version numbers of any SELinux-related
components that you updated (refpolicy, checkpolicy, anything else like
policycoreutils).

Aside from setting the TYPE and NAME in build.conf, you also need to set
(or override on the make commandline) several other definitions for a
CentOS 4 system, e.g.:
OUTPUT_POLICY = 18
DISTRO = rhel4
DIRECT_INITRC=y

Not sure about the booleans errors - what did that booleans file
contain?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
