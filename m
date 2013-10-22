Message-ID: <5266897F.7040907@tycho.nsa.gov>
Date: Tue, 22 Oct 2013 10:19:43 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Joe MacDonald <joe@deserted.net>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] libselinux: support building on older PCRE libs
References: <1382383000-16439-1-git-send-email-joe@deserted.net> <1382383000-16439-2-git-send-email-joe@deserted.net> <52658E3D.3010701@tycho.nsa.gov> <20131022141631.GB3728@deserted.net>
In-Reply-To: <20131022141631.GB3728@deserted.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/22/2013 10:16 AM, Joe MacDonald wrote:
> [Re: [PATCH 1/2] libselinux: support building on older PCRE libs] On 13.10.21 (Mon 16:27) Stephen Smalley wrote:
> 
>> On 10/21/2013 03:16 PM, Joe MacDonald wrote:
>>> Versions of PCRE prior to 8.20 did not have pcre_free_study().  In its
>>> absence, use pcre_free() instead.
>>>
>>> Signed-off-by: Joe MacDonald <joe@deserted.net>
>>> ---
>>>  libselinux/src/label_file.c           |    4 ++++
>>>  libselinux/utils/sefcontext_compile.c |    4 ++++
>>>  2 files changed, 8 insertions(+)
>>>
>>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>>> index 9b0d6b0..51520cf 100644
>>> --- a/libselinux/src/label_file.c
>>> +++ b/libselinux/src/label_file.c
>>> @@ -561,7 +561,11 @@ static void closef(struct selabel_handle *rec)
>>>  		free(spec->type_str);
>>>  		if (spec->regcomp) {
>>>  			pcre_free(spec->regex);
>>> +#if (PCRE_MAJOR >= 8 && PCRE_MINOR >= 20)
>>>  			pcre_free_study(spec->sd);
>>> +#else
>>> +			pcre_free(spec->sd);
>>
>> We try to avoid #if / #ifdef scattered throughout the code.
>> The preferred approach is to conditionally define pcre_free_study() to
>> pcre_free() if building with the older libpcre.
> 
> Sure thing.  I'll resubmit.  Given that this is present in only two
> files with the only obvious common #include (within the selinux repo
> itself) being label_file.h, I'll put the #define there.  Does that seem
> reasonable?

Yes, that looks right to me.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
