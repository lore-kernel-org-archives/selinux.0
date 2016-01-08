Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u08EVA6K019105
 for <selinux@tycho.nsa.gov>; Fri, 8 Jan 2016 09:31:10 -0500
Subject: Re: ANN: SELinux Userspace Release 20160107-rc1
To: Nicolas Iooss <nicolas.iooss@m4x.org>, <selinux@tycho.nsa.gov>
References: <568E8AA5.5030501@tresys.com> <568EE3C3.4060907@m4x.org>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <568FC820.4010405@tresys.com>
Date: Fri, 8 Jan 2016 09:30:56 -0500
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
In-Reply-To: <568EE3C3.4060907@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/07/2016 05:16 PM, Nicolas Iooss wrote:
> On 01/07/2016 04:56 PM, Steve Lawrence wrote:
>> A release candidate for SELinux Userspace is now available at:
>>
>> https://github.com/SELinuxProject/selinux/wiki/Releases
>>
>> This has been tagged as 20160107-rc1 in the git repository.
>>
>> Please give at a test and let us know if there are any issues.
>>
>> Thanks,
>> - Steve
> 
> Hello,
> 
> As I am updating my packages to test this -rc1, I encountered three very
> minor problems with secilc:
> 
> 1. The README says "libsepol >= 2.4", which seems not to be true.  I get
> this error when compiling secilc with libsepol 2.4:
> 
>   secilc.c:298:7: error: too few arguments to function
>   ‘cil_filecons_to_string’
>     rc = cil_filecons_to_string(db, &fc_buf, &fc_size);
>          ^
>   In file included from secilc.c:40:0:
>   /usr/include/sepol/cil/cil.h:47:12: note: declared here
>     extern int cil_filecons_to_string(cil_db_t *db, sepol_policydb_t
>   *sepol_db, char **o
>               ^
>   <builtin>: recipe for target 'secilc.o' failed
>   make: *** [secilc.o] Error 1
> 
> The build is fine with libsepol 2.5-rc1, so I guess the dependency only
> needs to be updated in the README file.
> 
> 2. "make" does not build the man page.  This is because it defaults to
> the first defined target in the Makefile, which is secilc, not "all",
> unlike the other SELinux projects.  I was a little bit surprised that
> "make" did not behave like "make all" but I guess this is not a big
> deal.  Feel free not to "fix" this.
> 
> 3. While reading the Makefile, I found that "man" target was missing
> from the .PHONY line [2] and I do not know the precise consequences of
> an incomplete .PHONY target.  Anyway "make all && make install" works fine.
> 
> Thanks,
> Nicolas
> 
> [1]
> https://github.com/SELinuxProject/selinux/blob/secilc-2.5-rc1/secilc/README#L14
> [2]
> https://github.com/SELinuxProject/selinux/blob/secilc-2.5-rc1/secilc/Makefile#L49
> 

Thanks for testing. You're correct on all counts. I'll send a patch to
fix these issues shortly.

Thanks,
- Steve
