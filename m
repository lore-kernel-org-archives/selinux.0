To: Ted Toth <txtoth@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Daniel J Walsh <dwalsh@redhat.com>
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
 <CAFPpqQEw38WqjLCdHba=krGygiUqp8Z8i+UG6d4CTkg0rW9i3Q@mail.gmail.com>
 <d4404bc7-9f23-7ed6-fb2f-24c31d7e4704@tycho.nsa.gov>
 <CAFPpqQF9=aGg_s8jYzCUycpT6qf6GQv6vkKSAXejZcPPEHpxOw@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <258b172b-01a2-3af5-35e0-6c8f9aade82b@tycho.nsa.gov>
Date: Wed, 12 Sep 2018 09:05:37 -0400
MIME-Version: 1.0
In-Reply-To: <CAFPpqQF9=aGg_s8jYzCUycpT6qf6GQv6vkKSAXejZcPPEHpxOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/11/2018 04:59 PM, Ted Toth wrote:
> That's awesome and now it's got me thinking about other 
> classes/permissions that we could implement. Can cil macros can be 
> referenced in .te/.if files?

Not sure I understand your question.  You can't directly embed cil 
statements in .te/.if files.  However, if you define a class/permission 
in a .cil module, you can certainly specify a require on it and use it 
from a conventional .te/.if module, ala:
$ cat > usemcstrans.te <<EOF
policy_module(usemcstrans, 1.0)

require {
	class mcstrans { color_use };
	attribute domain;
}

allow domain self:mcstrans color_use;
EOF

$ make -f /usr/share/selinux/devel/Makefile usemcstrans.pp
$ sudo semodule -i usemcstrans.pp

