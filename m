From: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
Subject: Re: net_admin audit for setsockopt SO_SNDBUFFORCE
Date: Thu, 23 Mar 2017 04:06:51 +1100
Message-ID: <1793997.zG1355pU9Z@russell.coker.com.au>
In-Reply-To: <1490189293.27242.1.camel@tycho.nsa.gov>
References: <CAJ2a_DdNpZ5vLtCmzC+o94zQrCGWwRYar5xYa4jyxohxnu7AZA@mail.gmail.com>
 <3955630.trR7UcfmOm@russell.coker.com.au>
 <1490189293.27242.1.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, 22 March 2017 9:28:13 AM AEDT Stephen Smalley wrote:
> > > Probably not, since SO_SNDBUFFORCE only exists to allow a process
> > > with
> > > CAP_NET_ADMIN to override the wmem_max limit per the man
> > > page.  IOW,
> > > only processes with CAP_NET_ADMIN should ever use that option. 
> > > dontaudit'ing that does not seem like a good idea either; I think
> > > you
> > > have to allow it or risk silent breakage.
> > 
> > We have had sshd, tor, and rpcbind denied access to that for some
> > time without 
> > any apparent breakage.
> 
> Two concerns with that:
> 1) The breakage might be subtle and not apparent, but nonetheless real.
>   They are presumably using SO_SNDBUFFORCE for a reason, not just for
> fun.  At the least, it may be degrading performance, possibly
> increasing potential for DoS, or similar.

For TOR the issue of DoS is relevant, although I am dubious about the idea 
that TOR might be unable to operate with the default buffer settings of any 
supported OS.  Also I'm generally dubious about the idea that a DoS might be 
enabled by preventing a daemon from enlarging it's buffers rather than being 
prevented by it.

Generally rpcbind should not be exposed to the public Internet, if it is then 
you might have bigger problems than buffer sizes.

As sshd is one of the most common targets of attack on the Internet it seems 
very unlikely to me that buffer sizes would be the problem.  For most servers 
it's just non-stop probes and attempts to brute-force passwords on port 22.

> 2) If we dontaudit net_admin now for SO_SNDBUFFORCE, and any of these
> programs later introduce code (or any of the libraries that they use do
> so) that actually requires net_admin for another purpose, we won't see
> the denial and users will experience breakage with no indication as to
> cause.

Yes this is a real issue.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
