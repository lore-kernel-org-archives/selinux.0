MIME-Version: 1.0
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
 <CAFPpqQEw38WqjLCdHba=krGygiUqp8Z8i+UG6d4CTkg0rW9i3Q@mail.gmail.com>
 <d4404bc7-9f23-7ed6-fb2f-24c31d7e4704@tycho.nsa.gov>
 <CAFPpqQF9=aGg_s8jYzCUycpT6qf6GQv6vkKSAXejZcPPEHpxOw@mail.gmail.com>
 <258b172b-01a2-3af5-35e0-6c8f9aade82b@tycho.nsa.gov>
In-Reply-To: <258b172b-01a2-3af5-35e0-6c8f9aade82b@tycho.nsa.gov>
From: Ted Toth <txtoth@gmail.com>
Date: Wed, 12 Sep 2018 08:26:49 -0500
Message-ID: <CAFPpqQE1x7oS0R21Fm_tU=1XHRy46FEz=ii-QHS9YDE=KAE7Sg@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000baf4be0575ac8bb5"
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000baf4be0575ac8bb5
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 12, 2018 at 8:04 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/11/2018 04:59 PM, Ted Toth wrote:
> > That's awesome and now it's got me thinking about other
> > classes/permissions that we could implement. Can cil macros can be
> > referenced in .te/.if files?
>
> Not sure I understand your question.  You can't directly embed cil
> statements in .te/.if files.  However, if you define a class/permission
> in a .cil module, you can certainly specify a require on it and use it
> from a conventional .te/.if module, ala:
> $ cat > usemcstrans.te <<EOF
> policy_module(usemcstrans, 1.0)
>
> require {
>         class mcstrans { color_use };
>         attribute domain;
> }
>
> allow domain self:mcstrans color_use;
> EOF
>
> $ make -f /usr/share/selinux/devel/Makefile usemcstrans.pp
> $ sudo semodule -i usemcstrans.pp
>
>
If the cil contained:

(macro use_color (type caller) (allow caller self mcstrans (color_use)))

then in x.te can I use the macro:

type x_t;
use_color(x_t)


