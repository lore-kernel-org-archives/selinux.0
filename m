MIME-Version: 1.0
In-Reply-To: <566e5aed-5e18-db1a-eb20-dce5694b67fc@tycho.nsa.gov>
References: <1471553689-14551-1-git-send-email-william.c.roberts@intel.com>
 <1471553689-14551-2-git-send-email-william.c.roberts@intel.com>
 <566e5aed-5e18-db1a-eb20-dce5694b67fc@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 19 Aug 2016 07:54:35 -0700
Message-ID: <CAFftDdoAHwVPyrCQXJ97vzcAYC3WNkDJNpy3DP0W2FkW8mTmMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: port str_read from kernel
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c05aa2a838a86053a6de0cd
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c05aa2a838a86053a6de0cd
Content-Type: text/plain; charset=UTF-8

On Aug 19, 2016 06:12, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 08/18/2016 04:54 PM, william.c.roberts@intel.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Rather than duplicating the following sequence:
> > 1. Read len from file
> > 2. alloc up space based on 1
> > 3. read the contents into the buffer from 2
> > 4. null terminate the buffer from 2
> >
> > Use the str_read() function that is in the kernel, which
> > collapses steps 2 and 4. This not only reduces redundant
> > code, but also has the side-affect of providing a central
> > check on zero_or_saturated lengths from step 1 when
> > generating string values.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libsepol/src/conditional.c |  9 +------
> >  libsepol/src/module.c      | 66
++++++++++++++++++++++------------------------
> >  libsepol/src/policydb.c    | 10 +------
> >  libsepol/src/private.h     |  1 +
> >  libsepol/src/services.c    | 33 +++++++++++++++++++++++
> >  5 files changed, 68 insertions(+), 51 deletions(-)
> >
> > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> > index 8680eb2..e1bc961 100644
> > --- a/libsepol/src/conditional.c
> > +++ b/libsepol/src/conditional.c
> > @@ -589,15 +589,8 @@ int cond_read_bool(policydb_t * p,
> >               goto err;
> >
> >       len = le32_to_cpu(buf[2]);
> > -     if (zero_or_saturated(len))
> > +     if (str_read(&key, fp, len))
> >               goto err;
> > -     key = malloc(len + 1);
> > -     if (!key)
> > -             goto err;
> > -     rc = next_entry(key, fp, len);
> > -     if (rc < 0)
> > -             goto err;
> > -     key[len] = 0;
> >
> >       if (p->policy_type != POLICY_KERN &&
> >           p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
> > diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> > index f25df95..a9d7c54 100644
> > --- a/libsepol/src/module.c
> > +++ b/libsepol/src/module.c
> > @@ -793,26 +793,26 @@ int sepol_module_package_info(struct
sepol_policy_file *spf, int *type,
> >                                   i);
> >                               goto cleanup;
> >                       }
> > +
> >                       len = le32_to_cpu(buf[0]);
> > -                     if (zero_or_saturated(len)) {
> > -                             ERR(file->handle,
> > -                                 "invalid module name length:
0x%"PRIx32,
> > -                                 len);
> > -                             goto cleanup;
> > -                     }
> > -                     *name = malloc(len + 1);
> > -                     if (!*name) {
> > -                             ERR(file->handle, "out of memory");
> > -                             goto cleanup;
> > -                     }
> > -                     rc = next_entry(*name, file, len);
> > -                     if (rc < 0) {
> > -                             ERR(file->handle,
> > -                                 "cannot get module name string (at
section %u)",
> > -                                 i);
> > +                     if (str_read(name, file, len)) {
> > +                             switch(rc) {
> > +                             case EINVAL:
> > +                                     ERR(file->handle,
> > +                                             "invalid module name
length: 0x%"PRIx32,
> > +                                             len);
> > +                                     break;
> > +                             case ENOMEM:
> > +                                     ERR(file->handle, "out of
memory");
> > +                                     break;
> > +                             default:
> > +                                     ERR(file->handle,
> > +                                             "cannot get module name
string (at section %u)",
> > +                                             i);
> > +                             }
>
> 1) You didn't set rc = str_read(), so you can't switch on it above.

It's a new gnuc extension ;-p

> 2) Using positive values for errors is likely to confuse matters when
> interacting with the existing code, which always uses negative values
> (either -errno as a legacy of common code with the kernel or -1).
> 3) I think this overcomplicates the error handling / reporting.  If
> str_read() were to set errno and return -1 instead, then you could just
> include strerror(errno) in a single error message.  Or you can just
> always report the most general error message.  But it isn't worth a
> switch statement.

Yeah I had all those thoughts, wasn't sure the best way considering the
conflict on -1 vs -errno. If you're OK with setting errno let's use that.

