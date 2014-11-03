Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA3DaUQx001701
 for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2014 08:36:30 -0500
Message-ID: <545784C2.30203@tresys.com>
Date: Mon, 3 Nov 2014 08:36:02 -0500
From: Steve Lawrence <slawrence@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux Userspace Release: 20140826-rc5
References: <5451090B.2080107@tresys.com>
 <CAPzO=NyRKK=jJ151W6xk_cs7dHKJQCwCxoJc2jZmTLZ_DaXPUA@mail.gmail.com>
In-Reply-To: <CAPzO=NyRKK=jJ151W6xk_cs7dHKJQCwCxoJc2jZmTLZ_DaXPUA@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/02/2014 10:17 AM, Sven Vermeulen wrote:
> On Wed, Oct 29, 2014 at 4:34 PM, Steve Lawrence <slawrence@tresys.com> wrote:
>> The fifth release candidate for the next release of SELinux Userspace
>> [1] is now available. The tarballs have been built and can be downloaded
>> from the Releases wiki page [2]. Changes since rc4 include:
> [...]
>> Please give this a test and let us know if you find any problems.
> 
> Hi Steve
> 
> I notice a regression that I can't quite place yet.
> 
> I am running with a policy that does not have the unconfined module
> loaded (so a strict environment). In the past (same policy, 2.3
> utilities) that also prevented those "unconfined domains" to get their
> privileges. For instance, initrc_t does not have the
> files_unconfined_type assigned to it.
> 
> With the 2.4 series, this attribute is assigned to the domain. I
> *think* that it is ignoring the gen_require(`type unconfined_t') that
> is in unconfined_domain_noaudit() in the sense that the rules that do
> not use unconfined_t are now loaded as well. In the past, this would
> ignore the entire block.
> 

It looks like you are correct, that unconfined_t is the problem. The
unconfined_domain_noaudit interface has a gen_require on unconfined_t.
However, CIL does not have a concept of gen_require. It just tries to
resolve all statements inside an optional block, and if any of them fail
then the optional is disabled. So in refpolicy, this interface depends
on the unconfined_t type, even though it never uses it.

One solution would create a tyepattribute that isn't used in any
statements (and so won't become part of the final kernel policy) but
that types that are gen_required are associated with. This should cause
a failure of the optional without affecting anything alse. Kindof a
hack, and it only works for types/roles since with have attributes for
those, but probably the only way to mimic gen_require in CIL.

Another option would be to change refpolicy so that the unconfined
attributes are defined in the unconfined module rather than in
kernel/domain/fs/etc, but maybe the way unconfined works would make the
difficult. It's also not backwards compatible, so we'd probably still
need the pp change anyway.

- Steve
