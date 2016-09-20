Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8K5Ps6C017893
 for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2016 01:25:55 -0400
Received: by mail-it0-f67.google.com with SMTP id 186so545420itf.1
 for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2016 22:25:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdr4PAa1P=9AOZzDB23HX5bHuOmgjY-S+nzAv+BvXjnoGw@mail.gmail.com>
References: <1474321526-26208-1-git-send-email-william.c.roberts@intel.com>
 <CAPuKSJb7wj7CrZKMh8snwHAr00Hr+8OKhFjoGGq-uEbHA=v9KQ@mail.gmail.com>
 <CAFftDdr4PAa1P=9AOZzDB23HX5bHuOmgjY-S+nzAv+BvXjnoGw@mail.gmail.com>
From: Jason Zaman <jason@perfinion.com>
Date: Tue, 20 Sep 2016 13:25:47 +0800
Message-ID: <CAPuKSJbKOAO1eRRD-=f6Zx0XoQOT3xVNGD7qLvBPXSWZJef00g@mail.gmail.com>
Subject: Re: [RFC] mmap file_contexts and property_contexts:
To: William Roberts <bill.c.roberts@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>, william.c.roberts@intel.com,
 Stephen Smalley <sds@tycho.nsa.gov>, seandroid-list@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c111e5445ba88053ce9a98e
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c111e5445ba88053ce9a98e
Content-Type: text/plain; charset=UTF-8

On 20 Sep 2016 12:50 pm, "William Roberts" <bill.c.roberts@gmail.com> wrote:
>
> On Sep 19, 2016 21:16, "Jason Zaman" <jason@perfinion.com> wrote:
> >
> > On 20 Sep 2016 5:47 am, <william.c.roberts@intel.com> wrote:
> > >
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > THIS IS WIP...
> > >
> > > Rather than using stdio and making copies, just mmap the files
> > > and use the pointers in place. The affect of this change, is that
> > > text file load time is now faster than binary load time by 4.7%
> > > when testing with a file_contexts file from the Android tree. Note
> > > that the Android doesn't use monstrous regexs.
> > >
> > > Times are the average of 3 runs.
> > >
> > > BEFORE:
> > > Text file allocs: 114803
> > > Text file load time: 0.266101
> > > Bin file allocs: 93073
> > > Bin file load time: 0.248757667
> > >
> > > AFTER:
> > > Text file allocs: 103933
> > > Text file load time: 0.236192667
> > > Bin file allocs: 87645
> > > Bin file load time: .247607333
> >
> > Do you have the scripts that generated these stats so I can play with
it too? These stats are from android right? Do you also have a comparison
for refpolicy too?
>
> For generating these I used checkfc.c from the Android tree. I used
valgrind to measure allocations and clock to measure the time in
selabel_open().

Okay cool I'll fetch that and give it a whirl when I get time.

> >
> > I haven't looked that closely yet but just realised, will this need new
perms because of the mmap? If it does, can you send a patch to refpolicy?
>
> I'm confused, mmap is not a permission, even if it was the binary path
already was doing an mmap, so the permission would have been there. We're
just making it so it always mmaps.

Yeah but mmap needs execute perms sometimes (always?). I am out so just
wanted to send an email before I forgot. If it was mmaping already then
there is nothing to worry about :).

