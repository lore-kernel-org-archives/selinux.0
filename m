Date: Thu, 20 May 2004 05:42:06 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "Bush, Daniel" <Daniel.Bush@boeing.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Policy compiler issues.
Message-ID: <20040520054206.GE24597@lkcl.net>
References: <E7E29FA7C732D146887C784B34AEF6A0044E3FD7@xch-ne-01.ne.nos.boeing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E7E29FA7C732D146887C784B34AEF6A0044E3FD7@xch-ne-01.ne.nos.boeing.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 06:10:17PM -0400, Bush, Daniel wrote:
> Hi all,

>   I've got what is probably a fairly stupid question, but I'll ask anyway:
>   I'm trying to deploy SELInux in an embedded environment. Footprint space is tight, every kilobyte counts. The environment is also fairly dynamic, the users list and assigned roles can change fairly rapidly.
>   It's my understanding that whenever the users' list changes (aside from default users)in a SELinux system, that the policy files and security labels need to be re-compiled. Is there any way around that? Can a user be assigned a set of (non-default user) roles without re-compiling the security system?
 
 hello, yes: if you look at /etc/selinux/users, you will note this:

 #
 # user_u is a generic user identity for Linux users who have no
 # SELinux user identity defined.  The modified daemons will use
 # this user identity in the security context if there is no matching
 # SELinux user identity for a Linux user.  If you do not want to
 # permit any access to such users, then remove this entry.
 #
 user user_u roles { user_r ifdef(`user_canbe_sysadm', `sysadm_r
 system_r') };


 so, if you don't want users to be able to be sysadmins, then
 edit tunable.te to exclude the user_canbe_sysadm ifdef.

 la?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
