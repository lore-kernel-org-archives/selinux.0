Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256FC370D6F
	for <selinux@vger.kernel.org>; Thu,  2 Apr 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163884; cv=pass; b=OwgilVDho5PQ6la7XoefQeZypQt+bQBYAVgU9Fa08PIdK4q0ZWFbi7YNLwYYmocqFw0jDXmHMSl085oQE6Rc6Ap6QXA0u7ELjWbeSj9e/9oTWw81sLw8cqtzmIjVz8Q0R0tnFwyQp0mEF7gyJBKAbI3Gn/e0lEL645CgYG1deQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163884; c=relaxed/simple;
	bh=LdOh1+8ZF5UigpYCcuDNnnIMguzfLbQM9B4zSiJkh88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aszVGoyExQm3q7tT76nQLTTgFFjwDC+fNOnNrJ7ZLXJw1b7s7rnBRSGS8iyAYsLp+i6OOGbdIhvmSPoHh1yzYC2sWPflEexrHqZCDncjYYAT5VvO9ANOfHpoHIWYWztQzbpo6GLspcW7goEKjG9V2qc7cvpYxE8UGrmFIWR8ypI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NTBzBVe1; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NTBzBVe1"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so942881a91.0
        for <selinux@vger.kernel.org>; Thu, 02 Apr 2026 14:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775163879; cv=none;
        d=google.com; s=arc-20240605;
        b=b1iekPlsXwmRStYuKe3tPoMyk98ryDDhNk4W2BtV4kBibflocD5FFVs0nWkOgvC+8p
         wJ05zaxmRtHsj5BCPMErg2wP0TPTs9CYbJF5KAddw3IjfqQry6qmpOmLTSLXIiKVewlX
         CA9pghGlwXjr93MwqX02Hw4GQXUe0CxZbY3cRuSzXplkCFmXhddmc9lc9elLUjPolwLA
         6xhykcU1ubGFeHQB4BVd5hDh1JoF1pCjsmXIefYNCBETiaEG6WXmnEXoiHsXNBF0BwHM
         3ewhKxwd8o4BKfa6914phreS0082ZlnokI5ktJMNwuxgGdjS1Urg7BRwLdPWOp2Fk/a/
         lCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9njQDibyDxsTjejHFKunCLdjj8yju/JtEBX+qmH9MAM=;
        fh=c+LSqqyREpEPuSYFQGo9jSUHljDqfpMWrY0wVHXVNKg=;
        b=QoyoFORepq9RfjAgK5LAV8/qtSPhpe5B2GqaYrktjFMyFtIpExm36rAFSWIpweqdAe
         a13pJt2gTwFknGzammIKtdOla71BH6nEU5gc8Ik3rkj50VQBY1zyXa9v8BQl05zw6he9
         A9R3DfJ4iaEmo8I1IQF9Q5KIjWYitZUwcGfEPSQJdIOsI1VhYaE80Sgx5NUiaa5jn4GL
         wPvZH60aP5Wgs6Gnf2zBgVhSZCEqx24iaMXj8HEu+MkXxZnQ/M2TCT/HyXSoZZozhwwN
         U0kkOecXCx9UrsybLKh4VVG5XPwhxF8KJQaMl4PDoD8OqyioamaZbOzAWR4oofq3ODAX
         jMXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775163879; x=1775768679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9njQDibyDxsTjejHFKunCLdjj8yju/JtEBX+qmH9MAM=;
        b=NTBzBVe1T5b+WQE1FKW7o9W2e+UjFUcsD2O0zhtkDWdG3dV1S3gXb8kGK5SoDKKx2Y
         WGOpZy4wMv8xzUuUi+5P6VFepWqAO2qLnfbKoqUXShe9ECzz5JFImjP2OX+KN4LKduUj
         pS2twkjoVThalE4jxp1V/a/I1eXHNcLMb+dvl8z0A20r/sSU1blI2YWgxNNT6PTwV4//
         FtydyUx9tpnkcMyGZs7V/HFHKFJCWkasONO2X+FRElszwQy+oOyeaiRPnpsvrayhsK7S
         Q5+WPX7IXaJbzJZ2eP+nrQGpOz0jbxsgZdMjjwhkn4+LAnimPs09cBlfFKXqPDg4SsBz
         //Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775163879; x=1775768679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9njQDibyDxsTjejHFKunCLdjj8yju/JtEBX+qmH9MAM=;
        b=ojfSAC5vvNT+ZZtIr2ftPsr18TycoxYW6+V4nq5FmflB+Gf3xwscG9YYOS1QXWDqxt
         P/hs/NBdb/ZB0HxDHtrBv1i6/NWIdNozd8Qq6z96bMyvSzoT0HzXvC+mPCgzv7pP4JBT
         LffRjAmi3+z9xZKMzkftT2CXEltNJuqprUC72sohrFZRNoX6092GeM3Z+0+oWSlqx5J2
         FOoXWGF4eNjVRd7cHKNxaDs+nJDhBlBhongpAVsuPnVuCINVLkDakprIHvLBV9mQSEXO
         pd2QdGqHr0v3NGxJEkEem/+zuPyFAYo4xE0h1QZ3dVV2zLZUXcPcJFGh/EhcKaPpsSWx
         k6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4BvD/9z9GhnFk+xQPChKOAhBMX7+3vHqDA87IikIyWC03OMox/5+wJbYKfNaOBnp7xUKwqdMt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ejAV/EZD74GwrV8mhBIImvrt0YX+zSGmKh26b7prP72XuMu5
	b8JL+TyVEV2JqF/rHIWRC+H+Gr1vkpC4+nVx57n3DG3luPpigsJjtmRCY7U4IRhCinm31S+NVrz
	zV/aiA4MAaO8OXi+clV0DjcG/3ke0CY13Su4QNKKU
