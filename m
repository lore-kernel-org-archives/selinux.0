MIME-Version: 1.0
In-Reply-To: <d9c8be28-2fbe-b22d-aaff-571073781b2e@tycho.nsa.gov>
References: <1498485334.13301.9.camel@tycho.nsa.gov>
 <20180228101510.21023-1-vmojzis@redhat.com>
 <20180228101510.21023-2-vmojzis@redhat.com>
 <d9c8be28-2fbe-b22d-aaff-571073781b2e@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Feb 2018 11:37:17 -0800
Message-ID: <CAFftDdpyqMSLwE0ttpfdC2N_9oUGHD30XqBne-S29Hr8OZ9SNw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Vit Mojzis <vmojzis@redhat.com>, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/3] libsemanage: remove access() check to make
 setuid programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 28, 2018 at 10:26 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 02/28/2018 05:15 AM, Vit Mojzis wrote:
>> F_OK access checks only work properly as long as all directories along
>> the path are accessible to real user running the program.
>> Replace F_OK access checks by testing return value of open, write, etc.
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>> ---
>>  libsemanage/src/direct_api.c | 39 +++++++++++++++------------------------
>>  1 file changed, 15 insertions(+), 24 deletions(-)
>>
>> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
>> index b7899d68..f4d57cf8 100644
>> --- a/libsemanage/src/direct_api.c
>> +++ b/libsemanage/src/direct_api.c
>> @@ -1563,34 +1563,25 @@ rebuild:
>>               goto cleanup;
>>       }
>>
>> -     path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL);
>> -     if (access(path, F_OK) == 0) {
>> -             retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
>> -                                                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
>> -                                                     sh->conf->file_mode);
>> -             if (retval < 0) {
>> -                     goto cleanup;
>> -             }
>> +     retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
>> +                                             semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
>> +                                             sh->conf->file_mode);
>> +     if (retval < 0 && errno != ENOENT) {
>> +             goto cleanup;
>>       }
>>
>> -     path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
>> -     if (access(path, F_OK) == 0) {
>> -             retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
>> -                                                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
>> -                                                     sh->conf->file_mode);
>> -             if (retval < 0) {
>> -                     goto cleanup;
>> -             }
>> +     retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
>> +                                             semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
>> +                                             sh->conf->file_mode);
>> +     if (retval < 0 && errno != ENOENT) {
>> +             goto cleanup;
>>       }
>>
>> -     path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
>> -     if (access(path, F_OK) == 0) {
>> -             retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
>> -                                                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
>> -                                                     sh->conf->file_mode);
>> -             if (retval < 0) {
>> -                     goto cleanup;
>> -             }
>> +     retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
>> +                                             semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
>> +                                             sh->conf->file_mode);
>> +     if (retval < 0 && errno != ENOENT) {
>> +             goto cleanup;
>>       }
>
> I think we need to clear retval here to ensure that we don't later
> misinterpret a negative retval as an error.  Otherwise, if
> disable_genhomedircon && !do_install, we'll fall through to the end of
> the function without ever setting retval again, so the mere absence of a
> seusers file will cause a fatal error from semanage_direct_commit.
>

That's spot on. That is precisely what happens. In the case retval is
-1 and errno IS
ENOENT, retval needs to be set to 0.

Maybe just make a static helper so this way you don't have to even
worry about errno here:

static int copy_file(...) {
   int rc = semanage_copy_file(...);
   return !(rc < 0 && errno != ENOENT);
}

It would make that main code simpler to read and then retval should be
0 on ENOENT case.

>>
>>       /* run genhomedircon if its enabled, this should be the last operation



-- 
Respectfully,

William C Roberts