> On Tue, Sep 11, 2018 at 2:27 PM Stephen Smalley <sds@tycho.nsa.gov 
> <mailto:sds@tycho.nsa.gov>> wrote:
> 
>     On 09/11/2018 02:49 PM, Ted Toth wrote:
>      > Yes I too noticed the translate permission but couldn't find any
>     info
>      > related to it intended purpose. Regarding CIL unfortunately I
>     have zero
>      > experience with it but I've installed the compiler and started
>     reading
>      > through https://github.com/SELinuxProject/cil/wiki (any other
>     pointers
>      > to useful info would be appreciated). I have written lots of policy
>      > would it be possible to add a class/permissions/mlsconstraints in an
>      > old-fashion policy module?
> 
>     The older binary modules didn't support those kinds of statements
>     outside of the base module.  Try this:
>     $ cat > mcstrans.cil <<EOF
>     ; define a mcstrans class with one permission color_use
>     (class mcstrans (color_use))
>     ; allow all domains mcstrans color_use permission to themselves
>     (allow domain self (mcstrans (color_use)))
>     ; only allow mcstrans color_use permission when h1 dominates h2
>     (mlsconstrain (mcstrans (color_use)) (dom h1 h2))
>     ; append the new mcstrans class to the end after all others
>     (classorder (unordered mcstrans))
>     EOF
> 
>     $ sudo semodule -i mcstrans.cil
> 
>     Then try performing permission checks with "mcstrans" as your class and
>     "color_use" as your permission, between a domain and itself, with
>     different levels.
> 
>      >
>      > On Tue, Sep 11, 2018 at 1:27 PM Stephen Smalley
>     <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
>      > <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>> wrote:
>      >
>      >     On 09/11/2018 10:41 AM, Stephen Smalley wrote:
>      >      > On 09/10/2018 06:30 PM, Ted Toth wrote:
>      >      >> mcstrans mcscolor.c also uses the same logic I'd been
>     using to
>      >     check
>      >      >> dominance so this too will no longer function as expected on
>      >     el7. Do
>      >      >> you any suggestions for doing a 'generic' (one not tied to a
>      >     specific
>      >      >> resource class) dominance check in lieu of context contains?
>      >      >
>      >      > You should probably define your own permission with its own
>      >     constraint
>      >      > to avoid depending on the base policy's particular constraint
>      >      > definitions.  Certainly for your own code.  For mcstrans,
>     mcscolor
>      >      > probably ought to be switched to using at least a separate
>      >     permission in
>      >      > the context class if not its own class to avoid
>     overloading the
>      >     meaning
>      >      > with pam_selinux's usage (or vice versa, but likely harder
>     to change
>      >      > pam_selinux at this point).
>      >      >
>      >      > It is possible to define an entirely new class, its
>     permissions,
>      >     and its
>      >      > mls constraints via a CIL module IIUC, without needing to
>     change the
>      >      > base policy.
>      >      >
>      >      > I don't think you can add a permission to an existing
>     class via a
>      >     CIL
>      >      > module currently, unfortunately, so you can't just extend the
>      >     context
>      >      > class without modifying the base policy.  So it may be
>     easier to
>      >     define
>      >      > an entirely new class.
>      >      >
>      >      > The class and permission ought to be specific to the
>     usage.  For
>      >      > example, mcstrans could have its own class (mcstrans) with
>     its own
>      >      > permissions (e.g. color_match or color_use or ...) that
>     abstract
>      >     away
>      >      > the logical check being performed.  Dominance checks
>     performed for
>      >      > different reasons ought to use different permissions so
>     that one can
>      >      > distinguish what TE pairs are allowed them.
>      >      >
>      >      > Your code could likewise define and use its own class and
>     permission.
>      >      >
>      >      > Does that make sense?
>      >
>      >     BTW, I noticed there is another permission ("translate")
>     defined in the
>      >     context class and its constraint is ((h1 dom h2) or (t1 ==
>      >     mlstranslate)).  I would have guessed that it was intended as a
>      >     front-end service check over what processes could request context
>      >     translations from mcstrans or what contexts they could
>     translate, but I
>      >     don't see it being used in mcstrans anywhere.  Is this a
>     legacy thing
>      >     from early setransd/mcstransd days?  There is a TODO comment in
>      >     mcstrans
>      >     process_request() that suggests there was an intent to perform a
>      >     dominance check between the requester context and the specified
>      >     context,
>      >     but that's not implemented.  Appears to be allowed in current
>     policy
>      >     for
>      >     all domains to the setrans_t domain itself.
>      >
>      >      >
>      >      >>
>      >      >> Ted
>      >      >>
>      >      >> On Mon, Sep 10, 2018 at 1:19 PM Ted Toth
>     <txtoth@gmail.com <mailto:txtoth@gmail.com>
>      >     <mailto:txtoth@gmail.com <mailto:txtoth@gmail.com>>
>      >      >> <mailto:txtoth@gmail.com <mailto:txtoth@gmail.com>
>     <mailto:txtoth@gmail.com <mailto:txtoth@gmail.com>>>> wrote:
>      >      >>
>      >      >>     Understood, thanks.
>      >      >>
>      >      >>     On Mon, Sep 10, 2018 at 12:46 PM Stephen Smalley
>      >     <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
>     <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>
>      >      >>     <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
>     <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>>> wrote:
>      >      >>
>      >      >>         On 09/10/2018 01:13 PM, Ted Toth wrote:
>      >      >>          > We currently have code running on el6 that
>     does a MLS
>      >      >>         dominance check by
>      >      >>          > calling security_compute_av_raw with the security
>      >     object class
>      >      >>          > SECCLASS_CONTEXT with permission
>     CONTEXT__CONTAINS as
>      >     you can
>      >      >>         see in the
>      >      >>          > python code below. When I run this code on el6 s1
>      >     dominates
>      >      >>         s0 however
>      >      >>          > when I run the same code on el7 s1 does not
>     dominate
>      >     s0. On
>      >      >>         both systems
>      >      >>          > the file read dominance check works as
>     expected. Can
>      >     anyone
>      >      >>         help me
>      >      >>          > understand why the context contains check does not
>      >     work the
>      >      >>         same on both
>      >      >>          > systems?
>      >      >>
>      >      >>         That would depend entirely on how the constraint is
>      >     written in
>      >      >> the
>      >      >>         policy.  I assume this is with the -mls policy on
>     both?
>      >     seinfo
>      >      >>         --constrain | grep -C1 context would show you the
>      >     constraint
>      >      >> in the
>      >      >>         kernel policy.
>      >      >>
>      >      >>         Looks like refpolicy defines it as:
>      >      >>         mlsconstrain context contains
>      >      >>                   (( h1 dom h2 ) and ( l1 domby l2));
>      >      >>
>      >      >>         The 2nd part of the constraint was introduced by:
>      >      >>         commit 4c365f4a6a6f933dd13b0127e03f832c6a6cf8fc
>      >      >>         Author: Harry Ciao <qingtao.cao@windriver.com
>     <mailto:qingtao.cao@windriver.com>
>      >     <mailto:qingtao.cao@windriver.com
>     <mailto:qingtao.cao@windriver.com>>
>      >      >>         <mailto:qingtao.cao@windriver.com
>     <mailto:qingtao.cao@windriver.com>
>      >     <mailto:qingtao.cao@windriver.com
>     <mailto:qingtao.cao@windriver.com>>>>
>      >      >>         Date:   Tue Feb 15 10:16:32 2011 +0800
>      >      >>
>      >      >>               l1 domby l2 for contains MLS constraint
>      >      >>
>      >      >>               As identified by Stephan Smalley, the
>     current MLS
>      >      >>         constraint for the
>      >      >>               contains permission of the context class should
>      >     consider
>      >      >>         the current
>      >      >>               level of a user along with the clearance
>     level so that
>      >      >>         mls_systemlow
>      >      >>               is no longer considered contained in
>     mls_systemhigh.
>      >      >>
>      >      >>               Signed-off-by: Harry Ciao
>      >     <qingtao.cao@windriver.com <mailto:qingtao.cao@windriver.com>
>     <mailto:qingtao.cao@windriver.com <mailto:qingtao.cao@windriver.com>>
>      >      >>         <mailto:qingtao.cao@windriver.com
>     <mailto:qingtao.cao@windriver.com>
>      >     <mailto:qingtao.cao@windriver.com
>     <mailto:qingtao.cao@windriver.com>>>>
>      >      >>
>      >      >>         This was to prevent a user from logging in at a level
>      >     below their
>      >      >>         authorized range, in the unusual scenario where the
>      >     user's low
>      >      >>         level was
>      >      >>         not s0/systemlow.
>      >      >>
>      >      >>          >
>      >      >>          > Ted
>      >      >>          >
>      >      >>          >
>      >      >>
>      >      >>
>      >   
>       ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>      >
>      >      >>
>      >      >>          >
>      >      >>          > import selinux
>      >      >>          >
>      >      >>          > SECCLASS_CONTEXT =
>      >     selinux.string_to_security_class("context")
>      >      >>          > CONTEXT__CONTAINS =
>      >      >>         selinux.string_to_av_perm(SECCLASS_CONTEXT,
>     "contains")
>      >      >>          > SECCLASS_FILE =
>     selinux.string_to_security_class("file")
>      >      >>          > FILE__READ =
>     selinux.string_to_av_perm(SECCLASS_FILE,
>      >     "read")
>      >      >>          >
>      >      >>          > raw_con1 = "user_u:user_r:user_t:s1"
>      >      >>          > raw_con2 = "user_u:user_r:user_t:s0"
>      >      >>          >
>      >      >>          > avd = selinux.av_decision()
>      >      >>          > selinux.avc_reset()
>      >      >>          > try:
>      >      >>          >      rc =
>     selinux.security_compute_av_raw(raw_con1,
>      >     raw_con2,
>      >      >>          > SECCLASS_CONTEXT, CONTEXT__CONTAINS, avd)
>      >      >>          >      if rc < 0:
>      >      >>          >          print("selinux.security_compute_av_raw
>      >     failed for %s
>      >      >>         %s" %
>      >      >>          > (raw_con1, raw_con2))
>      >      >>          >      if (avd.allowed & CONTEXT__CONTAINS) ==
>      >      >> CONTEXT__CONTAINS:
>      >      >>          >          print("%s dominates %s" % (raw_con1,
>     raw_con2))
>      >      >>          >      else:
>      >      >>          >          print("%s does not dominate %s" %
>     (raw_con1,
>      >      >> raw_con2))
>      >      >>          > except OSError, ex:
>      >      >>          >      print "exception calling
>      >      >>         selinux.security_compute_av_raw", ex
>      >      >>          >
>      >      >>          > avd = selinux.av_decision()
>      >      >>          > selinux.avc_reset()
>      >      >>          > try:
>      >      >>          >      rc =
>     selinux.security_compute_av_raw(raw_con1,
>      >     raw_con2,
>      >      >>          > SECCLASS_FILE, FILE__READ, avd)
>      >      >>          >      if rc < 0:
>      >      >>          >          print("selinux.security_compute_av_raw
>      >     failed for %s
>      >      >>         %s" %
>      >      >>          > (raw_con1, raw_con2))
>      >      >>          >      if (avd.allowed & FILE__READ) == FILE__READ:
>      >      >>          >          print("%s dominates %s" % (raw_con1,
>     raw_con2))
>      >      >>          >      else:
>      >      >>          >          print("%s does not dominate %s" %
>     (raw_con1,
>      >      >> raw_con2))
>      >      >>          >
>      >      >>          > except OSError:
>      >      >>          >      print "exception calling
>      >      >>         selinux.security_compute_av_raw", ex
>      >      >>          >
>      >      >>          >
>      >      >>          >
>      >      >>          > _______________________________________________
>      >      >>          > Selinux mailing list
>      >      >>          > Selinux@tycho.nsa.gov
>     <mailto:Selinux@tycho.nsa.gov> <mailto:Selinux@tycho.nsa.gov
>     <mailto:Selinux@tycho.nsa.gov>>
>      >     <mailto:Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
>     <mailto:Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>>>
>      >      >>          > To unsubscribe, send email to
>      > Selinux-leave@tycho.nsa.gov <mailto:Selinux-leave@tycho.nsa.gov>
>     <mailto:Selinux-leave@tycho.nsa.gov
>     <mailto:Selinux-leave@tycho.nsa.gov>>
>      >      >>         <mailto:Selinux-leave@tycho.nsa.gov
>     <mailto:Selinux-leave@tycho.nsa.gov>
>      >     <mailto:Selinux-leave@tycho.nsa.gov
>     <mailto:Selinux-leave@tycho.nsa.gov>>>.
>      >      >>          > To get help, send an email containing "help" to
>      >      >> Selinux-request@tycho.nsa.gov
>     <mailto:Selinux-request@tycho.nsa.gov>
>     <mailto:Selinux-request@tycho.nsa.gov
>     <mailto:Selinux-request@tycho.nsa.gov>>
>      >      >>         <mailto:Selinux-request@tycho.nsa.gov
>     <mailto:Selinux-request@tycho.nsa.gov>
>      >     <mailto:Selinux-request@tycho.nsa.gov
>     <mailto:Selinux-request@tycho.nsa.gov>>>.
>      >      >>          >
>      >      >>
>      >      >
>      >
> 
