Message-ID: <5458DC37.50903@tycho.nsa.gov>
Date: Tue, 04 Nov 2014 09:01:27 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: peter enderborg <peter.enderborg@sonymobile.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Missing security labels for socket objects?
References: <54526941.3090208@sonymobile.com> <5452702C.2000704@tycho.nsa.gov>
 <54588F41.9050507@sonymobile.com>
In-Reply-To: <54588F41.9050507@sonymobile.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/04/2014 03:33 AM, peter enderborg wrote:
> Is there any work going on the make it more granular? I did not see
> it in the "Remaning Work" backlog. It is a generic problem and should
> have a generic solution.

It is on the new kernel to-do list, at the bottom of new items on:
https://github.com/SELinuxProject/selinux/wiki/Kernel-Todo

However, I'm not sure what the general solution would look like.  I
don't think we want to write policies on socket (domain, type, protocol)
triples or introduce unique security classes for every such triple.  The
security class abstraction in SELinux (and its underlying Flask
architecture) is intended to provide a higher level abstraction for
security policy writers.
