From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: MCS and unconfined_t
Date: Thu, 30 Mar 2006 23:09:44 +1100
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, sds@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
References: <442933AD.3040208@kaigai.gr.jp> <1143655164.13732.36.camel@sgc.columbia.tresys.com> <442B5714.9080100@kaigai.gr.jp>
In-Reply-To: <442B5714.9080100@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Message-Id: <200603302309.50669.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 30 March 2006 14:57, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> Christopher J. PeBenito wrote:
> > On Wed, 2006-03-29 at 11:45 -0500, Stephen Smalley wrote:
> >> On Wed, 2006-03-29 at 11:29 -0500, Christopher J. PeBenito wrote:
> >>> My issue with that patch was that it had types hardcoded into the
> >>> constraints, violating encapsulation.  In the interim other parts of
> >>> the patch were fixed and resubmitted, but this piece got lost along the
> >>> way. I've committed it, using an attribute and an interface.
> >>
> >> Ok, but it seems like something still isn't quite conceptually here in
> >> MCS - pam_selinux was removed from su, so su isn't supposed to switch
> >> levels, yet running su on FC5 does change to a fully ranged context,
> >> presumably via range_transition.  Which makes no sense to me at all
> >> given the intent of MCS.
> >
> > Agreed.  My guess is that it is left over from when su did have
> > pam_selinux.  It probably should be removed.
>
> Does 'that patch' mean what Russell posted on 03/Feb, doesn't it?
> I think there is another issue other than violating encapsulation.

Yes.

> +mlsconstrain process { transition dyntransition } (( h1 dom h2 ) or
> +		( t1 == getty_t ) or ( t1 == init_t ) or ( t1 == initrc_t ) or
> +		( t1 == kernel_t ));
>
> It says an process can transit to more restricted categories only
> by (h1 dom h2). I felt it's over restriction.
> For example, a user login with 's0' cannot transit to any wider range
> categories, even if he would be allowed to belong 's0-s0:c0.c2' at most.

That is intentional.  The reason for this is that a user may want to run a 
process with a sub-set of their access.  One reason for doing so is dealing 
with untrusted code.  Another reason is to avoid having to make manual 
decisions about labeling and avoiding accidental relabeling.  If the user has 
categories c0 and c1, then they can use s0:c0-s0:c0 for accessing files with 
sensitivity s0:c0, this prevents reading files with category c1 and also 
prevents accidentally reading data from a s0:c0 file and writing it to a s0 
file (files will be created as s0:c0 by default).

> I modified my desktop environment (FC5). At a moment, the following
> configuration seems to me working fine.
> Do you think it's a reasonable solution ?
>
> 1. remove range_transition for su/sudo
>  'range_transition unconfined_t su_exec_t s0 - s0:c0.c255;'
>  is not necessary for su, I also think.

Yes, I believe that this is required as su no longer supports changing roles.

> 2. add a constraint for changing user
>  'constrain process { transition } (u1 == system_u) or (u1 == u2);'
>  is necessary to restrict unbounded transition between categories.
>  system_u is an exception because logind/sshd need to change user name.
>  (It should be replaced by macros from the refpolicy sight.)

Currently when the administrator restarts sshd the sshd process gets the 
identity of the administrator (usually "root").  I don't think that we want 
to go down the path of changing the mlsconstrain rules when adding new user 
identities.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
