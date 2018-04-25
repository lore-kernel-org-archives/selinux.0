MIME-Version: 1.0
In-Reply-To: <CAFftDdoQh=fOKjtkVHUVV-TBafdfNWpWKBwonpaZ8x3g2QbfdA@mail.gmail.com>
References: <20180420141754.30272-1-sds@tycho.nsa.gov>
 <CAFftDdoQh=fOKjtkVHUVV-TBafdfNWpWKBwonpaZ8x3g2QbfdA@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 25 Apr 2018 09:14:02 -0700
Message-ID: <CAFftDdoVoR1xVLu3-qOoxqeLAMQ=1nkcA1xZuR_N-VdAM7Dyog@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] Revert "libselinux: verify file_contexts when
 using restorecon"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Apr 23, 2018 at 9:55 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Fri, Apr 20, 2018 at 7:17 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> This reverts commit 814631d3aebaa041073a42c677c1ed62ce7830d5.
>> As reported by Petr Lautrbach, this commit changed the behavior
>> of selabel_open() when SELABEL_OPT_VALIDATE is 0, and this would
>> be an API change.
>>
>> Reported-by: Petr Lautrbach <plautrba@redhat.com>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>  libselinux/src/label.c                  | 7 ++++---
>>  libselinux/src/label_backends_android.c | 2 +-
>>  libselinux/src/label_file.c             | 2 +-
>>  libselinux/src/label_file.h             | 2 +-
>>  libselinux/src/label_internal.h         | 6 ++++--
>>  libselinux/src/matchpathcon.c           | 5 +++--
>>  6 files changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
>> index 591815a7..8d586bda 100644
>> --- a/libselinux/src/label.c
>> +++ b/libselinux/src/label.c
>> @@ -121,11 +121,12 @@ static inline int selabel_is_validate_set(const struct selinux_opt *opts,
>>         return 0;
>>  }
>>
>> -int selabel_validate(struct selabel_lookup_rec *contexts)
>> +int selabel_validate(struct selabel_handle *rec,
>> +                    struct selabel_lookup_rec *contexts)
>>  {
>>         int rc = 0;
>>
>> -       if (contexts->validated)
>> +       if (!rec->validating || contexts->validated)
>>                 goto out;
>>
>>         rc = selinux_validate(&contexts->ctx_raw);
>> @@ -142,7 +143,7 @@ static int selabel_fini(struct selabel_handle *rec,
>>                             struct selabel_lookup_rec *lr,
>>                             int translating)
>>  {
>> -       if (compat_validate(lr, rec->spec_file, lr->lineno))
>> +       if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
>>                 return -1;
>>
>>         if (translating && !lr->ctx_trans &&
>> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
>> index 49e39ec8..cb8aae26 100644
>> --- a/libselinux/src/label_backends_android.c
>> +++ b/libselinux/src/label_backends_android.c
>> @@ -122,7 +122,7 @@ static int process_line(struct selabel_handle *rec,
>>                 spec_arr[nspec].lr.ctx_raw = context;
>>
>>                 if (rec->validating) {
>> -                       if (selabel_validate(&spec_arr[nspec].lr) < 0) {
>> +                       if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
>>                                 selinux_log(SELINUX_ERROR,
>>                                             "%s:  line %u has invalid context %s\n",
>>                                             path, lineno, spec_arr[nspec].lr.ctx_raw);
>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>> index 169fed70..560d8c3d 100644
>> --- a/libselinux/src/label_file.c
>> +++ b/libselinux/src/label_file.c
>> @@ -328,7 +328,7 @@ end_arch_check:
>>                 spec->lr.ctx_raw = str_buf;
>>
>>                 if (strcmp(spec->lr.ctx_raw, "<<none>>") && rec->validating) {
>> -                       if (selabel_validate(&spec->lr) < 0) {
>> +                       if (selabel_validate(rec, &spec->lr) < 0) {
>>                                 selinux_log(SELINUX_ERROR,
>>                                             "%s: context %s is invalid\n",
>>                                             path, spec->lr.ctx_raw);
>> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
>> index 1ab139e9..2fa85474 100644
>> --- a/libselinux/src/label_file.h
>> +++ b/libselinux/src/label_file.h
>> @@ -509,7 +509,7 @@ static inline int process_line(struct selabel_handle *rec,
>>         spec_hasMetaChars(&spec_arr[nspec]);
>>
>>         if (strcmp(context, "<<none>>") && rec->validating)
>> -               return compat_validate(&spec_arr[nspec].lr, path, lineno);
>> +               return compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
>>
>>         return 0;
>>  }
>> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
>> index b0d05882..0e020557 100644
>> --- a/libselinux/src/label_internal.h
>> +++ b/libselinux/src/label_internal.h
>> @@ -112,7 +112,8 @@ struct selabel_handle {
>>   * Validation function
>>   */
>>  extern int
>> -selabel_validate(struct selabel_lookup_rec *contexts) hidden;
>> +selabel_validate(struct selabel_handle *rec,
>> +                struct selabel_lookup_rec *contexts) hidden;
>>
>>  /*
>>   * Compatibility support
>> @@ -127,7 +128,8 @@ extern void __attribute__ ((format(printf, 1, 2)))
>>                 selinux_log(type, fmt);
>>
>>  extern int
>> -compat_validate(struct selabel_lookup_rec *contexts,
>> +compat_validate(struct selabel_handle *rec,
>> +               struct selabel_lookup_rec *contexts,
>>                 const char *path, unsigned lineno) hidden;
>>
>>  /*
>> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
>> index c66739af..58b4144a 100644
>> --- a/libselinux/src/matchpathcon.c
>> +++ b/libselinux/src/matchpathcon.c
>> @@ -35,7 +35,8 @@ void set_matchpathcon_printf(void (*f) (const char *fmt, ...))
>>         myprintf_compat = 1;
>>  }
>>
>> -int compat_validate(struct selabel_lookup_rec *contexts,
>> +int compat_validate(struct selabel_handle *rec,
>> +                   struct selabel_lookup_rec *contexts,
>>                     const char *path, unsigned lineno)
>>  {
>>         int rc;
>> @@ -46,7 +47,7 @@ int compat_validate(struct selabel_lookup_rec *contexts,
>>         else if (mycanoncon)
>>                 rc = mycanoncon(path, lineno, ctx);
>>         else {
>> -               rc = selabel_validate(contexts);
>> +               rc = selabel_validate(rec, contexts);
>>                 if (rc < 0) {
>>                         if (lineno) {
>>                                 COMPAT_LOG(SELINUX_WARNING,
>> --
>> 2.14.3
>>
>
> Sorry for the delay, yes this does indeed break the behavior of the
> open flags and needs to be reverted.

FYI: this was merged:
https://github.com/SELinuxProject/selinux/commit/87a58b6b4ebf88da78bf1386c36d8d982ca41525
