To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
References: <20180307150538.14932-1-jwcart2@tycho.nsa.gov>
 <CAJfZ7==7G4YhJeYuVtq=yVseKecVjSPOZ1Z5htsi_cdshb+N_A@mail.gmail.com>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <3e657580-6267-cb07-9ebe-45cc45b27181@tycho.nsa.gov>
Date: Mon, 19 Mar 2018 12:41:02 -0400
MIME-Version: 1.0
In-Reply-To: <CAJfZ7==7G4YhJeYuVtq=yVseKecVjSPOZ1Z5htsi_cdshb+N_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re:  Re: [PATCH] libsepol: Prevent freeing
 unitialized value in ibendport handling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/08/2018 04:34 PM, Nicolas Iooss wrote:
> On Wed, Mar 7, 2018 at 4:05 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:
>> Nicolas Iooss reports:
>> In sepol_ibendport_key_create(), if sepol_ibendport_alloc_ibdev_name()
>> fails to allocate tmp_key->ibdev_name, sepol_ibendport_key_free() is
>> called to free the memory associated with tmp_key, which results in
>> free() being called on uninitialized tmp_key->ibdev_name.
>>
>> This issue is reported by clang's static analyzer with the following
>> message:
>>
>>      ibendport_record.c:115:2: warning: 1st function call argument is an
>>      uninitialized value
>>              free(key->ibdev_name);
>>              ^~~~~~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>   libsepol/src/ibendport_record.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/libsepol/src/ibendport_record.c b/libsepol/src/ibendport_record.c
>> index 912aeb53..bc56f090 100644
>> --- a/libsepol/src/ibendport_record.c
>> +++ b/libsepol/src/ibendport_record.c
>> @@ -32,14 +32,11 @@ struct sepol_ibendport_key {
>>   int sepol_ibendport_alloc_ibdev_name(sepol_handle_t *handle,
>>                                       char **ibdev_name)
>>   {
>> -       char *tmp_ibdev_name = NULL;
>> -
>> -       tmp_ibdev_name = calloc(1, IB_DEVICE_NAME_MAX);
>> +       *ibdev_name = calloc(1, IB_DEVICE_NAME_MAX);
>>
>> -       if (!tmp_ibdev_name)
>> +       if (!*ibdev_name)
>>                  goto omem;
>>
>> -       *ibdev_name = tmp_ibdev_name;
>>          return STATUS_SUCCESS;
>>
>>   omem:
>> --
>> 2.13.6
>>
> 
> This patch looks good to me and I confirm clang's static analyzer no
> longer reports the issue I had.
> 
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> 
> Thanks,
> Nicolas
> 
> 
> 
This has been applied.

Jim


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
