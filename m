Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3OIbIdE008350
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 14:37:18 -0400
In-Reply-To: <100DD2AB-228E-47B5-8058-C9F030AEA665@trentalancia.net>
References: <58517705.198270.1492699110308@pim.register.it>
 <138cd2dc-f5c8-43ce-eb22-6f59c768623d@gmail.com>
 <f5651c20-f14f-bd42-be2f-947294de28c9@gmail.com>
 <100DD2AB-228E-47B5-8058-C9F030AEA665@trentalancia.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] libsemanage: remove lock files
From: Guido Trentalancia <guido@trentalancia.net>
Date: Mon, 24 Apr 2017 20:38:40 +0200
To: selinux@tycho.nsa.gov
Message-ID: <C6C00E69-C6B1-4408-B27A-C05D7B6B9D00@trentalancia.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Also, another major benefit of not using flock() comes when using NFS (probably a very rare circumstance, but not entirely impossibile).

It is possible to use the presence of a file (with the same name) to indicate an "active" lock: such file should store the PID of the process that is requiring the lock.

If a lock is found with a PID that does not exist, then such lock is considered invalid and it is removed. 
That is it really...

Regards, 

Guido 

On the 24th of April 2017 19:51:27 CEST, Guido Trentalancia <guido@trentalancia.net> wrote:
>Yes, we already discussed this possibile race condition. 
>
>Usually there is only one system administrator operating on the
>semanage store, nevertheless it's worth having a robust locking
>mechanism...
>
>This patch either needs further work to avoid using flock() and instead
>using a simpler file lock mechanism with the added benefit of having a
>cleaner filesystem without confusing stale files around or we just drop
>the patch given it is not essential to keep things working. 
>
>Regards, 
>
>Guido 
>
>On the 24th of April 2017 14:08:22 CEST, Alan Jenkins
><alan.christopher.jenkins@gmail.com> wrote:
>>*expands thread
>>
>>Sorry, I see this has already been addressed.
>>
>>
>>On 24/04/17 13:06, Alan Jenkins wrote:
>>> On 20/04/17 15:38, Guido Trentalancia wrote:
>>>> Remove semanage read and transaction lock files upon releasing
>>>> them.
>>>
>>> What prevents this sequence?
>>>
>>> A release lock
>>>  B acquire lock
>>> A unlink lock file
>>>   C create lock file
>>>   C acquire lock
>>>
>>>> Signed-off-by: Guido Trentalancia 
>>>> <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
>>>> ---
>>>>   src/semanage_store.c |    2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff -pruN a/src/semanage_store.c b/src/semanage_store.c
>>>> --- a/src/semanage_store.c    2016-10-14 17:31:26.000000000 +0200
>>>> +++ b/src/semanage_store.c    2017-04-03 09:32:24.093627962 +0200
>>>> @@ -1904,6 +1904,7 @@ void semanage_release_trans_lock(semanag
>>>>           close(sh->u.direct.translock_file_fd);
>>>>           sh->u.direct.translock_file_fd = -1;
>>>>       }
>>>> +    unlink(semanage_files[SEMANAGE_TRANS_LOCK]);
>>>>       errno = errsv;
>>>>   }
>>>>   @@ -1917,6 +1918,7 @@ void semanage_release_active_lock(semana
>>>>           close(sh->u.direct.activelock_file_fd);
>>>>           sh->u.direct.activelock_file_fd = -1;
>>>>       }
>>>> +    unlink(semanage_files[SEMANAGE_READ_LOCK]);
>>>>       errno = errsv;
>>>>   }
>>>
>>>
>>>
