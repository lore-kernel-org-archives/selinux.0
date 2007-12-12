Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBCK9oxS021123
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 15:09:50 -0500
Received: from web36605.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lBCK9le8017187
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 20:09:48 GMT
Date: Wed, 12 Dec 2007 12:09:42 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: David Howells <dhowells@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <1197488946.1125.151.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <483979.69273.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2007-12-12 at 11:44 -0800, Casey Schaufler wrote:
> > --- David Howells <dhowells@redhat.com> wrote:
> > 
> > > Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > 
> > > > What sort of authorization are you thinking of? I would expect
> > > > that to have been done by cachefileselinuxcontext (or
> > > > cachefilesspiffylsmcontext) up in userspace. If you're going to
> > > > rely on userspace applications for policy enforcement they need
> > > > to be good enough to count on after all.
> > > 
> > > It can't be done in userspace, otherwise someone using the cachefilesd
> > > interface can pass an arbitrary context up.
> > 
> > Yes, but I would expect that interface to be protected (owned by root,
> > mode 0400). If /dev/cachefiles has to be publicly accessable make it
> > a privileged ioctl.
> 
> Uid 0 != CAP_MAC_OVERRIDE if you configure file caps and such.

Yes, but we're talking about writing the configuration information
to the kernel, not actually making any access checks with it. I
think. What I think we're talking about (and please correct me David
if I've stepped into the wrong theatre) is getting the magic
secctx that cachefiles will use instead of the secctx that the task
would have otherwise. I don't think we're talking about recomputing
it on every access, I think David is looking for the blunderbuss
secctx that he can use any time he needs one.

And it would be CAP_MAC_ADMIN, since you're changing the MAC
characteristics of the system, not doing an access check.

Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
