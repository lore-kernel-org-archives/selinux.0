Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBCJihe0017763
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 14:44:43 -0500
Received: from web36604.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lBCJigWc007913
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 19:44:42 GMT
Date: Wed, 12 Dec 2007 11:44:41 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
To: David Howells <dhowells@redhat.com>, casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <32187.1197484466@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <830252.82380.qm@web36604.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> > What sort of authorization are you thinking of? I would expect
> > that to have been done by cachefileselinuxcontext (or
> > cachefilesspiffylsmcontext) up in userspace. If you're going to
> > rely on userspace applications for policy enforcement they need
> > to be good enough to count on after all.
> 
> It can't be done in userspace, otherwise someone using the cachefilesd
> interface can pass an arbitrary context up.

Yes, but I would expect that interface to be protected (owned by root,
mode 0400). If /dev/cachefiles has to be publicly accessable make it
a privileged ioctl.

> The security context has to be
> passed across the file descriptor attached to /dev/cachefiles along with the
> other configuration parameters as a text string.

I got that.

> This fd selects the
> particular cache context that a particular instance of a running daemon is
> using.

Yes, but forgive me being slow, I don't see the problem.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
