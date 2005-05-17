Subject: Re: Busted by constraints.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1116329977.917.7.camel@moss-spartans.epoch.ncsc.mil>
References: <428368FF.2080603@redhat.com>
	 <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>
	 <42836C4C.6010301@redhat.com>
	 <1115996428.3576.47.camel@moss-spartans.epoch.ncsc.mil>
	 <1116269095.28782.102.camel@moss-spartans.epoch.ncsc.mil>
	 <428917F4.6030203@redhat.com>
	 <1116329977.917.7.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 17 May 2005 07:50:03 -0400
Message-Id: <1116330603.917.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-05-17 at 07:39 -0400, Stephen Smalley wrote:
> On Mon, 2005-05-16 at 18:00 -0400, Daniel J Walsh wrote:
> > I think, this patch is needed to export symbols of newly added libsepol 
> > functions. 
> 
> No.  These particular functions are _only_ for the static library and
> programs that link with it, as they expose too much of the internals of
> libsepol.  Note that audit2why is linked with libsepol.a, not the shared
> library (prior to your policycoreutils patch).  We will not _export_
> these symbols via the shared library.

Note btw that this is no different than checkpolicy, which also links
with the static libsepol.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
