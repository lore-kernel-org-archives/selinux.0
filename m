Subject: Re: [PATCH 2/2] libsepol: port str_read from kernel
To: William Roberts <bill.c.roberts@gmail.com>
References: <1471553689-14551-1-git-send-email-william.c.roberts@intel.com>
 <1471553689-14551-2-git-send-email-william.c.roberts@intel.com>
 <566e5aed-5e18-db1a-eb20-dce5694b67fc@tycho.nsa.gov>
 <CAFftDdoAHwVPyrCQXJ97vzcAYC3WNkDJNpy3DP0W2FkW8mTmMQ@mail.gmail.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8ec65984-0d79-342a-775f-98fe30606329@tycho.nsa.gov>
Date: Fri, 19 Aug 2016 11:26:01 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdoAHwVPyrCQXJ97vzcAYC3WNkDJNpy3DP0W2FkW8mTmMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/19/2016 10:54 AM, William Roberts wrote:
> On Aug 19, 2016 06:12, "Stephen Smalley" <sds@tycho.nsa.gov
> <mailto:sds@tycho.nsa.gov>> wrote:
>>
>> On 08/18/2016 04:54 PM, william.c.roberts@intel.com
> <mailto:william.c.roberts@intel.com> wrote:
>> > From: William Roberts <william.c.roberts@intel.com
> <mailto:william.c.roberts@intel.com>>
>> >
>> > Rather than duplicating the following sequence:
>> > 1. Read len from file
>> > 2. alloc up space based on 1
>> > 3. read the contents into the buffer from 2
>> > 4. null terminate the buffer from 2
>> >
>> > Use the str_read() function that is in the kernel, which
>> > collapses steps 2 and 4. This not only reduces redundant
>> > code, but also has the side-affect of providing a central
>> > check on zero_or_saturated lengths from step 1 when
>> > generating string values.
>> >
>> > Signed-off-by: William Roberts <william.c.roberts@intel.com
> <mailto:william.c.roberts@intel.com>>
>> > ---
>> >  libsepol/src/conditional.c |  9 +------
>> >  libsepol/src/module.c      | 66
> ++++++++++++++++++++++------------------------
>> >  libsepol/src/policydb.c    | 10 +------
>> >  libsepol/src/private.h     |  1 +
>> >  libsepol/src/services.c    | 33 +++++++++++++++++++++++
>> >  5 files changed, 68 insertions(+), 51 deletions(-)
>> >
>> > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
>> > index 8680eb2..e1bc961 100644
>> > --- a/libsepol/src/conditional.c
>> > +++ b/libsepol/src/conditional.c
>> > @@ -589,15 +589,8 @@ int cond_read_bool(policydb_t * p,
>> >               goto err;
>> >
>> >       len = le32_to_cpu(buf[2]);
>> > -     if (zero_or_saturated(len))
>> > +     if (str_read(&key, fp, len))
>> >               goto err;
>> > -     key = malloc(len + 1);
>> > -     if (!key)
>> > -             goto err;
>> > -     rc = next_entry(key, fp, len);
>> > -     if (rc < 0)
>> > -             goto err;
>> > -     key[len] = 0;
>> >
>> >       if (p->policy_type != POLICY_KERN &&
>> >           p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
>> > diff --git a/libsepol/src/module.c b/libsepol/src/module.c
>> > index f25df95..a9d7c54 100644
>> > --- a/libsepol/src/module.c
>> > +++ b/libsepol/src/module.c
>> > @@ -793,26 +793,26 @@ int sepol_module_package_info(struct
> sepol_policy_file *spf, int *type,
>> >                                   i);
>> >                               goto cleanup;
>> >                       }
>> > +
>> >                       len = le32_to_cpu(buf[0]);
>> > -                     if (zero_or_saturated(len)) {
>> > -                             ERR(file->handle,
>> > -                                 "invalid module name length:
> 0x%"PRIx32,
>> > -                                 len);
>> > -                             goto cleanup;
>> > -                     }
>> > -                     *name = malloc(len + 1);
>> > -                     if (!*name) {
>> > -                             ERR(file->handle, "out of memory");
>> > -                             goto cleanup;
>> > -                     }
>> > -                     rc = next_entry(*name, file, len);
>> > -                     if (rc < 0) {
>> > -                             ERR(file->handle,
>> > -                                 "cannot get module name string (at
> section %u)",
>> > -                                 i);
>> > +                     if (str_read(name, file, len)) {
>> > +                             switch(rc) {
>> > +                             case EINVAL:
>> > +                                     ERR(file->handle,
>> > +                                             "invalid module name
> length: 0x%"PRIx32,
>> > +                                             len);
>> > +                                     break;
>> > +                             case ENOMEM:
>> > +                                     ERR(file->handle, "out of
> memory");
>> > +                                     break;
>> > +                             default:
>> > +                                     ERR(file->handle,
>> > +                                             "cannot get module
> name string (at section %u)",
>> > +                                             i);
>> > +                             }
>>
>> 1) You didn't set rc = str_read(), so you can't switch on it above.
> 
> It's a new gnuc extension ;-p
> 
>> 2) Using positive values for errors is likely to confuse matters when
>> interacting with the existing code, which always uses negative values
>> (either -errno as a legacy of common code with the kernel or -1).
>> 3) I think this overcomplicates the error handling / reporting.  If
>> str_read() were to set errno and return -1 instead, then you could just
>> include strerror(errno) in a single error message.  Or you can just
>> always report the most general error message.  But it isn't worth a
>> switch statement.
> 
> Yeah I had all those thoughts, wasn't sure the best way considering the
> conflict on -1 vs -errno. If you're OK with setting errno let's use that.

Yes, setting errno is fine with me.  Not even necessary if the malloc fails.
