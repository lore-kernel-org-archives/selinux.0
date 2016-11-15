Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAFHUPMA012509
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 12:30:25 -0500
Received: by mail-wm0-f54.google.com with SMTP id g23so181361054wme.1
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 09:30:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFftDdoGPHLap-BmZT0MUyECqLzXi70XTL_=Q_CSikrgyNw3YA@mail.gmail.com>
References: <1479145685-4899-1-git-send-email-sds@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC561CD24A5C@ORSMSX103.amr.corp.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC561CD24D0F@ORSMSX103.amr.corp.intel.com>
 <c2d2d660-b8c6-7974-2ee7-a26e931addba@tycho.nsa.gov>
 <CAFftDdoGPHLap-BmZT0MUyECqLzXi70XTL_=Q_CSikrgyNw3YA@mail.gmail.com>
From: Nick Kralevich <nnk@google.com>
Date: Tue, 15 Nov 2016 09:30:21 -0800
Message-ID: <CAFJ0LnFyevTSrP2WsaAEOG6k_aoQq8Us-NySsyZGE4e4vcmYKw@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler bug
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Perhaps merge Stephen's change now, and address any changes in a
followup? I'd like to get it merged into the selinux tree so I can
merge the changes into the Android tree.

-- Nick

On Tue, Nov 15, 2016 at 9:10 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> For bit setting in constant time, one could always clear the bit(s) and or
> in what you want. I think that logic might be applicable here. I could take
> a stab at looking at it today, if no one has anything better by tomorrow
> well just merge yours as is. Does that sound reasonable?
>
>
> On Nov 15, 2016 06:18, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>>
>> On 11/14/2016 02:41 PM, Roberts, William C wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of
>> >> Roberts,
>> >> William C
>> >> Sent: Monday, November 14, 2016 10:44 AM
>> >> To: Stephen Smalley <sds@tycho.nsa.gov>; selinux@tycho.nsa.gov
>> >> Subject: RE: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler
>> >> bug
>> >>
>> >>
>> >>
>> >>> -----Original Message-----
>> >>> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of
>> >>> Stephen Smalley
>> >>> Sent: Monday, November 14, 2016 9:48 AM
>> >>> To: selinux@tycho.nsa.gov
>> >>> Cc: Stephen Smalley <sds@tycho.nsa.gov>
>> >>> Subject: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler bug
>> >>>
>> >>> The combining logic for dontaudit rules was wrong, causing a dontaudit
>> >>> A B:C *; rule to be clobbered by a dontaudit A B:C p; rule.
>> >>>
>> >>> Reported-by: Nick Kralevich <nnk@google.com>
>> >>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> >>> ---
>> >>>  libsepol/src/expand.c | 16 ++++++++++++----
>> >>>  1 file changed, 12 insertions(+), 4 deletions(-)
>> >>>
>> >>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c index
>> >>> 004a029..d7adbf8
>> >>> 100644
>> >>> --- a/libsepol/src/expand.c
>> >>> +++ b/libsepol/src/expand.c
>> >>> @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t *
>> >>> state, static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
>> >>>                                avtab_t * avtab, avtab_key_t * key,
>> >>>                                cond_av_list_t ** cond,
>> >>> -                              av_extended_perms_t *xperms)
>> >>> +                              av_extended_perms_t *xperms,
>> >>> +                              char *alloced)
>> >>>  {
>> >>>     avtab_ptr_t node;
>> >>>     avtab_datum_t avdatum;
>> >>> @@ -1658,6 +1659,11 @@ static avtab_ptr_t
>> >>> find_avtab_node(sepol_handle_t * handle,
>> >>>                     nl->next = *cond;
>> >>>                     *cond = nl;
>> >>>             }
>> >>> +           if (alloced)
>> >>> +                   *alloced = 1;
>> >>> +   } else {
>> >>> +           if (alloced)
>> >>> +                   *alloced = 0;
>> >>>     }
>> >>>
>> >>>     return node;
>> >>> @@ -1750,7 +1756,7 @@ static int expand_terule_helper(sepol_handle_t *
>> >>> handle,
>> >>>                     return EXPAND_RULE_CONFLICT;
>> >>>             }
>> >>>
>> >>> -           node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
>> >>> +           node = find_avtab_node(handle, avtab, &avkey, cond, NULL,
>> >>> NULL);
>> >>>             if (!node)
>> >>>                     return -1;
>> >>>             if (enabled) {
>> >>> @@ -1790,6 +1796,7 @@ static int expand_avrule_helper(sepol_handle_t *
>> >>> handle,
>> >>>     class_perm_node_t *cur;
>> >>>     uint32_t spec = 0;
>> >>>     unsigned int i;
>> >>> +   char alloced;
>> >>>
>> >>>     if (specified & AVRULE_ALLOWED) {
>> >>>             spec = AVTAB_ALLOWED;
>> >>> @@ -1824,7 +1831,8 @@ static int expand_avrule_helper(sepol_handle_t *
>> >>> handle,
>> >>>             avkey.target_class = cur->tclass;
>> >>>             avkey.specified = spec;
>> >>>
>> >>> -           node = find_avtab_node(handle, avtab, &avkey, cond,
>> >>> extended_perms);
>> >>> +           node = find_avtab_node(handle, avtab, &avkey, cond,
>> >>> +                                  extended_perms, &alloced);
>> >>>             if (!node)
>> >>>                     return EXPAND_RULE_ERROR;
>> >>>             if (enabled) {
>> >>> @@ -1850,7 +1858,7 @@ static int expand_avrule_helper(sepol_handle_t *
>> >>> handle,
>> >>>                      */
>> >>>                     avdatump->data &= cur->data;
>> >>>             } else if (specified & AVRULE_DONTAUDIT) {
>> >>> -                   if (avdatump->data)
>> >>> +                   if (!alloced)
>> >>>                             avdatump->data &= ~cur->data;
>> >>>                     else
>> >>>                             avdatump->data = ~cur->data;
>> >>
>> >> This seems awkward to me. If the insertion created a new empty node why
>> >> wouldn't !avdump->data be true (note the addition of the not operator)?
>> >
>> > I misstated that a bit, but the !avdump->data was the else case. I am
>> > really
>> > saying why didn't this work before? In my mind, we don't care if its
>> > allocated
>> > we care if it's set or not.
>>
>> The old logic wrongly assumed that !avdatump->data would only be true if
>> this was the first dontaudit rule for the (source type, target type,
>> target class) and the node had just been allocated by find_avtab_node()
>> with a zero avdatump->data value.
>> However, if you have a dontaudit A B:C *; rule, then the set complement
>> of it will be 0, so we can have !avdatump->data be true in that case
>> too.  Thus, if we end up processing:
>>         dontaudit A B:C *;
>>         dontaudit A B:C { p1 p2 ... };
>> we'll end up clobbering avdatump->data with ~{ p1 p2 ... }.
>>
>> The marlin policy contains:
>>         dontaudit su self:capability *;
>>         dontaudit domain self:capability sys_module;
>> and self rules are expanded (the kernel has no notion of self), so we
>> end up with:
>>         dontaudit su self:capability *;
>>         dontaudit su self:capability sys_module;
>>
>> We have never encountered this situation before because there are no
>> dontaudit A B:C *; rules in refpolicy; that's a corner case that only
>> shows up in Android's su policy, and only because it is a permissive
>> domain with no explicit allow rules (other than those picked up via
>> macros that set up attributes or transitions).
>>
>> The fix was to replace the avdatump->data test with an explicit
>> indication that the node was freshly allocated i.e. this is the first
>> such rule.  I agree that it could be clearer, but I was going for the
>> simplest, least invasive fix for now, both due to limited time and to
>> ease back-porting.
>>
>> >>
>> >> Or perhaps a mechanism to actual set the data on allocation, this way
>> >> the logic is
>> >> Just &=.
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
