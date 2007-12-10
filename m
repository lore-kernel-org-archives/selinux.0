Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM
	settings for task actions [try #2]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <25037.1197306473@redhat.com>
References: <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil>
	 <20071205193818.24617.79771.stgit@warthog.procyon.org.uk>
	 <20071205193859.24617.36392.stgit@warthog.procyon.org.uk>
	 <25037.1197306473@redhat.com>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 12:23:17 -0500
Message-Id: <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-10 at 17:07 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > > +	tsec->create_sid = SECINITSID_UNLABELED;
> > > +	tsec->keycreate_sid = SECINITSID_UNLABELED;
> > > +	tsec->sockcreate_sid = SECINITSID_UNLABELED;
> 
> Cleared means what?  Setting to 0?  Or is there some other constant I should
> use for that?

Yes, setting to 0.

Otherwise, only other issue I have with this interface is it won't
generalize to dealing with nfsd, where we want to set the acting context
to a context we obtain from or determine based upon the client.

Why can't cachefilesd just push a context into the kernel and pass that
into the hook as the acting context, and then nfsd can do likewise using
the context provided by the client or obtained locally from exports for
ordinary clients?  Avoids the transition SID computation altogether
within the kernel and makes this more generic.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
