Subject: Re: Adding alternate root patch to restorecon (setfiles?)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20041019183646.GC19398@lkcl.net>
References: <41741A2C.8040408@redhat.com> <20041018205136.GA2536@jmh.mhn.de>
	 <41751792.4060207@redhat.com>  <20041019183646.GC19398@lkcl.net>
Content-Type: text/plain
Message-Id: <1098210403.29525.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 14:26:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-19 at 14:36, Luke Kenneth Casson Leighton wrote:
> um... what happens if a user runs restorecon in a chroot environment
> that they create?
> 
> as an ordinary user, can they cp /lib/* and have the context preserved
> on their copy of libc.so.6?  just trying that now... no, it says setting
> attribute "security.selinux" for /home/sez/libc6.so.6': permission
> denied.
> 
> is there any concievable way round that?  [i hope not!]

Unprivileged user domains aren't allowed to transition to restorecon_t
in the policy.  There is a reason for that...
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
