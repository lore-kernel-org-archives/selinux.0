MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/3] Thread/Child-Domain Assignment (rev.4)
Date: Thu, 28 Aug 2008 23:01:10 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E3A3510@exchange2.columbia.tresys.com>
In-Reply-To: <48B756C4.2090909@ak.jp.nec.com>
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com> <4897EB6F.6080709@ak.jp.nec.com> <48B2A66D.7030608@ak.jp.nec.com> <48B6C966.7040006@tresys.com> <48B756C4.2090909@ak.jp.nec.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "KaiGai Kohei" <kaigai@ak.jp.nec.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, <jmorris@namei.org>,
        <paul.moore@hp.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> Joshua Brindle wrote:
>> KaiGai Kohei wrote:
>>> The following patch is revised one for libsepol.
>>> 
>>> Updates:
>>>  - The properties of type_datum are packed within the third word of
>>>    type entries in the kernel policy.
>>>    The first bit (TYPEDATUM_PROPERTY_PRIMARY) means the entry is a
>>>    primary type, and the second bit (TYPEDATUM_PROPERTY_ATTRIBUTE)
>>>    means the entry is an attribute.
>>> 
>> 
>> I didn't see an answer in the current threads, and this looks like
>  > the latest userland patch series so I'll ask here: What is
> the purpose  > of the properties? We can infer what it knows
> from the other fields
>> in the datum, right?
> 
> Stephen said as follows:
> http://marc.info/?l=selinux&m=121882413424973&w=2
> 
>> Keeping the type attribute names in the types symtab in the kernel
>> policy allows tools like audit2why and apol to extract the original
>> attribute names and display them.  I originally shed them because the
>> kernel didn't need to use that information and we don't want
>> attribute names to be used in security contexts, but it costs us
>> little to save them and check for them, and it benefits the tools.
> 

No, I got that part. What I was missing was that we identified
attributes differently in modules and kernel policy now, kind of
confusing.

> The purpose of property bits is to identify the sort of type_datum.
> The kernel policy version >= 24 allows to load attribute
> entries, so we have to distinguish them from existing type entries.
> 
> Any type_datum entries of attributes were removed at the tail
> of expand_module in the older version, so we can assume any
> entries loaded to kernel space are primary or alias type.
> Because existing format of type_datum does not have any
> information to identify it to be an attribute, we had to add
> a flag bit to mark.
> 
>> One thing that bothers me is that we read prop out of the binary but
>  > it is nowhere in the type datum, I can see this leading to
> errors in  > the reader where a developer can't figure out
> where the extra data is  > coming from.
> 
> (?_?) I'm not sure about your concern.
> 
> The type_datum has the following format in the newer kernel policy:
> 
>   +0 +-------------------------+
>      | length of name          |
>   +4 +-------------------------+
>      | type identifier value   |
>   +8 +-------------------------+
>      | property bits           | <--- TYPEDATUM_PROPERTY_PRIMARY
> +12 +-------------------------+      TYPEDATUM_PROPERTY_ATTRIBUTE
>      | bounds type identifier  |
> +16 +-------------------------+
>      | text representation of  |
>      | name (variable length)  |
>      +-------------------------+
> 
> Any property bits are packed within the third field.
> 

I don't see that in the libsepol patch:

@@ -145,8 +146,16 @@
 	ebitmap_t types;	/* types with this attribute */
 #define TYPE_FLAGS_PERMISSIVE	0x01
 	uint32_t flags;
+	uint32_t bounds;	/* bounds type, if exist */
 } type_datum_t;

> 
>> I will echo Steve's request to remove the old hierarchy stuff from
>> here
>  > and add in the implementation necessary to do validation
> of the bounds  > in libsepol.
> 
> OK, please wait for a few days.
> 
> Thanks,



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
