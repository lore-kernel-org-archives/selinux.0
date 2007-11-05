From: Steve Grubb <sgrubb@redhat.com>
To: Dean Anderson <dean@av8.com>
Subject: Re: Decoder for log messages???
Date: Mon, 5 Nov 2007 18:23:16 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
References: <Pine.LNX.4.44.0711051620330.20094-100000@citation2.av8.net>
In-Reply-To: <Pine.LNX.4.44.0711051620330.20094-100000@citation2.av8.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711051823.17175.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 05 November 2007 04:28:29 pm Dean Anderson wrote:
> > and such a pathname will always be process-local and not guaranteed to
> > be meaningful, stable, or the actual path by which the file was
> > accessed.  
>
> ?? The filesystem is not process local, except perhaps /proc

I think what he means is that if you have symlinks somewhere in the path or 
bind mount overlays, there could be several ways of identifying the same 
file. This is partly why the inode and filesystem is given. It helps identify 
exactly what is being accessed.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