X-Gm-Gg: AeBDies3+aLTEkhllSEknzqu30L8iIWeRsYNBDDa6AwC+P5eGu0PoBi3OvRPe5o5Hq6
	ha//1VLvNqHiawUM5K2Xr6/hiNDJESNxaye/nkGqBE1kyW4gMAGp76vVH4kU1V5z43X9h4kLofa
	QBz/uHIh/AUM45anjflNWktvNQZ3nZGDBuRRtt0wRtIDfVuitH+0pfe59oolMi1ghpDZUTqjCS/
	G6STxaJ8BcE2oWvPCISwjjhtHzETaDZnDbS41mgpoW14NKzdUUHrk9+TZzXXnbKj6csGqeU2/G0
	8Y0kKfU=
X-Received: by 2002:a17:90b:3143:b0:35b:9777:8bb1 with SMTP id
 98e67ed59e1d1-35de68ec770mr317508a91.19.1775163878592; Thu, 02 Apr 2026
 14:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
 <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
 <CAHC9VhRgi8_gdx0nKwkOws1VD6EFG+bHNTN5Q8YCxZ3HOCu5PQ@mail.gmail.com>
 <aclOtS61nbG5Wf3p@wind.enjellic.com> <CAHC9VhR1R7TcC2a2wZ9-G8dmXTuhcDK1YedDduq0sFgPC8QxFw@mail.gmail.com>
 <ac5MKr4lFQhc44i6@wind.enjellic.com>
In-Reply-To: <ac5MKr4lFQhc44i6@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Apr 2026 17:04:25 -0400
X-Gm-Features: AQROBzCIaHTnhc90bhEV2LSlRGySnydvh4poW1sdeWaSfT89bX6Xz1VFSyn7qk8
Message-ID: <CAHC9VhTjgOmQTyAvRXRoRa0cyT7VOiBb5xEBYsXOOt3-vNEG-g@mail.gmail.com>
Subject: Re: LSM namespacing API
To: "Dr. Greg" <greg@enjellic.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 7:00=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
> On Sun, Mar 29, 2026 at 08:56:37PM -0400, Paul Moore wrote:
> > On Sun, Mar 29, 2026 at 12:09???PM Dr. Greg <greg@enjellic.com> wrote:
> > > On Tue, Mar 24, 2026 at 05:31:09PM -0400, Paul Moore wrote:
> > > > On Tue, Mar 3, 2026 at 11:46???AM Paul Moore <paul@paul-moore.com> =
wrote:

...

> Christian had proposed patches for a generic mechanism to create
> LSM security namespace blobs, is implementation of that in scope for
> this effort?

That isn't what Christian proposed, although I can understand how a
quick glance at the patchset would lead you to believe that (I had the
same misunderstanding while skimming my inbox on my phone while
traveling).  I suggest reviewing Christian's post again as well as the
related Landlock patchset which is the first to use the hooks
Christian proposed.

> > > It would seem that the flags variable might be a good option to use t=
o
> > > handle this 2-stage transition, for example LSM_NS_INIT and
> > > LSM_NS_CHANGE, respectively, to specify the initialization and
> > > execution phases of the transition.
>
> > No.  The lsm_unshare() syscall is intended to mimic the existing
> > unshare() syscall as a single step process from a user's
> > perspective.  If it returns successfully the caller will be in a new
> > LSM namespace as defined by the individual LSM specified in the
> > syscall.
>
> OK, we can reason forward with that paradigm.
>
> An orchestrator issues the unshare call for an LSM namespace and upon
> return from the system call the calling task is in a new namespace for
> that particular LSM ...

