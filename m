Subject: Re: [PATCH] libsepol: support policy modules when roletrans rules
 not supported
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>, Steve Lawrence <slawrence@tresys.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "qingtao.cao@windriver.com" <qingtao.cao@windriver.com>,
        "dwalsh@redhat.com" <dwalsh@redhat.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1302789538.31033.57.camel@moss-pluto>
References: <1302642701-15441-1-git-send-email-eparis@redhat.com>
	 <4DA5BFF0.2090209@tresys.com> <4DA5DEDB.9020005@tresys.com>
	 <1302718034.8639.4.camel@unknown001a4b0c2895>
	 <BANLkTinU3TutCwDNA9eROjAjY+xXmztH1g@mail.gmail.com>
	 <1302789538.31033.57.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Apr 2011 10:06:59 -0400
Message-ID: <1302790019.9684.8.camel@unknown001a4b0c2895>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-04-14 at 09:58 -0400, Stephen Smalley wrote:
> On Thu, 2011-04-14 at 09:55 -0400, Eric Paris wrote:
> > So I'm questioning the correctness of the range_transition and
> > role_transition rules in libsepol.  My main problem is that libsepol
> > defines SECCLASS_* at all.  Right now if the policy reads in one of
> > these rules types without a tclass it will set SECCLASS_PROCESS in the
> > tclasses bitmap.  But we never had any that would declare what the
> > means.  At link time when we have to map "process" in a module to
> > "process" in the base policy.  But if the module didn't require
> > "process" it won't have the mapping.  So the fact that we set the
> > SECCLASS_PROCESS bit could cause it to get mapped to random crap (or
> > nothing at all)  Right?
> > 
> > I know it's ugly but I think we need to do a couple of things.  #1 on
> > that list is get SECCLASS_* out of libsepol altogether.  Those are
> > COMPLETELY a construct of policy.  Not libsepol.  After we remove all
> > of those we need to change the logic of everything that uses them to
> > instead make sure that the "process" class exists in it's definitions
> > and if not declare it.  Then set the bitmap for that new object.
> > 
> > Am I not understanding something about how using SECCLASS_PROCESS
> > could ever be a good idea?
> 
> Until we introduced the kernel support for dynamic class/perm mapping,
> the kernel classes were guaranteed to remain stable in value and thus
> both libsepol and the kernel security server could (and did) directly
> use SECCLASS_PROCESS.  It is still presently valid since we have yet to
> add any classes to the secclass_map[] in the kernel before the process
> class, so the policy value and the kernel index are still
> identity-mapped, but this could of course change going forward.  So
> libsepol needs to be fixed, but that shouldn't cause a bug at present.

So lets say I define a module with something like:

require {
	type unconfined_t;
	type kernel_t;
	class file read;
	class socket read;
	sensitivity s0;
}

allow unconfined_t kernel_t : file read;
allow unconfined_t kernel_t : socket read;
range_transition unconfined_t kernel_t s0;

The module is going to be created setting file as class #1 and socket as
class #2.  Since SECCLASS_PROCESS == 2 we are going to implicitly set
bit 2 when we create the range_transition rule.  Right?  Now when we map
from "bit 2" in the module (which is "socket") to the base.pp we are
actually going to put the rule

range_transition unconfined_t kernel_t : socket s0;

In the final policy.  Right?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
