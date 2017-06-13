Message-ID: <1497364983.26654.1.camel@tycho.nsa.gov>
Subject: Re: SO_PEERSEC on socket connected to the same process
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Laurent Bigonville <bigon@debian.org>, selinux <selinux@tycho.nsa.gov>
Date: Tue, 13 Jun 2017 10:43:03 -0400
In-Reply-To: <7f094e66-6131-f126-9e23-771d1520904f@debian.org>
References: <7f094e66-6131-f126-9e23-771d1520904f@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-06-13 at 09:37 +0200, Laurent Bigonville wrote:
> Hi,
> 
> Currently the dbus-daemon is not returning anything when asked about
> its 
> own security context (using GetConnectionSELinuxSecurityContext or 
> GetConnectionCredentials methods). This cause some issues[0] with 
> systemd now that it's enforcing the policy for user sessions again.
> 
> I already made a patch that has been merged[1][2] upstream in the 
> GetConnectionSELinuxSecurityContext case and it now returns the
> SELinux 
> context of the dbus-daemon process itself.
> 
> For the GetConnectionCredentials case, upstream wanted a generic way
> of 
> getting the security label and went the way of using SO_PEERSEC on a 
> socket connected to itself.
> 
> But for some reasons it's always returning unlabeled_t. Note that
> the 
> same value is returned by the getpeercon() function as well.
> 
> I've made a small test case (see attached file) and tested it on
> both 
> debian and RHEL7.
> 
> Is this somehow expected? Is this a bug?
> 
> Cheers,
> 
> Laurent Bigonville
> 
> [0]https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=864221
> [1]https://bugs.freedesktop.org/show_bug.cgi?id=101315
> [2] https://phabricator.freedesktop.org/rDBUSdcf02f80656d

SO_PEERSEC has never been supported for socketpair()-created sockets. 
To do so would require a new LSM hook called by unix_socketpair() to
set the peer SIDs for the two sockets.  In the absence of such a hook,
the peer SIDs are left with their initial values (the unlabeled SID),
and thus SO_PEERSEC returns the unlabeled context for both.  That's why
you see the current behavior.

It would be easy enough to implement such a hook (and perhaps we
should), but the more fundamental question is whether SO_PEERSEC makes
sense for socketpair()-created sockets and what does it actually mean.
Suppose we implement the hook and set the peer SIDs during
socketpair(). Pop quiz: Process P1 in context C1 calls socketpair(),
creating sockets S1 and S2 connected to each other.  P1 also creates a
socket S3 via socket() and connects to a socket S4 created via socket()
by process P2 in context C2.  P1 passes S2 over the connection to P2. 
P1 and P2 talk via S1 (P1's endpoint) and S2 (P2's endpoint). What is
the result of:

1. getsockopt(S1, SO_PEERSEC)? Answer: C1 (not C2!)

2. getsockopt(S2, SO_PEERSEC)? Answer: C1

3. getsockopt(S3, SO_PEERSEC)? Answer: C2

4. getsockopt(S4, SO_PEERSEC)? Answer: C1

NB SO_PEERSEC returns the context of the peer socket, i.e. the context
of the socket to which it is connected, not necessarily the context of
the peer process.
