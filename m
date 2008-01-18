Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0IIuacm031081
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 13:56:36 -0500
Received: from web36602.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m0IIuYhV019923
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 18:56:35 GMT
Date: Fri, 18 Jan 2008 10:56:34 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: selinux_inode_setsecurity and fsetxattr
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1200681973.7025.121.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <483685.52972.qm@web36602.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> 
> On Fri, 2008-01-18 at 10:38 -0800, Casey Schaufler wrote:
> > --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > 
> > > 
> > > On Fri, 2008-01-18 at 08:40 -0800, Casey Schaufler wrote:
> > > > I was looking in selinux_inode_setsecurity for my own
> > > > neffarious purposes and was curious what prevents a program
> > > > that has a file open from setting the context on the file
> > > > using fsetxattr. I confess that I haven't tried it to see
> > > > how it actually behaves.
> > > 
> > > Sorry, what's your question?  Of course you can relabel a file via
> > > fsetxattr (if you pass the permission check, which is a different hook
> > > called earlier).
> > 
> > In the case of fsetxattr, which hook would that be?
> 
> All three setxattr system calls ultimately call vfs_setxattr(), which
> calls security_inode_setxattr() to check security module permissions.
> If it passes that check, then it proceeds to the actual processing,
> which follows different paths depending on whether the fs implements a
> setxattr operation or not.
> 
> security_inode_setsecurity() is just the low level primitive for setting
> the value in the in-core security structure and can be called either
> from the vfs (as the fallback) or from the individual fs op (as in
> tmpfs).  Originally only the latter before the vfs fallbacks were
> introduced.

Thank you. That was what I was looking for.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
