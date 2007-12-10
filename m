Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBANl2PH004329
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2007 18:47:02 -0500
Received: from web36606.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lBANl0NX023187
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2007 23:47:00 GMT
Date: Mon, 10 Dec 2007 15:46:59 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
To: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, Karl MacMillan <kmacmill@redhat.com>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <25965.1197329769@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <899818.54251.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > From a config file whose pathname would be provided by libselinux (ala
> > the way in which dbusd imports contexts), or directly as a context
> > returned by a libselinux function.
> 
> That sounds too SELinux specific.  How do I do it so that it works for any
> LSM?
> 
> Is linking against libselinux is a viable option if it's not available under
> all LSM models?  Is it available under all LSM models?  Perhaps Casey can
> answer this one.

Linking against libselinux is not now, nor will it ever be, a viable
option. There's just too much sophistication contained in libselinux
for us simple folk to deal with.

> > > I use to do that, but someone objected...  Possibly Karl MacMillan.
> > 
> > Yes, but I think I disagreed then too.
> 
> So, who's right?

Me! (smiley inserted here, for those in need)

> > It doesn't fit with how other users of security_kernel_act_as() will
> > likely want to work (they will want to just set the context to a
> > specified value, whether one obtained from the client or from some local
> > source), nor with how type transitions normally work (exec, with the
> > program type as the second type field).  I think it will just cause
> > confusion and subtle breakage.
> 
> It's causing me lots of confusion as it is.  I have been / am being told by
> different people to do different things just in dealing with SELinux, and
> various people are raising extra requirements or restrictions beyond that.
> There doesn't seem to be a consensus.
> 
> It sounds like the best option is just to have the kernel nick the userspace
> daemon's security context and use that as is, and junk all the restrictions
> on
> what the daemon can do so that the kernel isn't too restricted.

That would be consistant with the (perhaps archaic now) behavior
of nfsd on Unix, which did nothing but "lend it's credential" to the
underlying kernel code. I think it's a rational approach, although I
expect that in may have troubles under SELinux.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