> On Tue, Sep 11, 2018 at 2:27 PM Stephen Smalley <sds@tycho.nsa.gov
> > <mailto:sds@tycho.nsa.gov>> wrote:
> >
> >     On 09/11/2018 02:49 PM, Ted Toth wrote:
> >      > Yes I too noticed the translate permission but couldn't find any
> >     info
> >      > related to it intended purpose. Regarding CIL unfortunately I
> >     have zero
> >      > experience with it but I've installed the compiler and started
> >     reading
> >      > through https://github.com/SELinuxProject/cil/wiki (any other
> >     pointers
> >      > to useful info would be appreciated). I have written lots of
> policy
> >      > would it be possible to add a class/permissions/mlsconstraints in
> an
> >      > old-fashion policy module?
> >
> >     The older binary modules didn't support those kinds of statements
> >     outside of the base module.  Try this:
> >     $ cat > mcstrans.cil <<EOF
> >     ; define a mcstrans class with one permission color_use
> >     (class mcstrans (color_use))
> >     ; allow all domains mcstrans color_use permission to themselves
> >     (allow domain self (mcstrans (color_use)))
> >     ; only allow mcstrans color_use permission when h1 dominates h2
> >     (mlsconstrain (mcstrans (color_use)) (dom h1 h2))
> >     ; append the new mcstrans class to the end after all others
> >     (classorder (unordered mcstrans))
> >     EOF
> >
> >     $ sudo semodule -i mcstrans.cil
> >
> >     Then try performing permission checks with "mcstrans" as your class
> and
> >     "color_use" as your permission, between a domain and itself, with
> >     different levels.
> >
> >      >
> >      > On Tue, Sep 11, 2018 at 1:27 PM Stephen Smalley
> >     <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
> >      > <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>> wrote:
> >      >
> >      >     On 09/11/2018 10:41 AM, Stephen Smalley wrote:
> >      >      > On 09/10/2018 06:30 PM, Ted Toth wrote:
> >      >      >> mcstrans mcscolor.c also uses the same logic I'd been
> >     using to
> >      >     check
> >      >      >> dominance so this too will no longer function as expected
> on
> >      >     el7. Do
> >      >      >> you any suggestions for doing a 'generic' (one not tied
> to a
> >      >     specific
> >      >      >> resource class) dominance check in lieu of context
> contains?
> >      >      >
> >      >      > You should probably define your own permission with its own
> >      >     constraint
> >      >      > to avoid depending on the base policy's particular
> constraint
> >      >      > definitions.  Certainly for your own code.  For mcstrans,
> >     mcscolor
> >      >      > probably ought to be switched to using at least a separate
> >      >     permission in
> >      >      > the context class if not its own class to avoid
> >     overloading the
> >      >     meaning
> >      >      > with pam_selinux's usage (or vice versa, but likely harder
> >     to change
> >      >      > pam_selinux at this point).
> >      >      >
> >      >      > It is possible to define an entirely new class, its
> >     permissions,
> >      >     and its
> >      >      > mls constraints via a CIL module IIUC, without needing to
> >     change the
> >      >      > base policy.
> >      >      >
> >      >      > I don't think you can add a permission to an existing
> >     class via a
> >      >     CIL
> >      >      > module currently, unfortunately, so you can't just extend
> the
> >      >     context
> >      >      > class without modifying the base policy.  So it may be
> >     easier to
> >      >     define
> >      >      > an entirely new class.
> >      >      >
> >      >      > The class and permission ought to be specific to the
> >     usage.  For
> >      >      > example, mcstrans could have its own class (mcstrans) with
> >     its own
> >      >      > permissions (e.g. color_match or color_use or ...) that
> >     abstract
> >      >     away
> >      >      > the logical check being performed.  Dominance checks
> >     performed for
> >      >      > different reasons ought to use different permissions so
> >     that one can
> >      >      > distinguish what TE pairs are allowed them.
> >      >      >
> >      >      > Your code could likewise define and use its own class and
> >     permission.
> >      >      >
> >      >      > Does that make sense?
> >      >
> >      >     BTW, I noticed there is another permission ("translate")
> >     defined in the
> >      >     context class and its constraint is ((h1 dom h2) or (t1 ==
> >      >     mlstranslate)).  I would have guessed that it was intended as
> a
> >      >     front-end service check over what processes could request
> context
> >      >     translations from mcstrans or what contexts they could
> >     translate, but I
> >      >     don't see it being used in mcstrans anywhere.  Is this a
> >     legacy thing
> >      >     from early setransd/mcstransd days?  There is a TODO comment
> in
> >      >     mcstrans
> >      >     process_request() that suggests there was an intent to
> perform a
> >      >     dominance check between the requester context and the
> specified
> >      >     context,
> >      >     but that's not implemented.  Appears to be allowed in current
> >     policy
> >      >     for
> >      >     all domains to the setrans_t domain itself.
> >      >
> >      >      >
> >      >      >>
> >      >      >> Ted
> >      >      >>
> >      >      >> On Mon, Sep 10, 2018 at 1:19 PM Ted Toth
> >     <txtoth@gmail.com <mailto:txtoth@gmail.com>
> >      >     <mailto:txtoth@gmail.com <mailto:txtoth@gmail.com>>
> >      >      >> <mailto:txtoth@gmail.com <mailto:txtoth@gmail.com>
> >     <mailto:txtoth@gmail.com <mailto:txtoth@gmail.com>>>> wrote:
> >      >      >>
> >      >      >>     Understood, thanks.
> >      >      >>
> >      >      >>     On Mon, Sep 10, 2018 at 12:46 PM Stephen Smalley
> >      >     <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
> >     <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>
> >      >      >>     <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
> >     <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>>> wrote:
> >      >      >>
> >      >      >>         On 09/10/2018 01:13 PM, Ted Toth wrote:
> >      >      >>          > We currently have code running on el6 that
> >     does a MLS
> >      >      >>         dominance check by
> >      >      >>          > calling security_compute_av_raw with the
> security
> >      >     object class
> >      >      >>          > SECCLASS_CONTEXT with permission
> >     CONTEXT__CONTAINS as
> >      >     you can
> >      >      >>         see in the
> >      >      >>          > python code below. When I run this code on el6
> s1
> >      >     dominates
> >      >      >>         s0 however
> >      >      >>          > when I run the same code on el7 s1 does not
> >     dominate
> >      >     s0. On
> >      >      >>         both systems
> >      >      >>          > the file read dominance check works as
> >     expected. Can
> >      >     anyone
> >      >      >>         help me
> >      >      >>          > understand why the context contains check does
> not
> >      >     work the
> >      >      >>         same on both
> >      >      >>          > systems?
> >      >      >>
> >      >      >>         That would depend entirely on how the constraint
> is
> >      >     written in
> >      >      >> the
> >      >      >>         policy.  I assume this is with the -mls policy on
> >     both?
> >      >     seinfo
> >      >      >>         --constrain | grep -C1 context would show you the
> >      >     constraint
> >      >      >> in the
> >      >      >>         kernel policy.
> >      >      >>
> >      >      >>         Looks like refpolicy defines it as:
> >      >      >>         mlsconstrain context contains
> >      >      >>                   (( h1 dom h2 ) and ( l1 domby l2));
> >      >      >>
> >      >      >>         The 2nd part of the constraint was introduced by:
> >      >      >>         commit 4c365f4a6a6f933dd13b0127e03f832c6a6cf8fc
> >      >      >>         Author: Harry Ciao <qingtao.cao@windriver.com
> >     <mailto:qingtao.cao@windriver.com>
> >      >     <mailto:qingtao.cao@windriver.com
> >     <mailto:qingtao.cao@windriver.com>>
> >      >      >>         <mailto:qingtao.cao@windriver.com
> >     <mailto:qingtao.cao@windriver.com>
> >      >     <mailto:qingtao.cao@windriver.com
> >     <mailto:qingtao.cao@windriver.com>>>>
> >      >      >>         Date:   Tue Feb 15 10:16:32 2011 +0800
> >      >      >>
> >      >      >>               l1 domby l2 for contains MLS constraint
> >      >      >>
> >      >      >>               As identified by Stephan Smalley, the
> >     current MLS
> >      >      >>         constraint for the
> >      >      >>               contains permission of the context class
> should
> >      >     consider
> >      >      >>         the current
> >      >      >>               level of a user along with the clearance
> >     level so that
> >      >      >>         mls_systemlow
> >      >      >>               is no longer considered contained in
> >     mls_systemhigh.
> >      >      >>
> >      >      >>               Signed-off-by: Harry Ciao
> >      >     <qingtao.cao@windriver.com <mailto:qingtao.cao@windriver.com>
> >     <mailto:qingtao.cao@windriver.com <mailto:qingtao.cao@windriver.com
> >>
> >      >      >>         <mailto:qingtao.cao@windriver.com
> >     <mailto:qingtao.cao@windriver.com>
> >      >     <mailto:qingtao.cao@windriver.com
> >     <mailto:qingtao.cao@windriver.com>>>>
> >      >      >>
> >      >      >>         This was to prevent a user from logging in at a
> level
> >      >     below their
> >      >      >>         authorized range, in the unusual scenario where
> the
> >      >     user's low
> >      >      >>         level was
> >      >      >>         not s0/systemlow.
> >      >      >>
> >      >      >>          >
> >      >      >>          > Ted
> >      >      >>          >
> >      >      >>          >
> >      >      >>
> >      >      >>
> >      >
> >
>  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> >      >
> >      >      >>
> >      >      >>          >
> >      >      >>          > import selinux
> >      >      >>          >
> >      >      >>          > SECCLASS_CONTEXT =
> >      >     selinux.string_to_security_class("context")
> >      >      >>          > CONTEXT__CONTAINS =
> >      >      >>         selinux.string_to_av_perm(SECCLASS_CONTEXT,
> >     "contains")
> >      >      >>          > SECCLASS_FILE =
> >     selinux.string_to_security_class("file")
> >      >      >>          > FILE__READ =
> >     selinux.string_to_av_perm(SECCLASS_FILE,
> >      >     "read")
> >      >      >>          >
> >      >      >>          > raw_con1 = "user_u:user_r:user_t:s1"
> >      >      >>          > raw_con2 = "user_u:user_r:user_t:s0"
> >      >      >>          >
> >      >      >>          > avd = selinux.av_decision()
> >      >      >>          > selinux.avc_reset()
> >      >      >>          > try:
> >      >      >>          >      rc =
> >     selinux.security_compute_av_raw(raw_con1,
> >      >     raw_con2,
> >      >      >>          > SECCLASS_CONTEXT, CONTEXT__CONTAINS, avd)
> >      >      >>          >      if rc < 0:
> >      >      >>          >          print("selinux.security_compute_av_raw
> >      >     failed for %s
> >      >      >>         %s" %
> >      >      >>          > (raw_con1, raw_con2))
> >      >      >>          >      if (avd.allowed & CONTEXT__CONTAINS) ==
> >      >      >> CONTEXT__CONTAINS:
> >      >      >>          >          print("%s dominates %s" % (raw_con1,
> >     raw_con2))
> >      >      >>          >      else:
> >      >      >>          >          print("%s does not dominate %s" %
> >     (raw_con1,
> >      >      >> raw_con2))
> >      >      >>          > except OSError, ex:
> >      >      >>          >      print "exception calling
> >      >      >>         selinux.security_compute_av_raw", ex
> >      >      >>          >
> >      >      >>          > avd = selinux.av_decision()
> >      >      >>          > selinux.avc_reset()
> >      >      >>          > try:
> >      >      >>          >      rc =
> >     selinux.security_compute_av_raw(raw_con1,
> >      >     raw_con2,
> >      >      >>          > SECCLASS_FILE, FILE__READ, avd)
> >      >      >>          >      if rc < 0:
> >      >      >>          >          print("selinux.security_compute_av_raw
> >      >     failed for %s
> >      >      >>         %s" %
> >      >      >>          > (raw_con1, raw_con2))
> >      >      >>          >      if (avd.allowed & FILE__READ) ==
> FILE__READ:
> >      >      >>          >          print("%s dominates %s" % (raw_con1,
> >     raw_con2))
> >      >      >>          >      else:
> >      >      >>          >          print("%s does not dominate %s" %
> >     (raw_con1,
> >      >      >> raw_con2))
> >      >      >>          >
> >      >      >>          > except OSError:
> >      >      >>          >      print "exception calling
> >      >      >>         selinux.security_compute_av_raw", ex
> >      >      >>          >
> >      >      >>          >
> >      >      >>          >
> >      >      >>          > _______________________________________________
> >      >      >>          > Selinux mailing list
> >      >      >>          > Selinux@tycho.nsa.gov
> >     <mailto:Selinux@tycho.nsa.gov> <mailto:Selinux@tycho.nsa.gov
> >     <mailto:Selinux@tycho.nsa.gov>>
> >      >     <mailto:Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
> >     <mailto:Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>>>
> >      >      >>          > To unsubscribe, send email to
> >      > Selinux-leave@tycho.nsa.gov <mailto:Selinux-leave@tycho.nsa.gov>
> >     <mailto:Selinux-leave@tycho.nsa.gov
> >     <mailto:Selinux-leave@tycho.nsa.gov>>
> >      >      >>         <mailto:Selinux-leave@tycho.nsa.gov
> >     <mailto:Selinux-leave@tycho.nsa.gov>
> >      >     <mailto:Selinux-leave@tycho.nsa.gov
> >     <mailto:Selinux-leave@tycho.nsa.gov>>>.
> >      >      >>          > To get help, send an email containing "help" to
> >      >      >> Selinux-request@tycho.nsa.gov
> >     <mailto:Selinux-request@tycho.nsa.gov>
> >     <mailto:Selinux-request@tycho.nsa.gov
> >     <mailto:Selinux-request@tycho.nsa.gov>>
> >      >      >>         <mailto:Selinux-request@tycho.nsa.gov
> >     <mailto:Selinux-request@tycho.nsa.gov>
> >      >     <mailto:Selinux-request@tycho.nsa.gov
> >     <mailto:Selinux-request@tycho.nsa.gov>>>.
> >      >      >>          >
> >      >      >>
> >      >      >
> >      >
> >
>
>

