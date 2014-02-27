Message-ID: <530F63F1.1040105@tycho.nsa.gov>
Date: Thu, 27 Feb 2014 11:12:33 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: put the mmap() DAC controls before the MAC
 controls
References: <20140227143045.14242.66994.stgit@localhost>
 <530F607A.8070200@tycho.nsa.gov>
In-Reply-To: <530F607A.8070200@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Cc: casey.schaufler@intel.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/27/2014 10:57 AM, Stephen Smalley wrote:
> On 02/27/2014 09:30 AM, Paul Moore wrote:
>> It turns out that doing the SELinux MAC checks for mmap() before the
>> DAC checks was causing users and the SELinux policy folks headaches
>> as users were seeing a lot of SELinux AVC denials for the
>> memprotect:mmap_zero permission that would have also been denied by
>> the normal DAC capability checks (CAP_SYS_RAWIO).
> 
> So you think that the explanation given in the comment for the current
> ordering is no longer valid?

And if so, is there in fact any real value in retaining the SELinux
check at all?  Do we in fact ever allow sys_rawio and not mmap_zero (or
if we do, is there a real reason for it)?

> 
>>
>> Example:
>>
>>  # cat mmap_test.c
>>   #include <stdlib.h>
>>   #include <stdio.h>
>>   #include <errno.h>
>>   #include <sys/mman.h>
>>
>>   int main(int argc, char *argv[])
>>   {
>>         int rc;
>>         void *mem;
>>
>>         mem = mmap(0x0, 4096,
>>                    PROT_READ | PROT_WRITE,
>>                    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>>         if (mem == MAP_FAILED)
>>                 return errno;
>>         printf("mem = %p\n", mem);
>>         munmap(mem, 4096);
>>
>>         return 0;
>>   }
>>  # gcc -g -O0 -o mmap_test mmap_test.c
>>  # ./mmap_test
>>  mem = (nil)
>>  # ausearch -m AVC | grep mmap_zero
>>  type=AVC msg=audit(...): avc:  denied  { mmap_zero }
>>    for pid=1025 comm="mmap_test"
>>    scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>>    tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>>    tclass=memprotect
>>
>> This patch corrects things so that when the above example is run by a
>> user without CAP_SYS_RAWIO the SELinux AVC is no longer generated as
>> the DAC capability check fails before the SELinux permission check.
>>
>> Signed-off-by: Paul Moore <pmoore@redhat.com>
>> ---
>>  security/selinux/hooks.c |   20 ++++++++------------
>>  1 file changed, 8 insertions(+), 12 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 57b0b49..e3664ae 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -3205,24 +3205,20 @@ error:
>>  
>>  static int selinux_mmap_addr(unsigned long addr)
>>  {
>> -	int rc = 0;
>> -	u32 sid = current_sid();
>> +	int rc;
>> +
>> +	/* do DAC check on address space usage */
>> +	rc = cap_mmap_addr(addr);
>> +	if (rc)
>> +		return rc;
>>  
>> -	/*
>> -	 * notice that we are intentionally putting the SELinux check before
>> -	 * the secondary cap_file_mmap check.  This is such a likely attempt
>> -	 * at bad behaviour/exploit that we always want to get the AVC, even
>> -	 * if DAC would have also denied the operation.
>> -	 */
>>  	if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
>> +		u32 sid = current_sid();
>>  		rc = avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
>>  				  MEMPROTECT__MMAP_ZERO, NULL);
>> -		if (rc)
>> -			return rc;
>>  	}
>>  
>> -	/* do DAC check on address space usage */
>> -	return cap_mmap_addr(addr);
>> +	return rc;
>>  }
>>  
>>  static int selinux_mmap_file(struct file *file, unsigned long reqprot,
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
