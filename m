Date: Tue, 17 Sep 2002 09:37:43 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: /var/lock
In-Reply-To: <200209132039.59879.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209170932220.11411-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 13 Sep 2002, Russell Coker wrote:

> Currently to run minicom you have to be in sysadm_r, minicom needs to create a
> lock file under /var/lock which needs sysadm_t.
>
> This is wrong.
>
> I am thinking of adding a user_lock_t file type for this purpose.
>
> Also it would need a userlock attribute for allowing appropriate programs to
> unlink the lock files.

It appears that the lock file creation is handled by /usr/sbin/lockdev, a
setgid lock program.  Hence, you could place lockdev into a domain and
define a file type auto transition rule to create /var/lock files with a
derived type.  More generally, we should likely be using file type
transitions for all of the /var/lock files, as with the /var/run files.

Of course, minicom requires permissions to the modem device in order to
function, so I'm not sure what you intend there (i.e. placing minicom into
a domain with such access).

> I also thought of giving system programs (such as pppd) the ability to unlink
> userlock files so that they can break locks.  However this would also require
> access to kill the user_t processes which hold the locks, and is possibly
> undesirable.
>
> What do you think?

It would be preferable to maintain separation between system processes and
user processes.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
