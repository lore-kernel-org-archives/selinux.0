Subject: Re: Need functions to manipulare users file.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <4239F161.8030403@redhat.com>
References: <4239F161.8030403@redhat.com>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 16:16:41 -0500
Message-Id: <1111094201.8664.143.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-17 at 16:06 -0500, Daniel J Walsh wrote:
> Stephen we want to build a patch to either libselinux or libsepol or a 
> third library to manipulate the local.users file.

libsepol already has to understand the users source file format for
reading it by sepol_genusers(3), and doesn't depend on running on a
SELinux system.  So I think it is likely the right place.  Since
libsepol doesn't assume that it is running on a SELinux system and
doesn't want to assume the presence of /etc/selinux/config, the caller
has to provide the path to the users directory, so for example,
load_policy passes the result of selinux_users_path(3), which is
provided by libselinux, to sepol_genusers(3).

Ultimately, the policy source parsing code might be moved into libsepol
so that it not only provides manipulation of binary policies and user
source files but also manipulation of any source.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
