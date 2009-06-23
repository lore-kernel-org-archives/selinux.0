Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5NH8uLc011866
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 13:08:56 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5NH8frs007509
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 17:08:41 GMT
Message-ID: <4A410C25.3030607@manicmethod.com>
Date: Tue, 23 Jun 2009 13:08:53 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Tomas Mraz <tmraz@redhat.com>,
        Manoj Srivastava <srivasta@golden-gryphon.com>, selinux@tycho.nsa.gov,
        505920-forwarded@bgs.debian.org, Kees Cook <kees@debian.org>,
        505920-submitter@bugs.debian.org,
        selinux-devel-owner@lists.alioth.debian.org
Subject: Re: Problems with freeing thread local storage in libselinux
References: <C656D61C.A7DF2%csellers@tresys.com>
In-Reply-To: <C656D61C.A7DF2%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> On 5/6/09 6:38 AM, "Tomas Mraz"<tmraz@redhat.com>  wrote:
>
>> On Wed, 2009-05-06 at 01:32 -0500, Manoj Srivastava wrote:
>>> Hi folks,
>>>
>>>          There have been numerous reports in Debian and derivatives of
>>>   programs linked with libselinux intermittently getting segfaults.
>>>   There is, for instance, the Debian report 505920[0], and Ubuntu
>>>   reports[1], [3] and [5], and Gnome [2]. I have not been able to
>>>   reproduce the error myself, though I have run the test cases a number
>>>   of times.
>>>
>>>          The common thread in unclutter, libavg, gst-inspect et al. is a
>>>   segmentation fault in libselinux1, in the 'fini' destructor functions,
>>>   referencing the thread local variables.
>>>
>>>          The Ubuntu bug log reference my old patch for libselinux from
>>>   1.X days, where I replaced the thread local storage with regular
>>>   variables and mutexes, and people report success with that.  I suspect
>>>   that something is corrupting the thread local storage. From the ubuntu
>>>   report:
>>> --8<---------------cut here---------------start------------->8---
>>> Valgrind reports:
>>> =29183== Invalid read of size 8
>>> ==29183== at 0xE29B9DD: fini_context_translations (setrans_client.c:211)
>>> ==29183== by 0xE28F1F1: (within /lib/libselinux.so.1)
>>> ==29183== by 0xE29D040: (within /lib/libselinux.so.1)
>>> ==29183== by 0x570010F: exit (exit.c:75)
>>> 505920==29183== by 0x56E91CA: (below main) (libc-start.c:252)
>>> ==29183== Address 0x80 is not stack'd, malloc'd or (recently) free'd
>>> ==29183==
>>> ==29183== Process terminating with default action of signal 11 (SIGSEGV):
>>> dumping core
>>> ==29183== Access not within mapped region at address 0x80
>>> ==29183== at 0xE29B9DD: fini_context_translations (setrans_client.c:211)
>>> ==29183== by 0xE28F1F1: (within /lib/libselinux.so.1)
>>> ==29183== by 0xE29D040: (within /lib/libselinux.so.1)==29183== by 0x570010F:
>>> exit (exit.c:75)
>>> ==29183== by 0x56E91CA: (below main) (libc-start.c:252)
>>>
>>>
>>> (gdb) bt
>>> #0 0x00007f3ae812a9dd in fini_context_translations () at setrans_client.c:211
>>> #1 0x00007f3ae811e1f2 in __do_global_dtors_aux () from /lib/libselinux.so.1
>>> #2 0x00007ffff9097700 in ?? ()
>>> #3 0x00007f3ae812c041 in _fini () from /lib/libselinux.so.1
>>> #4 0x00007ffff9097700 in ?? ()
>>> #5 0x00007f3af0e88796 in _dl_fini () from /lib64/ld-linux-x86-64.so.2
>>> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
>>> --8<---------------cut here---------------end--------------->8---
>>>
>>>          There have been two sets of patches proposed for this; first one
>>>   merely initializes the variables in the init function, and this works
>>>   for a number of people, but at least one person has reported a second
>>>   segfault even with the patch installed[6]
>>>
>>>          The second patch below converts a thread local cache to a
>>>   process wide cache, with mutex guards, which makes the cache slower,
>>>   and non-thread local caches means that cache misses are more likely.
>>>
>>>          I'll try and follow up with people who can reproduce the
>>>   problems to see if either one of the patches solve their problems
>>>   without triggering other segmentation faults, but I'd appreciate
>>>   comments if anyone has insight into the issue.
>> The problem is with freeing storage referenced by TLS variables in
>> destructors. The destructor is called only in one of the threads and the
>> variables might not be even properly initialized in that thread. One
>> possibility is to not free the storage at all but that will leak memory
>> if the libselinux is loaded/unloaded multiple times in a process.
>>
>> The only proper way is to use TSD (pthread_key_create,
>> pthread_setspecific etc.) to store the pointers to the cached contexts.
>>
>> The attached patch implements this. I did not test it thoroughly though.
>
> I did some testing on this and it seems to work well.
>
> Acked-by: Chad Sellers<csellers@tresys.com>
>

Merged in libselinux 2.0.82

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
