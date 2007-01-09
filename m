Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l09FpgUn009661
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 10:51:42 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l09FqUeY023137
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 15:52:30 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l09FqT8b024038
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 10:52:29 -0500
Message-ID: <45A3BA1B.9000908@mentalrootkit.com>
Date: Tue, 09 Jan 2007 10:51:55 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: James Antill <jantill@redhat.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Support for bzip compressed modules
References: <45A2AADC.1090907@mentalrootkit.com> <1168327098.22423.93.camel@code.and.org>
In-Reply-To: <1168327098.22423.93.camel@code.and.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Antill wrote:
> On Mon, 2007-01-08 at 15:34 -0500, Karl MacMillan wrote:
> 
>> The patch implements this support by changing sepol_policy_file_t to 
>> support decompressing files or memory areas into a private memory copy. 
>> This support is optional - dlopen is used so that a hard dependency to 
>> libbz2 is not introduced. I took the approach of decompressing the 
>> entire file or memory area because:
> 
>  Why don't we want to depend on libbz, if we are building with bz2
> support? 
> 

This allows the same binary to be installed with or without libbz2. 
Since libsepol gets pulled into so many installs, it seems preferable to 
not add additional dependencies.

On the other hand, I don't have a strong preference about that part of 
the patch. If libbz2 is deemed sufficiently available (or even libz I 
guess) we can just directly link. Perhaps with compile time options.

>> * It is very simple
>> * The current code depends on the ability to seek within policy files - 
>> this is not really possible within compressed streams using the bzip2 
>> library.
>>
>> The downsides are:
>>
>> * Increased memory usage
>> * No transparent support for compressed writing with an fd based policy 
>> file.
>>
>> I didn't want to add additional set functions - I would have preferred 
>> to allow sepol_policy_file_set_[mem,fd] to transparently open compressed 
>> streams with functions to set other behaviors as options stored in 
>> sepol_policy_file_t structs. This was not possible becuase the current 
>> set functions do not return errors.
> 
>  Do we really care about the memory usage, my instinct would be to drop
> the FILE specific code and just dump everything into memory and then
> call the mem_set function and thus. have only one decompression loop
> (adding the fd version is simple then too).
>  Calling fstat(fileno(fp)) to read the policy in is probably easier than
> a loop.
> 

Not certain what you are getting at - both code paths result in an 
uncompressed copy of the compressed data in memory. The only difference 
is whether we are decompressing from an fd or from another memory buffer.

>> Comments appreciated. Some very crude benchmarking below (note that I am 
>> using a patched semodule to allow the globbing syntax - patch for that 
>> to follow). The summary is that there is substantial space savings at 
>> the expense of some increase in time to complete common actions. An 
>> acceptable trade-off in my opinion.
>>
>> Anyone have suggestions for something as simple as time but for max 
>> memory usage?
> 
>  There's memusage in glibc-utils.
> 

Thanks

> ---- code ----
> 
>  The bz2 code looks fine, although the += BUFSIZE in one loop and *= 2
> in the other is weird, and there's a couple of minor nits in the
> interface:
> 

If you look at the loop with *= 2, we are just guessing buffer size so I 
want to grow the buffer much more quickly if the decompression fails. We 
start with a 2-1 compression ratio, then try 4-1, etc. If we only adding 
BUFSIZ then we might loop for a long time growing the buffer.

> . check is always true in callers, and I'm not sure why you'd have it
> zero.
> 

The magic number checking seems fragile - I'm assuming it might be 
necessary to force the stream as compressed at some point. Since we are 
maintaining ABI for this library (and these functions), seems better to 
be safe.

> . All code paths have:
> 
>  if (set_foo_bz2() == FAILED)
>   set_foo();
> 
> ...which tells me set_foo_bz2() should do that ... in fact it seems sane
> to just change set_foo() to check of bz2ness and do the right thing,
> without having to alter the callers.
> 

Note my comments with the original patch - this isn't possible because 
set_foo() has a void return and we want to maintain binary compatibility.

> . A personal minor nit is that free(NULL) works fine, so don't work
> around it (this idiom seems to be used in sepol).
> 

I don't that I see - maybe you mean:

+	if (pf && pf->orig_data) {
+		free(pf->orig_data);
+		pf->orig_data = NULL;
+	}

This is to allow this function to be called with a null pf - so I have 
to check before looking in the struct.

> . sepol_policy_file_free_data() is also called multiple times at the end
> of the set_foo_bz2() functions (once inside set_foo() and then
> explicitly immediately after).
> 

Good catch - thanks.

> 
>  I assume the only reason you went with bzip2 over gzip is the "have to
> init yourself in the set_mem case"?

No - just better compression.

[kmacmill@localhost ~]$ ls -l base.pp.*
-rw-r--r-- 1 kmacmill kmacmill  86379 Jan  9 10:50 base.pp.bz2
-rw-r--r-- 1 kmacmill kmacmill 167382 Jan  9 10:50 base.pp.gz

  I've done that before[1], so I can
> help you get that bit done if you want ... this will drop
> CPU/memory/dependency requirements (although expecting all Linux to have
> libbz now isn't a big deal, IMO).
> 

Ok - I'd be happy to support both if you want to send a patch.

Thanks - Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
