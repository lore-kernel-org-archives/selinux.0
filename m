Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA26199
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 14:20:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA28856
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 18:19:04 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA28852
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 18:19:03 GMT
Date: Tue, 16 Apr 2002 14:20:20 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fwd: Re: addition for xdm.te
In-Reply-To: <20020416115705.DC4965953@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204161417010.5820-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1018981220=:5820"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-959030623-1018981220=:5820
Content-Type: TEXT/PLAIN; charset=US-ASCII


Thanks.  I edited it slightly, so I'm using the attached patch relative to
our policy Makefile.  I added $(wildcard), limited the lists to *.te to
avoid picking up extraneous files, and dropped the macro_ prefix, since
the macro files already have _macros in the name.  I'm also not using
a separate tmp directory, although it doesn't especially matter to me.
Is there a strong reason to use a separate tmp directory for the
intermediate files?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



On Tue, 16 Apr 2002, Russell Coker wrote:

> I currently have the following in my policy Makefile:
> POLICYFILES = security_classes initial_sids access_vectors
> ifeq ($(MLS),y)
> POLICYFILES += mls
> endif
> POLICYFILES += tmp/macro_used_flags.te tmp/program_used_flags.te tmp/all.te
> rbacPOLICYFILES += users
> POLICYFILES += constraints
> POLICYFILES += initial_sid_contexts fs_contexts devfs_contexts net_contexts
>
> tmp/program_used_flags.te: domains/program/* domains/program
>         ( cd domains/program/ ; for n in * ; do echo "define(\`$$n')"; done )
> >
> $@
>
> tmp/macro_used_flags.te: macros/program/* macros/program
>         ( cd macros/program/ ; for n in * ; do echo "define(\`macro_$$n')";
> done ) > $@
>
> So now a policy file that needs dpkg can check for ifdef(`dpkg.te' and a
> policy file that needs the GPG macros to be defines can check for
> ifdef(`gpg_macros.te', ...
>
> ----------  Forwarded Message  ----------
>
> Subject: Re: addition for xdm.te
> Date: Thu, 21 Mar 2002 21:39:10 +0100
> From: Russell Coker <russell@coker.com.au>
> To: Stephen Smalley <sds@tislabs.com>
> Cc: SE Linux <selinux@tycho.nsa.gov>
>
> On Thu, 21 Mar 2002 20:41, Stephen Smalley wrote:
> > On Thu, 21 Mar 2002, Russell Coker wrote:
> > > I think it makes more sense to have all the xdm policy in the xdm file.
> > > Then someone who doesn't use a xdm type program can remove the file and
> > > everything else will be fine.
> >
> > This isn't as straightforward as it might appear.  Consider the
> > xdm-related rules in user_macros.te and netscape_macros.te.  We can
> > relocate those rules to xdm.te through the use of type attributes (to
> > cover all user domains and all netscape domains), but you then have a
> > little piece of the netscape policy in the xdm.te file.  Perhaps that is
> > more acceptable than having a little piece of the xdm policy in the
> > netscape_macros.te file.
>
> What if you have some shell code such as the following to generate m4 macro
> definitions:
> ( cd domains/program/ ; for n in * ; do echo "define(\`$n')"; done )
>
> Then in netscape.te you can have:
> ifdef(`xdm.te', `...
>
> Or in xdm.te you can have:
> ifdef(`netscape.te', `...
>
> While we're at it we could use similar m4 code to use those generated macros
> in file_contexts to make it adapt to the policy files you have installed.
>
> It may be almost as straightforward as it appears!  ;)
>
> --
> If you send email to me or to a mailing list that I use which has >4 lines
> of legalistic junk at the end then you are specifically authorizing me to do
> whatever I wish with the message and all other messages from your domain, by
> posting the message you agree that your long legalistic sig is void.
>
> -------------------------------------------------------
>
> --
> If you send email to me or to a mailing list that I use which has >4 lines
> of legalistic junk at the end then you are specifically authorizing me to do
> whatever I wish with the message and all other messages from your domain, by
> posting the message you agree that your long legalistic sig is void.
>
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

---559023410-959030623-1018981220=:5820
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="Makefile.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0204161420200.5820@raven>
Content-Description: 
Content-Disposition: attachment; filename="Makefile.patch"

SW5kZXg6IHBvbGljeS9NYWtlZmlsZQ0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KUkNTIGZpbGU6IC9jdnMvbHNtL3NlbGludXgvcG9saWN5L01ha2VmaWxl
LHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4xNw0KZGlmZiAtdSAtcjEuMTcg
TWFrZWZpbGUNCi0tLSBwb2xpY3kvTWFrZWZpbGUJMjAwMi8wNC8xNSAxMzo0
NzoyMgkxLjE3DQorKysgcG9saWN5L01ha2VmaWxlCTIwMDIvMDQvMTYgMTg6
MTY6MTcNCkBAIC0yNiw3ICsyNiw3IEBADQogaWZlcSAoJChNTFMpLHkpDQog
UE9MSUNZRklMRVMgKz0gbWxzDQogZW5kaWYNCi1QT0xJQ1lGSUxFUyArPSBh
bGwudGUgcmJhYw0KK1BPTElDWUZJTEVTICs9IG1hY3JvX3VzZWRfZmxhZ3Mu
dGUgcHJvZ3JhbV91c2VkX2ZsYWdzLnRlIGFsbC50ZSByYmFjDQogUE9MSUNZ
RklMRVMgKz0gdXNlcnMNCiBQT0xJQ1lGSUxFUyArPSBjb25zdHJhaW50cyAN
CiBQT0xJQ1lGSUxFUyArPSBpbml0aWFsX3NpZF9jb250ZXh0cyBmc19jb250
ZXh0cyBkZXZmc19jb250ZXh0cyBuZXRfY29udGV4dHMNCkBAIC02MSw2ICs2
MSwxMiBAQA0KIHRlc3Rwb2xpY3kuY29uZjogJChURVNUUE9MSUNZRklMRVMp
DQogCW00IC1JbWFjcm9zIC1zICReID4gdGVzdHBvbGljeS5jb25mDQogDQor
cHJvZ3JhbV91c2VkX2ZsYWdzLnRlOiAkKHdpbGRjYXJkIGRvbWFpbnMvcHJv
Z3JhbS8qLnRlKSBkb21haW5zL3Byb2dyYW0NCisJKCBjZCBkb21haW5zL3By
b2dyYW0vIDsgZm9yIG4gaW4gKi50ZSA7IGRvIGVjaG8gImRlZmluZShcYCQk
bicpIjsgZG9uZSApID4gJEANCisNCittYWNyb191c2VkX2ZsYWdzLnRlOiAk
KHdpbGRjYXJkIG1hY3Jvcy9wcm9ncmFtLyoudGUpIG1hY3Jvcy9wcm9ncmFt
DQorCSggY2QgbWFjcm9zL3Byb2dyYW0vIDsgZm9yIG4gaW4gKi50ZSA7IGRv
IGVjaG8gImRlZmluZShcYCQkbicpIjsgZG9uZSApID4gJEANCisNCiB0ZXN0
X2FsbC50ZTogbWFjcm9zL2dsb2JhbF9tYWNyb3MudGUgYWxsX3R5cGVzLnRl
IGFsbF9kb21haW5zLnRlIHRlc3RfZG9tYWlucy50ZQ0KIAljYXQgJF4gPiAk
QA0KIAlybSAtZiBhbGxfdHlwZXMudGUgYWxsX2RvbWFpbnMudGUgdGVzdF9k
b21haW5zLnRlDQpAQCAtODIsNiArODgsNyBAQA0KIAlybSAtZiBwb2xpY3kg
cG9saWN5LmNvbmYgJChQT0xJQ1lWRVIpDQogCXJtIC1mIGFsbC50ZSBhbGxf
dHlwZXMudGUgYWxsX2RvbWFpbnMudGUgdGVzdF9kb21haW5zLnRlDQogCXJt
IC1mIHRlc3RfYWxsLnRlIHRlc3RfYWxsX2RvbWFpbnMudGUgdGVzdHBvbGlj
eSB0ZXN0cG9saWN5LmNvbmYNCisJcm0gLWYgcHJvZ3JhbV91c2VkX2ZsYWdz
LnRlIG1hY3JvX3VzZWRfZmxhZ3MudGUNCiANCiByZWxhYmVsOg0KIAljaGNv
biBzeXN0ZW1fdTpvYmplY3Rfcjpwb2xpY3lfY29uZmlnX3QgJChMT0FEUEFU
SCkNCg==
---559023410-959030623-1018981220=:5820--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
