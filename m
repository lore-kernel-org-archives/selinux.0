Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8LJr6S6004017
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 15:53:06 -0400
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 40A9F5613B6
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 21:52:17 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id k12-v6so12387063oiw.8
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 12:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180919205114.2683-1-nicolas.iooss@m4x.org>
 <e3e0ae6a-4433-5b66-6410-f25f010a69f3@redhat.com>
In-Reply-To: <e3e0ae6a-4433-5b66-6410-f25f010a69f3@redhat.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Fri, 21 Sep 2018 21:52:05 +0200
Message-ID: <CAJfZ7==sczRmbFRVnLhQyNsQ=nQXEJwWUELZgpJANqxr-3J+eA@mail.gmail.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] python/sepolicy: fix compatibility with setools 4.2.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 20, 2018 at 9:48 AM Vit Mojzis <vmojzis@redhat.com> wrote:
>
>
> On 19/09/2018 22:51, Nicolas Iooss wrote:
> > When testing sepolicy gui with setools 4.2.0-beta, the following error
> > happened:
> >
> >        File "python/sepolicy/sepolicy/__init__.py", line 277, in _setools_rule_to_dict
> >          if isinstance(rule, setools.policyrep.terule.AVRule):
> >      AttributeError: module 'setools.policyrep' has no attribute 'terule'
> >
> > This is due to a reorganization of files in setools 4.2. After reporting
> > the issue on https://github.com/SELinuxProject/setools/issues/8 , it
> > appears that sepolicy has not been using setools API properly. Fix this
> > by:
> > * replacing exception types internal to setools with AttributeError, as
> >    they all inherit from it ;
> > * using rule.conditional.evaluate(...) in order to find out whether a
> >    conditional rule is enabled, instead of relying on
> >    rule.qpol_symbol.is_enabled() (which disappeared).
> >
> > This last point required knowing the states of the booleans in the
> > policy. As sepolicy already retrieves all boolean states in
> > get_all_bools(), put them in a dict which can be used by
> > rule.conditional.evaluate().
> >
> > This code has been tested with setools 4.1.1 and setools 4.2.0-beta.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >   python/sepolicy/sepolicy/__init__.py | 30 +++++++++++++++++++---------
> >   1 file changed, 21 insertions(+), 9 deletions(-)
> >
> > diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> > index 89346aba0b15..ed6dfea9718a 100644
> > --- a/python/sepolicy/sepolicy/__init__.py
> > +++ b/python/sepolicy/sepolicy/__init__.py
> > @@ -112,6 +112,7 @@ login_mappings = None
> >   file_types = None
> >   port_types = None
> >   bools = None
> > +bools_dict = None
> >   all_attributes = None
> >   booleans = None
> >   booleans_dict = None
> > @@ -134,6 +135,7 @@ def policy(policy_file):
> >       global all_domains
> >       global all_attributes
> >       global bools
> > +    global bools_dict
> >       global all_types
> >       global role_allows
> >       global users
> > @@ -143,6 +145,7 @@ def policy(policy_file):
> >       all_domains = None
> >       all_attributes = None
> >       bools = None
> > +    bools_dict = None
> >       all_types = None
> >       role_allows = None
> >       users = None
> > @@ -272,34 +275,35 @@ def _setools_rule_to_dict(rule):
> >           'class': str(rule.tclass),
> >       }
> >
> > +    # Evaluate the boolean condition if it is a conditional rule.
> > +    # In order to do this, extract the booleans which are used in the condition first.
> >       try:
> > -        enabled = bool(rule.qpol_symbol.is_enabled(rule.policy))
> > +        all_bools = get_all_bools_as_dict()
> > +        used_bools = dict((str(name), all_bools[name]) for name in rule.conditional.booleans)
> > +        enabled = rule.conditional.evaluate(**used_bools) == rule.conditional_block
>
>
> Thank you for the patch, I've just been testing my version (almost
> identical except for this block).
> Why don't you get the boolean state directly from the booleans inside
> the conditional?

Thanks for your review. I missed that "boolean.state" was available
when looking for a way to replace rule.qpol_symbol.is_enabled(), as it
does not appear in "repr(boolean)". If you send your patch, I will
accept it. Otherwise I will send a v2 that will most likely be exactly
like your version. How do you want to proceed?

By the way, I have tested that boolean.state is available in both
setools 4.1.1 and setools 4.2.0-beta.

Nicolas
