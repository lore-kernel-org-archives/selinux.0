Subject: Re: polyinstantiation support in fs?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1076619586.2481.147.camel@kusturica>
References: <1076619586.2481.147.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1076681620.10189.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 13 Feb 2004 09:13:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-02-12 at 15:59, Magosányi Árpád wrote:
> Hi!
> 
> Do we have polyinstantiation support in the fs?
> Something like moldy dirs of trusted irix(?) or symlink add rc role
> of rsbac?

Not yet.  The security server does export an interface and the policy
language includes support for selecting a member subdirectory of a
partitioned directory, but the corresponding filesystem support does not
presently exist.  Care to work on it?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
