Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB1Kh8Xm012904
 for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2016 15:43:10 -0500
Message-ID: <1480624978.7565.1.camel@trentalancia.net>
Subject: Re: [RFC][PATCH] selinux: support distinctions among all network
 address families
From: Guido Trentalancia <guido@trentalancia.net>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Date: Thu, 01 Dec 2016 21:42:58 +0100
In-Reply-To: <9b023671-606f-d3b2-9d70-3bbcbf5e5dba@tycho.nsa.gov>
References: <1480604861-13982-1-git-send-email-sds@tycho.nsa.gov>
 <f89685d0-2088-6b27-2671-bfaafea57786@tycho.nsa.gov>
 <1480613322.4558.29.camel@trentalancia.net>
 <9b023671-606f-d3b2-9d70-3bbcbf5e5dba@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello Stephen.

On Thu, 01/12/2016 at 13.03 -0500, Stephen Smalley write:
> On 12/01/2016 12:28 PM, Guido Trentalancia wrote:
> > 
> > Hello again Stephen and Paul.
> > 
> > On Thu, 01/12/2016 at 10.57 -0500, Stephen Smalley wrote:
> > > 
> > > On 12/01/2016 10:07 AM, Stephen Smalley wrote:
> > 
> > [...]
> > 
> > > 
> > > A couple of notes on this change:
> > > 
> > > - To fully test (beyond just confirming that it doesn't break
> > > anything
> > > when the policy capability is not defined), we'll need a patched
> > > libsepol and policy (and unfortunately it requires patching the
> > > base
> > > policy; can't be done via a policy module).  Can certainly
> > > provide
> > > those
> > > too but figured I'd wait to see the response to the kernel patch
> > > first.
> > 
> > The libsepol patch is straightforward.
> > 
> > You can have a look at the one I have posted on the 23rd of August
> > 2016
> > under the subject "[PATCH] Update libsepol to support the policy
> > capability for AF_ALG sockets" and adapt it to the new policy
> > capability name and to the fact that you are now removing the
> > Redhat
> > policy capability.
> > 
> > As for the Reference Policy patch, if you want, I can forward to
> > you
> > the one that I had created at that time for the ALG_SOCKET family,
> > so
> > that you can adapt it to the multiple socket types.
> > 
> > Same thing for the SELinux Testsuite patch: if you want, I can
> > forward
> > to you the one that I had created at that time for the ALG_SOCKET
> > family and that would be enough for testing the new capability
> > because
> > it's representative of all the new socket types.
> > 
> > With kind regards,
> 
> Actually, I realized belatedly that CIL makes it possible to enable
> testing of this change just through a policy module.  Attached is a
> CIL
> policy module that one can insert via semodule -i
> testextsockclass.cil (caveat: may break your system if using any of
> these socket classes). Also attached is the libsepol patch.  So now I
> just need a test case - will have a look at your AF_ALG patch.

The libsepol patch looks fine to me, provided that, as you say, it
doesn't break anything on Redhat systems.

Regards,

Guido
