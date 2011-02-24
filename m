Subject: Re: Separate type for AF_UNIX socket created by syslogd_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, paul.moore@hp.com,
        selinux-mailing-list <selinux@tycho.nsa.gov>,
        refpolicy-mailing-list
 <refpolicy@oss1.tresys.com>
In-Reply-To: <SNT139-w42F5BDB103916DC8160624ABDA0@phx.gbl>
References: <SNT139-w42F5BDB103916DC8160624ABDA0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Feb 2011 08:35:12 -0500
Message-ID: <1298554512.31953.38.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-02-24 at 10:44 +0000, HarryCiao wrote:
> Since syslogd_t runs at mls_systemhigh, both the /dev/log file and the
> unix_dgram_socket object bond to it are of mls_systemhigh, rendering
> that other application domain such as klogd_t running at lower
> security level failed to "sendto" it. One possible solution is to add
> syslogd_t to mlstrustedobject attribute since the unix_dgram_socket
> object inherits the creator's SID by default.
> 
> However, the side effect is that syslogd_t is also the label for the
> entire syslogd's procfs entries. The attached two patches are aimed to
> resolve this problem while eliminating such side effect, by declaring
> a separate type, syslogd_s_t,  for the unix_dgram_socket object
> created by syslogd_t which alone could be added to the
> mlstrustedobject attribute.
> 
> Thanks to Stephen's suggestion security_transition_sid() would be
> called in socket_sockcreate_sid() to query the relevant
> type_transition rule say in logging.pp for any newly created socket.
> 
> After applying th! ese two patches below errors don't exist any more:
> 
> type=1400 audit(1298535101.654:868): avc:  denied  { sendto } for
> pid=385 comm="klogd" path="/dev/log"
> scontext=system_u:object_r:klogd_t:s0
> tcontext=system_u:object_r:syslogd_t:s15:c0.c1023
> tclass=unix_dgram_socket
> 
> BTW, do we have a way to actually display the label for the
> unix_dgram_socket that bond to /dev/log?
> 
> Any comments is are greatly appreciated!

Hi,

You should separately post the kernel patch as its own message,
preferably inline so that it can be easily reviewed and commented upon.
Make sure you have read and are following
Documentation/SubmittingPatches and that the posting explicitly cc's the
SELinux maintainers listed in MAINTAINERS.  I wouldn't bother reposting
the policy patch again until/unless the kernel patch is agreed upon, as
it won't make sense to review it until that time.

Unfortunately my original "simple" suggestion turns out to have side
effects. At present, the socket gets the same exact security context as
the creating process by default, including the role and MLS range, since
we just assign the SID directly.  But when using security_transition_sid
-> security_compute_sid, the new security context uses object_r as the
role for all objects and mls_compute_sid degrades the full MLS range to
the low level for objects. This is based on the desired behavior for
files and didn't take into account sockets.  Thus with your patch,
sockets will no longer be labeled identically to their creating process,
which will affect labeled networking and the network access controls.

To preserve existing behavior when there are no type transition rules
configured for sockets, I think security_compute_sid and mls_compute_sid
need logic handling the socket classes differently than other objects
(files).  And given that we are using dynamic class mappings now, those
socket class values would have to be looked up just like the process
class upon policy load.  Maybe we can come up with some generalized
solution that will be more flexible going forward for configuring how
different parts of the context are assigned for different classes.  We
have talked previously about using the role field even for files rather
than just making them all object_r.

On the implementation:
- security_transition_sid() error case likely needs to be propagated to
the hook and up to the caller of the hook rather than just defaulting to
the old behavior upon error.
- Don't move the setting of isec->initialized before isec->sid has been
set.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