Yes.

> ... the goal of which is presumably to implement a
> security policy/model different than what had been in force
> previously.

Maybe.  That is dependent on the individual LSM, I don't want to
encode any assumptions on this at the LSM framework layer.

> So the process is in a new LSM specific namespace, but still
> implementing the policy from the previous namespace, until the
> orchestrator can load the new policy and then trigger the LSM to
> change from its previous policy to the newly loaded policy.
>
> Is this consistent with your vision as to how all of this will work?

No.  What an individual LSM does upon creation of a new namespace via
lsm_unshare() is entirely up to that LSM.  The LSM may choose to bound
the new namespace by the parent's policy, or it may choose a
non-hierarchical relationship where the new namespace remains entirely
separate from the parent.  The LSM may start the new namespace in an
uninitialized state (similar to early boot), initialized with a
default policy, initialized with the parent's policy, or something
else.

> > > The other unanswered issue, or perhaps we missed it, are the security
> > > controls that should be associated with the unshare call.
>
> > Each LSM is free to implement whatever access controls it deems
> > necessary in its lsm_unshare() callback.
>
> Just to be clear.
>
> When you refer to 'lsm_unshare() callback' are you referring to a new
> LSM security hook to be be implemented that will allow all of the
> active LSM's to pass judgement on whether or not the unshare should be
> allowed to complete successfully?

No.  The lsm_unshare() callback is the individual LSM provided
function that the LSM framework calls when the lsm_unshare() syscall
is invoked.  Put another way, the lsm_unshare() callback is the
function specified by a LSM, using the LSM_HOOK_INIT() macro, that is
called by the lsm_unshare() syscall.

> > > Will there be a new LSM hook that allows other LSM's to veto the
> > > creation of a namespace either for itself or for another LSM?
> >
> > I would expect the lsm_unshare() syscall to operate similarly to the
> > lsm_set_self_attr() syscall in this regard.
>
> The reference to handling this like lsm_set_self_attr() is unclear.
>
> With lsm_set_self_attr() there is no reason for another LSM to deny
> setting what is an LSM specific attribute, as you note above, each LSM
> gets to decide if the request to set an attribute for the LSM should
> be accepted or denied.

No.  LSM "A" gets to decide if LSM "A" can create a new namespace
using the lsm_unshare() syscall, LSM "B" does not get to enforce any
policy on LSM "A"'s decision.

> Since lsm_unshare() is changing the overall platform security state,
> it seems consistent with the design of the LSM for other LSM's to be
> able to veto this action.

No.  This is not consistent with either the design or general
conventions associated with LSM development.

> Once again, this seems like an action that would be consistent with
> the notion of the lockdown LSM,

No.

> > > Should there be an option to completely compile LSM namespaces out of
> > > the kernel?
>
> > That doesn't belong in the LSM framework layer, that is up to the
> > individual LSMs.
>
> You noted above the desire for lsm_unshare to be consistent with other
> namespaces.
>
> The current kernel paradigm is to allow classes of namespace
> resources, ie. CONFIG_UTS_NS, CONFIG_TIME_NS et.al., to be compiled in
> our out of the kernel.
>
> It seems that CONFIG_LSM_NS would be consistent with that model.

CONFIG_UTS_NS does not have multiple radically different
implementations underneath it.  Comparing any of the existing Kconfig
namespace knobs to what we are attempting to do with the LSM framework
is going to be difficult due to some inherent differences between the
two things.

The lsm_unshare() syscall is simply an API abstraction intended to
make it easier for userspace to interact with the individual LSMs;
instead of dealing with multiple different namespacing APIs, one for
each LSM, lsm_unshare() provides a single interface to make app devs'
lives easier.

If a individual LSM wants to provide a Kconfig knob to toggle their
namespace support they are welcome to do so, lsm_unshare() should
exist regardless and return an error code if the desired LSM does not
implement namespace support in the particular kernel build.

> > > > * Implement /proc/pid/ns/lsm and setns(CLONE_NEWLSM)
> > > >
> > > > As discussed previously, this allows us to move a process into an
> > > > existing, established LSM namespace set.  The caller cannot
> > > > selectively choose which individual LSM namespaces they join from t=
he
> > > > given LSM namespace set, they receive the same LSM namespace
> > > > configuration as the target process.
> > >
> > > As an initial aside.  It would be assumed that a positive result of a
> > > setns call would be to cause the calling process to atomically change
> > > its security namespace set.  This would further suggest the need to
> > > have the security namespace creation process also execute atomically
> > > in a multi-LSM namespace change environment.
>
> > In the setns case no new LSM namespaces should be created, the process
> > simply joins an existing set of LSM namespaces.
>
> The issue isn't about new namespaces being created, the issue is
> atomicity of a change to a new set of security policies.
>
> With setns an atomic transition is implemented.
>
> The proposed lsm_unshare() behavior results in a period of time when
> multiple and varying security policies are active, depending on
> various race issues in the orchestrator implementation.
>
> This opens the door to a raft of potential security issues that we can
> have a new acronym for, Time Of Implementation Time Of Use (TOITOU).

