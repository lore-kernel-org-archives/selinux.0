Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM
	settings for task actions [try #2]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: David Howells <dhowells@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <830252.82380.qm@web36604.mail.mud.yahoo.com>
References: <830252.82380.qm@web36604.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 12 Dec 2007 14:49:06 -0500
Message-Id: <1197488946.1125.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-12 at 11:44 -0800, Casey Schaufler wrote:
> --- David Howells <dhowells@redhat.com> wrote:
> 
> > Casey Schaufler <casey@schaufler-ca.com> wrote:
> > 
> > > What sort of authorization are you thinking of? I would expect
> > > that to have been done by cachefileselinuxcontext (or
> > > cachefilesspiffylsmcontext) up in userspace. If you're going to
> > > rely on userspace applications for policy enforcement they need
> > > to be good enough to count on after all.
> > 
> > It can't be done in userspace, otherwise someone using the cachefilesd
> > interface can pass an arbitrary context up.
> 
> Yes, but I would expect that interface to be protected (owned by root,
> mode 0400). If /dev/cachefiles has to be publicly accessable make it
> a privileged ioctl.

Uid 0 != CAP_MAC_OVERRIDE if you configure file caps and such.

> > The security context has to be
> > passed across the file descriptor attached to /dev/cachefiles along with the
> > other configuration parameters as a text string.
> 
> I got that.
> 
> > This fd selects the
> > particular cache context that a particular instance of a running daemon is
> > using.
> 
> Yes, but forgive me being slow, I don't see the problem.
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
