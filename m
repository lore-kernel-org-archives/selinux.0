Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u28Dc24X008278
 for <selinux@tycho.nsa.gov>; Tue, 8 Mar 2016 08:38:03 -0500
Date: Tue, 8 Mar 2016 13:35:14 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <770970403.3564872.1457444114303.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <1439711485.8727172.1457442762500.JavaMail.yahoo@mail.yahoo.com>
References: <1439711485.8727172.1457442762500.JavaMail.yahoo@mail.yahoo.com>
Subject: Re: initial_sid context via libsepol
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>






> On Tuesday, 8 March 2016, 13:17, Richard Haines <richard_c_haines@btinternet.com> wrote:
> > 
> 
> 
> 
> On Tuesday, 8 March 2016, 1:32, William Roberts <bill.c.roberts@gmail.com> 
> wrote:
> 
> 
>> 
>> 
>> 
>> 
>> 
>> 
>> On Mon, Mar 7, 2016 at 12:32 PM, Stephen Smalley <sds@tycho.nsa.gov> 
> wrote:
>> 
>> On 03/07/2016 01:44 PM, Stephen Smalley wrote:
>>> 
>>> On 03/07/2016 10:41 AM, Richard Haines wrote:
>>>> 
>>>> 
>>>>> 
>>>>> 
>>>>> 
>>>>> 
>>>>> 
>>>>> On Saturday, 5 March 2016, 14:48, Richard Haines
>>>>>> <richard_c_haines@btinternet.com> wrote:
>>>>>> 
>>>>>> 
>>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> On Friday, 4 March 2016, 21:18, "Roberts, William 
> C"
>>>>>> <william.c.roberts@intel.com> wrote:
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>>> 
>>>>>>> 
>>>>>>> 
>>>>>>> How can one obtain the same value as
>>>>>>> /sys/fs/selinux/initial_contexts/file
>>>>>>> 
> via libsepol?
>>>>>> 
>>>>>> 
>>>>>>> I’ve been digging around libsepol and its not quite 
> clear to me.
>>>>>>> 
>>>>>>> It looks as though the record is here:
>>>>>>>                  context_struct_t *a = &((policydb_t
>>>>>>> 
> *)pol.db)->ocontexts[OCON_ISID]->context[0];
>>>>>> 
>>>>>>                  context_struct_t *b = &((policydb_t
>>>>>>> 
> *)pol.db)->ocontexts[OCON_ISID]->context[1];
>>>>>> 
>>>>>> 
>>>>>>>                  printf("%u\n", 
> a->type);
>>>>>>>                 
> printf("%u\n",b->type);
>>>>>>> 
>>>>>>> Prints:
>>>>>>> 185
>>>>>>> 0
>>>>>>> 
>>>>>>> Not sure if this is right, and how to format the context 
> struct to a
>>>>>>> string.
>>>>>>> 
> I didn’t see any helpers.
>>>>>> 
>>>>>> 
>>>>>>> 
>>>>>> 
>>>>>> 
>>>>>>> 
>>>>> 
>>>>> I've attached an example, hope it's useful
>>>>>> 
>>>>> I've updated the example with more detail and display SID 
> name using
>>>>> SID value not counter.
>>>>> 
>>>>> 
>>>> Any particular reason you didn't use sepol_sid_to_context()?
>>>> 
>>> 
> I guess context_to_string() on the context structure would work better for your 
> purposes.   sepol_sid_to_context() would require loading the sidtab via 
> policydb_load_isids() and setting the internal policydb to the one you loaded 
> via sepol_set_policydb().
>> 
>> 
>> 
>> 
>> Seems as though its not exported api, but it does indeed print something:
>> 
>> code:
>> char *s;
>> size_t len;
>> context_struct_t *a = &((policydb_t 
> *)pol.db)->ocontexts[OCON_ISID]->context[0];
>> 
>> 
>> int rc = context_to_string(pol.handle, (policydb_t *)pol.db, a, &s, 
> &len);
>> 
>> 
>> printf("rc: %d\n", rc);
>> printf("con: %s\n", s);
>> 
>> 
>> prints:
>>   rc: 0
>>   con: u:object_r:null_device:s0
>> 
>> 
>> However, I am after the initial sid for file, which this isn't it... is 
> it in the ocontexts array under a different index?
> 
>> 
> 
> From what I can see the only ways for you to get the context of a specifically
> named initial sid, is to:
> 
> 1) If working on the active policy then read /sys/fs/selinux/initial_contexts
> for the specific name.
> 
> 2) If working on a binary policy that has been loaded by libsepol for
> investigation, then I guess the official answer would be "you cannot do
> this", simply because the names are not held in the binary policy.
> 
> What you could do is:
> 
> a) Load the initial_sid_to_string.h or the policy initial_sids file and search
> through it for a match. This will give the offset and would (by magic) give
> the initial SID value (e.g. "file" = 5) as it just so happens that the
> initial SIDs start at '1' in a standard SELinux system. You can then 
> obtain

> the context string.
Sorry missed the bit about using the offset as the index for matching 
the cur->sid[0] value that would then allow the correct context to be
retrieved.

> 
> b) Or you could just say they start at 1 and I know "file" is the 5th 
> entry !!
> 
> c) Modify policy, kernel etc. to add the names.
> 
> Unless someone knows another way !!!!
> 
>> 
>> Bill
>> 
>> 
>>> 
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
>>> 
>> 
>> 
>> 
>> -- 
>> 
>> Respectfully,
>> 
>> William C Roberts
> 
>> 
>> 
>> 
>> 
>> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
>
