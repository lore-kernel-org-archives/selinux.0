Subject: Re: swapon unsuppoted?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200510121517.j9CFHl11010821@mms-r01.iijmio.jp>
References: <1129031794.3308.22.camel@moss-spartans.epoch.ncsc.mil>
	 <200510121517.j9CFHl11010821@mms-r01.iijmio.jp>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 11:38:53 -0400
Message-Id: <1129131534.3308.278.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-12 at 11:17 -0400, Yuichi Nakamura wrote:
> I am reviewing meaning of access vectors to develop SELinux Policy Editor.
> I also found  
> capability:net_broadcast, 
> filesystem:transition and object class ipc are unused.
> Is it correct?
> And are they going to be used in the future?

SELinux simply defines a parallel capability for every capability
defined by the core kernel, so even if CAP_NET_BROADCAST is presently
unused by the mainline kernel, we would want to retain the definition as
long as it remains defined in include/linux/capability.h.  An out of
tree driver could still be using it.

Filesystem transition is unused; the filesystem
relabelfrom/relabelto/transition triple was originally for the old
chsidfs interface and persistent label on superblocks, which was lost
when we migrated to using xattrs and overhauled the API, and
relabelfrom/relabelto were later reclaimed for use to control context
mounts.

Object class ipc is obsolete; it is a relic of the old modular SELinux
and precondition function handling.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
