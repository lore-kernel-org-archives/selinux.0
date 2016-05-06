From: "Roberts, William C" <william.c.roberts@intel.com>
To: James Carter <jwcart2@tycho.nsa.gov>, William Roberts
 <bill.c.roberts@gmail.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: [PATCH] libsepol: Change which attributes CIL keeps in the
 binary policy
Date: Fri, 6 May 2016 20:09:49 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC56012293BC@ORSMSX103.amr.corp.intel.com>
References: <1462561003-2629-1-git-send-email-jwcart2@tycho.nsa.gov>
 <CAFftDdrdT1+=HHUFhVpQb6hmHbZswa=XEe=jXJysx87ixcOrwA@mail.gmail.com>
 <CAFftDdpeO4C7nH6coQ-ZXrab+eCWjkVo8bv=SHQ-5mMe_o_Rdg@mail.gmail.com>
 <CAFftDdra7ygQKTszajTpevP3+3tnsm7OedHpdG6SPCeYkTufDg@mail.gmail.com>
 <476DC76E7D1DF2438D32BFADF679FC560122936D@ORSMSX103.amr.corp.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC5601229385@ORSMSX103.amr.corp.intel.com>
 <56cd77c0-d264-7ee3-9742-2b5c2aa118b8@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>

> > >> On May 6, 2016 11:58 AM, "James Carter" <jwcart2@tycho.nsa.gov> wrote:
> > >>>
> > >>> The removal of attributes that are only used in neverallow rules
> > >>> is hindering AOSP adoption of the CIL compiler. This is because
> > >>> AOSP extracts neverallow rules from its policy.conf for use in the
> > >>> Android compatibility test suite. These neverallow rules are
> > >>> applied against the binary policy being tested to check for a
> > >>> violation. Any neverallow rules with an attribute that has been
> > >>> removed cannot be
> > checked.
> > >>>
> > >>> Now attributes are kept unless they are not used in any allow rule
> > >>> and they are auto-generated or named "cil_gen_require" or do not
> > >>> have any types associated with them.
> > >>
> > >> I see now, you’re keeping them unless they are generated or marked.
> > >
> > > I'm still not convinced  this does what's on the tin. In the case of
> > > AOSP, the Attributes are not used in any allow rules, they are not
> > > auto-generated or named cil_gen_require And they will not have any
> > > types
> > associated with them. So I see them being discarded.
> > >
> >
> > If they don't have types associated with them, then I misunderstood
> > the problem and we will have to keep the attributes without types around.
> 
> This is pretty much all my understanding on this issue is from this link:
> 
> Per sds:
> https://android-review.googlesource.com/#/c/145034/
> 
> "CIL also deletes unused attributes from the kernel policy, which is a problem for
> the Android neverallow checking.  It considers an attribute that is only referenced
> by a neverallow rule to be unused since neverallows are not included in the
> kernel policy, so this drops data_file_type from the kernel policy.  But we then
> would lose checking of the various neverallows on data_file_type by CTS." - sds
> 
> Looking through the policy in file.te:
> 
> file.te:151:type app_data_file, file_type, data_file_type; file.te:153:type
> system_app_data_file, file_type, data_file_type, mlstrustedobject;
> file.te:169:type asec_apk_file, file_type, data_file_type, mlstrustedobject;
> file.te:171:type asec_public_file, file_type, data_file_type; file.te:173:type
> asec_image_file, file_type, data_file_type; file.te:175:type backup_data_file,
> file_type, data_file_type, mlstrustedobject;
> 
> Data file type does have type associations, but it does NOT have allow rules.
> 
> So when this gets generated to cil, how is indicated in cil intermediary not to
> discard that data_file_type attribute?
> 

That’s not the question I meant to ask. The cardinality check would be sufficient there.

In other words, this LGTM. I am going to restore sds's changes and try this.

Thanks.

<snip>