-- Jason
> >
> > > THINGS TO DO:
> > > 1. What's arm performance like?
> > > 2. What interfaces to backends are busted by this (if any)?
> > > 3. Test Android Properties
> > > 4. Im pretty sure this breaks sefcontext_compile, fix.
> > > 5. Test with PCRE2 enabled.
> > > 6. Spell check this message!
> > > 7. Run checkpatch
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > ---
> > >  libselinux/src/label.c                  |   2 -
> > >  libselinux/src/label_android_property.c |  22 ++---
> > >  libselinux/src/label_file.c             | 140
+++++++++++++++++++-------------
> > >  libselinux/src/label_file.h             |  66 +++++++++------
> > >  libselinux/src/label_internal.h         |   3 +-
> > >  libselinux/src/label_support.c          |  79 ++++++++----------
> > >  6 files changed, 172 insertions(+), 140 deletions(-)
> > >
> > > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > > index 963bfcb..d767b49 100644
> > > --- a/libselinux/src/label.c
> > > +++ b/libselinux/src/label.c
> > > @@ -15,8 +15,6 @@
> > >  #include "callbacks.h"
> > >  #include "label_internal.h"
> > >
> > > -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > > -
> > >  typedef int (*selabel_initfunc)(struct selabel_handle *rec,
> > >                                 const struct selinux_opt *opts,
> > >                                 unsigned nopts);
> > > diff --git a/libselinux/src/label_android_property.c
b/libselinux/src/label_android_property.c
> > > index 290b438..2aac394 100644
> > > --- a/libselinux/src/label_android_property.c
> > > +++ b/libselinux/src/label_android_property.c
> > > @@ -85,13 +85,19 @@ static int process_line(struct selabel_handle
*rec,
> > >                         int pass, unsigned lineno)
> > >  {
> > >         int items;
> > > -       char *prop = NULL, *context = NULL;
> > > +       union {
> > > +               struct {
> > > +                       char *prop;
> > > +                       char *context;
> > > +               };
> > > +               char *array[2];
> > > +       } found = { .array = { 0 } };
> > >         struct saved_data *data = (struct saved_data *)rec->data;
> > >         spec_t *spec_arr = data->spec_arr;
> > >         unsigned int nspec = data->nspec;
> > >         const char *errbuf = NULL;
> > >
> > > -       items = read_spec_entries(line_buf, &errbuf, 2, &prop,
&context);
> > > +       items = read_spec_entries(line_buf, &errbuf,
ARRAY_SIZE(found.array), found.array);
> > >         if (items < 0) {
> > >                 items = errno;
> > >                 selinux_log(SELINUX_ERROR,
> > > @@ -108,18 +114,14 @@ static int process_line(struct selabel_handle
*rec,
> > >                 selinux_log(SELINUX_ERROR,
> > >                             "%s:  line %u is missing fields\n", path,
> > >                             lineno);
> > > -               free(prop);
> > >                 errno = EINVAL;
> > >                 return -1;
> > >         }
> > >
> > > -       if (pass == 0) {
> > > -               free(prop);
> > > -               free(context);
> > > -       } else if (pass == 1) {
> > > +       if (pass == 1) {
> > >                 /* On the second pass, process and store the
specification in spec. */
> > > -               spec_arr[nspec].property_key = prop;
> > > -               spec_arr[nspec].lr.ctx_raw = context;
> > > +               spec_arr[nspec].property_key = found.prop;
> > > +               spec_arr[nspec].lr.ctx_raw = found.context;
> > >
> > >                 if (rec->validating) {
> > >                         if (selabel_validate(rec,
&spec_arr[nspec].lr) < 0) {
> > > @@ -234,7 +236,7 @@ static void closef(struct selabel_handle *rec)
> > >         for (i = 0; i < data->nspec; i++) {
> > >                 spec = &data->spec_arr[i];
> > >                 free(spec->property_key);
> > > -               free(spec->lr.ctx_raw);
> > > +               //free(spec->lr.ctx_raw);
> > >                 free(spec->lr.ctx_trans);
> > >         }
> > >
> > > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > > index 7156825..4dc440e 100644
> > > --- a/libselinux/src/label_file.c
> > > +++ b/libselinux/src/label_file.c
> > > @@ -96,43 +96,64 @@ static int nodups_specs(struct saved_data *data,
const char *path)
> > >         return rc;
> > >  }
> > >
> > > -static int process_text_file(FILE *fp, const char *prefix,
> > > -                            struct selabel_handle *rec, const char
*path)
> > > +static inline struct saved_data *rec_to_data(struct selabel_handle
*rec)
> > > +{
> > > +       return (struct saved_data *)rec->data;
> > > +}
> > > +
> > > +static char *mmap_area_get_line(struct mmap_area *area)
> > > +{
> > > +       size_t len = area->next_len;
> > > +       if (!len)
> > > +               return NULL;
> > > +
> > > +       char *start = area->next_addr;
> > > +       char *end = memchr(start, '\n', len);
> > > +
> > > +       /* the file may not end with a newline */
> > > +       if (!end)
> > > +               end = (char *)area->next_addr + len - 1;
> > > +
> > > +       *end = '\0';
> > > +       /* len includes null byte */
> > > +       len = end - start;
> > > +
> > > +       area->next_len -= len + 1;
> > > +       area->next_addr = ++end;
> > > +       return start;
> > > +}
> > > +
> > > +static int process_text_file(const char *path, const char *prefix,
> > > +               struct selabel_handle *rec)
> > >  {
> > >         int rc;
> > > -       size_t line_len;
> > >         unsigned int lineno = 0;
> > > -       char *line_buf = NULL;
> > > +       char *line_buf;
> > > +       struct mmap_area *areas = rec_to_data(rec)->mmap_areas;
> > > +
> > > +       /* mmap_area_get_line() and process_line() require mutable
string pointers */
> > > +       rc = mprotect(areas->addr, areas->len, PROT_READ |
PROT_WRITE);
> > > +       if (rc < 0)
> > > +               goto out;
> > >
> > > -       while (getline(&line_buf, &line_len, fp) > 0) {
> > > +       while ( (line_buf = mmap_area_get_line(areas)) ) {
> > >                 rc = process_line(rec, path, prefix, line_buf,
++lineno);
> > >                 if (rc)
> > >                         goto out;
> > >         }
> > >         rc = 0;
> > >  out:
> > > -       free(line_buf);
> > >         return rc;
> > >  }
> > >
> > > -static int load_mmap(FILE *fp, size_t len, struct selabel_handle
*rec,
> > > -                    const char *path)
> > > +static int mmap_file(FILE *fp, size_t len, struct saved_data *data)
> > >  {
> > > -       struct saved_data *data = (struct saved_data *)rec->data;
> > > -       int rc;
> > > -       char *addr, *str_buf;
> > > -       int *stem_map;
> > > -       struct mmap_area *mmap_area;
> > > -       uint32_t i, magic, version;
> > > -       uint32_t entry_len, stem_map_len, regex_array_len;
> > > -       const char *reg_version;
> > > -
> > > -       mmap_area = malloc(sizeof(*mmap_area));
> > > +       struct mmap_area *mmap_area = malloc(sizeof(*mmap_area));
> > >         if (!mmap_area) {
> > >                 return -1;
> > >         }
> > >
> > > -       addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fileno(fp), 0);
> > > +       void *addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE,
fileno(fp), 0);
> > >         if (addr == MAP_FAILED) {
> > >                 free(mmap_area);
> > >                 perror("mmap");
> > > @@ -145,17 +166,26 @@ static int load_mmap(FILE *fp, size_t len,
struct selabel_handle *rec,
> > >         mmap_area->next = data->mmap_areas;
> > >         data->mmap_areas = mmap_area;
> > >
> > > -       /* check if this looks like an fcontext file */
> > > -       rc = next_entry(&magic, mmap_area, sizeof(uint32_t));
> > > -       if (rc < 0 || magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
> > > -               return -1;
> > > +       return 0;
> > > +}
> > > +
> > > +static int process_binary_file(const char *path, struct
selabel_handle *rec)
> > > +{
> > > +       struct saved_data *data = (struct saved_data *)rec->data;
> > > +       int rc;
> > > +       char *str_buf;
> > > +       int *stem_map;
> > > +       struct mmap_area *mmap_area = data->mmap_areas;
> > > +       uint32_t i, version;
> > > +       uint32_t entry_len, stem_map_len, regex_array_len;
> > > +       size_t len;
> > >
> > >         /* check if this version is higher than we understand */
> > >         rc = next_entry(&version, mmap_area, sizeof(uint32_t));
> > >         if (rc < 0 || version > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
> > >                 return -1;
> > >
> > > -       reg_version = regex_version();
> > > +       const char *reg_version = regex_version();
> > >         if (!reg_version)
> > >                 return -1;
> > >
> > > @@ -235,12 +265,11 @@ static int load_mmap(FILE *fp, size_t len,
struct selabel_handle *rec,
> > >                 /* store the mapping between old and new */
> > >                 newid = find_stem(data, buf, stem_len);
> > >                 if (newid < 0) {
> > > -                       newid = store_stem(data, buf, stem_len);
> > > +                       newid = store_stem(data, buf, stem_len, true);
> > >                         if (newid < 0) {
> > >                                 rc = newid;
> > >                                 goto out;
> > >                         }
> > > -                       data->stem_arr[newid].from_mmap = 1;
> > >                 }
> > >                 stem_map[i] = newid;
> > >         }
> > > @@ -262,7 +291,6 @@ static int load_mmap(FILE *fp, size_t len, struct
selabel_handle *rec,
> > >                         goto out;
> > >
> > >                 spec = &data->spec_arr[data->nspec];
> > > -               spec->from_mmap = 1;
> > >
> > >                 /* Process context */
> > >                 rc = next_entry(&entry_len, mmap_area,
sizeof(uint32_t));
> > > @@ -271,22 +299,10 @@ static int load_mmap(FILE *fp, size_t len,
struct selabel_handle *rec,
> > >                         goto out;
> > >                 }
> > >
> > > -               str_buf = malloc(entry_len);
> > > -               if (!str_buf) {
> > > -                       rc = -1;
> > > -                       goto out;
> > > -               }
> > > -               rc = next_entry(str_buf, mmap_area, entry_len);
> > > +               rc = next_pstr(&spec->lr.ctx_raw, mmap_area,
entry_len);
> > >                 if (rc < 0)
> > >                         goto out;
> > >
> > > -               if (str_buf[entry_len - 1] != '\0') {
> > > -                       free(str_buf);
> > > -                       rc = -1;
> > > -                       goto out;
> > > -               }
> > > -               spec->lr.ctx_raw = str_buf;
> > > -
> > >                 if (strcmp(spec->lr.ctx_raw, "<<none>>") &&
rec->validating) {
> > >                         if (selabel_validate(rec, &spec->lr) < 0) {
> > >                                 selinux_log(SELINUX_ERROR,
> > > @@ -401,17 +417,29 @@ static char *rolling_append(char *current,
const char *suffix, size_t max)
> > >         return current;
> > >  }
> > >
> > > -static bool fcontext_is_binary(FILE *fp)
> > > +static inline int mmap_area_rewind(struct mmap_area *area, size_t
bytes)
> > > +{
> > > +       if (area->next_len + bytes > area->len)
> > > +               return -1;
> > > +
> > > +       area->next_addr = (char *) area->next_addr - bytes;
> > > +       area->next_len += bytes;
> > > +       return 0;
> > > +}
> > > +
> > > +static bool fcontext_is_binary(struct mmap_area *area)
> > >  {
> > >         uint32_t magic;
> > > +       bool is_binary = false;
> > >
> > > -       size_t len = fread(&magic, sizeof(magic), 1, fp);
> > > -       rewind(fp);
> > > +       int rc = next_entry(&magic, area, sizeof(magic));
> > >
> > > -       return (len && (magic == SELINUX_MAGIC_COMPILED_FCONTEXT));
> > > -}
> > > +       is_binary = (!rc && (magic ==
SELINUX_MAGIC_COMPILED_FCONTEXT));
> > > +       if (!is_binary)
> > > +               mmap_area_rewind(area, sizeof(magic));
> > >
> > > -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > > +       return is_binary;
> > > +}
> > >
> > >  static FILE *open_file(const char *path, const char *suffix,
> > >                char *save_path, size_t len, struct stat *sb, bool
open_oldest)
> > > @@ -504,12 +532,17 @@ static int process_file(const char *path, const
char *suffix,
> > >                 if (fp == NULL)
> > >                         return -1;
> > >
> > > -               rc = fcontext_is_binary(fp) ?
> > > -                               load_mmap(fp, sb.st_size, rec,
found_path) :
> > > -                               process_text_file(fp, prefix, rec,
found_path);
> > > +               rc = mmap_file(fp, sb.st_size, rec_to_data(rec));
> > > +               if (rc < 0) {
> > > +                       fclose(fp);
> > > +                       return -1;
> > > +               }
> > > +
> > > +               rc = fcontext_is_binary(rec_to_data(rec)->mmap_areas)
?
> > > +                               process_binary_file(found_path, rec) :
> > > +                               process_text_file(found_path, prefix,
rec);
> > >                 if (!rc)
> > > -                       rc = digest_add_specfile(digest, fp, NULL,
sb.st_size,
> > > -                               found_path);
> > > +                       rc = digest_add_specfile(digest, fp, NULL,
sb.st_size, found_path);
> > >
> > >                 fclose(fp);
> > >
> > > @@ -613,12 +646,7 @@ static void closef(struct selabel_handle *rec)
> > >         for (i = 0; i < data->nspec; i++) {
> > >                 spec = &data->spec_arr[i];
> > >                 free(spec->lr.ctx_trans);
> > > -               free(spec->lr.ctx_raw);
> > >                 regex_data_free(spec->regex);
> > > -               if (spec->from_mmap)
> > > -                       continue;
> > > -               free(spec->regex_str);
> > > -               free(spec->type_str);
> > >         }
> > >
> > >         for (i = 0; i < (unsigned int)data->num_stems; i++) {
> > > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > > index 88f4294..2704906 100644
> > > --- a/libselinux/src/label_file.h
> > > +++ b/libselinux/src/label_file.h
> > > @@ -37,7 +37,6 @@ struct spec {
> > >         int matches;            /* number of matching pathnames */
> > >         int stem_id;            /* indicates which stem-compression
item */
> > >         char hasMetaChars;      /* regular expression has meta-chars
*/
> > > -       char from_mmap;         /* this spec is from an mmap of the
data */
> > >         size_t prefix_len;      /* length of fixed path prefix */
> > >  };
> > >
> > > @@ -255,7 +254,7 @@ static inline int find_stem(struct saved_data
*data, const char *buf,
> > >  }
> > >
> > >  /* returns the index of the new stored object */
> > > -static inline int store_stem(struct saved_data *data, char *buf, int
stem_len)
> > > +static inline int store_stem(struct saved_data *data, char *buf, int
stem_len, bool from_mmap)
> > >  {
> > >         int num = data->num_stems;
> > >
> > > @@ -271,7 +270,7 @@ static inline int store_stem(struct saved_data
*data, char *buf, int stem_len)
> > >         }
> > >         data->stem_arr[num].len = stem_len;
> > >         data->stem_arr[num].buf = buf;
> > > -       data->stem_arr[num].from_mmap = 0;
> > > +       data->stem_arr[num].from_mmap = from_mmap;
> > >         data->num_stems++;
> > >
> > >         return num;
> > > @@ -298,7 +297,7 @@ static inline int find_stem_from_spec(struct
saved_data *data, const char *buf)
> > >         if (!stem)
> > >                 return -1;
> > >
> > > -       return store_stem(data, stem, stem_len);
> > > +       return store_stem(data, stem, stem_len, false);
> > >  }
> > >
> > >  /* This will always check for buffer over-runs and either read the
next entry
> > > @@ -317,6 +316,22 @@ static inline int next_entry(void *buf, struct
mmap_area *fp, size_t bytes)
> > >         return 0;
> > >  }
> > >
> > > +static inline int next_pstr(char **str, struct mmap_area *fp, size_t
len)
> > > +{
> > > +       if (len > fp->next_len)
> > > +               return -1;
> > > +
> > > +       char *tmp = (char *)fp->next_addr;
> > > +       if (tmp[len-1] != '\0')
> > > +               return -1;
> > > +
> > > +       *str = tmp;
> > > +
> > > +       fp->next_addr = (char *)fp->next_addr + len;
> > > +       fp->next_len -= len;
> > > +       return 0;
> > > +}
> > > +
> > >  static inline int compile_regex(struct saved_data *data, struct spec
*spec,
> > >                                             const char **errbuf)
> > >  {
> > > @@ -375,13 +390,21 @@ static inline int process_line(struct
selabel_handle *rec,
> > >                         char *line_buf, unsigned lineno)
> > >  {
> > >         int items, len, rc;
> > > -       char *regex = NULL, *type = NULL, *context = NULL;
> > > +       union {
> > > +               struct {
> > > +                       char *regex;
> > > +                       char *type;
> > > +                       char *context;
> > > +               };
> > > +               char *array[3];
> > > +       } found = { .array = { 0 } };
> > > +
> > >         struct saved_data *data = (struct saved_data *)rec->data;
> > >         struct spec *spec_arr;
> > >         unsigned int nspec = data->nspec;
> > >         const char *errbuf = NULL;
> > >
> > > -       items = read_spec_entries(line_buf, &errbuf, 3, &regex,
&type, &context);
> > > +       items = read_spec_entries(line_buf, &errbuf,
ARRAY_SIZE(found.array), found.array);
> > >         if (items < 0) {
> > >                 rc = errno;
> > >                 selinux_log(SELINUX_ERROR,
> > > @@ -398,22 +421,17 @@ static inline int process_line(struct
selabel_handle *rec,
> > >                 COMPAT_LOG(SELINUX_ERROR,
> > >                             "%s:  line %u is missing fields\n", path,
> > >                             lineno);
> > > -               if (items == 1)
> > > -                       free(regex);
> > >                 errno = EINVAL;
> > >                 return -1;
> > >         } else if (items == 2) {
> > >                 /* The type field is optional. */
> > > -               context = type;
> > > -               type = 0;
> > > +               found.context = found.type;
> > > +               found.type = NULL;
> > >         }
> > >
> > > -       len = get_stem_from_spec(regex);
> > > -       if (len && prefix && strncmp(prefix, regex, len)) {
> > > +       len = get_stem_from_spec(found.regex);
> > > +       if (len && prefix && strncmp(prefix, found.regex, len)) {
> > >                 /* Stem of regex does not match requested prefix,
discard. */
> > > -               free(regex);
> > > -               free(type);
> > > -               free(context);
> > >                 return 0;
> > >         }
> > >
> > > @@ -424,13 +442,13 @@ static inline int process_line(struct
selabel_handle *rec,
> > >         spec_arr = data->spec_arr;
> > >
> > >         /* process and store the specification in spec. */
> > > -       spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
> > > -       spec_arr[nspec].regex_str = regex;
> > > +       spec_arr[nspec].stem_id = find_stem_from_spec(data,
found.regex);
> > > +       spec_arr[nspec].regex_str = found.regex;
> > >
> > > -       spec_arr[nspec].type_str = type;
> > > +       spec_arr[nspec].type_str = found.type;
> > >         spec_arr[nspec].mode = 0;
> > >
> > > -       spec_arr[nspec].lr.ctx_raw = context;
> > > +       spec_arr[nspec].lr.ctx_raw = found.context;
> > >
> > >         /*
> > >          * bump data->nspecs to cause closef() to cover it in its free
> > > @@ -442,18 +460,18 @@ static inline int process_line(struct
selabel_handle *rec,
> > >                         && compile_regex(data, &spec_arr[nspec],
&errbuf)) {
> > >                 COMPAT_LOG(SELINUX_ERROR,
> > >                            "%s:  line %u has invalid regex %s:  %s\n",
> > > -                          path, lineno, regex, errbuf);
> > > +                          path, lineno, found.regex, errbuf);
> > >                 errno = EINVAL;
> > >                 return -1;
> > >         }
> > >
> > > -       if (type) {
> > > -               mode_t mode = string_to_mode(type);
> > > +       if (found.type) {
> > > +               mode_t mode = string_to_mode(found.type);
> > >
> > >                 if (mode == (mode_t)-1) {
> > >                         COMPAT_LOG(SELINUX_ERROR,
> > >                                    "%s:  line %u has invalid file
type %s\n",
> > > -                                  path, lineno, type);
> > > +                                  path, lineno, found.type);
> > >                         errno = EINVAL;
> > >                         return -1;
> > >                 }
> > > @@ -464,7 +482,7 @@ static inline int process_line(struct
selabel_handle *rec,
> > >          * any meta characters in the RE */
> > >         spec_hasMetaChars(&spec_arr[nspec]);
> > >
> > > -       if (strcmp(context, "<<none>>") && rec->validating)
> > > +       if (strcmp(found.context, "<<none>>") && rec->validating)
> > >                 compat_validate(rec, &spec_arr[nspec].lr, path,
lineno);
> > >
> > >         return 0;
> > > diff --git a/libselinux/src/label_internal.h
b/libselinux/src/label_internal.h
> > > index aa48fff..e40d68b 100644
> > > --- a/libselinux/src/label_internal.h
> > > +++ b/libselinux/src/label_internal.h
> > > @@ -136,10 +136,11 @@ compat_validate(struct selabel_handle *rec,
> > >                 struct selabel_lookup_rec *contexts,
> > >                 const char *path, unsigned lineno) hidden;
> > >
> > > +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > >  /*
> > >   * The read_spec_entries function may be used to
> > >   * replace sscanf to read entries from spec files.
> > >   */
> > > -extern int read_spec_entries(char *line_buf, const char **errbuf,
int num_args, ...);
> > > +extern int hidden read_spec_entries(char *line_buf, const char
**errbuf, unsigned int num, char *found[]);
> > >
> > >  #endif                         /* _SELABEL_INTERNAL_H_ */
> > > diff --git a/libselinux/src/label_support.c
b/libselinux/src/label_support.c
> > > index 26f9ef1..3f5728d 100644
> > > --- a/libselinux/src/label_support.c
> > > +++ b/libselinux/src/label_support.c
> > > @@ -17,39 +17,40 @@
> > >   * Read an entry from a spec file (e.g. file_contexts)
> > >   * entry - Buffer to allocate for the entry.
> > >   * ptr - current location of the line to be processed.
> > > - * returns  - 0 on success and *entry is set to be a null
> > > - *            terminated value. On Error it returns -1 and
> > > - *            errno will be set.
> > > + * returns  - a pointer to the begining of the string.
> > > + *            that is the
> > >   *
> > >   */
> > > -static inline int read_spec_entry(char **entry, char **ptr, int
*len, const char **errbuf)
> > > +static inline char *read_spec_entry(char **current, const char
**errbuf)
> > >  {
> > > -       *entry = NULL;
> > > -       char *tmp_buf = NULL;
> > > -
> > > -       while (isspace(**ptr) && **ptr != '\0')
> > > -               (*ptr)++;
> > > +       if(!**current) {
> > > +               (*current)++;
> > > +               return NULL;
> > > +       }
> > >
> > > -       tmp_buf = *ptr;
> > > -       *len = 0;
> > > +       while (isspace(**current) && **current != '\0')
> > > +               (*current)++;
> > >
> > > -       while (!isspace(**ptr) && **ptr != '\0') {
> > > -               if (!isascii(**ptr)) {
> > > +       char *start = *current;
> > > +       while (!isspace(**current) && **current != '\0') {
> > > +               if (!isascii(**current)) {
> > >                         errno = EINVAL;
> > >                         *errbuf = "Non-ASCII characters found";
> > > -                       return -1;
> > > +                       return NULL;
> > >                 }
> > > -               (*ptr)++;
> > > -               (*len)++;
> > > +               (*current)++;
> > >         }
> > >
> > > -       if (*len) {
> > > -               *entry = strndup(tmp_buf, *len);
> > > -               if (!*entry)
> > > -                       return -1;
> > > -       }
> > > +       char *end = *current;
> > >
> > > -       return 0;
> > > +       if (start == end)
> > > +               return NULL;
> > > +
> > > +       if (*end != '\0') {
> > > +               *end = '\0';
> > > +               (*current)++;
> > > +       }
> > > +       return start;
> > >  }
> > >
> > >  /*
> > > @@ -63,15 +64,13 @@ static inline int read_spec_entry(char **entry,
char **ptr, int *len, const char
> > >   * This function calls read_spec_entry() to do the actual string
processing.
> > >   * As such, can return anything from that function as well.
> > >   */
> > > -int hidden read_spec_entries(char *line_buf, const char **errbuf,
int num_args, ...)
> > > +int hidden read_spec_entries(char *line_buf, const char **errbuf,
unsigned int num, char *found[])
> > >  {
> > > -       char **spec_entry, *buf_p;
> > > -       int len, rc, items, entry_len = 0;
> > > -       va_list ap;
> > > -
> > > +       char*buf_p;
> > > +       unsigned int items = 0;
> > >         *errbuf = NULL;
> > >
> > > -       len = strlen(line_buf);
> > > +       size_t len = strlen(line_buf);
> > >         if (line_buf[len - 1] == '\n')
> > >                 line_buf[len - 1] = '\0';
> > >         else
> > > @@ -89,26 +88,12 @@ int hidden read_spec_entries(char *line_buf,
const char **errbuf, int num_args,
> > >                 return 0;
> > >
> > >         /* Process the spec file entries */
> > > -       va_start(ap, num_args);
> > > -
> > > -       items = 0;
> > > -       while (items < num_args) {
> > > -               spec_entry = va_arg(ap, char **);
> > > -
> > > -               if (len - 1 == buf_p - line_buf) {
> > > -                       va_end(ap);
> > > -                       return items;
> > > -               }
> > > -
> > > -               rc = read_spec_entry(spec_entry, &buf_p, &entry_len,
errbuf);
> > > -               if (rc < 0) {
> > > -                       va_end(ap);
> > > -                       return rc;
> > > -               }
> > > -               if (entry_len)
> > > -                       items++;
> > > +       while (items < num) {
> > > +               found[items] = read_spec_entry(&buf_p, errbuf);
> > > +               if (!found[items])
> > > +                       break;
> > > +               items++;
> > >         }
> > > -       va_end(ap);
> > >         return items;
> > >  }
> > >
> > > --
> > > 1.9.1
> > >
> > > _______________________________________________
> > > Selinux mailing list
> > > Selinux@tycho.nsa.gov
> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.
> >
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--94eb2c111e5445ba88053ce9a98e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On 20 Sep 2016 12:50 pm, &quot;William Roberts&quot; &lt;<a =
href=3D"mailto:bill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt; On Sep 19, 2016 21:16, &quot;Jason Zaman&quot; &lt;<a href=3D"mailto:j=
ason@perfinion.com">jason@perfinion.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On 20 Sep 2016 5:47 am, &lt;<a href=3D"mailto:william.c.roberts@i=
ntel.com">william.c.roberts@intel.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From: William Roberts &lt;<a href=3D"mailto:william.c.robert=
s@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; THIS IS WIP...<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Rather than using stdio and making copies, just mmap the fil=
es<br>
&gt; &gt; &gt; and use the pointers in place. The affect of this change, is=
 that<br>
&gt; &gt; &gt; text file load time is now faster than binary load time by 4=
.7%<br>
&gt; &gt; &gt; when testing with a file_contexts file from the Android tree=
. Note<br>
&gt; &gt; &gt; that the Android doesn&#39;t use monstrous regexs.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Times are the average of 3 runs.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; BEFORE:<br>
&gt; &gt; &gt; Text file allocs: 114803<br>
&gt; &gt; &gt; Text file load time: 0.266101<br>
&gt; &gt; &gt; Bin file allocs: 93073<br>
&gt; &gt; &gt; Bin file load time: 0.248757667<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; AFTER:<br>
&gt; &gt; &gt; Text file allocs: 103933<br>
&gt; &gt; &gt; Text file load time: 0.236192667<br>
&gt; &gt; &gt; Bin file allocs: 87645<br>
&gt; &gt; &gt; Bin file load time: .247607333<br>
&gt; &gt;<br>
&gt; &gt; Do you have the scripts that generated these stats so I can play =
with it too? These stats are from android right? Do you also have a compari=
son for refpolicy too?<br>
&gt;<br>
&gt; For generating these I used checkfc.c from the Android tree. I used va=
lgrind to measure allocations and clock to measure the time in selabel_open=
().</p>
<p dir=3D"ltr">Okay cool I&#39;ll fetch that and give it a whirl when I get=
 time. </p>
<p dir=3D"ltr">&gt; &gt;<br>
&gt; &gt; I haven&#39;t looked that closely yet but just realised, will thi=
s need new perms because of the mmap? If it does, can you send a patch to r=
efpolicy?<br>
&gt;<br>
&gt; I&#39;m confused, mmap is not a permission, even if it was the binary =
path already was doing an mmap, so the permission would have been there. We=
&#39;re just making it so it always mmaps.</p>
<p dir=3D"ltr">Yeah but mmap needs execute perms sometimes (always?). I am =
out so just wanted to send an email before I forgot. If it was mmaping alre=
ady then there is nothing to worry about :). </p>
<p dir=3D"ltr">-- Jason<br>
&gt; &gt;<br>
&gt; &gt; &gt; THINGS TO DO:<br>
&gt; &gt; &gt; 1. What&#39;s arm performance like?<br>
&gt; &gt; &gt; 2. What interfaces to backends are busted by this (if any)?<=
br>
&gt; &gt; &gt; 3. Test Android Properties<br>
&gt; &gt; &gt; 4. Im pretty sure this breaks sefcontext_compile, fix.<br>
&gt; &gt; &gt; 5. Test with PCRE2 enabled.<br>
&gt; &gt; &gt; 6. Spell check this message!<br>
&gt; &gt; &gt; 7. Run checkpatch<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william=
.c.roberts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; =C2=A0libselinux/src/label.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 -<br>
&gt; &gt; &gt; =C2=A0libselinux/src/label_android_property.c |=C2=A0 22 ++-=
--<br>
&gt; &gt; &gt; =C2=A0libselinux/src/label_file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 140 +++++++++++++++++++-------------<br>
&gt; &gt; &gt; =C2=A0libselinux/src/label_file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 66 +++++++++------<br>
&gt; &gt; &gt; =C2=A0libselinux/src/label_internal.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
&gt; &gt; &gt; =C2=A0libselinux/src/label_support.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 79 ++++++++----------<br>
&gt; &gt; &gt; =C2=A06 files changed, 172 insertions(+), 140 deletions(-)<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/libselinux/src/label.c b/libselinux/src/label.c=
<br>
&gt; &gt; &gt; index 963bfcb..d767b49 100644<br>
&gt; &gt; &gt; --- a/libselinux/src/label.c<br>
&gt; &gt; &gt; +++ b/libselinux/src/label.c<br>
&gt; &gt; &gt; @@ -15,8 +15,6 @@<br>
&gt; &gt; &gt; =C2=A0#include &quot;callbacks.h&quot;<br>
&gt; &gt; &gt; =C2=A0#include &quot;label_internal.h&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; =C2=A0typedef int (*selabel_initfunc)(struct selabel_handle =
*rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct selinux_o=
pt *opts,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned nopts);<br>
&gt; &gt; &gt; diff --git a/libselinux/src/label_android_property.c b/libse=
linux/src/label_android_property.c<br>
&gt; &gt; &gt; index 290b438..2aac394 100644<br>
&gt; &gt; &gt; --- a/libselinux/src/label_android_property.c<br>
&gt; &gt; &gt; +++ b/libselinux/src/label_android_property.c<br>
&gt; &gt; &gt; @@ -85,13 +85,19 @@ static int process_line(struct selabel_h=
andle *rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int pass, unsigned lineno)<br>
&gt; &gt; &gt; =C2=A0{<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int items;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0char *prop =3D NULL, *context =
=3D NULL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0union {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stru=
ct {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0char *prop;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0char *context;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char=
 *array[2];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0} found =3D { .array =3D { 0 } }=
;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct saved_data *data =3D (str=
uct saved_data *)rec-&gt;data;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_t *spec_arr =3D data-&gt;sp=
ec_arr;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int nspec =3D data-&gt;=
nspec;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *errbuf =3D NULL;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0items =3D read_spec_entries(line=
_buf, &amp;errbuf, 2, &amp;prop, &amp;context);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0items =3D read_spec_entries(line=
_buf, &amp;errbuf, ARRAY_SIZE(found.array), found.array);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (items &lt; 0) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 item=
s =3D errno;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seli=
nux_log(SELINUX_ERROR,<br>
&gt; &gt; &gt; @@ -108,18 +114,14 @@ static int process_line(struct selabel=
_handle *rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seli=
nux_log(SELINUX_ERROR,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s:=C2=A0 line %u is missing f=
ields\n&quot;, path,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lineno);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free=
(prop);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errn=
o =3D EINVAL;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pass =3D=3D 0) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free=
(prop);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free=
(context);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (pass =3D=3D 1) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pass =3D=3D 1) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* O=
n the second pass, process and store the specification in spec. */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec=
_arr[nspec].property_key =3D prop;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec=
_arr[nspec].lr.ctx_raw =3D context;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec=
_arr[nspec].property_key =3D found.prop;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec=
_arr[nspec].lr.ctx_raw =3D found.context;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
rec-&gt;validating) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (selabel_validate(rec, &amp;spec_arr[nspec].lr)=
 &lt; 0) {<br>
&gt; &gt; &gt; @@ -234,7 +236,7 @@ static void closef(struct selabel_handle=
 *rec)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; data-&gt;ns=
pec; i++) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec=
 =3D &amp;data-&gt;spec_arr[i];<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free=
(spec-&gt;property_key);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free=
(spec-&gt;lr.ctx_raw);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//fr=
ee(spec-&gt;lr.ctx_raw);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free=
(spec-&gt;lr.ctx_trans);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/libselinux/src/label_file.c b/libselinux/src/la=
bel_file.c<br>
&gt; &gt; &gt; index 7156825..4dc440e 100644<br>
&gt; &gt; &gt; --- a/libselinux/src/label_file.c<br>
&gt; &gt; &gt; +++ b/libselinux/src/label_file.c<br>
&gt; &gt; &gt; @@ -96,43 +96,64 @@ static int nodups_specs(struct saved_dat=
a *data, const char *path)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br>
&gt; &gt; &gt; =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -static int process_text_file(FILE *fp, const char *prefix,<=
br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct selabel_handle *rec, const ch=
ar *path)<br>
&gt; &gt; &gt; +static inline struct saved_data *rec_to_data(struct selabel=
_handle *rec)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return (struct saved_data *)rec-=
&gt;data;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static char *mmap_area_get_line(struct mmap_area *area)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len =3D area-&gt;next_len=
;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!len)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn NULL;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char *start =3D area-&gt;next_ad=
dr;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char *end =3D memchr(start, &#39=
;\n&#39;, len);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* the file may not end with a n=
ewline */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!end)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end =
=3D (char *)area-&gt;next_addr + len - 1;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0*end =3D &#39;\0&#39;;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* len includes null byte */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D end - start;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0area-&gt;next_len -=3D len + 1;<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0area-&gt;next_addr =3D ++end;<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return start;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static int process_text_file(const char *path, const char *=
prefix,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stru=
ct selabel_handle *rec)<br>
&gt; &gt; &gt; =C2=A0{<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t line_len;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int lineno =3D 0;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0char *line_buf =3D NULL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char *line_buf;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmap_area *areas =3D rec_=
to_data(rec)-&gt;mmap_areas;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* mmap_area_get_line() and proc=
ess_line() require mutable string pointers */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D mprotect(areas-&gt;addr, =
areas-&gt;len, PROT_READ | PROT_WRITE);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto=
 out;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0while (getline(&amp;line_buf, &a=
mp;line_len, fp) &gt; 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0while ( (line_buf =3D mmap_area_=
get_line(areas)) ) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =
=3D process_line(rec, path, prefix, line_buf, ++lineno);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
rc)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D 0;<br>
&gt; &gt; &gt; =C2=A0out:<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0free(line_buf);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br>
&gt; &gt; &gt; =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -static int load_mmap(FILE *fp, size_t len, struct selabel_h=
andle *rec,<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const char *path)<br>
&gt; &gt; &gt; +static int mmap_file(FILE *fp, size_t len, struct saved_dat=
a *data)<br>
&gt; &gt; &gt; =C2=A0{<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct saved_data *data =3D (str=
uct saved_data *)rec-&gt;data;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0char *addr, *str_buf;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0int *stem_map;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmap_area *mmap_area;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t i, magic, version;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t entry_len, stem_map_len=
, regex_array_len;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *reg_version;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0mmap_area =3D malloc(sizeof(*mma=
p_area));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmap_area *mmap_area =3D =
malloc(sizeof(*mmap_area));<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mmap_area) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D mmap(NULL, len, PROT_RE=
AD, MAP_PRIVATE, fileno(fp), 0);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0void *addr =3D mmap(NULL, len, P=
ROT_READ, MAP_PRIVATE, fileno(fp), 0);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (addr =3D=3D MAP_FAILED) {<br=
>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free=
(mmap_area);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 perr=
or(&quot;mmap&quot;);<br>
&gt; &gt; &gt; @@ -145,17 +166,26 @@ static int load_mmap(FILE *fp, size_t =
len, struct selabel_handle *rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_area-&gt;next =3D data-&gt;=
mmap_areas;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;mmap_areas =3D mmap_are=
a;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* check if this looks like an f=
context file */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D next_entry(&amp;magic, mm=
ap_area, sizeof(uint32_t));<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0 || magic !=3D SELI=
NUX_MAGIC_COMPILED_FCONTEXT)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static int process_binary_file(const char *path, struct sel=
abel_handle *rec)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct saved_data *data =3D (str=
uct saved_data *)rec-&gt;data;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char *str_buf;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int *stem_map;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmap_area *mmap_area =3D =
data-&gt;mmap_areas;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t i, version;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t entry_len, stem_map_len=
, regex_array_len;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* check if this version is high=
er than we understand */<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D next_entry(&amp;version, =
mmap_area, sizeof(uint32_t));<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt; 0 || version &gt; SE=
LINUX_COMPILED_FCONTEXT_MAX_VERS)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0reg_version =3D regex_version();=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *reg_version =3D rege=
x_version();<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!reg_version)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -235,12 +265,11 @@ static int load_mmap(FILE *fp, size_t =
len, struct selabel_handle *rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* s=
tore the mapping between old and new */<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newi=
d =3D find_stem(data, buf, stem_len);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
newid &lt; 0) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0newid =3D store_stem(data, buf, stem_len);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0newid =3D store_stem(data, buf, stem_len, true);<br=
>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (newid &lt; 0) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D newid;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;stem_arr[newid].from_mmap =3D 1;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stem=
_map[i] =3D newid;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; @@ -262,7 +291,6 @@ static int load_mmap(FILE *fp, size_t le=
n, struct selabel_handle *rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec=
 =3D &amp;data-&gt;spec_arr[data-&gt;nspec];<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec=
-&gt;from_mmap =3D 1;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* P=
rocess context */<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =
=3D next_entry(&amp;entry_len, mmap_area, sizeof(uint32_t));<br>
&gt; &gt; &gt; @@ -271,22 +299,10 @@ static int load_mmap(FILE *fp, size_t =
len, struct selabel_handle *rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0str_=
buf =3D malloc(entry_len);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
!str_buf) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -1;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =
=3D next_entry(str_buf, mmap_area, entry_len);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =
=3D next_pstr(&amp;spec-&gt;lr.ctx_raw, mmap_area, entry_len);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
rc &lt; 0)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
str_buf[entry_len - 1] !=3D &#39;\0&#39;) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0free(str_buf);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -1;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec=
-&gt;lr.ctx_raw =3D str_buf;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
strcmp(spec-&gt;lr.ctx_raw, &quot;&lt;&lt;none&gt;&gt;&quot;) &amp;&amp; re=
c-&gt;validating) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (selabel_validate(rec, &amp;spec-&gt;lr) &lt; 0=
) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 selinux_log(SELINUX_ER=
ROR,<br>
&gt; &gt; &gt; @@ -401,17 +417,29 @@ static char *rolling_append(char *curr=
ent, const char *suffix, size_t max)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return current;<br>
&gt; &gt; &gt; =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -static bool fcontext_is_binary(FILE *fp)<br>
&gt; &gt; &gt; +static inline int mmap_area_rewind(struct mmap_area *area, =
size_t bytes)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (area-&gt;next_len + bytes &g=
t; area-&gt;len)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -1;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0area-&gt;next_addr =3D (char *) =
area-&gt;next_addr - bytes;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0area-&gt;next_len +=3D bytes;<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static bool fcontext_is_binary(struct mmap_area *area)<br>
&gt; &gt; &gt; =C2=A0{<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t magic;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool is_binary =3D false;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len =3D fread(&amp;magic,=
 sizeof(magic), 1, fp);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0rewind(fp);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc =3D next_entry(&amp;magic=
, area, sizeof(magic));<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return (len &amp;&amp; (magic =
=3D=3D SELINUX_MAGIC_COMPILED_FCONTEXT));<br>
&gt; &gt; &gt; -}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0is_binary =3D (!rc &amp;&amp; (m=
agic =3D=3D SELINUX_MAGIC_COMPILED_FCONTEXT));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!is_binary)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmap=
_area_rewind(area, sizeof(magic));<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return is_binary;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0static FILE *open_file(const char *path, const char *s=
uffix,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char =
*save_path, size_t len, struct stat *sb, bool open_oldest)<br>
&gt; &gt; &gt; @@ -504,12 +532,17 @@ static int process_file(const char *pa=
th, const char *suffix,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
fp =3D=3D NULL)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =
=3D fcontext_is_binary(fp) ?<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load_mmap(fp, sb.st_siz=
e, rec, found_path) :<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_text_file(fp, p=
refix, rec, found_path);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =
=3D mmap_file(fp, sb.st_size, rec_to_data(rec));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
rc &lt; 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0fclose(fp);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =
=3D fcontext_is_binary(rec_to_data(rec)-&gt;mmap_areas) ?<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_binary_file(fou=
nd_path, rec) :<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_text_file(found=
_path, prefix, rec);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
!rc)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0rc =3D digest_add_specfile(digest, fp, NULL, sb.st_=
size,<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found_path);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0rc =3D digest_add_specfile(digest, fp, NULL, sb.st_=
size, found_path);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fclo=
se(fp);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -613,12 +646,7 @@ static void closef(struct selabel_handl=
e *rec)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; data-&gt;ns=
pec; i++) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec=
 =3D &amp;data-&gt;spec_arr[i];<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free=
(spec-&gt;lr.ctx_trans);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free=
(spec-&gt;lr.ctx_raw);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rege=
x_data_free(spec-&gt;regex);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
spec-&gt;from_mmap)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free=
(spec-&gt;regex_str);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free=
(spec-&gt;type_str);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; (unsigned i=
nt)data-&gt;num_stems; i++) {<br>
&gt; &gt; &gt; diff --git a/libselinux/src/label_file.h b/libselinux/src/la=
bel_file.h<br>
&gt; &gt; &gt; index 88f4294..2704906 100644<br>
&gt; &gt; &gt; --- a/libselinux/src/label_file.h<br>
&gt; &gt; &gt; +++ b/libselinux/src/label_file.h<br>
&gt; &gt; &gt; @@ -37,7 +37,6 @@ struct spec {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int matches;=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 /* number of matching pathnames */<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int stem_id;=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 /* indicates which stem-compression item */<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 char hasMetaChars;=C2=A0 =C2=A0 =
=C2=A0 /* regular expression has meta-chars */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0char from_mmap;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* this spec is from an mmap of the data */<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t prefix_len;=C2=A0 =C2=A0 =
=C2=A0 /* length of fixed path prefix */<br>
&gt; &gt; &gt; =C2=A0};<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -255,7 +254,7 @@ static inline int find_stem(struct saved=
_data *data, const char *buf,<br>
&gt; &gt; &gt; =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0/* returns the index of the new stored object */<br>
&gt; &gt; &gt; -static inline int store_stem(struct saved_data *data, char =
*buf, int stem_len)<br>
&gt; &gt; &gt; +static inline int store_stem(struct saved_data *data, char =
*buf, int stem_len, bool from_mmap)<br>
&gt; &gt; &gt; =C2=A0{<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int num =3D data-&gt;num_stems;<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -271,7 +270,7 @@ static inline int store_stem(struct save=
d_data *data, char *buf, int stem_len)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;stem_arr[num].len =3D s=
tem_len;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;stem_arr[num].buf =3D b=
uf;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;stem_arr[num].from_mmap=
 =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;stem_arr[num].from_mmap=
 =3D from_mmap;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;num_stems++;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return num;<br>
&gt; &gt; &gt; @@ -298,7 +297,7 @@ static inline int find_stem_from_spec(st=
ruct saved_data *data, const char *buf)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!stem)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return store_stem(data, stem, st=
em_len);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return store_stem(data, stem, st=
em_len, false);<br>
&gt; &gt; &gt; =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0/* This will always check for buffer over-runs and eit=
her read the next entry<br>
&gt; &gt; &gt; @@ -317,6 +316,22 @@ static inline int next_entry(void *buf,=
 struct mmap_area *fp, size_t bytes)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +static inline int next_pstr(char **str, struct mmap_area *f=
p, size_t len)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &gt; fp-&gt;next_len)<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -1;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char *tmp =3D (char *)fp-&gt;nex=
t_addr;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tmp[len-1] !=3D &#39;\0&#39;=
)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -1;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0*str =3D tmp;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fp-&gt;next_addr =3D (char *)fp-=
&gt;next_addr + len;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fp-&gt;next_len -=3D len;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; =C2=A0static inline int compile_regex(struct saved_data *dat=
a, struct spec *spec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 const char **errbuf)<br>
&gt; &gt; &gt; =C2=A0{<br>
&gt; &gt; &gt; @@ -375,13 +390,21 @@ static inline int process_line(struct =
selabel_handle *rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 char *line_buf, unsigned lineno)<br>
&gt; &gt; &gt; =C2=A0{<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int items, len, rc;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0char *regex =3D NULL, *type =3D =
NULL, *context =3D NULL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0union {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stru=
ct {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0char *regex;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0char *type;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0char *context;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char=
 *array[3];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0} found =3D { .array =3D { 0 } }=
;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct saved_data *data =3D (str=
uct saved_data *)rec-&gt;data;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct spec *spec_arr;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int nspec =3D data-&gt;=
nspec;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *errbuf =3D NULL;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0items =3D read_spec_entries(line=
_buf, &amp;errbuf, 3, &amp;regex, &amp;type, &amp;context);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0items =3D read_spec_entries(line=
_buf, &amp;errbuf, ARRAY_SIZE(found.array), found.array);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (items &lt; 0) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =
=3D errno;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seli=
nux_log(SELINUX_ERROR,<br>
&gt; &gt; &gt; @@ -398,22 +421,17 @@ static inline int process_line(struct =
selabel_handle *rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COMP=
AT_LOG(SELINUX_ERROR,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s:=C2=A0 line %u is missing f=
ields\n&quot;, path,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lineno);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
items =3D=3D 1)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0free(regex);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errn=
o =3D EINVAL;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (items =3D=3D 2) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* T=
he type field is optional. */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cont=
ext =3D type;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type=
 =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0foun=
d.context =3D found.type;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0foun=
d.type =3D NULL;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D get_stem_from_spec(regex=
);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &amp;&amp; prefix &amp;&=
amp; strncmp(prefix, regex, len)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D get_stem_from_spec(found=
.regex);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &amp;&amp; prefix &amp;&=
amp; strncmp(prefix, found.regex, len)) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* S=
tem of regex does not match requested prefix, discard. */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free=
(regex);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free=
(type);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free=
(context);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn 0;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -424,13 +442,13 @@ static inline int process_line(struct =
selabel_handle *rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_arr =3D data-&gt;spec_arr;<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* process and store the specifi=
cation in spec. */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].stem_id =3D find=
_stem_from_spec(data, regex);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].regex_str =3D re=
gex;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].stem_id =3D find=
_stem_from_spec(data, found.regex);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].regex_str =3D fo=
und.regex;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].type_str =3D typ=
e;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].type_str =3D fou=
nd.type;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_arr[nspec].mode =3D 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].lr.ctx_raw =3D c=
ontext;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].lr.ctx_raw =3D f=
ound.context;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* bump data-&gt;nspecs to =
cause closef() to cover it in its free<br>
&gt; &gt; &gt; @@ -442,18 +460,18 @@ static inline int process_line(struct =
selabel_handle *rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; compile_regex(data, &amp;spec_arr[nspec=
], &amp;errbuf)) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COMP=
AT_LOG(SELINUX_ERROR,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%s:=C2=A0 line %u has invalid r=
egex %s:=C2=A0 %s\n&quot;,<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path, lineno, regex, errbuf);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path, lineno, found.regex, errbuf);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errn=
o =3D EINVAL;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -1;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (type) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode=
_t mode =3D string_to_mode(type);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (found.type) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode=
_t mode =3D string_to_mode(found.type);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
mode =3D=3D (mode_t)-1) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 COMPAT_LOG(SELINUX_ERROR,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%s:=
=C2=A0 line %u has invalid file type %s\n&quot;,<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path, lineno, t=
ype);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path, lineno, f=
ound.type);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D EINVAL;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
&gt; &gt; &gt; @@ -464,7 +482,7 @@ static inline int process_line(struct se=
label_handle *rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* any meta characters in t=
he RE */<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_hasMetaChars(&amp;spec_arr[=
nspec]);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(context, &quot;&lt;&l=
t;none&gt;&gt;&quot;) &amp;&amp; rec-&gt;validating)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(found.context, &quot;=
&lt;&lt;none&gt;&gt;&quot;) &amp;&amp; rec-&gt;validating)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 comp=
at_validate(rec, &amp;spec_arr[nspec].lr, path, lineno);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; diff --git a/libselinux/src/label_internal.h b/libselinux/sr=
c/label_internal.h<br>
&gt; &gt; &gt; index aa48fff..e40d68b 100644<br>
&gt; &gt; &gt; --- a/libselinux/src/label_internal.h<br>
&gt; &gt; &gt; +++ b/libselinux/src/label_internal.h<br>
&gt; &gt; &gt; @@ -136,10 +136,11 @@ compat_validate(struct selabel_handle =
*rec,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stru=
ct selabel_lookup_rec *contexts,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cons=
t char *path, unsigned lineno) hidden;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))<br>
&gt; &gt; &gt; =C2=A0/*<br>
&gt; &gt; &gt; =C2=A0 * The read_spec_entries function may be used to<br>
&gt; &gt; &gt; =C2=A0 * replace sscanf to read entries from spec files.<br>
&gt; &gt; &gt; =C2=A0 */<br>
&gt; &gt; &gt; -extern int read_spec_entries(char *line_buf, const char **e=
rrbuf, int num_args, ...);<br>
&gt; &gt; &gt; +extern int hidden read_spec_entries(char *line_buf, const c=
har **errbuf, unsigned int num, char *found[]);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0#endif=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* _SELABEL_INTERNAL_H_ */<br>
&gt; &gt; &gt; diff --git a/libselinux/src/label_support.c b/libselinux/src=
/label_support.c<br>
&gt; &gt; &gt; index 26f9ef1..3f5728d 100644<br>
&gt; &gt; &gt; --- a/libselinux/src/label_support.c<br>
&gt; &gt; &gt; +++ b/libselinux/src/label_support.c<br>
&gt; &gt; &gt; @@ -17,39 +17,40 @@<br>
&gt; &gt; &gt; =C2=A0 * Read an entry from a spec file (e.g. file_contexts)=
<br>
&gt; &gt; &gt; =C2=A0 * entry - Buffer to allocate for the entry.<br>
&gt; &gt; &gt; =C2=A0 * ptr - current location of the line to be processed.=
<br>
&gt; &gt; &gt; - * returns=C2=A0 - 0 on success and *entry is set to be a n=
ull<br>
&gt; &gt; &gt; - *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 terminated valu=
e. On Error it returns -1 and<br>
&gt; &gt; &gt; - *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno will be s=
et.<br>
&gt; &gt; &gt; + * returns=C2=A0 - a pointer to the begining of the string.=
<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 that is the<br>
&gt; &gt; &gt; =C2=A0 *<br>
&gt; &gt; &gt; =C2=A0 */<br>
&gt; &gt; &gt; -static inline int read_spec_entry(char **entry, char **ptr,=
 int *len, const char **errbuf)<br>
