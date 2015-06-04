Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54JQFoH014685
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 15:26:16 -0400
Received: by igbpi8 with SMTP id pi8so145751580igb.1
 for <selinux@tycho.nsa.gov>; Thu, 04 Jun 2015 12:26:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55707CF4.4050807@tycho.nsa.gov>
References: <20150604161454.4124.77310.stgit@localhost>
 <20150604161538.4124.38211.stgit@localhost>
 <55707CF4.4050807@tycho.nsa.gov>
Date: Thu, 4 Jun 2015 15:26:13 -0400
Message-ID: <CAHC9VhSiSc=zQjUbSivivSFwKm2ZVopjaxMF1URwA4Pkk9DZOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux-testsuite: fix compile warnings in
 tests/execshare
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jun 4, 2015 at 12:29 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 06/04/2015 12:15 PM, Paul Moore wrote:
>> Correct the following:
>>
>> make[2]: Entering directory '/root/sources/selinux-testsuite/tests/execshare'
>> cc     parent.c  -lselinux -o parent
>> parent.c: In function 'main':
>> parent.c:83:8: warning: implicit declaration of function 'clone'
>>   pid = clone(clone_fn, clone_stack, cloneflags | SIGCHLD, argv);
>>         ^
>>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> Although maybe we should just add -D_GNU_SOURCE to CFLAGS in the
> tests/Makefile...

Good point, v2 shortly.

-- 
paul moore
www.paul-moore.com
