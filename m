Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: /var/lock
Date: Tue, 17 Sep 2002 17:02:39 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0209170932220.11411-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0209170932220.11411-100000@raven>
MIME-Version: 1.0
Message-Id: <200209171702.39880.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Sep 2002 15:37, Stephen Smalley wrote:
> On Fri, 13 Sep 2002, Russell Coker wrote:
> > Currently to run minicom you have to be in sysadm_r, minicom needs to
> > create a lock file under /var/lock which needs sysadm_t.
> >
> > This is wrong.
> >
> > I am thinking of adding a user_lock_t file type for this purpose.
> >
> > Also it would need a userlock attribute for allowing appropriate programs
> > to unlink the lock files.
>
> It appears that the lock file creation is handled by /usr/sbin/lockdev, a
> setgid lock program.

Not on Debian, and not for all programs.  Portslave and pppd do the lock 
creation internally.

This is something that should be changed.  The process that creates the lock 
in the case of a lockfile that may be stale will do "kill(pid, 0)" which 
requires signal access.

> Hence, you could place lockdev into a domain and
> define a file type auto transition rule to create /var/lock files with a
> derived type.  More generally, we should likely be using file type
> transitions for all of the /var/lock files, as with the /var/run files.

Yes.

> Of course, minicom requires permissions to the modem device in order to
> function, so I'm not sure what you intend there (i.e. placing minicom into
> a domain with such access).

No, just giving the device file a type that the user can access.

> > I also thought of giving system programs (such as pppd) the ability to
> > unlink userlock files so that they can break locks.  However this would
> > also require access to kill the user_t processes which hold the locks,
> > and is possibly undesirable.
> >
> > What do you think?
>
> It would be preferable to maintain separation between system processes and
> user processes.

True.  So I don't think that killing the process would be required or desired.  
But having signal 0 being covered by the "signal" perms does make it 
difficult, if we had a separate permission check for it then it would make 
things easier...

-- 
There is no point PGP/GPG signing an email if the people who read it can't
verify the signature.  If you post to a list then don't sign the message
unless your key is available on public key servers and has been signed by
someone who is in the web of trust, otherwise you just waste bandwidth and 
CPU.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
