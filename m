Subject: Re: Still getting random execute permissions on shared libraries.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: petre rodan <kaiowas@gentoo.org>
Cc: Daniel J Walsh <Dan-Walsh@comcast.net>, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41A788C2.9060609@gentoo.org>
References: <41A3EC21.1090200@comcast.net>
	 <1101303008.22014.47.camel@moss-spartans.epoch.ncsc.mil>
	 <41A788C2.9060609@gentoo.org>
Content-Type: text/plain
Message-Id: <1101739123.13948.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 29 Nov 2004 09:38:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-26 at 14:49, petre rodan wrote:
> I made a patch to the kernel that reverts to the old behaviour. no more execs on random files.
> I find that changing the policy to allow those execs is not a valid solution.
> 
> would it be feasible to send upstream a patch that would remove the 'exec on read' behaviour if the kernel has selinux capabilities?

Removing it completely would be a problem if you want to support any
binaries at all that are assuming that read implies exec.  
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
