Message-ID: <48BB8B1E.7010208@ak.jp.nec.com>
Date: Mon, 01 Sep 2008 15:26:38 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org, paul.moore@hp.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] Thread/Child-Domain Assignment (rev.4)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com> <4897EB6F.6080709@ak.jp.nec.com> <48B2A66D.7030608@ak.jp.nec.com> <48B6C966.7040006@tresys.com> <48B756C4.2090909@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3510@exchange2.columbia.tresys.com>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E3A3510@exchange2.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> KaiGai Kohei wrote:
>> Joshua Brindle wrote:
>>> KaiGai Kohei wrote:
>>>> The following patch is revised one for libsepol.
>>>>
>>>> Updates:
>>>>  - The properties of type_datum are packed within the third word of
>>>>    type entries in the kernel policy.
>>>>    The first bit (TYPEDATUM_PROPERTY_PRIMARY) means the entry is a
>>>>    primary type, and the second bit (TYPEDATUM_PROPERTY_ATTRIBUTE)
>>>>    means the entry is an attribute.
>>>>
>>> I didn't see an answer in the current threads, and this looks like
>>  > the latest userland patch series so I'll ask here: What is
>> the purpose  > of the properties? We can infer what it knows
>> from the other fields
>>> in the datum, right?
>> Stephen said as follows:
>> http://marc.info/?l=selinux&m=121882413424973&w=2
>>
>>> Keeping the type attribute names in the types symtab in the kernel
>>> policy allows tools like audit2why and apol to extract the original
>>> attribute names and display them.  I originally shed them because the
>>> kernel didn't need to use that information and we don't want
>>> attribute names to be used in security contexts, but it costs us
>>> little to save them and check for them, and it benefits the tools.
> 
> No, I got that part. What I was missing was that we identified
> attributes differently in modules and kernel policy now, kind of
> confusing.

I see, modular policy format now has "primary", "flavor" and "flags"
members to identify its properties. It is different from newer kernel
policy format.

>> The type_datum has the following format in the newer kernel policy:
>>
>>   +0 +-------------------------+
>>      | length of name          |
>>   +4 +-------------------------+
>>      | type identifier value   |
>>   +8 +-------------------------+
>>      | property bits           | <--- TYPEDATUM_PROPERTY_PRIMARY
>> +12 +-------------------------+      TYPEDATUM_PROPERTY_ATTRIBUTE
>>      | bounds type identifier  |
>> +16 +-------------------------+
>>      | text representation of  |
>>      | name (variable length)  |
>>      +-------------------------+
>>
>> Any property bits are packed within the third field.
>>
> 
> I don't see that in the libsepol patch:
> 
> @@ -145,8 +146,16 @@
>  	ebitmap_t types;	/* types with this attribute */
>  #define TYPE_FLAGS_PERMISSIVE	0x01
>  	uint32_t flags;
> +	uint32_t bounds;	/* bounds type, if exist */
>  } type_datum_t;

Are you saying members within type_datum_t should have one-to-one mapping
with its disk format? If so, it is the most straightforward approach to
add a "flavor" member for the disk format of kernel policy.

I guess your opinion is that smaller differences between kernel and
modular policy format is better. If so, what do you think about an idea
which packs all properties of a type into a property bits members.
We need 1 bit for "primary" property, 2 bits for "flavor" and 1 bit for
"permissive", so it is enough to store them into a 32bits variable.

In this case, the format of type_datum is changed as follows:

  + 0 : length of name (unchanged)
  + 4 : type identifier value (unchanged)
  + 8 : property bits which can have following bits
  +12 : bounds type identifier (newly added)
  +16 : ebitmap of attributes (modular only/unchanged)
  +XX : text representation of type name
  (*) flavor in modular policy format is deprecated.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
