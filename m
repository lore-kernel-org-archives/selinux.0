Subject: Re: Decoder for log messages???
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dean Anderson <dean@av8.com>
Cc: selinux@tycho.nsa.gov, Steve Grubb <sgrubb@redhat.com>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
In-Reply-To: <Pine.LNX.4.44.0711051620330.20094-100000@citation2.av8.net>
References: <Pine.LNX.4.44.0711051620330.20094-100000@citation2.av8.net>
Content-Type: text/plain
Date: Tue, 06 Nov 2007 09:07:42 -0500
Message-Id: <1194358062.28518.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-11-05 at 16:28 -0500, Dean Anderson wrote:
> On Wed, 31 Oct 2007, Stephen Smalley wrote:
> > 
> > Not a full pathname, no.
> > 
> > We don't have enough information at the point where we do our permission
> > checks to reconstruct a pathname, 
> 
> ?? These checks are in open or exec. The full pathname should be 
> available.

Not where we do the check, no.  The audit system though can collect the
component names as the lookup occurs, and emit the name at syscall exit.

> > and such a pathname will always be process-local and not guaranteed to
> > be meaningful, stable, or the actual path by which the file was
> > accessed.  
> 
> ?? The filesystem is not process local, except perhaps /proc

The view that a process has of the filesystem can be tailored on a
per-process basis in Linux; a given pathname is only meaningful relative
to a particular namespace.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
