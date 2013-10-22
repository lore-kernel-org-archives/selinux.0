Message-ID: <5266A048.5070907@tycho.nsa.gov>
Date: Tue, 22 Oct 2013 11:56:56 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Joe MacDonald <joe@deserted.net>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: support building on older PCRE libs
References: <1382453199-19064-1-git-send-email-joe@deserted.net> <20131022144823.GC3728@deserted.net> <20131022150005.GD3728@deserted.net>
In-Reply-To: <20131022150005.GD3728@deserted.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/22/2013 11:05 AM, Joe MacDonald wrote:
> [Re: [PATCH] libselinux: support building on older PCRE libs] On 13.10.22 (Tue 10:48) Joe MacDonald wrote:
> 
>> [[PATCH] libselinux: support building on older PCRE libs] On 13.10.22 (Tue 10:46) Joe MacDonald wrote:
>>
>>> Versions of PCRE prior to 8.20 did not have pcre_free_study().  In its
>>> absence, use pcre_free() instead.
>>>
>>> Signed-off-by: Joe MacDonald <joe@deserted.net>
>>> ---
>>>
>>> This will hit all uses of pcre_free_study() provided label_file.h gets
>>> included somewhere along the way.  Also makes it cleaner to back out when
>>> ancient versions of libpcre fall off the support map and it keeps the code
>>> from being filled with all-caps.
>>>
>>>  libselinux/src/label_file.h |    5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
>>> index bf0c9e2..7d48832 100644
>>> --- a/libselinux/src/label_file.h
>>> +++ b/libselinux/src/label_file.h
>>> @@ -8,6 +8,11 @@
>>>  #define SELINUX_MAGIC_COMPILED_FCONTEXT	0xf97cff8a
>>>  #define SELINUX_COMPILED_FCONTEXT_MAX_VERS	1
>>>  
>>> +/* Prior to verison 8.20, libpcre did not have pcre_free_study() */
>>> +#if (PCRE_MAJOR < 8 || PCRE_MINOR < 20)
>>> +#define pcre_free_study  pcre_free
>>> +#endif
>>> +
>>>  /* A file security context specification. */
>>>  struct spec {
>>>  	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
>>
>> Hmm, actually, no.  That's the same logic I had in the previous #if ...
>> #endif block but it's wrong for cases where PCRE_MAJOR > 8.  Sorry about
>> that.
> 
> Sorry about the noise, this is what I intended and should be okay.  And
> I can't even claim it's Monday morning ... :-}

I think you want PCRE_MAJOR < 8 || PCRE_MAJOR == 8 && PCRE_MINOR < 20 to
avoid problems when we get to version 9.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
