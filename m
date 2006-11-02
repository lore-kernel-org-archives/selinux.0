Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: David Howells <dhowells@redhat.com>, jmorris@namei.org,
        chrisw@sous-sol.org, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <1162484964.6503.9.camel@localhost.localdomain>
References: <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com>
	 <1162396705.29617.18.camel@localhost.localdomain>
	 <1162403134.32614.242.camel@moss-spartans.epoch.ncsc.mil>
	 <1162484964.6503.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 13:04:16 -0500
Message-Id: <1162490657.5519.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-02 at 11:29 -0500, Karl MacMillan wrote:
> On Wed, 2006-11-01 at 12:45 -0500, Stephen Smalley wrote:
> > On Wed, 2006-11-01 at 10:58 -0500, Karl MacMillan wrote:
> 
> <snip>
> 
> 
> > > fssid seems like the wrong name, though it does match the DAC concept.
> > > This is really more general impersonation of another domain by the
> > > kernel and might have other uses.
> > 
> > NFS will want a fssid in order to have file access checks applied
> > against the client process' SID if/when the client process' context
> > becomes available.
> 
> I was suggesting that it might be helpful if this applied to all checks
> - not just file access - and would therefore need a different name.

Not all checks (e.g. not when checking the ability of another task to
send a signal to the task), but all checks where the task SID is used as
the subject/source.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
