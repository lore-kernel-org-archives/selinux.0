Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA4I8dm9006343
 for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2014 13:08:39 -0500
Received: by mail-oi0-f50.google.com with SMTP id v63so7360764oia.37
 for <selinux@tycho.nsa.gov>; Tue, 04 Nov 2014 10:08:37 -0800 (PST)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <545784C2.30203@tresys.com>
References: <5451090B.2080107@tresys.com>
 <CAPzO=NyRKK=jJ151W6xk_cs7dHKJQCwCxoJc2jZmTLZ_DaXPUA@mail.gmail.com>
 <545784C2.30203@tresys.com>
Date: Tue, 4 Nov 2014 19:08:37 +0100
Message-ID: <CAPzO=Ny_xEYC6hgSb+nWJxqfgX6eYOBeUsf7wh+18h9j6nc0JA@mail.gmail.com>
Subject: Re: SELinux Userspace Release: 20140826-rc5
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Steve Lawrence <slawrence@tresys.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 3, 2014 at 2:36 PM, Steve Lawrence <slawrence@tresys.com> wrote:
> It looks like you are correct, that unconfined_t is the problem. The
> unconfined_domain_noaudit interface has a gen_require on unconfined_t.
> However, CIL does not have a concept of gen_require. It just tries to
> resolve all statements inside an optional block, and if any of them fail
> then the optional is disabled. So in refpolicy, this interface depends
> on the unconfined_t type, even though it never uses it.
>
> One solution would create a tyepattribute that isn't used in any
> statements (and so won't become part of the final kernel policy) but
> that types that are gen_required are associated with. This should cause
> a failure of the optional without affecting anything alse. Kindof a
> hack, and it only works for types/roles since with have attributes for
> those, but probably the only way to mimic gen_require in CIL.

Or perhaps inside the optional_policy() block I can define a rule
that, if unconfined was enabled, would be applicable anyway, like so:

allow unconfined_t self:process signal;

(assuming that that is a rule that is applied to unconfined_t - can't
verify it at this moment).

As the unconfined_t isn't defined (unconfined module is not loaded)
then this part blocks as well.

Of course, it's indeed a hack (similar to the typeattribute one).
Having a simple comment above it to make clear that it is to work
around this situation should make it clear.

> Another option would be to change refpolicy so that the unconfined
> attributes are defined in the unconfined module rather than in
> kernel/domain/fs/etc, but maybe the way unconfined works would make the
> difficult. It's also not backwards compatible, so we'd probably still
> need the pp change anyway.

This was actually what I was thinking about implementing on Gentoo to
"fix" this, but might take some time.

Do you have an idea how we could find similar cases? I think the
unconfined ones are the only ones that use such a construction
(gen_require without directly using it) but I rather be certain.

Wkr,
  Sven Vermeulen
