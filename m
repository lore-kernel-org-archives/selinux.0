Subject: Re: initial_sid context via libsepol
To: Richard Haines <richard_c_haines@btinternet.com>,
 "Roberts, William C" <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <121365621.6063900.1457189031805.JavaMail.yahoo@mail.yahoo.com>
 <767708561.7764421.1457365274229.JavaMail.yahoo@mail.yahoo.com>
 <56DDCBF6.6010605@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56DDE54F.4050208@tycho.nsa.gov>
Date: Mon, 7 Mar 2016 15:32:15 -0500
MIME-Version: 1.0
In-Reply-To: <56DDCBF6.6010605@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/07/2016 01:44 PM, Stephen Smalley wrote:
> On 03/07/2016 10:41 AM, Richard Haines wrote:
>>
>>
>>
>>
>>
>>> On Saturday, 5 March 2016, 14:48, Richard Haines
>>> <richard_c_haines@btinternet.com> wrote:
>>>>
>>>
>>>
>>>
>>> On Friday, 4 March 2016, 21:18, "Roberts, William C"
>>> <william.c.roberts@intel.com> wrote:
>>>
>>>
>>>>
>>>>
>>>>
>>>>
>>>> How can one obtain the same value as
>>>> /sys/fs/selinux/initial_contexts/file
>>> via libsepol?
>>>>
>>>> I’ve been digging around libsepol and its not quite clear to me.
>>>>
>>>> It looks as though the record is here:
>>>>                  context_struct_t *a = &((policydb_t
>>> *)pol.db)->ocontexts[OCON_ISID]->context[0];
>>>>                  context_struct_t *b = &((policydb_t
>>> *)pol.db)->ocontexts[OCON_ISID]->context[1];
>>>>
>>>>                  printf("%u\n", a->type);
>>>>                  printf("%u\n",b->type);
>>>>
>>>> Prints:
>>>> 185
>>>> 0
>>>>
>>>> Not sure if this is right, and how to format the context struct to a
>>>> string.
>>> I didn’t see any helpers.
>>>>
>>>
>>>>
>>
>>> I've attached an example, hope it's useful
>>
>> I've updated the example with more detail and display SID name using
>> SID value not counter.
>>
>
> Any particular reason you didn't use sepol_sid_to_context()?

I guess context_to_string() on the context structure would work better 
for your purposes.   sepol_sid_to_context() would require loading the 
sidtab via policydb_load_isids() and setting the internal policydb to 
the one you loaded via sepol_set_policydb().
