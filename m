Subject: Re: selinux_inode_setsecurity and fsetxattr
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <377171.19862.qm@web36610.mail.mud.yahoo.com>
References: <377171.19862.qm@web36610.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 18 Jan 2008 13:33:03 -0500
Message-Id: <1200681183.7025.112.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-01-18 at 08:40 -0800, Casey Schaufler wrote:
> I was looking in selinux_inode_setsecurity for my own
> neffarious purposes and was curious what prevents a program
> that has a file open from setting the context on the file
> using fsetxattr. I confess that I haven't tried it to see
> how it actually behaves.

Sorry, what's your question?  Of course you can relabel a file via
fsetxattr (if you pass the permission check, which is a different hook
called earlier).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
