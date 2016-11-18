Subject: Re: [PATCH 0/2] Add the ability to write policy.conf file from CIL AST
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1479492328-12238-1-git-send-email-jwcart2@tycho.nsa.gov>
 <21dbe2db-8048-d166-d628-dca9fcd34be3@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <8d036b45-a516-5ea2-351a-39537ab8b771@tycho.nsa.gov>
Date: Fri, 18 Nov 2016 13:28:44 -0500
MIME-Version: 1.0
In-Reply-To: <21dbe2db-8048-d166-d628-dca9fcd34be3@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/18/2016 01:26 PM, Stephen Smalley wrote:
> On 11/18/2016 01:05 PM, James Carter wrote:
>> The first patch adds the cil_gen_policy() function to libsepol and the second
>> patch adds the cil2conf program to policycoreutils.
>>
>> I am open to a different name and/or location for cil2conf.
>
> Maybe add it to secilc (no need for a separate subdir, just add it to
> the secilc Makefile), and rename it to secil2conf?  It isn't needed for
> a production system in general, so doesn't really fit into
> policycoreutils, and seems like the inverse of secilc (analogous to
> dismod/dispol in checkpolicy).
>

That sounds like a good idea. I originally had just added a flag to secilc, but 
that made secilc more complex. I had not considered just keeping the new program 
with secilc.

Jim

>>
>> James Carter (2):
>>   libsepol/cil: Add ability to write policy.conf file from CIL AST
>>   policycoreutils: Add cil2conf which creates a policy.conf from CIL
>>     policy
>>
>>  libsepol/cil/include/cil/cil.h      |    1 +
>>  libsepol/cil/src/cil.c              |    6 +
>>  libsepol/cil/src/cil_policy.c       | 2696 +++++++++++++++++++++--------------
>>  libsepol/cil/src/cil_policy.h       |   12 +-
>>  libsepol/src/libsepol.map.in        |    1 +
>>  policycoreutils/Makefile            |    2 +-
>>  policycoreutils/cil2conf/Makefile   |   33 +
>>  policycoreutils/cil2conf/cil2conf.c |  192 +++
>>  8 files changed, 1837 insertions(+), 1106 deletions(-)
>>  create mode 100644 policycoreutils/cil2conf/Makefile
>>  create mode 100644 policycoreutils/cil2conf/cil2conf.c
>>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
