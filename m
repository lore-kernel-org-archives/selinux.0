Subject: Re: Latest diffs.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <439EED4B.4070701@redhat.com>
References: <439EED4B.4070701@redhat.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 15:43:47 -0500
Message-Id: <1134506627.4936.23.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-12-13 at 10:48 -0500, Daniel J Walsh wrote:
> Add crond range_transition to run at SystemHigh for MCS policy
> Added transition from unconfined_t to run ping at s0.
> Which brings up a point, when a transition happens should the 
> application continue to run at the same security level that the prev 
> context ran at?  Or should all domains start with a default security 
> level. 
> 
> In current MCS policy if unconfined_t started ping, it would run at the 
> with the same mls range as unconfined_t.

The cron part makes sense, but I don't understand why this would be
needed for ping.

> Beginning to fix up automouter.  Wants to read sysctl_fs_t.  Also seems 
> to exec showmount which requires additional privs.
> 
> allow automount_t self:capability net_bind_service;
> allow automount_t portmap_port_t:tcp_socket name_connect;
> allow automount_t reserved_port_t:tcp_socket name_connect;
> allow automount_t sbin_t:file read;
> 
> We probably need a policy for the showmount command, rather then adding 
> these rules to automount.  Anyone want to write some policy?
> 
> Rules to make dovecot work better.
> 
> /var/log/proftpd/ should be marked xferlog
> 
> gpm wants to communicate using unix_stream_socket.
> 
> More fixes for hal.  Seems hal is now tied into powersaver and needs 
> some addtional privs.
> Needs to be able to start init scripts.
> Added new policy for vbetool, to be execed from hal.

all merged.  I removed the execmem from hal, since it transitions to
vbetool, and the comment said it was required for vbetool.

> If you need to signal nis, you need to read the pid file.  This is what 
> dhcpd does.

See my previous email.

> spamassassin needs to write to users homedirs in targeted policy.  I 
> hate it but, it has to work.
> 
> unconfined_t was not able to read textrel_shlib_t.
> Added auditallow to show when unconfined_t is running a program that 
> requires execmem

merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
