Message-ID: <558328DF.4040805@tycho.nsa.gov>
Date: Thu, 18 Jun 2015 16:23:59 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 02/10 v2] libsepol: Treat types like an attribute in the
 attr_type_map.
References: <1434571134-31452-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1434571134-31452-3-git-send-email-jwcart2@tycho.nsa.gov>
 <5582CA84.5090503@tycho.nsa.gov> <55832738.60606@tycho.nsa.gov>
 <55832860.5050800@tycho.nsa.gov>
In-Reply-To: <55832860.5050800@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/18/2015 04:21 PM, Stephen Smalley wrote:
> On 06/18/2015 04:16 PM, James Carter wrote:
>> On 06/18/2015 09:41 AM, Stephen Smalley wrote:
>>> Can you provide an example of the difference it makes?
>>>
>>
>> I'll add something like the following.
>>
>>
>> This allows the following statement:
>>
>> ebitmap_and(&m, &p->attr_type_map[src-1], &p->attr_type_map[tgt-1]);
>>
>>
>> which would have previously been written as:
>>
>> if (p->type_val_to_struct[src-1]->flavor == TYPE_ATTRIB &&
>>     p->type_val_to_struct[tgt-1]->flavor == TYPE_ATTRIB) {
>>     ebitmap_and(&m, &p->attr_type_map[src-1], &p->attr_type_map[tgt-1]);
>> } else if (p->type_val_to_struct[k->source_type - 1]->flavor ==
>> TYPE_ATTRIB) {
>>     if (ebitmap_get_bit(&p->attr_type_map[src-1], tgt-1)) {   
>>         ebitmap_set_bit(&m, tgt-1, 1);
>>     }
>> } else if (p->type_val_to_struct[tgt-1]->flavor == TYPE_ATTRIB) {
>>     if (ebitmap_get_bit(&p->attr_type_map[tgt-1], src-1)) {   
>>         ebitmap_set_bit(&m, src-1, 1);
>>     }
>> } else {
>>     if (src == tgt) {
>>         ebitmap_set_bit(&m, src-1, 1);
>>     }
>> }
> 
> Oh, you don't have to be that specific.  Could just note that this
> simplified the implementation of neverallow checking in assertion.c or
> something.
> 
> 
>>> I was wondering though if we are being inconsistent with type_attr_map.
>>>   We do set the type itself here upon policydb_read() of an existing
>>> kernel policy, but do we do it when first generating the type_attr_map
>>> by libsepol?
>>>
>>>
>>
>> I only see the type_attr_map being generated in policydb_read for a
>> kernel policy and when expand_module() is called. This surprised me and
>> made me think that there must be a better place to generate these
>> mappings, but I can't think of a better place. Can you?
> 
> No, I think it makes sense to generate it in the expand.c code (when
> generating the kernel policy from modules) and in policydb_read (when
> reading a kernel policy from a file/image).  But my question is whether
> we are consistently setting the type itself in both places.  You did
> that for attr_type_map, but are we doing it for type_attr_map?  And if
> not, why not?

Actually, I see that we do set it in expand_module before calling
hashtab_map on the type_attr_map callback function.  Whereas you do it
for attr_type_map within type_attr_map callback.
