Subject: Re: Security issues with local filesystem caching
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, jmorris@namei.org,
        chrisw@sous-sol.org, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <1162403134.32614.242.camel@moss-spartans.epoch.ncsc.mil>
References: <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com>
	 <1162396705.29617.18.camel@localhost.localdomain>
	 <1162403134.32614.242.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 11:29:24 -0500
Message-Id: <1162484964.6503.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-01 at 12:45 -0500, Stephen Smalley wrote:
> On Wed, 2006-11-01 at 10:58 -0500, Karl MacMillan wrote:

<snip>


> > fssid seems like the wrong name, though it does match the DAC concept.
> > This is really more general impersonation of another domain by the
> > kernel and might have other uses.
> 
> NFS will want a fssid in order to have file access checks applied
> against the client process' SID if/when the client process' context
> becomes available.

I was suggesting that it might be helpful if this applied to all checks
- not just file access - and would therefore need a different name.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