&gt; &gt; &gt; +static inline char *read_spec_entry(char **current, const c=
har **errbuf)<br>
&gt; &gt; &gt; =C2=A0{<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0*entry =3D NULL;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0char *tmp_buf =3D NULL;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0while (isspace(**ptr) &amp;&amp;=
 **ptr !=3D &#39;\0&#39;)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*pt=
r)++;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if(!**current) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*cu=
rrent)++;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn NULL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp_buf =3D *ptr;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0*len =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0while (isspace(**current) &amp;&=
amp; **current !=3D &#39;\0&#39;)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*cu=
rrent)++;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0while (!isspace(**ptr) &amp;&amp=
; **ptr !=3D &#39;\0&#39;) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
!isascii(**ptr)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char *start =3D *current;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0while (!isspace(**current) &amp;=
&amp; **current !=3D &#39;\0&#39;) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
!isascii(**current)) {<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D EINVAL;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 *errbuf =3D &quot;Non-ASCII characters found&quot;=
;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*pt=
r)++;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*le=
n)++;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*cu=
rrent)++;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*len) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ent=
ry =3D strndup(tmp_buf, *len);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
!*entry)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char *end =3D *current;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (start =3D=3D end)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn NULL;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*end !=3D &#39;\0&#39;) {<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*end=
 =3D &#39;\0&#39;;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*cu=