>
> Same applies throughout.
>
> >                               goto cleanup;
> >                       }
> > -                     (*name)[len] = '\0';
> > +
> >                       rc = next_entry(buf, file, sizeof(uint32_t));
> >                       if (rc < 0) {
> >                               ERR(file->handle,
> > @@ -821,25 +821,23 @@ int sepol_module_package_info(struct
sepol_policy_file *spf, int *type,
> >                               goto cleanup;
> >                       }
> >                       len = le32_to_cpu(buf[0]);
> > -                     if (zero_or_saturated(len)) {
> > -                             ERR(file->handle,
> > -                                 "invalid module version length:
0x%"PRIx32,
> > -                                 len);
> > -                             goto cleanup;
> > -                     }
> > -                     *version = malloc(len + 1);
> > -                     if (!*version) {
> > -                             ERR(file->handle, "out of memory");
> > -                             goto cleanup;
> > -                     }
> > -                     rc = next_entry(*version, file, len);
> > -                     if (rc < 0) {
> > -                             ERR(file->handle,
> > -                                 "cannot get module version string (at
section %u)",
> > -                                 i);
> > +                     if (str_read(version, file, len)) {
> > +                             switch(rc) {
> > +                             case EINVAL:
> > +                                     ERR(file->handle,
> > +                                             "invalid module name
length: 0x%"PRIx32,
> > +                                             len);
> > +                                     break;
> > +                             case ENOMEM:
> > +                                     ERR(file->handle, "out of
memory");
> > +                                     break;
> > +                             default:
> > +                                     ERR(file->handle,
> > +                                             "cannot get module
version string (at section %u)",
> > +                                             i);
> > +                             }
> >                               goto cleanup;
> >                       }
> > -                     (*version)[len] = '\0';
> >                       seen |= SEEN_MOD;
> >                       break;
> >               default:
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index 5f888d3..cdb3cde 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -1911,19 +1911,11 @@ static int perm_read(policydb_t * p
> >               goto bad;
> >
> >       len = le32_to_cpu(buf[0]);
> > -     if (zero_or_saturated(len))
> > +     if(str_read(&key, fp, len))
> >               goto bad;
> >
> >       perdatum->s.value = le32_to_cpu(buf[1]);
> >
> > -     key = malloc(len + 1);
> > -     if (!key)
> > -             goto bad;
> > -     rc = next_entry(key, fp, len);
> > -     if (rc < 0)
> > -             goto bad;
> > -     key[len] = 0;
> > -
> >       if (hashtab_insert(h, key, perdatum))
> >               goto bad;
> >
> > diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> > index 0beb4d4..b884c23 100644
> > --- a/libsepol/src/private.h
> > +++ b/libsepol/src/private.h
> > @@ -65,3 +65,4 @@ extern struct policydb_compat_info
*policydb_lookup_compat(unsigned int version,
> >  extern int next_entry(void *buf, struct policy_file *fp, size_t bytes)
hidden;
> >  extern size_t put_entry(const void *ptr, size_t size, size_t n,
> >                       struct policy_file *fp) hidden;
> > +extern int str_read(char **strp, struct policy_file *fp, size_t len)
hidden;
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index d2b80b4..f61f692 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -1679,6 +1679,39 @@ size_t hidden put_entry(const void *ptr, size_t
size, size_t n,
> >  }
> >
> >  /*
> > + * Reads a string and null terminates it from the policy file.
> > + * This is a port of str_read from the SE Linux kernel code.
> > + *
> > + * It returns:
> > + *   0 - Success
> > + *   EINVAL - len is no good
> > + *   ENOMEM - allocation failed
> > + *   or any error possible from next_entry().
> > + */
> > +int hidden str_read(char **strp, struct policy_file *fp, size_t len)
> > +{
> > +     int rc;
> > +     char *str;
> > +
> > +     if (zero_or_saturated(len))
> > +             return EINVAL;
> > +
> > +     str = malloc(len + 1);
> > +     if (!str)
> > +             return ENOMEM;
> > +
> > +     /* it's expected the caller should free the str */
> > +     *strp = str;
> > +
> > +     rc = next_entry(str, fp, len);
> > +     if (rc)
> > +             return rc;
> > +
> > +     str[len] = '\0';
> > +     return 0;
> > +}
> > +
> > +/*
> >   * Read a new set of configuration data from
> >   * a policy database binary representation file.
> >   *
> >
>
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Seandroid-list-request@tycho.nsa.gov.

--94eb2c05aa2a838a86053a6de0cd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PHAgZGlyPSJsdHIiPjwvcD4NCjxwIGRpcj0ibHRyIj5PbiBBdWcgMTksIDIwMTYgMDY6MTIsICZx
dW90O1N0ZXBoZW4gU21hbGxleSZxdW90OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnNkc0B0eWNoby5u
c2EuZ292Ij5zZHNAdHljaG8ubnNhLmdvdjwvYT4mZ3Q7IHdyb3RlOjxicj4NCiZndDs8YnI+DQom
Z3Q7IE9uIDA4LzE4LzIwMTYgMDQ6NTQgUE0sIDxhIGhyZWY9Im1haWx0bzp3aWxsaWFtLmMucm9i
ZXJ0c0BpbnRlbC5jb20iPndpbGxpYW0uYy5yb2JlcnRzQGludGVsLmNvbTwvYT4gd3JvdGU6PGJy
Pg0KJmd0OyAmZ3Q7IEZyb206IFdpbGxpYW0gUm9iZXJ0cyAmbHQ7PGEgaHJlZj0ibWFpbHRvOndp
bGxpYW0uYy5yb2JlcnRzQGludGVsLmNvbSI+d2lsbGlhbS5jLnJvYmVydHNAaW50ZWwuY29tPC9h
PiZndDs8YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgUmF0aGVyIHRoYW4gZHVwbGljYXRp
bmcgdGhlIGZvbGxvd2luZyBzZXF1ZW5jZTo8YnI+DQomZ3Q7ICZndDsgMS4gUmVhZCBsZW4gZnJv
bSBmaWxlPGJyPg0KJmd0OyAmZ3Q7IDIuIGFsbG9jIHVwIHNwYWNlIGJhc2VkIG9uIDE8YnI+DQom
Z3Q7ICZndDsgMy4gcmVhZCB0aGUgY29udGVudHMgaW50byB0aGUgYnVmZmVyIGZyb20gMjxicj4N
CiZndDsgJmd0OyA0LiBudWxsIHRlcm1pbmF0ZSB0aGUgYnVmZmVyIGZyb20gMjxicj4NCiZndDsg
Jmd0Ozxicj4NCiZndDsgJmd0OyBVc2UgdGhlIHN0cl9yZWFkKCkgZnVuY3Rpb24gdGhhdCBpcyBp
biB0aGUga2VybmVsLCB3aGljaDxicj4NCiZndDsgJmd0OyBjb2xsYXBzZXMgc3RlcHMgMiBhbmQg
NC4gVGhpcyBub3Qgb25seSByZWR1Y2VzIHJlZHVuZGFudDxicj4NCiZndDsgJmd0OyBjb2RlLCBi
dXQgYWxzbyBoYXMgdGhlIHNpZGUtYWZmZWN0IG9mIHByb3ZpZGluZyBhIGNlbnRyYWw8YnI+DQom
Z3Q7ICZndDsgY2hlY2sgb24gemVyb19vcl9zYXR1cmF0ZWQgbGVuZ3RocyBmcm9tIHN0ZXAgMSB3
aGVuPGJyPg0KJmd0OyAmZ3Q7IGdlbmVyYXRpbmcgc3RyaW5nIHZhbHVlcy48YnI+DQomZ3Q7ICZn
dDs8YnI+DQomZ3Q7ICZndDsgU2lnbmVkLW9mZi1ieTogV2lsbGlhbSBSb2JlcnRzICZsdDs8YSBo
cmVmPSJtYWlsdG86d2lsbGlhbS5jLnJvYmVydHNAaW50ZWwuY29tIj53aWxsaWFtLmMucm9iZXJ0
c0BpbnRlbC5jb208L2E+Jmd0Ozxicj4NCiZndDsgJmd0OyAtLS08YnI+DQomZ3Q7ICZndDvCoCBs
aWJzZXBvbC9zcmMvY29uZGl0aW9uYWwuYyB8wqAgOSArLS0tLS0tPGJyPg0KJmd0OyAmZ3Q7wqAg
bGlic2Vwb2wvc3JjL21vZHVsZS5jwqAgwqAgwqAgfCA2NiArKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPg0KJmd0OyAmZ3Q7wqAgbGlic2Vwb2wvc3JjL3Bv
bGljeWRiLmPCoCDCoCB8IDEwICstLS0tLS08YnI+DQomZ3Q7ICZndDvCoCBsaWJzZXBvbC9zcmMv
cHJpdmF0ZS5owqAgwqAgwqB8wqAgMSArPGJyPg0KJmd0OyAmZ3Q7wqAgbGlic2Vwb2wvc3JjL3Nl
cnZpY2VzLmPCoCDCoCB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrPGJyPg0KJmd0OyAmZ3Q7
wqAgNSBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCA1MSBkZWxldGlvbnMoLSk8YnI+
DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9jb25k
aXRpb25hbC5jIGIvbGlic2Vwb2wvc3JjL2NvbmRpdGlvbmFsLmM8YnI+DQomZ3Q7ICZndDsgaW5k
ZXggODY4MGViMi4uZTFiYzk2MSAxMDA2NDQ8YnI+DQomZ3Q7ICZndDsgLS0tIGEvbGlic2Vwb2wv
c3JjL2NvbmRpdGlvbmFsLmM8YnI+DQomZ3Q7ICZndDsgKysrIGIvbGlic2Vwb2wvc3JjL2NvbmRp
dGlvbmFsLmM8YnI+DQomZ3Q7ICZndDsgQEAgLTU4OSwxNSArNTg5LDggQEAgaW50IGNvbmRfcmVh
ZF9ib29sKHBvbGljeWRiX3QgKiBwLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZ290byBlcnI7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBsZW4g
PSBsZTMyX3RvX2NwdShidWZbMl0pOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqBpZiAoemVyb19v
cl9zYXR1cmF0ZWQobGVuKSk8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgaWYgKHN0cl9yZWFkKCZh
bXA7a2V5LCBmcCwgbGVuKSk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdv
dG8gZXJyOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqBrZXkgPSBtYWxsb2MobGVuICsgMSk7PGJy
Pg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoGlmICgha2V5KTxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqBnb3RvIGVycjs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgcmMgPSBuZXh0X2Vu
dHJ5KGtleSwgZnAsIGxlbik7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoGlmIChyYyAmbHQ7IDAp
PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyOzxicj4NCiZndDsg
Jmd0OyAtwqAgwqAgwqBrZXlbbGVuXSA9IDA7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqBpZiAocC0mZ3Q7cG9saWN5X3R5cGUgIT0gUE9MSUNZX0tFUk4gJmFtcDsmYW1w
Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgcC0mZ3Q7cG9saWN5dmVycyAmZ3Q7PSBN
T0RfUE9MSUNZREJfVkVSU0lPTl9UVU5BQkxFX1NFUCkgezxicj4NCiZndDsgJmd0OyBkaWZmIC0t
Z2l0IGEvbGlic2Vwb2wvc3JjL21vZHVsZS5jIGIvbGlic2Vwb2wvc3JjL21vZHVsZS5jPGJyPg0K
Jmd0OyAmZ3Q7IGluZGV4IGYyNWRmOTUuLmE5ZDdjNTQgMTAwNjQ0PGJyPg0KJmd0OyAmZ3Q7IC0t
LSBhL2xpYnNlcG9sL3NyYy9tb2R1bGUuYzxicj4NCiZndDsgJmd0OyArKysgYi9saWJzZXBvbC9z
cmMvbW9kdWxlLmM8YnI+DQomZ3Q7ICZndDsgQEAgLTc5MywyNiArNzkzLDI2IEBAIGludCBzZXBv
bF9tb2R1bGVfcGFja2FnZV9pbmZvKHN0cnVjdCBzZXBvbF9wb2xpY3lfZmlsZSAqc3BmLCBpbnQg
KnR5cGUsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gY2xlYW51cDs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7ICZndDsgKzxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbGVuID0gbGUzMl90b19j
cHUoYnVmWzBdKTs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgKHplcm9fb3Jfc2F0dXJhdGVkKGxlbikpIHs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJSKGZpbGUtJmd0O2hhbmRsZSw8
YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgJnF1b3Q7aW52YWxpZCBtb2R1bGUgbmFtZSBsZW5ndGg6IDB4JSZxdW90O1BSSXgz
Miw8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgbGVuKTs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBjbGVhbnVwOzxicj4NCiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCpuYW1lID0gbWFsbG9jKGxlbiArIDEpOzxicj4NCiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoISpuYW1lKSB7PGJyPg0KJmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVSUihm
aWxlLSZndDtoYW5kbGUsICZxdW90O291dCBvZiBtZW1vcnkmcXVvdDspOzxicj4NCiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGNsZWFu
dXA7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+
DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmMgPSBuZXh0X2Vu
dHJ5KCpuYW1lLCBmaWxlLCBsZW4pOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAocmMgJmx0OyAwKSB7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVSUihmaWxlLSZndDtoYW5kbGUsPGJy
Pg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCZxdW90O2Nhbm5vdCBnZXQgbW9kdWxlIG5hbWUgc3RyaW5nIChhdCBzZWN0aW9uICV1
KSZxdW90Oyw8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaSk7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChzdHJfcmVhZChuYW1lLCBmaWxlLCBsZW4pKSB7PGJyPg0KJmd0OyAm
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN3aXRjaChy
Yykgezxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBjYXNlIEVJTlZBTDo8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJSKGZpbGUtJmd0O2hhbmRsZSw8
YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7aW52YWxpZCBtb2R1bGUgbmFtZSBsZW5n
dGg6IDB4JSZxdW90O1BSSXgzMiw8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbGVuKTs8YnI+
DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgRU5PTUVNOjxicj4NCiZndDsgJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBFUlIoZmls
ZS0mZ3Q7aGFuZGxlLCAmcXVvdDtvdXQgb2YgbWVtb3J5JnF1b3Q7KTs8YnI+DQomZ3Q7ICZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
YnJlYWs7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVSUihmaWxlLSZndDtoYW5kbGUsPGJy
Pg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O2Nhbm5vdCBnZXQgbW9kdWxlIG5hbWUgc3Ry
aW5nIChhdCBzZWN0aW9uICV1KSZxdW90Oyw8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaSk7
PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoH08YnI+DQomZ3Q7PGJyPg0KJmd0OyAxKSBZb3UgZGlkbiYjMzk7dCBzZXQgcmMgPSBzdHJf
cmVhZCgpLCBzbyB5b3UgY2FuJiMzOTt0IHN3aXRjaCBvbiBpdCBhYm92ZS48L3A+DQo8cCBkaXI9
Imx0ciI+SXQmIzM5O3MgYSBuZXcgZ251YyBleHRlbnNpb24gOy1wPC9wPg0KPHAgZGlyPSJsdHIi
PiZndDsgMikgVXNpbmcgcG9zaXRpdmUgdmFsdWVzIGZvciBlcnJvcnMgaXMgbGlrZWx5IHRvIGNv
bmZ1c2UgbWF0dGVycyB3aGVuPGJyPg0KJmd0OyBpbnRlcmFjdGluZyB3aXRoIHRoZSBleGlzdGlu
ZyBjb2RlLCB3aGljaCBhbHdheXMgdXNlcyBuZWdhdGl2ZSB2YWx1ZXM8YnI+DQomZ3Q7IChlaXRo
ZXIgLWVycm5vIGFzIGEgbGVnYWN5IG9mIGNvbW1vbiBjb2RlIHdpdGggdGhlIGtlcm5lbCBvciAt
MSkuPGJyPg0KJmd0OyAzKSBJIHRoaW5rIHRoaXMgb3ZlcmNvbXBsaWNhdGVzIHRoZSBlcnJvciBo
YW5kbGluZyAvIHJlcG9ydGluZy7CoCBJZjxicj4NCiZndDsgc3RyX3JlYWQoKSB3ZXJlIHRvIHNl
dCBlcnJubyBhbmQgcmV0dXJuIC0xIGluc3RlYWQsIHRoZW4geW91IGNvdWxkIGp1c3Q8YnI+DQom
Z3Q7IGluY2x1ZGUgc3RyZXJyb3IoZXJybm8pIGluIGEgc2luZ2xlIGVycm9yIG1lc3NhZ2UuwqAg
T3IgeW91IGNhbiBqdXN0PGJyPg0KJmd0OyBhbHdheXMgcmVwb3J0IHRoZSBtb3N0IGdlbmVyYWwg
ZXJyb3IgbWVzc2FnZS7CoCBCdXQgaXQgaXNuJiMzOTt0IHdvcnRoIGE8YnI+DQomZ3Q7IHN3aXRj
aCBzdGF0ZW1lbnQuPC9wPg0KPHAgZGlyPSJsdHIiPlllYWggSSBoYWQgYWxsIHRob3NlIHRob3Vn
aHRzLCB3YXNuJiMzOTt0IHN1cmUgdGhlIGJlc3Qgd2F5IGNvbnNpZGVyaW5nIHRoZSBjb25mbGlj
dCBvbiAtMSB2cyAtZXJybm8uIElmIHlvdSYjMzk7cmUgT0sgd2l0aCBzZXR0aW5nIGVycm5vIGxl
dCYjMzk7cyB1c2UgdGhhdC48L3A+DQo8cCBkaXI9Imx0ciI+Jmd0Ozxicj4NCiZndDsgU2FtZSBh
cHBsaWVzIHRocm91Z2hvdXQuPGJyPg0KJmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBjbGVhbnVwOzxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoKm5hbWUpW2xlbl0gPSAmIzM5O1wwJiMz
OTs7PGJyPg0KJmd0OyAmZ3Q7ICs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJjID0gbmV4dF9lbnRyeShidWYsIGZpbGUsIHNpemVvZih1aW50MzJfdCkp
Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJj
ICZsdDsgMCkgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgRVJSKGZpbGUtJmd0O2hhbmRsZSw8YnI+DQomZ3Q7ICZndDsgQEAgLTgy
MSwyNSArODIxLDIzIEBAIGludCBzZXBvbF9tb2R1bGVfcGFja2FnZV9pbmZvKHN0cnVjdCBzZXBv
bF9wb2xpY3lfZmlsZSAqc3BmLCBpbnQgKnR5cGUsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGNsZWFudXA7PGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBsZW4gPSBsZTMyX3RvX2NwdShidWZb
MF0pOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
emVyb19vcl9zYXR1cmF0ZWQobGVuKSkgezxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBFUlIoZmlsZS0mZ3Q7aGFuZGxlLDxicj4NCiZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAmcXVvdDtpbnZhbGlkIG1vZHVsZSB2ZXJzaW9uIGxlbmd0aDogMHglJnF1b3Q7UFJJeDMyLDxi
cj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBsZW4pOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBnb3RvIGNsZWFudXA7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgKnZlcnNpb24gPSBtYWxsb2MobGVuICsgMSk7PGJyPg0KJmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghKnZlcnNpb24pIHs8YnI+DQom
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJS
KGZpbGUtJmd0O2hhbmRsZSwgJnF1b3Q7b3V0IG9mIG1lbW9yeSZxdW90Oyk7PGJyPg0KJmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gY2xl
YW51cDs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxi
cj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYyA9IG5leHRf
ZW50cnkoKnZlcnNpb24sIGZpbGUsIGxlbik7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyYyAmbHQ7IDApIHs8YnI+DQomZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJSKGZpbGUtJmd0O2hhbmRs
ZSw8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgJnF1b3Q7Y2Fubm90IGdldCBtb2R1bGUgdmVyc2lvbiBzdHJpbmcgKGF0IHNl
Y3Rpb24gJXUpJnF1b3Q7LDxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpKTs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHN0cl9yZWFkKHZlcnNpb24sIGZpbGUsIGxlbikpIHs8
YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgc3dpdGNoKHJjKSB7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgRUlOVkFMOjxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBFUlIoZmlsZS0m
Z3Q7aGFuZGxlLDxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtpbnZhbGlkIG1vZHVs
ZSBuYW1lIGxlbmd0aDogMHglJnF1b3Q7UFJJeDMyLDxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBsZW4pOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBFTk9NRU06PGJyPg0KJmd0OyAm
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoEVSUihmaWxlLSZndDtoYW5kbGUsICZxdW90O291dCBvZiBtZW1vcnkmcXVvdDspOzxicj4N
CiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBicmVhazs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVmYXVsdDo8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJSKGZpbGUtJmd0
O2hhbmRsZSw8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7Y2Fubm90IGdldCBtb2R1
bGUgdmVyc2lvbiBzdHJpbmcgKGF0IHNlY3Rpb24gJXUpJnF1b3Q7LDxicj4NCiZndDsgJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpKTs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBjbGVhbnVwOzxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoKnZlcnNpb24pW2xlbl0gPSAmIzM5O1wwJiMzOTs7PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWVuIHw9IFNF
RU5fTU9EOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
YnJlYWs7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4N
CiZndDsgJmd0OyBkaWZmIC0tZ2l0IGEvbGlic2Vwb2wvc3JjL3BvbGljeWRiLmMgYi9saWJzZXBv
bC9zcmMvcG9saWN5ZGIuYzxicj4NCiZndDsgJmd0OyBpbmRleCA1Zjg4OGQzLi5jZGIzY2RlIDEw
MDY0NDxicj4NCiZndDsgJmd0OyAtLS0gYS9saWJzZXBvbC9zcmMvcG9saWN5ZGIuYzxicj4NCiZn
dDsgJmd0OyArKysgYi9saWJzZXBvbC9zcmMvcG9saWN5ZGIuYzxicj4NCiZndDsgJmd0OyBAQCAt
MTkxMSwxOSArMTkxMSwxMSBAQCBzdGF0aWMgaW50IHBlcm1fcmVhZChwb2xpY3lkYl90ICogcDxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBiYWQ7PGJyPg0KJmd0OyAm
Z3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBsZW4gPSBsZTMyX3RvX2NwdShidWZbMF0pOzxi
cj4NCiZndDsgJmd0OyAtwqAgwqAgwqBpZiAoemVyb19vcl9zYXR1cmF0ZWQobGVuKSk8YnI+DQom
Z3Q7ICZndDsgK8KgIMKgIMKgaWYoc3RyX3JlYWQoJmFtcDtrZXksIGZwLCBsZW4pKTxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBiYWQ7PGJyPg0KJmd0OyAmZ3Q7PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBwZXJkYXR1bS0mZ3Q7cy52YWx1ZSA9IGxlMzJfdG9fY3B1
KGJ1ZlsxXSk7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoGtleSA9IG1h
bGxvYyhsZW4gKyAxKTs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgaWYgKCFrZXkpPGJyPg0KJmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gYmFkOzxicj4NCiZndDsgJmd0OyAtwqAg
wqAgwqByYyA9IG5leHRfZW50cnkoa2V5LCBmcCwgbGVuKTs8YnI+DQomZ3Q7ICZndDsgLcKgIMKg
IMKgaWYgKHJjICZsdDsgMCk8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgZ290
byBiYWQ7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoGtleVtsZW5dID0gMDs8YnI+DQomZ3Q7ICZn
dDsgLTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgaWYgKGhhc2h0YWJfaW5zZXJ0KGgsIGtleSwg
cGVyZGF0dW0pKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBiYWQ7
PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IGRpZmYgLS1naXQgYS9saWJzZXBvbC9zcmMv
cHJpdmF0ZS5oIGIvbGlic2Vwb2wvc3JjL3ByaXZhdGUuaDxicj4NCiZndDsgJmd0OyBpbmRleCAw
YmViNGQ0Li5iODg0YzIzIDEwMDY0NDxicj4NCiZndDsgJmd0OyAtLS0gYS9saWJzZXBvbC9zcmMv
cHJpdmF0ZS5oPGJyPg0KJmd0OyAmZ3Q7ICsrKyBiL2xpYnNlcG9sL3NyYy9wcml2YXRlLmg8YnI+
DQomZ3Q7ICZndDsgQEAgLTY1LDMgKzY1LDQgQEAgZXh0ZXJuIHN0cnVjdCBwb2xpY3lkYl9jb21w
YXRfaW5mbyAqcG9saWN5ZGJfbG9va3VwX2NvbXBhdCh1bnNpZ25lZCBpbnQgdmVyc2lvbiw8YnI+
DQomZ3Q7ICZndDvCoCBleHRlcm4gaW50IG5leHRfZW50cnkodm9pZCAqYnVmLCBzdHJ1Y3QgcG9s
aWN5X2ZpbGUgKmZwLCBzaXplX3QgYnl0ZXMpIGhpZGRlbjs8YnI+DQomZ3Q7ICZndDvCoCBleHRl
cm4gc2l6ZV90IHB1dF9lbnRyeShjb25zdCB2b2lkICpwdHIsIHNpemVfdCBzaXplLCBzaXplX3Qg
biw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVj
dCBwb2xpY3lfZmlsZSAqZnApIGhpZGRlbjs8YnI+DQomZ3Q7ICZndDsgK2V4dGVybiBpbnQgc3Ry
X3JlYWQoY2hhciAqKnN0cnAsIHN0cnVjdCBwb2xpY3lfZmlsZSAqZnAsIHNpemVfdCBsZW4pIGhp
ZGRlbjs8YnI+DQomZ3Q7ICZndDsgZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9zZXJ2aWNlcy5j
IGIvbGlic2Vwb2wvc3JjL3NlcnZpY2VzLmM8YnI+DQomZ3Q7ICZndDsgaW5kZXggZDJiODBiNC4u
ZjYxZjY5MiAxMDA2NDQ8YnI+DQomZ3Q7ICZndDsgLS0tIGEvbGlic2Vwb2wvc3JjL3NlcnZpY2Vz
LmM8YnI+DQomZ3Q7ICZndDsgKysrIGIvbGlic2Vwb2wvc3JjL3NlcnZpY2VzLmM8YnI+DQomZ3Q7
ICZndDsgQEAgLTE2NzksNiArMTY3OSwzOSBAQCBzaXplX3QgaGlkZGVuIHB1dF9lbnRyeShjb25z
dCB2b2lkICpwdHIsIHNpemVfdCBzaXplLCBzaXplX3Qgbiw8YnI+DQomZ3Q7ICZndDvCoCB9PGJy
Pg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgLyo8YnI+DQomZ3Q7ICZndDsgKyAqIFJlYWRz
IGEgc3RyaW5nIGFuZCBudWxsIHRlcm1pbmF0ZXMgaXQgZnJvbSB0aGUgcG9saWN5IGZpbGUuPGJy
Pg0KJmd0OyAmZ3Q7ICsgKiBUaGlzIGlzIGEgcG9ydCBvZiBzdHJfcmVhZCBmcm9tIHRoZSBTRSBM
aW51eCBrZXJuZWwgY29kZS48YnI+DQomZ3Q7ICZndDsgKyAqPGJyPg0KJmd0OyAmZ3Q7ICsgKiBJ
dCByZXR1cm5zOjxicj4NCiZndDsgJmd0OyArICrCoCDCoDAgLSBTdWNjZXNzPGJyPg0KJmd0OyAm
Z3Q7ICsgKsKgIMKgRUlOVkFMIC0gbGVuIGlzIG5vIGdvb2Q8YnI+DQomZ3Q7ICZndDsgKyAqwqAg
wqBFTk9NRU0gLSBhbGxvY2F0aW9uIGZhaWxlZDxicj4NCiZndDsgJmd0OyArICrCoCDCoG9yIGFu
eSBlcnJvciBwb3NzaWJsZSBmcm9tIG5leHRfZW50cnkoKS48YnI+DQomZ3Q7ICZndDsgKyAqLzxi
cj4NCiZndDsgJmd0OyAraW50IGhpZGRlbiBzdHJfcmVhZChjaGFyICoqc3RycCwgc3RydWN0IHBv
bGljeV9maWxlICpmcCwgc2l6ZV90IGxlbik8YnI+DQomZ3Q7ICZndDsgK3s8YnI+DQomZ3Q7ICZn
dDsgK8KgIMKgIMKgaW50IHJjOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqBjaGFyICpzdHI7PGJy
Pg0KJmd0OyAmZ3Q7ICs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgaWYgKHplcm9fb3Jfc2F0dXJh
dGVkKGxlbikpPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBFSU5W
QUw7PGJyPg0KJmd0OyAmZ3Q7ICs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgc3RyID0gbWFsbG9j
KGxlbiArIDEpOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqBpZiAoIXN0cik8YnI+DQomZ3Q7ICZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIEVOT01FTTs8YnI+DQomZ3Q7ICZndDsgKzxi
cj4NCiZndDsgJmd0OyArwqAgwqAgwqAvKiBpdCYjMzk7cyBleHBlY3RlZCB0aGUgY2FsbGVyIHNo
b3VsZCBmcmVlIHRoZSBzdHIgKi88YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgKnN0cnAgPSBzdHI7
PGJyPg0KJmd0OyAmZ3Q7ICs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgcmMgPSBuZXh0X2VudHJ5
KHN0ciwgZnAsIGxlbik7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoGlmIChyYyk8YnI+DQomZ3Q7
ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJjOzxicj4NCiZndDsgJmd0OyArPGJy
Pg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoHN0cltsZW5dID0gJiMzOTtcMCYjMzk7Ozxicj4NCiZndDsg
Jmd0OyArwqAgwqAgwqByZXR1cm4gMDs8YnI+DQomZ3Q7ICZndDsgK308YnI+DQomZ3Q7ICZndDsg
Kzxicj4NCiZndDsgJmd0OyArLyo8YnI+DQomZ3Q7ICZndDvCoCDCoCogUmVhZCBhIG5ldyBzZXQg
b2YgY29uZmlndXJhdGlvbiBkYXRhIGZyb208YnI+DQomZ3Q7ICZndDvCoCDCoCogYSBwb2xpY3kg
ZGF0YWJhc2UgYmluYXJ5IHJlcHJlc2VudGF0aW9uIGZpbGUuPGJyPg0KJmd0OyAmZ3Q7wqAgwqAq
PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0Ozxicj4NCiZndDsgX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX188YnI+DQomZ3Q7IFNlYW5kcm9pZC1saXN0IG1haWxp
bmcgbGlzdDxicj4NCiZndDsgPGEgaHJlZj0ibWFpbHRvOlNlYW5kcm9pZC1saXN0QHR5Y2hvLm5z
YS5nb3YiPlNlYW5kcm9pZC1saXN0QHR5Y2hvLm5zYS5nb3Y8L2E+PGJyPg0KJmd0OyBUbyB1bnN1
YnNjcmliZSwgc2VuZCBlbWFpbCB0byA8YSBocmVmPSJtYWlsdG86U2VhbmRyb2lkLWxpc3QtbGVh
dmVAdHljaG8ubnNhLmdvdiI+U2VhbmRyb2lkLWxpc3QtbGVhdmVAdHljaG8ubnNhLmdvdjwvYT4u
PGJyPg0KJmd0OyBUbyBnZXQgaGVscCwgc2VuZCBhbiBlbWFpbCBjb250YWluaW5nICZxdW90O2hl
bHAmcXVvdDsgdG8gPGEgaHJlZj0ibWFpbHRvOlNlYW5kcm9pZC1saXN0LXJlcXVlc3RAdHljaG8u
bnNhLmdvdiI+U2VhbmRyb2lkLWxpc3QtcmVxdWVzdEB0eWNoby5uc2EuZ292PC9hPi48YnI+PC9w
Pg0K
--94eb2c05aa2a838a86053a6de0cd--
