Subject: Re: [SECILC] does not seem to filter redundant attributes and rules
To: selinux@tycho.nsa.gov, Gary Tierney <gary.tierney@gmx.com>
References: <a1c00b1d-c5fd-981e-489a-591f3bff3407@gmail.com>
 <823811d5-d5b2-585e-0ff9-5699768f1e91@tycho.nsa.gov>
 <20161109181753.GA14141@workstation.home>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <2056c5f4-fd07-1ecb-085a-17ca5c08d1a0@tycho.nsa.gov>
Date: Wed, 9 Nov 2016 13:53:25 -0500
MIME-Version: 1.0
In-Reply-To: <20161109181753.GA14141@workstation.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/09/2016 01:17 PM, Gary Tierney wrote:
> On Wed, Nov 09, 2016 at 09:52:35AM -0500, James Carter wrote:
>> On 11/09/2016 07:40 AM, Dominick Grift wrote:
>>> I am in the process of a DSSP rewrite, taking a different approach this
>>> time.
>>>
>>> However I encountered something that seems suboptimal:
>>>
>>> SECILC seems to not filter redundant attributes and rules
>>>
>>> Example i have a type attribute and it has rules associated with it.
>>> However, the type attribute is not associated with any types.
>>>
>>> I was hoping that SECILC would be smart enough to determine that it
>>> might as well filter both the type attribute as well as the rules
>>> associated with it.
>>>
>>> To reproduce:
>>>
>>> git clone https://github.com/DefenSec/dssp1-base.git
>>> cd dssp1-base
>>> secilc `ls *.cil`
>>> sesearch -ASCT -s lib.ld_so.read_files_subj_type_attribute policy.30
>>> seinfo -xalib.ld_so.read_files_subj_type_attribute policy.30
>>>
>>>
>>> Am i expecting the impossible by expecting SECILC to be smart enough to
>>> determine that something is redundant, and that it can be filtered out
>>> until it becomes applicable?
>>>
>>>
>>
>> I don't think that it would be too hard to remove attributes that have no
>> types associated with them along with rules containing those attributes. I
>> have this nagging feeling, though, that there is a reason that we didn't do
>> that. I'll have to think about it a bit.
>>
>> Jim
>>
>
> I had a hack 'n' slash attempt at this earlier for just avrules by adding
> naive checks in avrule_write (libsepol/src/write.c) to check if both the
> source and target type_set bitmaps have a cardinality of 0, though couldn't
> help but think I was missing something else.  That didn't work in any case,
> and didn't seem like the codepath is ever hit when a CIL policy is
> written to disk (maybe it's only module policy avrule_write is called for?).
>
> Any hints on where I can start prodding?  Would be nice to get an idea of how
> the binary policy is serialized too.
>>

In libsepol/src/write.c:policydb_write(), avtab_write(), and avtab_write_item() 
checks could be added, but I am not sure off the top of my head what they would 
look like. This would cause the rules to be removed for all kernel policies.

For CIL only, in libsepol/cil/src/cil_binary.c:__cil_avrule_to_avtab() you could 
add a check for the src and tgt like the function below:

static int cil_check_unused_attribute(struct cil_symtab_datum *datum)
{
	struct cil_tree_node *node = datum->nodes->head->data;

	if (node->flavor == CIL_TYPEATTRIBUTE) {
		struct cil_typeattribute *attr = (struct cil_typeattribute *)datum;
		if (ebitmap_cardinality(attr->types) == 0) {
			return CIL_TRUE;
		}
	}

	return CIL_FALSE;
}

Jim

>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>>
>>
>>
>> --
>> James Carter <jwcart2@tycho.nsa.gov>
>> National Security Agency
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
