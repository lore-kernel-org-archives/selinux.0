Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8T5inIN024224
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 01:44:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id b4so8980800wmb.2
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 22:44:47 -0700 (PDT)
Subject: Re: [PATCH 1/1] libsepol/cil: do not heap-overflow when too many
 permissions are in a class
To: William Roberts <bill.c.roberts@gmail.com>
References: <20160928205708.14686-1-nicolas.iooss@m4x.org>
 <CAFftDdryDVqUhm8YagFQKw5zOXFSjy4GWjPfgCy+NS7zD_Mx0Q@mail.gmail.com>
 <049bd4f3-74d6-f460-b703-8135100f2f33@m4x.org>
 <CAFftDdqsoqPgc9zk8YhcdLEQyGzNd2Q86Fhy6o=WQ5RprtTccQ@mail.gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <c5f03c00-fbad-fe5b-cbb0-330f0fbe7329@m4x.org>
Date: Thu, 29 Sep 2016 07:44:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAFftDdqsoqPgc9zk8YhcdLEQyGzNd2Q86Fhy6o=WQ5RprtTccQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 29/09/16 00:44, William Roberts wrote:
> On Wed, Sep 28, 2016 at 5:34 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>> On 28/09/16 23:06, William Roberts wrote:
>>> On Sep 28, 2016 17:02, "Nicolas Iooss" <nicolas.iooss@m4x.org
>>> <mailto:nicolas.iooss@m4x.org>> wrote:
>>>>
>>>> When compiling a CIL policy with more than 32 items in a class (e.g. in
>>>> (class capability (chown ...)) with many items),
>>>> cil_classorder_to_policydb() overflows perm_value_to_cil[class_index]
>>>> array. As this array is allocated on the heap through
>>>> calloc(PERMS_PER_CLASS+1, sizeof(...)), this makes secilc crash with the
>>>> following message:
>>>>
>>>>     *** Error in `/usr/bin/secilc': double free or corruption (!prev):
>>> 0x000000000062be80 ***
>>>>     ======= Backtrace: =========
>>>>     /usr/lib/libc.so.6(+0x70c4b)[0x7ffff76a7c4b]
>>>>     /usr/lib/libc.so.6(+0x76fe6)[0x7ffff76adfe6]
>>>>     /usr/lib/libc.so.6(+0x777de)[0x7ffff76ae7de]
>>>>     /lib/libsepol.so.1(+0x14fbda)[0x7ffff7b24bda]
>>>>     /lib/libsepol.so.1(+0x152db8)[0x7ffff7b27db8]
>>>>     /lib/libsepol.so.1(cil_build_policydb+0x63)[0x7ffff7af8723]
>>>>     /usr/bin/secilc[0x40273b]
>>>>     /usr/lib/libc.so.6(__libc_start_main+0xf1)[0x7ffff7657291]
>>>>     /usr/bin/secilc[0x402f7a]
>>>>
>>>> Fix this by detecting the overflow before adding new permissions to a
>>>> class.
>>>>
>>>> This bug has been found by fuzzing secilc with american fuzzy lop.
>>>>
>>>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org
>>> <mailto:nicolas.iooss@m4x.org>>
>>>> ---
>>>>  libsepol/cil/src/cil_binary.c | 15 +++++++++++++--
>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
>>>> index cc73648ad1b7..d3b3e90df45b 100644
>>>> --- a/libsepol/cil/src/cil_binary.c
>>>> +++ b/libsepol/cil/src/cil_binary.c
>>>> @@ -332,6 +332,11 @@ int cil_classorder_to_policydb(policydb_t *pdb,
>>> const struct cil_db *db, struct
>>>>                                         goto exit;
>>>>                                 }
>>>>                         }
>>>> +                       if (sepol_class->permissions.nprim +
>>> sepol_common->permissions.nprim > PERMS_PER_CLASS) {
>>>> +                               cil_log(CIL_ERR, "Too many permissions
>>> in class '%s'\n", cil_class->datum.fqn);
>>>> +                               rc = SEPOL_ERR;
>>>> +                               goto exit;
>>>> +                       }
>>>>                         sepol_class->comdatum = sepol_common;
>>>>                         sepol_class->comkey = cil_strdup(key);
>>>>                         sepol_class->permissions.nprim +=
>>> sepol_common->permissions.nprim;
>>>> @@ -344,9 +349,15 @@ int cil_classorder_to_policydb(policydb_t *pdb,
>>> const struct cil_db *db, struct
>>>>
>>>>                 for (curr = NODE(cil_class)->cl_head; curr; curr =
>>> curr->next) {
>>>>                         struct cil_perm *cil_perm = curr->data;
>>>> -                       perm_datum_t *sepol_perm =
>>> cil_malloc(sizeof(*sepol_perm));
>>>> -                       memset(sepol_perm, 0, sizeof(perm_datum_t));
>>>> +                       perm_datum_t *sepol_perm;
>>>>
>>>> +                       if (sepol_class->permissions.nprim + 1 >
>>> PERMS_PER_CLASS)
>>>
>>> Is nprim input data? This could overflow here and be 0 right? You
>>> probably want to check if nprim is saturated assuming unsigned.
>>
>> I mostly read the code of cil_classorder_to_policydb() in the way it is
>> used in secilc: ...permissions.nprim is both the length of an array of
>> perm_value_to_cil[] (off one) and the length of a linked list of CIL
>> nodes. Therefore I did not consider the possibility of the addition to
>> overflow here, and afterwards I still fail to see how it could overflow.
>>
>> In case you want to reproduce the bug, please find attached the source
>> file I used (it is secilc/test/minimum.cil with 33 permissions defined
>> in the first class).
>>
> 
> Its that both additions in that file, and the nprim++ statements are
> ripe for overflows.
> 
> All those additions occur based on the inputs from source code.
> So, if you defined (uint32_t)~0 amount of classes, you should
> be able to hit an overflow. nprim itself is a uint32_t.

After a good night sleep I see now "rc =
symtab_init(&sepol_class->permissions, PERM_SYMTAB_SIZE);" in
cil_classorder_to_policydb(). This statement initializes
sepol_class->permissions.nprim with 0. Later nprim is incremented both
with sepol_common->permissions.nprim (which should be <= 32 and I will
add a check for this) and one. If I define (uint32_t)~0 permissions in a
CIL class object, I hit the if() when it crosses 32.

Is there a way to make nprim equals to a value which would overflow that
I am missing?

-- Nicolas