rrent)++;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return start;<br>
&gt; &gt; &gt; =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0/*<br>
&gt; &gt; &gt; @@ -63,15 +64,13 @@ static inline int read_spec_entry(char *=
*entry, char **ptr, int *len, const char<br>
&gt; &gt; &gt; =C2=A0 * This function calls read_spec_entry() to do the act=
ual string processing.<br>
&gt; &gt; &gt; =C2=A0 * As such, can return anything from that function as =
well.<br>
&gt; &gt; &gt; =C2=A0 */<br>
&gt; &gt; &gt; -int hidden read_spec_entries(char *line_buf, const char **e=
rrbuf, int num_args, ...)<br>
&gt; &gt; &gt; +int hidden read_spec_entries(char *line_buf, const char **e=
rrbuf, unsigned int num, char *found[])<br>
&gt; &gt; &gt; =C2=A0{<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0char **spec_entry, *buf_p;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0int len, rc, items, entry_len =
=3D 0;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0va_list ap;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char*buf_p;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int items =3D 0;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 *errbuf =3D NULL;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D strlen(line_buf);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len =3D strlen(line_buf);=
<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (line_buf[len - 1] =3D=3D &#3=
9;\n&#39;)<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line=
_buf[len - 1] =3D &#39;\0&#39;;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; &gt; &gt; @@ -89,26 +88,12 @@ int hidden read_spec_entries(char *line_=
buf, const char **errbuf, int num_args,<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Process the spec file entries=
 */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0va_start(ap, num_args);<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0items =3D 0;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0while (items &lt; num_args) {<br=
>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec=
_entry =3D va_arg(ap, char **);<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
len - 1 =3D=3D buf_p - line_buf) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0va_end(ap);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return items;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =
=3D read_spec_entry(spec_entry, &amp;buf_p, &amp;entry_len, errbuf);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
rc &lt; 0) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0va_end(ap);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
entry_len)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0items++;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0while (items &lt; num) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0foun=
d[items] =3D read_spec_entry(&amp;buf_p, errbuf);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
!found[items])<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0item=
s++;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0va_end(ap);<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return items;<br>
&gt; &gt; &gt; =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 1.9.1<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; Selinux mailing list<br>
&gt; &gt; &gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.g=
ov</a><br>
&gt; &gt; &gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leav=
e@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; &gt; &gt; To get help, send an email containing &quot;help&quot; to <a=
 href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.go=
v</a>.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; Selinux mailing list<br>
&gt; &gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a=
><br>
&gt; &gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tyc=
ho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; &gt; To get help, send an email containing &quot;help&quot; to <a href=
=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>=
.<br></p>

--94eb2c111e5445ba88053ce9a98e--