I would expect that any LSM implementing namespaces would have
sufficient protections/locking in place to ensure that processes and
namespaces remain in a consistent state outside of the
protected/locked regions.  It is reasonable for one process to attempt
the creation of a new namespace while another attempts to join the
namespace of the process creating the new namespace.  This is not
really a new problem in systems programming, and is one reason why
synchronization mechanisms exist.  Once again, we do not want to force
any particular solution at the LSM framework layer as the
synchonization mechanisms will likely be very LSM dependent.

> > > ... That is the concept of whether or not a setns
> > > call, for any resource namespace, should also force a security
> > > namespace change if the security namespace of the calling process
> > > differs from that of the target process.
>
> > That decision is left to the individual LSMs.
>
> That is reasonable.
>
> In order to support that model, there would seem to be a need to have
> a new LSM call in the setns code that allows LSM's to determine
> whether or not a change in the active security namespace set should be
> forced, correct?

Possibly.  I think we need to see some RFC code to see how this would
look, but I think the LSM implementation inside the setns() syscall
would need to be done in two stages: the first to "prepare" the join
operation where permissions checks are performed (if desired by the
individual LSM) and any operations that could fail are done; the
second stage would be very basic and simply finish the join operation
without any risk of failure.  An individual LSM could fail the join
operation for a variety of reasons in stage 1, causing the entire
setns() operation to fail, but once we progress to stage 2 the
operation should succeed.

At this point I'm not too bothered by how we do this as it is an
implementation detail buried within the setns() implementation and not
really an API issue.  We could create a single LSM hook that is called
within sys_setns(), or we could leverage the existing two-stage
process within sys_setns() and implement the two LSM stages as two LSM
hooks.  The first option would be more complicated from a LSM
perspective, but cleaner from a nsproxy.c perspective (that alone
could make it the more preferable option).  The latter option would
result in cleaner, thinner LSM hooks, but it would likley add
complexity to ns_common and/or nsset.  As I said earlier, this is a
decision that will likely be decided by how the code ends up looking.

> If so, is implementation of this in scope for the lsm_unshare()
> infrastructure?

No.  The lsm_unshare() syscall would only operate on one LSM at a time
so a two stage process isn't needed at the LSM framework layer.  It is
possible that an individual LSM may want to implement a two-stage
transaction in their lsm_unshare() callback, but that is their
decision.

> To close, at the risk of being the devils advocate.
>
> Given that the sentiment is to force almost all of these
> issues/decisions into the individual LSM's, what is the advantage of
> having a common lsm_unshare() system call?

A single uniform API for userspace applications that wish to make use
of LSM namespaces.  Ideally we want to leverage the existing kernel
APIs, e.g. procfs and setns(), but others, e.g. clone(), remain
impractical due to a combination of technical and political reasons
(we've already discussed some of the former, the latter is a rathole
discussion I'm not going to engage in at the moment).

> In the proposed model, a resource orchestrator is going to need to
> have extensive knowledge over the mechanics of all the LSM's that
> implement namespace functionality.

Maybe.  I don't think orchestrators will need to have "extensive"
knowledge of the individual LSMs, although this largely depends on
what you define as "extensive".

I also want to get ahead of this and say that I have absolutely zero
desire to debate this point with you at the moment.  It's an argument
without end and the discussion is unlikely to yield anything specific
enough to be helpful.

> At a very minimum, intrinsic to
> the concept of security namespaces, there will be a need to load a new
> policy or model into the namespace, an action that will be deeply LSM
> specific.

Possibly, as this is once again very LSM dependent.  Some LSMs may not
need a new policy loaded when they create a new namespace.

I will also, once again, point you at the LSM policy loading syscall
ideas.  While on hold, we've already discussed that they should be
namespace aware and potentially have the ability to trigger new LSM
namespace creation.

> At this point, the only common functionality may be the allocation of
> a new LSM namespace 'blob'.

Now you are starting to get it.  The LSM framework exists primarily as
a multiplexing layer hidden beneath an API.  Originally the API was
only for internal kernel users, but recently we started providing a
userspace syscall API.

--=20
paul-moore.com
