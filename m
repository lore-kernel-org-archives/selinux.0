Subject: Re: [PATCH 1/3] libselinux: Evaluate inodes in selinux_restorecon(3)
To: Stephen Smalley <sds@tycho.nsa.gov>, Richard Haines
 <richard_c_haines@btinternet.com>, <selinux@tycho.nsa.gov>
References: <1462893734-9509-1-git-send-email-richard_c_haines@btinternet.com>
 <08abe881-e195-92d0-fa20-87eadaccf645@tycho.nsa.gov>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <1789fd8c-ba32-1703-4d93-ae0f96b0c876@tresys.com>
Date: Fri, 20 May 2016 13:04:43 -0400
MIME-Version: 1.0
In-Reply-To: <08abe881-e195-92d0-fa20-87eadaccf645@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/20/2016 12:26 PM, Stephen Smalley wrote:
> On 05/10/2016 11:22 AM, Richard Haines wrote:
>> This patch transfers matchpathcon.c inode evaluation services to
>> selinux_restorecon.c and modifies them to also support setfiles(8)
>> inode services.
>>
>> The overall objective is to modify restorecon(8) and setfiles(8)
>> to use selinux_restorecon(3) services and then, when ready
>> remove the deprecated matchpathcon services from libselinux.
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> ---
>>  libselinux/include/selinux/restorecon.h  |   4 +
>>  libselinux/man/man3/selinux_restorecon.3 |   5 +-
>>  libselinux/src/matchpathcon.c            | 139 +------------
>>  libselinux/src/selinux_restorecon.c      | 333 ++++++++++++++++++++++++++++---
>>  libselinux/utils/selinux_restorecon.c    |  14 +-
>>  5 files changed, 330 insertions(+), 165 deletions(-)
>>
>> diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
>> index ba1232e..0b93b0c 100644
>> --- a/libselinux/include/selinux/restorecon.h
>> +++ b/libselinux/include/selinux/restorecon.h
>> @@ -46,6 +46,10 @@ extern int selinux_restorecon(const char *pathname,
>>  /* Prevent descending into directories that have a different
>>   * device number than the pathname from which the descent began */
>>  #define SELINUX_RESTORECON_XDEV				128
>> +/* Attempt to add an association between an inode and a context.
>> + * If there is a different context that matched the inode,
>> + * then use the first context that matched. */
>> +#define SELINUX_RESTORECON_ADD_ASSOC			256
> 
> IIRC, the (original) behavior in setfiles was to use the higher priority
> entry, i.e. the last matching specification in file_contexts, in the
> case of a conflict.  Not sure if that is still the case.

Latter entries being higher priority would be my expectation in
refpolicy.  That's why we sort entries in order of specificity (least
specific at the top of the file to most specific at the end).

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
