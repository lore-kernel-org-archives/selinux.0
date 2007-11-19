Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAJLis4n021482
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 16:44:54 -0500
Received: from web36605.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAJLirgT009003
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 21:44:53 GMT
Date: Mon, 19 Nov 2007 13:44:48 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [Labeled-nfs] [PATCH 13/13] NFSD: Label change notification for NFSv4 Server
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>
Cc: labeled-nfs@linux-nfs.org, selinux@tycho.nsa.gov
In-Reply-To: <1195506545.5327.1.camel@heimdal.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <236192.48539.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> 
> On Mon, 2007-11-19 at 15:30 -0500, Matthew N. Dodd wrote:
> > J. Bruce Fields wrote:
> > > On Fri, Nov 16, 2007 at 03:13:02PM -0500, David P. Quigley wrote:
> > >> NFSv4 Provides methods for detecting changes in attributes and
> > >> recalling delegations when state has changed on the server. This has
> > >> been extended to include this functionality for label changes on the
> > >> server. This patch provides the server implementation for a new
> > >> callback used to signal relabeling of files.
> > > 
> > > What's the goal of these callbacks?
> > > 
> > > If you really need a guarantee that all clients will be notified before
> > > the relabelling operation, then I think you need something stronger than
> > > inotify.
> > > 
> > > If you don't care about synchronous notification, then why not just
> > > let nfs find out about the change the next time it does an access check
> > > or something?
> > 
> > That won't happen during vfs_read()/vfs_write().
> 
> You expect it to be common practice for people to change security labels
> on files in the middle of an application read and/or write?

No, it's not common, but it's really really important, and that's
the real problem with a remote callback approach. If you mostly
disallow label changes* you don't need the notification, and if you
do you absolutely need to check every access. There are very few
differences between lockd and what you're looking at here, and no one
is about to hold lockd up as an example of how things ought to work.

Or that's how it looks from here.

-----
* I had said completely, but don't have to be fanatical.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
