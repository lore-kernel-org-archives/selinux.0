From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: [OT] SELinux vs. other systems [was Re: [idea] udev + selinux]
Date: Thu, 2 Sep 2004 22:15:20 +1000
Cc: Linas Vepstas <linas@austin.ibm.com>, Nigel Kukard <nkukard@lbsd.net>,
   SELinux <SELinux@tycho.nsa.gov>
References: <20040830173744.GD10151@lbsd.net> <20040831191809.GC4375@lkcl.net> <20040831224447.GA4964@austin.ibm.com>
In-Reply-To: <20040831224447.GA4964@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409022215.20830.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Sep 2004 08:44, Linas Vepstas <linas@austin.ibm.com> wrote:
> Every now and then, I look at SELinux, and I get scared away by its
> complexity.  This complexity makes it very hard to audit, and assure

What auditing are you referring to?  Kernel code, application code, or policy?

The application code is not overly complex.  The kernel code is as good as 
such code can be.  Tresys http://www.tresys.com/ are developing tools for 
auditing SE Linux policy.

> oneself that its actually providing any real security, as opposed to
> the illusion of security.  During this email thread, there are
> references to mysterious rules that neither party in the conversation
> fully understands; this scares me.

Which mysterious rules are you referring to?

> Compare that to this thread, where we are talking about atomic vs.
> non-atomic restoration of context for udev-mounted temp file systems.
> Shudder. This seems to be begging for an exploit to be discovered.
> Are we sure that SELinux is really on the right track here?

The original udev implementation had the device nodes relabelled after 
creation.  As of recent times (since 2002) the default SE Linux policy has 
denied almost all domains (only two system domains) access to device nodes 
labelled as device_t.  This means that there is no window of opportunity for 
an attacker to access a device before it is correctly labelled.

The worst race condition attack would be a DOS attack, cause an access at the 
wrong time and have it be denied when otherwise it would be permitted.  This 
is the least serious of all possible problems related to device labelling.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
