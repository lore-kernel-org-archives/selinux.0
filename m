Subject: Re: Logging the target?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1076949388.10004.14.camel@kusturica>
References: <1076949388.10004.14.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1077031954.16139.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 17 Feb 2004 10:32:34 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-02-16 at 11:36, Magosányi Árpád wrote:
> Hi!
> 
> Is there a way to figure out the target object of a deny?
> An example: when I done an exec("/bin/bash") it was denied
> by my policy, because some library files was not the right
> type. It would spare me 2 reboots if the actual target would be stated
> in the logs.

SELinux logs the target pathname when it has the necessary information
available to it, i.e. the (vfsmount,dentry) pair.  Otherwise, it cannot
generate a pathname for auditing.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
