Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3KFve65032306
 for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2017 11:57:40 -0400
Date: Thu, 20 Apr 2017 17:56:28 +0200 (CEST)
From: Guido Trentalancia <guido@trentalancia.net>
To: selinux@tycho.nsa.gov
Message-ID: <1142061194.203411.1492703788891@pim.register.it>
In-Reply-To: <1492703796.669.3.camel@tycho.nsa.gov>
References: <58517705.198270.1492699110308@pim.register.it>
 <1492703075.669.1.camel@tycho.nsa.gov>
 <1967496203.202650.1492703110228@pim.register.it>
 <1492703796.669.3.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: remove lock files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello and thanks for getting back.

If it doesn't have any side-effect (as it should), then I think it's preferable that the filesystem is kept clean.

It can be confusing too: because lock files are generally considered "active" when present in the filesystem.

Well, you've heard my opinion and you have the very simple patch now. Feel free to do whatever you and the authors like with it...

Regards,

Guido

> On the 20th of April 2017 at 17.56 Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> 
> On Thu, 2017-04-20 at 17:45 +0200, Guido Trentalancia wrote:
> > Hello Stephen.
> > 
> > Usually, when a lock file is released, the corresponding file is
> > removed from the filesystem for keeping it clean and tidy.
> > 
> > I might be wrong... But why not ?
> > 
> > If nothing is handling the semanage store, then there shouldn't be a
> > reason for keeping it locked. The presence of a lock file, usually
> > means that the lock is active.
> 
> libsemanage doesn't use the lock files that way; it just uses them as
> the object for flock() operations.  So the presence of the lock file
> means nothing.  Removing it just means it will have to be re-created on
> the next operation.  Not fundamentally opposed, but someone would need
> to validate that it doesn't cause any issues.  It's been that way
> forever.  Maybe the original Tresys authors of this code have an
> opinion on it.
