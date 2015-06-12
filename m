Date: Fri, 12 Jun 2015 10:57:44 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux-testsuite: update socket tests
Message-ID: <20150612155744.GA21411@mail.hallyn.com>
References: <1433947049-11929-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433947049-11929-1-git-send-email-sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jun 10, 2015 at 10:37:29AM -0400, Stephen Smalley wrote:
> The socket, unix_socket, and unix_secure tests were all
> for the original SELinux implementation (before Linux 2.6.0),
> and never worked for SELinux in mainline.
> Delete these legacy tests and their associated policy as they
> neither build nor work and embody many assumptions that are no
> longer true of SELinux (e.g. permissions that are no longer used,
> automatic propagation of security contexts for INET over loopback).
> 
> Add a new set of unix_socket tests that exercise the Unix domain
> socket connectto (stream) and sendto (datagram) permission checks
> and the SO_PEERSEC (stream) and SCM_SECURITY (datagram) functionality.
> These tests use the abstract name space as the purpose is to test the
> socket layer hooks, not the file/inode hooks.  We currently only
> test SCM_SECURITY for datagram sockets but this can be extended to
> also test with stream sockets if/when that functionality is accepted
> into the kernel.
> 
> Possibly we could add similar tests for INET over loopback if we
> were to also add support for loading netlabel configuration in addition
> to policy configuration, but that is left to a future change.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Looks good to me.

Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
