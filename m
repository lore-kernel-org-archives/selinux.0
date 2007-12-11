Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBKexfT012110
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 15:40:59 -0500
Received: from web36611.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lBBKesEe008216
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 20:40:54 GMT
Date: Tue, 11 Dec 2007 12:40:54 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: David Howells <dhowells@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <1197402998.28006.95.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <81940.57362.qm@web36611.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> 
> > I am much more concerned with the interfaces used to pass the
> > information into the kernel. I would expect that to be LSM
> > independent, not a call into libselinux that resolves into a
> > selinuxfs operation, or it's netlink equivilant. It would be
> > unfortunate if the userland/kernel interface became an obstacle
> > to cachefiles being adopted.
> 
> That wasn't the issue.  The interface to the cachefiles module would
> just consist of cachefilesd writing a string label to some pseudo file
> tell cachefiles what label to apply as the acting label for operations
> performed by cachefiles.  Which isn't SELinux-specific at all.

Calm down. Just checking.

> David was asking though how cachefilesd (the userspace agent) would
> obtain such a label to use.  And that may very well be LSM-specific, and
> as there is no LSM userspace API, it makes sense for him to invoke a
> libselinux function at present.  If a liblsm is later created and
> provides a common front-end API (internally dlopen'ing the right shared
> library based on some configuration, whether libselinux or libsmack or
> whatever), then cachefilesd can instead call the liblsm interface, but
> that doesn't exist today.

I am certainly not in favor of adding such complexity.
I suggest that cachefilesd get the context it wants using
whatever scheme works. I think there should be a cachefiles
specific (LSM independent) scheme for getting it into the
kernel, and a LSM hooks for setting it, if that's what he
really wants to do.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