--000000000000baf4be0575ac8bb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9
Imx0ciI+T24gV2VkLCBTZXAgMTIsIDIwMTggYXQgODowNCBBTSBTdGVwaGVuIFNtYWxsZXkgJmx0
OzxhIGhyZWY9Im1haWx0bzpzZHNAdHljaG8ubnNhLmdvdiI+c2RzQHR5Y2hvLm5zYS5nb3Y8L2E+
Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+T24gMDkvMTEvMjAxOCAwNDo1OSBQTSwgVGVkIFRvdGggd3JvdGU6PGJyPg0KJmd0
OyBUaGF0JiMzOTtzIGF3ZXNvbWUgYW5kIG5vdyBpdCYjMzk7cyBnb3QgbWUgdGhpbmtpbmcgYWJv
dXQgb3RoZXIgPGJyPg0KJmd0OyBjbGFzc2VzL3Blcm1pc3Npb25zIHRoYXQgd2UgY291bGQgaW1w
bGVtZW50LiBDYW4gY2lsIG1hY3JvcyBjYW4gYmUgPGJyPg0KJmd0OyByZWZlcmVuY2VkIGluIC50
ZS8uaWYgZmlsZXM/PGJyPg0KPGJyPg0KTm90IHN1cmUgSSB1bmRlcnN0YW5kIHlvdXIgcXVlc3Rp
b24uwqAgWW91IGNhbiYjMzk7dCBkaXJlY3RseSBlbWJlZCBjaWwgPGJyPg0Kc3RhdGVtZW50cyBp
biAudGUvLmlmIGZpbGVzLsKgIEhvd2V2ZXIsIGlmIHlvdSBkZWZpbmUgYSBjbGFzcy9wZXJtaXNz
aW9uIDxicj4NCmluIGEgLmNpbCBtb2R1bGUsIHlvdSBjYW4gY2VydGFpbmx5IHNwZWNpZnkgYSBy
ZXF1aXJlIG9uIGl0IGFuZCB1c2UgaXQgPGJyPg0KZnJvbSBhIGNvbnZlbnRpb25hbCAudGUvLmlm
IG1vZHVsZSwgYWxhOjxicj4NCiQgY2F0ICZndDsgdXNlbWNzdHJhbnMudGUgJmx0OyZsdDtFT0Y8
YnI+DQpwb2xpY3lfbW9kdWxlKHVzZW1jc3RyYW5zLCAxLjApPGJyPg0KPGJyPg0KcmVxdWlyZSB7
PGJyPg0KwqAgwqAgwqAgwqAgY2xhc3MgbWNzdHJhbnMgeyBjb2xvcl91c2UgfTs8YnI+DQrCoCDC
oCDCoCDCoCBhdHRyaWJ1dGUgZG9tYWluOzxicj4NCn08YnI+DQo8YnI+DQphbGxvdyBkb21haW4g
c2VsZjptY3N0cmFucyBjb2xvcl91c2U7PGJyPg0KRU9GPGJyPg0KPGJyPg0KJCBtYWtlIC1mIC91
c3Ivc2hhcmUvc2VsaW51eC9kZXZlbC9NYWtlZmlsZSB1c2VtY3N0cmFucy5wcDxicj4NCiQgc3Vk
byBzZW1vZHVsZSAtaSB1c2VtY3N0cmFucy5wcDxicj4NCjxicj48L2Jsb2NrcXVvdGU+PGRpdj48
YnI+PC9kaXY+PGRpdj5JZiB0aGUgY2lsIGNvbnRhaW5lZDo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PihtYWNybyB1c2VfY29sb3IgKHR5cGUgY2FsbGVyKSAoYWxsb3cgY2FsbGVyIHNlbGYgbWNz
dHJhbnMgKGNvbG9yX3VzZSkpKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+dGhlbiBpbiB4LnRl
IGNhbiBJIHVzZSB0aGUgbWFjcm86PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj50eXBlIHhfdDs8
L2Rpdj48ZGl2PnVzZV9jb2xvcih4X3QpPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQomZ3Q7IE9u
IFR1ZSwgU2VwIDExLCAyMDE4IGF0IDI6MjcgUE0gU3RlcGhlbiBTbWFsbGV5ICZsdDs8YSBocmVm
PSJtYWlsdG86c2RzQHR5Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5zZHNAdHljaG8ubnNh
LmdvdjwvYT4gPGJyPg0KJmd0OyAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpzZHNAdHljaG8u
bnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsiPnNkc0B0eWNoby5uc2EuZ292PC9hPiZndDsmZ3Q7IHdy
b3RlOjxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgT24gMDkvMTEvMjAxOCAwMjo0OSBQTSwg
VGVkIFRvdGggd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKgICZndDsgWWVzIEkgdG9vIG5vdGljZWQg
dGhlIHRyYW5zbGF0ZSBwZXJtaXNzaW9uIGJ1dCBjb3VsZG4mIzM5O3QgZmluZCBhbnk8YnI+DQom
Z3Q7wqAgwqAgwqBpbmZvPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgcmVsYXRlZCB0byBpdCBpbnRl
bmRlZCBwdXJwb3NlLiBSZWdhcmRpbmcgQ0lMIHVuZm9ydHVuYXRlbHkgSTxicj4NCiZndDvCoCDC
oCDCoGhhdmUgemVybzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7IGV4cGVyaWVuY2Ugd2l0aCBpdCBi
dXQgSSYjMzk7dmUgaW5zdGFsbGVkIHRoZSBjb21waWxlciBhbmQgc3RhcnRlZDxicj4NCiZndDvC
oCDCoCDCoHJlYWRpbmc8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyB0aHJvdWdoIDxhIGhyZWY9Imh0
dHBzOi8vZ2l0aHViLmNvbS9TRUxpbnV4UHJvamVjdC9jaWwvd2lraSIgcmVsPSJub3JlZmVycmVy
IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL1NFTGludXhQcm9qZWN0L2NpbC93
aWtpPC9hPiAoYW55IG90aGVyPGJyPg0KJmd0O8KgIMKgIMKgcG9pbnRlcnM8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0OyB0byB1c2VmdWwgaW5mbyB3b3VsZCBiZSBhcHByZWNpYXRlZCkuIEkgaGF2ZSB3
cml0dGVuIGxvdHMgb2YgcG9saWN5PGJyPg0KJmd0O8KgIMKgIMKgICZndDsgd291bGQgaXQgYmUg
cG9zc2libGUgdG8gYWRkIGEgY2xhc3MvcGVybWlzc2lvbnMvbWxzY29uc3RyYWludHMgaW4gYW48
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyBvbGQtZmFzaGlvbiBwb2xpY3kgbW9kdWxlPzxicj4NCiZn
dDsgPGJyPg0KJmd0O8KgIMKgIMKgVGhlIG9sZGVyIGJpbmFyeSBtb2R1bGVzIGRpZG4mIzM5O3Qg
c3VwcG9ydCB0aG9zZSBraW5kcyBvZiBzdGF0ZW1lbnRzPGJyPg0KJmd0O8KgIMKgIMKgb3V0c2lk
ZSBvZiB0aGUgYmFzZSBtb2R1bGUuwqAgVHJ5IHRoaXM6PGJyPg0KJmd0O8KgIMKgIMKgJCBjYXQg
Jmd0OyBtY3N0cmFucy5jaWwgJmx0OyZsdDtFT0Y8YnI+DQomZ3Q7wqAgwqAgwqA7IGRlZmluZSBh
IG1jc3RyYW5zIGNsYXNzIHdpdGggb25lIHBlcm1pc3Npb24gY29sb3JfdXNlPGJyPg0KJmd0O8Kg
IMKgIMKgKGNsYXNzIG1jc3RyYW5zIChjb2xvcl91c2UpKTxicj4NCiZndDvCoCDCoCDCoDsgYWxs
b3cgYWxsIGRvbWFpbnMgbWNzdHJhbnMgY29sb3JfdXNlIHBlcm1pc3Npb24gdG8gdGhlbXNlbHZl
czxicj4NCiZndDvCoCDCoCDCoChhbGxvdyBkb21haW4gc2VsZiAobWNzdHJhbnMgKGNvbG9yX3Vz
ZSkpKTxicj4NCiZndDvCoCDCoCDCoDsgb25seSBhbGxvdyBtY3N0cmFucyBjb2xvcl91c2UgcGVy
bWlzc2lvbiB3aGVuIGgxIGRvbWluYXRlcyBoMjxicj4NCiZndDvCoCDCoCDCoChtbHNjb25zdHJh
aW4gKG1jc3RyYW5zIChjb2xvcl91c2UpKSAoZG9tIGgxIGgyKSk8YnI+DQomZ3Q7wqAgwqAgwqA7
IGFwcGVuZCB0aGUgbmV3IG1jc3RyYW5zIGNsYXNzIHRvIHRoZSBlbmQgYWZ0ZXIgYWxsIG90aGVy
czxicj4NCiZndDvCoCDCoCDCoChjbGFzc29yZGVyICh1bm9yZGVyZWQgbWNzdHJhbnMpKTxicj4N
CiZndDvCoCDCoCDCoEVPRjxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgJCBzdWRvIHNlbW9k
dWxlIC1pIG1jc3RyYW5zLmNpbDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgVGhlbiB0cnkg
cGVyZm9ybWluZyBwZXJtaXNzaW9uIGNoZWNrcyB3aXRoICZxdW90O21jc3RyYW5zJnF1b3Q7IGFz
IHlvdXIgY2xhc3MgYW5kPGJyPg0KJmd0O8KgIMKgIMKgJnF1b3Q7Y29sb3JfdXNlJnF1b3Q7IGFz
IHlvdXIgcGVybWlzc2lvbiwgYmV0d2VlbiBhIGRvbWFpbiBhbmQgaXRzZWxmLCB3aXRoPGJyPg0K
Jmd0O8KgIMKgIMKgZGlmZmVyZW50IGxldmVscy48YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDsgT24gVHVlLCBTZXAgMTEsIDIwMTggYXQgMToy
NyBQTSBTdGVwaGVuIFNtYWxsZXk8YnI+DQomZ3Q7wqAgwqAgwqAmbHQ7PGEgaHJlZj0ibWFpbHRv
OnNkc0B0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+c2RzQHR5Y2hvLm5zYS5nb3Y8L2E+
ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnNkc0B0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9i
bGFuayI+c2RzQHR5Y2hvLm5zYS5nb3Y8L2E+Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7ICZs
dDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnNkc0B0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFu
ayI+c2RzQHR5Y2hvLm5zYS5nb3Y8L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnNkc0B0
eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+c2RzQHR5Y2hvLm5zYS5nb3Y8L2E+Jmd0OyZn
dDsmZ3Q7IHdyb3RlOjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoE9uIDA5LzExLzIwMTggMTA6NDEgQU0sIFN0ZXBoZW4gU21hbGxleSB3cm90ZTo8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgT24gMDkvMTAvMjAxOCAwNjozMCBQ
TSwgVGVkIFRvdGggd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0
OyBtY3N0cmFucyBtY3Njb2xvci5jIGFsc28gdXNlcyB0aGUgc2FtZSBsb2dpYyBJJiMzOTtkIGJl
ZW48YnI+DQomZ3Q7wqAgwqAgwqB1c2luZyB0bzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqBjaGVjazxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgZG9taW5hbmNl
IHNvIHRoaXMgdG9vIHdpbGwgbm8gbG9uZ2VyIGZ1bmN0aW9uIGFzIGV4cGVjdGVkIG9uPGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoGVsNy4gRG88YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsmZ3Q7IHlvdSBhbnkgc3VnZ2VzdGlvbnMgZm9yIGRvaW5nIGEgJiMzOTtnZW5l
cmljJiMzOTsgKG9uZSBub3QgdGllZCB0byBhPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oHNwZWNpZmljPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyByZXNvdXJj
ZSBjbGFzcykgZG9taW5hbmNlIGNoZWNrIGluIGxpZXUgb2YgY29udGV4dCBjb250YWlucz88YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgWW91IHNob3VsZCBwcm9iYWJseSBkZWZpbmUgeW91ciBvd24gcGVybWlzc2lv
biB3aXRoIGl0cyBvd248YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgY29uc3RyYWludDxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyB0byBhdm9pZCBkZXBlbmRpbmcgb24g
dGhlIGJhc2UgcG9saWN5JiMzOTtzIHBhcnRpY3VsYXIgY29uc3RyYWludDxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyBkZWZpbml0aW9ucy7CoCBDZXJ0YWlubHkgZm9yIHlvdXIg
b3duIGNvZGUuwqAgRm9yIG1jc3RyYW5zLDxicj4NCiZndDvCoCDCoCDCoG1jc2NvbG9yPGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7IHByb2JhYmx5IG91Z2h0IHRvIGJlIHN3aXRj
aGVkIHRvIHVzaW5nIGF0IGxlYXN0IGEgc2VwYXJhdGU8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgcGVybWlzc2lvbiBpbjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyB0
aGUgY29udGV4dCBjbGFzcyBpZiBub3QgaXRzIG93biBjbGFzcyB0byBhdm9pZDxicj4NCiZndDvC
oCDCoCDCoG92ZXJsb2FkaW5nIHRoZTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBtZWFu
aW5nPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7IHdpdGggcGFtX3NlbGludXgm
IzM5O3MgdXNhZ2UgKG9yIHZpY2UgdmVyc2EsIGJ1dCBsaWtlbHkgaGFyZGVyPGJyPg0KJmd0O8Kg
IMKgIMKgdG8gY2hhbmdlPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7IHBhbV9z
ZWxpbnV4IGF0IHRoaXMgcG9pbnQpLjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyBJdCBpcyBwb3NzaWJsZSB0byBk
ZWZpbmUgYW4gZW50aXJlbHkgbmV3IGNsYXNzLCBpdHM8YnI+DQomZ3Q7wqAgwqAgwqBwZXJtaXNz
aW9ucyw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgYW5kIGl0czxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyBtbHMgY29uc3RyYWludHMgdmlhIGEgQ0lMIG1vZHVsZSBJ
SVVDLCB3aXRob3V0IG5lZWRpbmcgdG88YnI+DQomZ3Q7wqAgwqAgwqBjaGFuZ2UgdGhlPGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7IGJhc2UgcG9saWN5Ljxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyBJIGRvbiYjMzk7dCB0aGluayB5b3UgY2FuIGFkZCBhIHBlcm1pc3Npb24gdG8gYW4gZXhpc3Rp
bmc8YnI+DQomZ3Q7wqAgwqAgwqBjbGFzcyB2aWEgYTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqBDSUw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgbW9kdWxlIGN1cnJl
bnRseSwgdW5mb3J0dW5hdGVseSwgc28geW91IGNhbiYjMzk7dCBqdXN0IGV4dGVuZCB0aGU8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgY29udGV4dDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyBjbGFzcyB3aXRob3V0IG1vZGlmeWluZyB0aGUgYmFzZSBwb2xpY3kuwqAg
U28gaXQgbWF5IGJlPGJyPg0KJmd0O8KgIMKgIMKgZWFzaWVyIHRvPGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoGRlZmluZTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyBh
biBlbnRpcmVseSBuZXcgY2xhc3MuPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7IFRoZSBjbGFzcyBhbmQgcGVybWlz
c2lvbiBvdWdodCB0byBiZSBzcGVjaWZpYyB0byB0aGU8YnI+DQomZ3Q7wqAgwqAgwqB1c2FnZS7C
oCBGb3I8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgZXhhbXBsZSwgbWNzdHJh
bnMgY291bGQgaGF2ZSBpdHMgb3duIGNsYXNzIChtY3N0cmFucykgd2l0aDxicj4NCiZndDvCoCDC
oCDCoGl0cyBvd248YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgcGVybWlzc2lv
bnMgKGUuZy4gY29sb3JfbWF0Y2ggb3IgY29sb3JfdXNlIG9yIC4uLikgdGhhdDxicj4NCiZndDvC
oCDCoCDCoGFic3RyYWN0PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoGF3YXk8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgdGhlIGxvZ2ljYWwgY2hlY2sgYmVpbmcgcGVy
Zm9ybWVkLsKgIERvbWluYW5jZSBjaGVja3M8YnI+DQomZ3Q7wqAgwqAgwqBwZXJmb3JtZWQgZm9y
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7IGRpZmZlcmVudCByZWFzb25zIG91
Z2h0IHRvIHVzZSBkaWZmZXJlbnQgcGVybWlzc2lvbnMgc288YnI+DQomZ3Q7wqAgwqAgwqB0aGF0
IG9uZSBjYW48YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgZGlzdGluZ3Vpc2gg
d2hhdCBURSBwYWlycyBhcmUgYWxsb3dlZCB0aGVtLjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyBZb3VyIGNvZGUg
Y291bGQgbGlrZXdpc2UgZGVmaW5lIGFuZCB1c2UgaXRzIG93biBjbGFzcyBhbmQ8YnI+DQomZ3Q7
wqAgwqAgwqBwZXJtaXNzaW9uLjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0Ozxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyBEb2VzIHRoYXQgbWFrZSBzZW5zZT88
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBCVFcs
IEkgbm90aWNlZCB0aGVyZSBpcyBhbm90aGVyIHBlcm1pc3Npb24gKCZxdW90O3RyYW5zbGF0ZSZx
dW90Oyk8YnI+DQomZ3Q7wqAgwqAgwqBkZWZpbmVkIGluIHRoZTxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqBjb250ZXh0IGNsYXNzIGFuZCBpdHMgY29uc3RyYWludCBpcyAoKGgxIGRvbSBo
Mikgb3IgKHQxID09PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoG1sc3RyYW5zbGF0ZSkp
LsKgIEkgd291bGQgaGF2ZSBndWVzc2VkIHRoYXQgaXQgd2FzIGludGVuZGVkIGFzIGE8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgZnJvbnQtZW5kIHNlcnZpY2UgY2hlY2sgb3ZlciB3aGF0
IHByb2Nlc3NlcyBjb3VsZCByZXF1ZXN0IGNvbnRleHQ8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgdHJhbnNsYXRpb25zIGZyb20gbWNzdHJhbnMgb3Igd2hhdCBjb250ZXh0cyB0aGV5IGNv
dWxkPGJyPg0KJmd0O8KgIMKgIMKgdHJhbnNsYXRlLCBidXQgSTxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqBkb24mIzM5O3Qgc2VlIGl0IGJlaW5nIHVzZWQgaW4gbWNzdHJhbnMgYW55d2hl
cmUuwqAgSXMgdGhpcyBhPGJyPg0KJmd0O8KgIMKgIMKgbGVnYWN5IHRoaW5nPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoGZyb20gZWFybHkgc2V0cmFuc2QvbWNzdHJhbnNkIGRheXM/wqAg
VGhlcmUgaXMgYSBUT0RPIGNvbW1lbnQgaW48YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
bWNzdHJhbnM8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgcHJvY2Vzc19yZXF1ZXN0KCkg
dGhhdCBzdWdnZXN0cyB0aGVyZSB3YXMgYW4gaW50ZW50IHRvIHBlcmZvcm0gYTxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqBkb21pbmFuY2UgY2hlY2sgYmV0d2VlbiB0aGUgcmVxdWVzdGVy
IGNvbnRleHQgYW5kIHRoZSBzcGVjaWZpZWQ8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
Y29udGV4dCw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgYnV0IHRoYXQmIzM5O3Mgbm90
IGltcGxlbWVudGVkLsKgIEFwcGVhcnMgdG8gYmUgYWxsb3dlZCBpbiBjdXJyZW50PGJyPg0KJmd0
O8KgIMKgIMKgcG9saWN5PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoGZvcjxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBhbGwgZG9tYWlucyB0byB0aGUgc2V0cmFuc190IGRvbWFp
biBpdHNlbGYuPGJyPg0KJmd0O8KgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7PGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyBUZWQ8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
Jmd0OyBPbiBNb24sIFNlcCAxMCwgMjAxOCBhdCAxOjE5IFBNIFRlZCBUb3RoPGJyPg0KJmd0O8Kg
IMKgIMKgJmx0OzxhIGhyZWY9Im1haWx0bzp0eHRvdGhAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFu
ayI+dHh0b3RoQGdtYWlsLmNvbTwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86dHh0b3Ro
QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnR4dG90aEBnbWFpbC5jb208L2E+Jmd0Ozxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzp0eHRv
dGhAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+dHh0b3RoQGdtYWlsLmNvbTwvYT4gJmx0O21h
aWx0bzo8YSBocmVmPSJtYWlsdG86dHh0b3RoQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnR4
dG90aEBnbWFpbC5jb208L2E+Jmd0OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsmZ3Q7ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnR4dG90aEBnbWFpbC5jb20iIHRh
cmdldD0iX2JsYW5rIj50eHRvdGhAZ21haWwuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1h
aWx0bzp0eHRvdGhAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+dHh0b3RoQGdtYWlsLmNvbTwv
YT4mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86dHh0b3Ro
QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnR4dG90aEBnbWFpbC5jb208L2E+ICZsdDttYWls
dG86PGEgaHJlZj0ibWFpbHRvOnR4dG90aEBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj50eHRv
dGhAZ21haWwuY29tPC9hPiZndDsmZ3Q7Jmd0OyZndDsgd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyZndDsgwqDCoMKgIFVuZGVyc3Rvb2QsIHRoYW5rcy48YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDC
oMKgwqAgT24gTW9uLCBTZXAgMTAsIDIwMTggYXQgMTI6NDYgUE0gU3RlcGhlbiBTbWFsbGV5PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCZsdDs8YSBocmVmPSJtYWlsdG86c2RzQHR5Y2hv
Lm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5zZHNAdHljaG8ubnNhLmdvdjwvYT4gJmx0O21haWx0
bzo8YSBocmVmPSJtYWlsdG86c2RzQHR5Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5zZHNA
dHljaG8ubnNhLmdvdjwvYT4mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmx0O21haWx0bzo8YSBocmVm
PSJtYWlsdG86c2RzQHR5Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5zZHNAdHljaG8ubnNh
LmdvdjwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86c2RzQHR5Y2hvLm5zYS5nb3YiIHRh
cmdldD0iX2JsYW5rIj5zZHNAdHljaG8ubnNhLmdvdjwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgICZsdDttYWlsdG86PGEgaHJlZj0ibWFp
bHRvOnNkc0B0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+c2RzQHR5Y2hvLm5zYS5nb3Y8
L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnNkc0B0eWNoby5uc2EuZ292IiB0YXJnZXQ9
Il9ibGFuayI+c2RzQHR5Y2hvLm5zYS5nb3Y8L2E+Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCZsdDtt
YWlsdG86PGEgaHJlZj0ibWFpbHRvOnNkc0B0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+
c2RzQHR5Y2hvLm5zYS5nb3Y8L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnNkc0B0eWNo
by5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+c2RzQHR5Y2hvLm5zYS5nb3Y8L2E+Jmd0OyZndDsm
Z3Q7Jmd0OyB3cm90ZTo8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoCBPbiAw
OS8xMC8yMDE4IDAxOjEzIFBNLCBUZWQgVG90aCB3cm90ZTo8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0OyBXZSBjdXJyZW50bHkgaGF2
ZSBjb2RlIHJ1bm5pbmcgb24gZWw2IHRoYXQ8YnI+DQomZ3Q7wqAgwqAgwqBkb2VzIGEgTUxTPGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoCBkb21p
bmFuY2UgY2hlY2sgYnk8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKg
wqDCoMKgwqDCoMKgwqAgJmd0OyBjYWxsaW5nIHNlY3VyaXR5X2NvbXB1dGVfYXZfcmF3IHdpdGgg
dGhlIHNlY3VyaXR5PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoG9iamVjdCBjbGFzczxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAm
Z3Q7IFNFQ0NMQVNTX0NPTlRFWFQgd2l0aCBwZXJtaXNzaW9uPGJyPg0KJmd0O8KgIMKgIMKgQ09O
VEVYVF9fQ09OVEFJTlMgYXM8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgeW91IGNhbjxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqAgc2Vl
IGluIHRoZTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDC
oMKgwqDCoCAmZ3Q7IHB5dGhvbiBjb2RlIGJlbG93LiBXaGVuIEkgcnVuIHRoaXMgY29kZSBvbiBl
bDYgczE8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgZG9taW5hdGVzPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoCBzMCBob3dldmVyPGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZn
dDsgd2hlbiBJIHJ1biB0aGUgc2FtZSBjb2RlIG9uIGVsNyBzMSBkb2VzIG5vdDxicj4NCiZndDvC
oCDCoCDCoGRvbWluYXRlPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHMwLiBPbjxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqAgYm90aCBz
eXN0ZW1zPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKg
wqDCoMKgICZndDsgdGhlIGZpbGUgcmVhZCBkb21pbmFuY2UgY2hlY2sgd29ya3MgYXM8YnI+DQom
Z3Q7wqAgwqAgwqBleHBlY3RlZC4gQ2FuPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoGFu
eW9uZTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKg
wqAgaGVscCBtZTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKg
wqDCoMKgwqDCoCAmZ3Q7IHVuZGVyc3RhbmQgd2h5IHRoZSBjb250ZXh0IGNvbnRhaW5zIGNoZWNr
IGRvZXMgbm90PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHdvcmsgdGhlPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoCBzYW1lIG9uIGJv
dGg8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKg
wqAgJmd0OyBzeXN0ZW1zPzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgIFRo
YXQgd291bGQgZGVwZW5kIGVudGlyZWx5IG9uIGhvdyB0aGUgY29uc3RyYWludCBpczxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqB3cml0dGVuIGluPGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7Jmd0OyB0aGU8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsm
Z3Q7IMKgwqDCoMKgwqDCoMKgIHBvbGljeS7CoCBJIGFzc3VtZSB0aGlzIGlzIHdpdGggdGhlIC1t
bHMgcG9saWN5IG9uPGJyPg0KJmd0O8KgIMKgIMKgYm90aD88YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgc2VpbmZvPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDC
oMKgwqDCoMKgwqDCoCAtLWNvbnN0cmFpbiB8IGdyZXAgLUMxIGNvbnRleHQgd291bGQgc2hvdyB5
b3UgdGhlPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoGNvbnN0cmFpbnQ8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IGluIHRoZTxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqAga2VybmVsIHBvbGljeS48YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoCBMb29rcyBsaWtlIHJlZnBvbGljeSBkZWZp
bmVzIGl0IGFzOjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKg
wqDCoMKgwqAgbWxzY29uc3RyYWluIGNvbnRleHQgY29udGFpbnM8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgwqAgwqAgwqAgwqAgwqAoKCBo
MSBkb20gaDIgKSBhbmQgKCBsMSBkb21ieSBsMikpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKg
wqDCoMKgwqDCoMKgIFRoZSAybmQgcGFydCBvZiB0aGUgY29uc3RyYWludCB3YXMgaW50cm9kdWNl
ZCBieTo8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDC
oMKgIGNvbW1pdCA0YzM2NWY0YTZhNmY5MzNkZDEzYjAxMjdlMDNmODMyYzZhNmNmOGZjPGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoCBBdXRob3I6
IEhhcnJ5IENpYW8gJmx0OzxhIGhyZWY9Im1haWx0bzpxaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29t
IiB0YXJnZXQ9Il9ibGFuayI+cWluZ3Rhby5jYW9Ad2luZHJpdmVyLmNvbTwvYT48YnI+DQomZ3Q7
wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpxaW5ndGFvLmNhb0B3aW5kcml2ZXIu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+cWluZ3Rhby5jYW9Ad2luZHJpdmVyLmNvbTwvYT4mZ3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnFp
bmd0YW8uY2FvQHdpbmRyaXZlci5jb20iIHRhcmdldD0iX2JsYW5rIj5xaW5ndGFvLmNhb0B3aW5k
cml2ZXIuY29tPC9hPjxicj4NCiZndDvCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRv
OnFpbmd0YW8uY2FvQHdpbmRyaXZlci5jb20iIHRhcmdldD0iX2JsYW5rIj5xaW5ndGFvLmNhb0B3
aW5kcml2ZXIuY29tPC9hPiZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpxaW5ndGFv
LmNhb0B3aW5kcml2ZXIuY29tIiB0YXJnZXQ9Il9ibGFuayI+cWluZ3Rhby5jYW9Ad2luZHJpdmVy
LmNvbTwvYT48YnI+DQomZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpxaW5n
dGFvLmNhb0B3aW5kcml2ZXIuY29tIiB0YXJnZXQ9Il9ibGFuayI+cWluZ3Rhby5jYW9Ad2luZHJp
dmVyLmNvbTwvYT4mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCZsdDttYWlsdG86
PGEgaHJlZj0ibWFpbHRvOnFpbmd0YW8uY2FvQHdpbmRyaXZlci5jb20iIHRhcmdldD0iX2JsYW5r
Ij5xaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29tPC9hPjxicj4NCiZndDvCoCDCoCDCoCZsdDttYWls
dG86PGEgaHJlZj0ibWFpbHRvOnFpbmd0YW8uY2FvQHdpbmRyaXZlci5jb20iIHRhcmdldD0iX2Js
YW5rIj5xaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29tPC9hPiZndDsmZ3Q7Jmd0OyZndDs8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgIERhdGU6wqAg
wqBUdWUgRmViIDE1IDEwOjE2OjMyIDIwMTEgKzA4MDA8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDC
oMKgwqDCoMKgwqDCoMKgIMKgIMKgIMKgbDEgZG9tYnkgbDIgZm9yIGNvbnRhaW5zIE1MUyBjb25z
dHJhaW50PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0Ozxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCDCoCDCoCDCoEFz
IGlkZW50aWZpZWQgYnkgU3RlcGhhbiBTbWFsbGV5LCB0aGU8YnI+DQomZ3Q7wqAgwqAgwqBjdXJy
ZW50IE1MUzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDC
oMKgwqAgY29uc3RyYWludCBmb3IgdGhlPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgIMKgIMKgIMKgY29udGFpbnMgcGVybWlzc2lvbiBvZiB0
aGUgY29udGV4dCBjbGFzcyBzaG91bGQ8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgY29u
c2lkZXI8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDC
oMKgIHRoZSBjdXJyZW50PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDC
oMKgwqDCoMKgwqDCoMKgIMKgIMKgIMKgbGV2ZWwgb2YgYSB1c2VyIGFsb25nIHdpdGggdGhlIGNs
ZWFyYW5jZTxicj4NCiZndDvCoCDCoCDCoGxldmVsIHNvIHRoYXQ8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgIG1sc19zeXN0ZW1sb3c8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgwqAgwqAg
wqBpcyBubyBsb25nZXIgY29uc2lkZXJlZCBjb250YWluZWQgaW48YnI+DQomZ3Q7wqAgwqAgwqBt
bHNfc3lzdGVtaGlnaC48YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgIMKg
IMKgIMKgU2lnbmVkLW9mZi1ieTogSGFycnkgQ2lhbzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAmbHQ7PGEgaHJlZj0ibWFpbHRvOnFpbmd0YW8uY2FvQHdpbmRyaXZlci5jb20iIHRhcmdl
dD0iX2JsYW5rIj5xaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhy
ZWY9Im1haWx0bzpxaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29tIiB0YXJnZXQ9Il9ibGFuayI+cWlu
Z3Rhby5jYW9Ad2luZHJpdmVyLmNvbTwvYT4mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmx0O21haWx0
bzo8YSBocmVmPSJtYWlsdG86cWluZ3Rhby5jYW9Ad2luZHJpdmVyLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPnFpbmd0YW8uY2FvQHdpbmRyaXZlci5jb208L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFp
bHRvOnFpbmd0YW8uY2FvQHdpbmRyaXZlci5jb20iIHRhcmdldD0iX2JsYW5rIj5xaW5ndGFvLmNh
b0B3aW5kcml2ZXIuY29tPC9hPiZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpxaW5n
dGFvLmNhb0B3aW5kcml2ZXIuY29tIiB0YXJnZXQ9Il9ibGFuayI+cWluZ3Rhby5jYW9Ad2luZHJp
dmVyLmNvbTwvYT48YnI+DQomZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpx
aW5ndGFvLmNhb0B3aW5kcml2ZXIuY29tIiB0YXJnZXQ9Il9ibGFuayI+cWluZ3Rhby5jYW9Ad2lu
ZHJpdmVyLmNvbTwvYT4mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCZsdDttYWls
dG86PGEgaHJlZj0ibWFpbHRvOnFpbmd0YW8uY2FvQHdpbmRyaXZlci5jb20iIHRhcmdldD0iX2Js
YW5rIj5xaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29tPC9hPjxicj4NCiZndDvCoCDCoCDCoCZsdDtt
YWlsdG86PGEgaHJlZj0ibWFpbHRvOnFpbmd0YW8uY2FvQHdpbmRyaXZlci5jb20iIHRhcmdldD0i
X2JsYW5rIj5xaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29tPC9hPiZndDsmZ3Q7Jmd0OyZndDs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoCBUaGlzIHdhcyB0byBwcmV2ZW50IGEg
dXNlciBmcm9tIGxvZ2dpbmcgaW4gYXQgYSBsZXZlbDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqBiZWxvdyB0aGVpcjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsg
wqDCoMKgwqDCoMKgwqAgYXV0aG9yaXplZCByYW5nZSwgaW4gdGhlIHVudXN1YWwgc2NlbmFyaW8g
d2hlcmUgdGhlPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHVzZXImIzM5O3MgbG93PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoCBsZXZl
bCB3YXM8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDC
oMKgIG5vdCBzMC9zeXN0ZW1sb3cuPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKg
wqDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDC
oMKgwqDCoMKgICZndDsgVGVkPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0
OyDCoMKgwqDCoMKgwqDCoMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7PGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZndDsgaW1wb3J0IHNlbGludXg8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0Ozxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7
IFNFQ0NMQVNTX0NPTlRFWFQgPTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBzZWxpbnV4
LnN0cmluZ190b19zZWN1cml0eV9jbGFzcygmcXVvdDtjb250ZXh0JnF1b3Q7KTxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7IENPTlRF
WFRfX0NPTlRBSU5TID08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKg
wqDCoMKgwqDCoMKgIHNlbGludXguc3RyaW5nX3RvX2F2X3Blcm0oU0VDQ0xBU1NfQ09OVEVYVCw8
YnI+DQomZ3Q7wqAgwqAgwqAmcXVvdDtjb250YWlucyZxdW90Oyk8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0OyBTRUNDTEFTU19GSUxF
ID08YnI+DQomZ3Q7wqAgwqAgwqBzZWxpbnV4LnN0cmluZ190b19zZWN1cml0eV9jbGFzcygmcXVv
dDtmaWxlJnF1b3Q7KTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDC
oMKgwqDCoMKgwqDCoCAmZ3Q7IEZJTEVfX1JFQUQgPTxicj4NCiZndDvCoCDCoCDCoHNlbGludXgu
c3RyaW5nX3RvX2F2X3Blcm0oU0VDQ0xBU1NfRklMRSw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgJnF1b3Q7cmVhZCZxdW90Oyk8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7IHJhd19jb24xID0gJnF1b3Q7dXNlcl91
OnVzZXJfcjp1c2VyX3Q6czEmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0OyByYXdfY29uMiA9ICZxdW90O3VzZXJfdTp1c2Vy
X3I6dXNlcl90OnMwJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0
OyDCoMKgwqDCoMKgwqDCoMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0OyBhdmQgPSBzZWxpbnV4LmF2X2RlY2lzaW9uKCk8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAg
Jmd0OyBzZWxpbnV4LmF2Y19yZXNldCgpPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZndDsgdHJ5Ojxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7wqAgwqAgwqAgcmMgPTxicj4N
CiZndDvCoCDCoCDCoHNlbGludXguc2VjdXJpdHlfY29tcHV0ZV9hdl9yYXcocmF3X2NvbjEsPGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHJhd19jb24yLDxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7IFNFQ0NMQVNTX0NPTlRF
WFQsIENPTlRFWFRfX0NPTlRBSU5TLCBhdmQpPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZndDvCoCDCoCDCoCBpZiByYyAmbHQ7IDA6PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZn
dDvCoCDCoCDCoCDCoCDCoCBwcmludCgmcXVvdDtzZWxpbnV4LnNlY3VyaXR5X2NvbXB1dGVfYXZf
cmF3PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoGZhaWxlZCBmb3IgJXM8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgICVzJnF1b3Q7ICU8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAg
Jmd0OyAocmF3X2NvbjEsIHJhd19jb24yKSk8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0O8KgIMKgIMKgIGlmIChhdmQuYWxsb3dlZCAm
YW1wOyBDT05URVhUX19DT05UQUlOUykgPT08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsmZ3Q7IENPTlRFWFRfX0NPTlRBSU5TOjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7wqAgwqAgwqAgwqAgwqAgcHJpbnQoJnF1
b3Q7JXMgZG9taW5hdGVzICVzJnF1b3Q7ICUgKHJhd19jb24xLDxicj4NCiZndDvCoCDCoCDCoHJh
d19jb24yKSk8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKg
wqDCoMKgwqAgJmd0O8KgIMKgIMKgIGVsc2U6PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZndDvCoCDCoCDCoCDCoCDCoCBwcmludCgmcXVv
dDslcyBkb2VzIG5vdCBkb21pbmF0ZSAlcyZxdW90OyAlPGJyPg0KJmd0O8KgIMKgIMKgKHJhd19j
b24xLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgcmF3X2NvbjIpKTxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAm
Z3Q7IGV4Y2VwdCBPU0Vycm9yLCBleDo8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0O8KgIMKgIMKgIHByaW50ICZxdW90O2V4Y2VwdGlv
biBjYWxsaW5nPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDC
oMKgwqDCoCBzZWxpbnV4LnNlY3VyaXR5X2NvbXB1dGVfYXZfcmF3JnF1b3Q7LCBleDxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZn
dDsgYXZkID0gc2VsaW51eC5hdl9kZWNpc2lvbigpPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZndDsgc2VsaW51eC5hdmNfcmVzZXQoKTxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAm
Z3Q7IHRyeTo8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKg
wqDCoMKgwqAgJmd0O8KgIMKgIMKgIHJjID08YnI+DQomZ3Q7wqAgwqAgwqBzZWxpbnV4LnNlY3Vy
aXR5X2NvbXB1dGVfYXZfcmF3KHJhd19jb24xLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqByYXdfY29uMiw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDC
oMKgwqDCoMKgwqAgJmd0OyBTRUNDTEFTU19GSUxFLCBGSUxFX19SRUFELCBhdmQpPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZndDvCoCDC
oCDCoCBpZiByYyAmbHQ7IDA6PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0
OyDCoMKgwqDCoMKgwqDCoMKgICZndDvCoCDCoCDCoCDCoCDCoCBwcmludCgmcXVvdDtzZWxpbnV4
LnNlY3VyaXR5X2NvbXB1dGVfYXZfcmF3PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoGZh
aWxlZCBmb3IgJXM8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDC
oMKgwqDCoMKgICVzJnF1b3Q7ICU8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsm
Z3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0OyAocmF3X2NvbjEsIHJhd19jb24yKSk8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0O8KgIMKg
IMKgIGlmIChhdmQuYWxsb3dlZCAmYW1wOyBGSUxFX19SRUFEKSA9PSBGSUxFX19SRUFEOjxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7
wqAgwqAgwqAgwqAgwqAgcHJpbnQoJnF1b3Q7JXMgZG9taW5hdGVzICVzJnF1b3Q7ICUgKHJhd19j
b24xLDxicj4NCiZndDvCoCDCoCDCoHJhd19jb24yKSk8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0O8KgIMKgIMKgIGVsc2U6PGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZndDvC
oCDCoCDCoCDCoCDCoCBwcmludCgmcXVvdDslcyBkb2VzIG5vdCBkb21pbmF0ZSAlcyZxdW90OyAl
PGJyPg0KJmd0O8KgIMKgIMKgKHJhd19jb24xLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyZndDsgcmF3X2NvbjIpKTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZndDsgZXhjZXB0IE9TRXJyb3I6PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZndDvCoCDC
oCDCoCBwcmludCAmcXVvdDtleGNlcHRpb24gY2FsbGluZzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqAgc2VsaW51eC5zZWN1cml0eV9jb21wdXRl
X2F2X3JhdyZxdW90OywgZXg8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsmZ3Q7
IMKgwqDCoMKgwqDCoMKgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0OyBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7IFNlbGludXggbWFpbGluZyBsaXN0PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgICZn
dDsgPGEgaHJlZj0ibWFpbHRvOlNlbGludXhAdHljaG8ubnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsi
PlNlbGludXhAdHljaG8ubnNhLmdvdjwvYT48YnI+DQomZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxh
IGhyZWY9Im1haWx0bzpTZWxpbnV4QHR5Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5TZWxp
bnV4QHR5Y2hvLm5zYS5nb3Y8L2E+Jmd0OyAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpTZWxp
bnV4QHR5Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5TZWxpbnV4QHR5Y2hvLm5zYS5nb3Y8
L2E+PGJyPg0KJmd0O8KgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86U2VsaW51eEB0
eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+U2VsaW51eEB0eWNoby5uc2EuZ292PC9hPiZn
dDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0i
bWFpbHRvOlNlbGludXhAdHljaG8ubnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsiPlNlbGludXhAdHlj
aG8ubnNhLmdvdjwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86U2VsaW51eEB0eWNoby5u
c2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+U2VsaW51eEB0eWNoby5uc2EuZ292PC9hPiZndDs8YnI+
DQomZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpTZWxpbnV4QHR5Y2hvLm5z
YS5nb3YiIHRhcmdldD0iX2JsYW5rIj5TZWxpbnV4QHR5Y2hvLm5zYS5nb3Y8L2E+ICZsdDttYWls
dG86PGEgaHJlZj0ibWFpbHRvOlNlbGludXhAdHljaG8ubnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsi
PlNlbGludXhAdHljaG8ubnNhLmdvdjwvYT4mZ3Q7Jmd0OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqAgJmd0OyBUbyB1bnN1YnNjcmli
ZSwgc2VuZCBlbWFpbCB0bzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7IDxhIGhyZWY9Im1haWx0bzpT
ZWxpbnV4LWxlYXZlQHR5Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5TZWxpbnV4LWxlYXZl
QHR5Y2hvLm5zYS5nb3Y8L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOlNlbGludXgtbGVh
dmVAdHljaG8ubnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsiPlNlbGludXgtbGVhdmVAdHljaG8ubnNh
LmdvdjwvYT4mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86
U2VsaW51eC1sZWF2ZUB0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+U2VsaW51eC1sZWF2
ZUB0eWNoby5uc2EuZ292PC9hPjxicj4NCiZndDvCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0i
bWFpbHRvOlNlbGludXgtbGVhdmVAdHljaG8ubnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsiPlNlbGlu
dXgtbGVhdmVAdHljaG8ubnNhLmdvdjwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqAgJmx0O21haWx0bzo8YSBocmVmPSJtYWls
dG86U2VsaW51eC1sZWF2ZUB0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+U2VsaW51eC1s
ZWF2ZUB0eWNoby5uc2EuZ292PC9hPjxicj4NCiZndDvCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJl
Zj0ibWFpbHRvOlNlbGludXgtbGVhdmVAdHljaG8ubnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsiPlNl
bGludXgtbGVhdmVAdHljaG8ubnNhLmdvdjwvYT4mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOlNlbGludXgtbGVhdmVAdHljaG8ubnNh
LmdvdiIgdGFyZ2V0PSJfYmxhbmsiPlNlbGludXgtbGVhdmVAdHljaG8ubnNhLmdvdjwvYT48YnI+
DQomZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpTZWxpbnV4LWxlYXZlQHR5
Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5TZWxpbnV4LWxlYXZlQHR5Y2hvLm5zYS5nb3Y8
L2E+Jmd0OyZndDsmZ3Q7Ljxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyZndDsg
wqDCoMKgwqDCoMKgwqDCoCAmZ3Q7IFRvIGdldCBoZWxwLCBzZW5kIGFuIGVtYWlsIGNvbnRhaW5p
bmcgJnF1b3Q7aGVscCZxdW90OyB0bzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyZndDsgPGEgaHJlZj0ibWFpbHRvOlNlbGludXgtcmVxdWVzdEB0eWNoby5uc2EuZ292IiB0YXJn
ZXQ9Il9ibGFuayI+U2VsaW51eC1yZXF1ZXN0QHR5Y2hvLm5zYS5nb3Y8L2E+PGJyPg0KJmd0O8Kg
IMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86U2VsaW51eC1yZXF1ZXN0QHR5Y2hvLm5z
YS5nb3YiIHRhcmdldD0iX2JsYW5rIj5TZWxpbnV4LXJlcXVlc3RAdHljaG8ubnNhLmdvdjwvYT4m
Z3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86U2VsaW51eC1y
ZXF1ZXN0QHR5Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5TZWxpbnV4LXJlcXVlc3RAdHlj
aG8ubnNhLmdvdjwvYT48YnI+DQomZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0
bzpTZWxpbnV4LXJlcXVlc3RAdHljaG8ubnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsiPlNlbGludXgt
cmVxdWVzdEB0eWNoby5uc2EuZ292PC9hPiZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0
bzpTZWxpbnV4LXJlcXVlc3RAdHljaG8ubnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsiPlNlbGludXgt
cmVxdWVzdEB0eWNoby5uc2EuZ292PC9hPjxicj4NCiZndDvCoCDCoCDCoCZsdDttYWlsdG86PGEg
aHJlZj0ibWFpbHRvOlNlbGludXgtcmVxdWVzdEB0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFu
ayI+U2VsaW51eC1yZXF1ZXN0QHR5Y2hvLm5zYS5nb3Y8L2E+Jmd0Ozxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpTZWxpbnV4LXJlcXVlc3RA
dHljaG8ubnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsiPlNlbGludXgtcmVxdWVzdEB0eWNoby5uc2Eu
Z292PC9hPjxicj4NCiZndDvCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOlNlbGlu
dXgtcmVxdWVzdEB0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+U2VsaW51eC1yZXF1ZXN0
QHR5Y2hvLm5zYS5nb3Y8L2E+Jmd0OyZndDsmZ3Q7Ljxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0Ozxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0OyA8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+
PC9kaXY+PC9kaXY+DQo=
--000000000000baf4be0575ac8bb5--
