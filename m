Subject: Re: Revocation Support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: Mohammad Mahmoudi <mahmoudi1379@yahoo.com>, SELinux@tycho.nsa.gov
In-Reply-To: <447A1C33.2040200@gentoo.org>
References: <20060528115017.96102.qmail@web50413.mail.yahoo.com>
	 <447A1C33.2040200@gentoo.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 11:12:02 -0400
Message-Id: <1149001922.524.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-05-28 at 17:54 -0400, Joshua Brindle wrote:
> Mohammad Mahmoudi wrote:
> > Does SELinux support revocation of permissions?
> >   
> The FLASK architecture, which SELinux is based on, does indeed support 
> revocation by allowing object managers to register callbacks with the 
> security server. However, on SELinux, this is not currently in use. So 
> direct revocation where the object managers actively remove access to 
> objects after a policy change doesn't happen.
> 
> However, on some object classes permission is revalidated on every 
> object use (like files and file descriptors). So, even though a process 
> has a file descriptor to a file it previously had access top open, if 
> the permissions change to that file type the next read or write 
> operation will fail which essentially revokes access to it. This should 
> be the case on a file types, fds, sockets, ipc (except shared memory).

Further, SELinux checks access to descriptors upon execve when the
security context changes, and when descriptors are received via local
IPC.  This controls propagation of the access rights among security
contexts.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
