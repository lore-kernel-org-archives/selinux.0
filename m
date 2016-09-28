Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SLYwFo010588
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 17:34:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id b184so7843844wma.3
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 14:34:56 -0700 (PDT)
Subject: Re: [PATCH 1/1] libsepol/cil: do not heap-overflow when too many
 permissions are in a class
To: William Roberts <bill.c.roberts@gmail.com>
References: <20160928205708.14686-1-nicolas.iooss@m4x.org>
 <CAFftDdryDVqUhm8YagFQKw5zOXFSjy4GWjPfgCy+NS7zD_Mx0Q@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <049bd4f3-74d6-f460-b703-8135100f2f33@m4x.org>
Date: Wed, 28 Sep 2016 23:34:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAFftDdryDVqUhm8YagFQKw5zOXFSjy4GWjPfgCy+NS7zD_Mx0Q@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------06EA56775641B10785893436"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------06EA56775641B10785893436
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 28/09/16 23:06, William Roberts wrote:
> On Sep 28, 2016 17:02, "Nicolas Iooss" <nicolas.iooss@m4x.org
> <mailto:nicolas.iooss@m4x.org>> wrote:
>>
>> When compiling a CIL policy with more than 32 items in a class (e.g. in
>> (class capability (chown ...)) with many items),
>> cil_classorder_to_policydb() overflows perm_value_to_cil[class_index]
>> array. As this array is allocated on the heap through
>> calloc(PERMS_PER_CLASS+1, sizeof(...)), this makes secilc crash with the
>> following message:
>>
>>     *** Error in `/usr/bin/secilc': double free or corruption (!prev):
> 0x000000000062be80 ***
>>     ======= Backtrace: =========
>>     /usr/lib/libc.so.6(+0x70c4b)[0x7ffff76a7c4b]
>>     /usr/lib/libc.so.6(+0x76fe6)[0x7ffff76adfe6]
>>     /usr/lib/libc.so.6(+0x777de)[0x7ffff76ae7de]
>>     /lib/libsepol.so.1(+0x14fbda)[0x7ffff7b24bda]
>>     /lib/libsepol.so.1(+0x152db8)[0x7ffff7b27db8]
>>     /lib/libsepol.so.1(cil_build_policydb+0x63)[0x7ffff7af8723]
>>     /usr/bin/secilc[0x40273b]
>>     /usr/lib/libc.so.6(__libc_start_main+0xf1)[0x7ffff7657291]
>>     /usr/bin/secilc[0x402f7a]
>>
>> Fix this by detecting the overflow before adding new permissions to a
>> class.
>>
>> This bug has been found by fuzzing secilc with american fuzzy lop.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org
> <mailto:nicolas.iooss@m4x.org>>
>> ---
>>  libsepol/cil/src/cil_binary.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
>> index cc73648ad1b7..d3b3e90df45b 100644
>> --- a/libsepol/cil/src/cil_binary.c
>> +++ b/libsepol/cil/src/cil_binary.c
>> @@ -332,6 +332,11 @@ int cil_classorder_to_policydb(policydb_t *pdb,
> const struct cil_db *db, struct
>>                                         goto exit;
>>                                 }
>>                         }
>> +                       if (sepol_class->permissions.nprim +
> sepol_common->permissions.nprim > PERMS_PER_CLASS) {
>> +                               cil_log(CIL_ERR, "Too many permissions
> in class '%s'\n", cil_class->datum.fqn);
>> +                               rc = SEPOL_ERR;
>> +                               goto exit;
>> +                       }
>>                         sepol_class->comdatum = sepol_common;
>>                         sepol_class->comkey = cil_strdup(key);
>>                         sepol_class->permissions.nprim +=
> sepol_common->permissions.nprim;
>> @@ -344,9 +349,15 @@ int cil_classorder_to_policydb(policydb_t *pdb,
> const struct cil_db *db, struct
>>
>>                 for (curr = NODE(cil_class)->cl_head; curr; curr =
> curr->next) {
>>                         struct cil_perm *cil_perm = curr->data;
>> -                       perm_datum_t *sepol_perm =
> cil_malloc(sizeof(*sepol_perm));
>> -                       memset(sepol_perm, 0, sizeof(perm_datum_t));
>> +                       perm_datum_t *sepol_perm;
>>
>> +                       if (sepol_class->permissions.nprim + 1 >
> PERMS_PER_CLASS)
> 
> Is nprim input data? This could overflow here and be 0 right? You
> probably want to check if nprim is saturated assuming unsigned.

I mostly read the code of cil_classorder_to_policydb() in the way it is
used in secilc: ...permissions.nprim is both the length of an array of
perm_value_to_cil[] (off one) and the length of a linked list of CIL
nodes. Therefore I did not consider the possibility of the addition to
overflow here, and afterwards I still fail to see how it could overflow.

In case you want to reproduce the bug, please find attached the source
file I used (it is secilc/test/minimum.cil with 33 permissions defined
in the first class).

Nicolas

--------------06EA56775641B10785893436
Content-Type: text/x-selinux-cil;
 name="overflow.cil"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="overflow.cil"

(class CLASS (PERM p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 p31 p32 p33))
(classorder (CLASS))
(sid SID)
(sidorder (SID))
(user USER)
(role ROLE)
(type TYPE)
(category CAT)
(categoryorder (CAT))
(sensitivity SENS)
(sensitivityorder (SENS))
(sensitivitycategory SENS (CAT))
(allow TYPE self (CLASS (PERM)))
(roletype ROLE TYPE)
(userrole USER ROLE)
(userlevel USER (SENS))
(userrange USER ((SENS)(SENS (CAT))))
(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

--------------06EA56775641B10785893436--
