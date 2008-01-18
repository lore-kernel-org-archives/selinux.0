Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0IIcXHw028803
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 13:38:33 -0500
Received: from web36606.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0IIcWhC005054
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 18:38:32 GMT
Date: Fri, 18 Jan 2008 10:38:31 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: selinux_inode_setsecurity and fsetxattr
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1200681183.7025.112.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <806709.49466.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> 
> On Fri, 2008-01-18 at 08:40 -0800, Casey Schaufler wrote:
> > I was looking in selinux_inode_setsecurity for my own
> > neffarious purposes and was curious what prevents a program
> > that has a file open from setting the context on the file
> > using fsetxattr. I confess that I haven't tried it to see
> > how it actually behaves.
> 
> Sorry, what's your question?  Of course you can relabel a file via
> fsetxattr (if you pass the permission check, which is a different hook
> called earlier).

In the case of fsetxattr, which hook would that be?


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
