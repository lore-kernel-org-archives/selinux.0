Subject: Re: [PATCH v4 2/2] selinux:  generate flask headers during kernel
 build
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Kaigai Kohei <kaigai@ak.jp.nec.com>, Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1254244459.2252.143.camel@moss-pluto.epoch.ncsc.mil>
References: <1254244173.2252.138.camel@moss-pluto.epoch.ncsc.mil>
	 <1254244459.2252.143.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 29 Sep 2009 14:03:03 -0400
Message-Id: <1254247383.2252.192.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-09-29 at 13:14 -0400, Stephen Smalley wrote:
> Add a simple utility (scripts/selinux/genheaders) and invoke it to
> generate the kernel-private class and permission indices in flask.h
> and av_permissions.h automatically during the kernel build from the
> security class mapping definitions in classmap.h.  Adding new kernel
> classes and permissions can then be done just by adding them to classmap.h.

I've run the ltp selinux testsuite before and after these patches and
confirmed no regressions in denying system calls (i.e. no FAILs) or in
generated AVC messages (by clearing the audit log and restarting auditd
before each run, then running ausearch -m AVC -ts today | audit2allow
afterward and comparing the generated allow rules - cannot compare the
raw audit messages since they have data that changes on each run, e.g.
pid, ino, ...).

Looks like these patches are linux-next material though since the merge
window has closed for 2.6.32.

Eric, with these patches applied, to add a new permission (e.g. for
access) to the kernel, you would add it to
security/selinux/include/classmap.h, and then separately add it to the
refpolicy access vector definitions.  No requirement for the two
definitions to line up in terms of index value since they will get
mapped based on string name.  You could even add the new permission to
COMMON_FILE_PERMS, and the rest of the per-class file permissions will
just get remapped appropriately.  On the policy side though, you don't
want to modify the common file permissions definition because that will
affect older kernels that predate this dynamic class/perm discovery
support.  But there is no need for COMMON_FILE_PERMS to line up with the
common file perms in the policy, which means we can in fact continue to
use common file perms as a convenient way to avoid a switch statement or
array for mapping classes to permissions in the hook functions.

One caveat is that we still need to ensure that COMMON_FILE_PERMS and
COMMON_SOCK_PERMS continue to line up with each other in the set of
permissions used by file hooks that can act on either files or sockets,
unless we change those hooks to select the specific permission based on
the class.  The permissions that are shared by file and socket classes
are the ones up through "append"; after that they diverge.

There are several legacy permissions that are no longer used by SELinux.
We could remove these from the kernel's classmap.h definitions without
breaking anything (subsequent permissions would get mapped to policy
values appropriately by the new logic), but removing them from the
policy would be harder as it would break all kernels that predate these
patches.  Thus, I'm not sure we benefit from removing them from
classmap.h.

The unused permissions include:
# LSM hook never merged to mainline
file swapon
# compat_net=1 checks
socket { recv_msg send_msg }
# Only added so that subsequent permissions (execmod) would get the same value as class file
chr_file { execute_no_trans entrypoint }
# Original socket controls; never merged to mainline
tcp_socket { connectto newconn acceptfrom }
# legacy network or compat_net=1 checks
node { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send enforce_dest dccp_recv dccp_send }
# legacy network or compat_net=1 checks
netif { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_recv dccp_send }
# Original socket controls; never merged to mainline - only connectto is used
unix_stream_socket { newconn acceptfrom }
# Patches merged prematurely by Fedora, never merged to mainline
packet { flow_in flow_out }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
