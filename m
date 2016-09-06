MIME-Version: 1.0
In-Reply-To: <2030c403-fde5-8538-d282-cc8a3b423945@tycho.nsa.gov>
References: <1472487768-4104-1-git-send-email-william.c.roberts@intel.com>
 <2030c403-fde5-8538-d282-cc8a3b423945@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 6 Sep 2016 11:59:50 -0700
Message-ID: <CAFftDdqaGPEzsTFNAKnG7JP4kDtD7_tBoH8fkpCB6xq67azrog@mail.gmail.com>
Subject: Re: [PATCH] [RFC] nodups_specs: speedup
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c07d1eac27874053bdb66a8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c07d1eac27874053bdb66a8
Content-Type: text/plain; charset=UTF-8

On Sep 6, 2016 11:58, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 08/29/2016 12:22 PM, william.c.roberts@intel.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > I noticed, via gprof, that the time spent in nodups_specs()
> > accounts for 100% of the label_open() call.
> >
> > It seems as though the N^2 comparison using strcmp is very
> > slow.
> >
> > Do two major things:
> > 1. move the rec->validating check to the left, check the simple
> >    thing first before runnning the expensive strcmp(). strcmp()
> >    is used to check string equality, check lengths first.
> > 2. strlen() is used all over to calculate lengths, just store
> >    it in a struct with the string so its usable elsewhere, rather
> >    than recalculating it.
> >
> > text 21.4% speedup:
> > before text: 248
> > after text: 195
> >
> > binary 24.6% speedup:
> > before bin: 236
> > after bin: 178
> >
> > Some things to ponder:
> > 1. We can use C ABI safe pointer instead of len_str structure
> >    https://bitbucket.org/billcroberts/twist
> >    There are pros and cons to this approach, namely if someone
> >    calls free(x) instead of twist_free(x)
> >    It also currently has 0 support for stack based strings (simple
> >    enough to add). I think this approach is overkill here.
>
> Agreed.
>
> >
> > 2. The location of the str_len struct and routines should likely
> >    move elsewhere.
>
> Agreed.
>
> >
> > 3. The impact on Android is currently unmeasured, that's next.
> >    Also, bionic uses something from label_file.h for processing
> >    property_contexts for the Android property subsystem... so
> >    need to ensure that all works as advertised still.
> >
> > Things to do:
> > 1. Cleanup the code locations, likely a util.h or a len_str.h,
> >    a better name would be nice.
> > 2. Spell check this commit message
>
> Seems a bit prone to the str and len fields getting out of sync since
> they are both directly manipulated.

Agreed I can handle that easily. As long as you're OK with the general
concept I'll clean this up and send out after the process file changes.

>
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libselinux/src/label.c                  |  8 ++--
> >  libselinux/src/label_android_property.c | 44 +++++++++----------
> >  libselinux/src/label_db.c               |  7 +--
> >  libselinux/src/label_file.c             | 63 ++++++++++++++------------
> >  libselinux/src/label_file.h             | 78
+++++++++++++++++++--------------
> >  libselinux/src/label_internal.h         | 22 +++++++++-
> >  libselinux/src/label_media.c            |  5 ++-
> >  libselinux/src/label_support.c          | 32 ++++++++------
> >  libselinux/src/label_x.c                |  5 ++-
> >  libselinux/src/matchpathcon.c           |  2 +-
> >  10 files changed, 159 insertions(+), 107 deletions(-)
> >
> > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > index 963bfcb..11324ea 100644
> > --- a/libselinux/src/label.c
> > +++ b/libselinux/src/label.c
> > @@ -209,7 +209,7 @@ int selabel_validate(struct selabel_handle *rec,
> >       if (!rec->validating || contexts->validated)
> >               goto out;
> >
> > -     rc = selinux_validate(&contexts->ctx_raw);
> > +     rc = selinux_validate(&contexts->ctx_raw.str);
> >       if (rc < 0)
> >               goto out;
> >
> > @@ -248,7 +248,7 @@ static int selabel_fini(struct selabel_handle *rec,
> >               return -1;
> >
> >       if (translating && !lr->ctx_trans &&
> > -         selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
> > +         selinux_raw_to_trans_context(lr->ctx_raw.str, &lr->ctx_trans))
> >               return -1;
> >
> >       return 0;
> > @@ -369,7 +369,7 @@ int selabel_lookup_raw(struct selabel_handle *rec,
char **con,
> >       if (!lr)
> >               return -1;
> >
> > -     *con = strdup(lr->ctx_raw);
> > +     *con = strdup(lr->ctx_raw.str);
> >       return *con ? 0 : -1;
> >  }
> >
> > @@ -429,7 +429,7 @@ int selabel_lookup_best_match_raw(struct
selabel_handle *rec, char **con,
> >       if (!lr)
> >               return -1;
> >
> > -     *con = strdup(lr->ctx_raw);
> > +     *con = strdup(lr->ctx_raw.str);
> >       return *con ? 0 : -1;
> >  }
> >
> > diff --git a/libselinux/src/label_android_property.c
b/libselinux/src/label_android_property.c
> > index 290b438..af0b9a8 100644
> > --- a/libselinux/src/label_android_property.c
> > +++ b/libselinux/src/label_android_property.c
> > @@ -16,7 +16,7 @@
> >  /* A property security context specification. */
> >  typedef struct spec {
> >       struct selabel_lookup_rec lr;   /* holds contexts for lookup
result */
> > -     char *property_key;             /* property key string */
> > +     struct len_str property_key;            /* property key string */
> >  } spec_t;
> >
> >  /* Our stored configuration */
> > @@ -33,13 +33,13 @@ static int cmp(const void *A, const void *B)
> >  {
> >       const struct spec *sp1 = A, *sp2 = B;
> >
> > -     if (strncmp(sp1->property_key, "*", 1) == 0)
> > +     if (strncmp(sp1->property_key.str, "*", 1) == 0)
> >               return 1;
> > -     if (strncmp(sp2->property_key, "*", 1) == 0)
> > +     if (strncmp(sp2->property_key.str, "*", 1) == 0)
> >               return -1;
> >
> > -     size_t L1 = strlen(sp1->property_key);
> > -     size_t L2 = strlen(sp2->property_key);
> > +     size_t L1 = sp1->property_key.len;
> > +     size_t L2 = sp2->property_key.len;
> >
> >       return (L1 < L2) - (L1 > L2);
> >  }
> > @@ -56,23 +56,23 @@ static int nodups_specs(struct saved_data *data,
const char *path)
> >       for (ii = 0; ii < data->nspec; ii++) {
> >               curr_spec = &spec_arr[ii];
> >               for (jj = ii + 1; jj < data->nspec; jj++) {
> > -                     if (!strcmp(spec_arr[jj].property_key,
> > -                                         curr_spec->property_key)) {
> > +                     if (len_str_eq(&spec_arr[jj].property_key,
> > +                                         &curr_spec->property_key)) {
> >                               rc = -1;
> >                               errno = EINVAL;
> > -                             if (strcmp(spec_arr[jj].lr.ctx_raw,
> > -
 curr_spec->lr.ctx_raw)) {
> > +                             if (!len_str_eq(&spec_arr[jj].lr.ctx_raw,
> > +
 &curr_spec->lr.ctx_raw)) {
> >                                       selinux_log
> >                                               (SELINUX_ERROR,
> >                                                "%s: Multiple different
specifications for %s  (%s and %s).\n",
> > -                                              path,
curr_spec->property_key,
> > -                                              spec_arr[jj].lr.ctx_raw,
> > -                                              curr_spec->lr.ctx_raw);
> > +                                              path,
curr_spec->property_key.str,
> > +
spec_arr[jj].lr.ctx_raw.str,
> > +
curr_spec->lr.ctx_raw.str);
> >                               } else {
> >                                       selinux_log
> >                                               (SELINUX_ERROR,
> >                                                "%s: Multiple same
specifications for %s.\n",
> > -                                              path,
curr_spec->property_key);
> > +                                              path,
curr_spec->property_key.str);
> >                               }
> >                       }
> >               }
> > @@ -85,7 +85,7 @@ static int process_line(struct selabel_handle *rec,
> >                       int pass, unsigned lineno)
> >  {
> >       int items;
> > -     char *prop = NULL, *context = NULL;
> > +     struct len_str *prop = { 0 }, *context = { 0 };
> >       struct saved_data *data = (struct saved_data *)rec->data;
> >       spec_t *spec_arr = data->spec_arr;
> >       unsigned int nspec = data->nspec;
> > @@ -118,14 +118,14 @@ static int process_line(struct selabel_handle
*rec,
> >               free(context);
> >       } else if (pass == 1) {
> >               /* On the second pass, process and store the
specification in spec. */
> > -             spec_arr[nspec].property_key = prop;
> > -             spec_arr[nspec].lr.ctx_raw = context;
> > +             memcpy(&spec_arr[nspec].property_key, prop,
sizeof(*prop));
> > +             memcpy(&spec_arr[nspec].lr.ctx_raw, context,
sizeof(*context));
> >
> >               if (rec->validating) {
> >                       if (selabel_validate(rec, &spec_arr[nspec].lr) <
0) {
> >                               selinux_log(SELINUX_ERROR,
> >                                           "%s:  line %u has invalid
context %s\n",
> > -                                         path, lineno,
spec_arr[nspec].lr.ctx_raw);
> > +                                         path, lineno,
spec_arr[nspec].lr.ctx_raw.str);
> >                               errno = EINVAL;
> >                               return -1;
> >                       }
> > @@ -233,8 +233,8 @@ static void closef(struct selabel_handle *rec)
> >
> >       for (i = 0; i < data->nspec; i++) {
> >               spec = &data->spec_arr[i];
> > -             free(spec->property_key);
> > -             free(spec->lr.ctx_raw);
> > +             free(spec->property_key.str);
> > +             free(spec->lr.ctx_raw.str);
> >               free(spec->lr.ctx_trans);
> >       }
> >
> > @@ -259,11 +259,11 @@ static struct selabel_lookup_rec *lookup(struct
selabel_handle *rec,
> >       }
> >
> >       for (i = 0; i < data->nspec; i++) {
> > -             if (strncmp(spec_arr[i].property_key, key,
> > -                         strlen(spec_arr[i].property_key)) == 0) {
> > +             if (strncmp(spec_arr[i].property_key.str, key,
> > +                         spec_arr[i].property_key.len) == 0) {
> >                       break;
> >               }
> > -             if (strncmp(spec_arr[i].property_key, "*", 1) == 0)
> > +             if (strncmp(spec_arr[i].property_key.str, "*", 1) == 0)
> >                       break;
> >       }
> >
> > diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> > index 1155bcc..c700aca 100644
> > --- a/libselinux/src/label_db.c
> > +++ b/libselinux/src/label_db.c
> > @@ -153,7 +153,8 @@ process_line(const char *path, char *line_buf,
unsigned int line_num,
> >
> >       free(type);
> >       spec->key = key;
> > -     spec->lr.ctx_raw = context;
> > +     spec->lr.ctx_raw.str = context;
> > +     spec->lr.ctx_raw.len = strlen(context);
> >
> >       catalog->nspec++;
> >
> > @@ -181,7 +182,7 @@ db_close(struct selabel_handle *rec)
> >       for (i = 0; i < catalog->nspec; i++) {
> >               spec = &catalog->specs[i];
> >               free(spec->key);
> > -             free(spec->lr.ctx_raw);
> > +             free(spec->lr.ctx_raw.str);
> >               free(spec->lr.ctx_trans);
> >       }
> >       free(catalog);
> > @@ -333,7 +334,7 @@ out_error:
> >               spec_t         *spec = &catalog->specs[i];
> >
> >               free(spec->key);
> > -             free(spec->lr.ctx_raw);
> > +             free(spec->lr.ctx_raw.str);
> >               free(spec->lr.ctx_trans);
> >       }
> >       free(catalog);
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 68c566b..ade07d8 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -71,25 +71,24 @@ static int nodups_specs(struct saved_data *data,
const char *path)
> >       for (ii = 0; ii < data->nspec; ii++) {
> >               curr_spec = &spec_arr[ii];
> >               for (jj = ii + 1; jj < data->nspec; jj++) {
> > -                     if ((!strcmp(spec_arr[jj].regex_str,
> > -                             curr_spec->regex_str))
> > +                     if (len_str_eq(&spec_arr[jj].regex_str,
&curr_spec->regex_str)
> >                           && (!spec_arr[jj].mode || !curr_spec->mode
> >                               || spec_arr[jj].mode == curr_spec->mode))
{
> >                               rc = -1;
> >                               errno = EINVAL;
> > -                             if (strcmp(spec_arr[jj].lr.ctx_raw,
> > -                                         curr_spec->lr.ctx_raw)) {
> > +                             if (!len_str_eq(&spec_arr[jj].lr.ctx_raw,
> > +                                         &curr_spec->lr.ctx_raw)) {
> >                                       COMPAT_LOG
> >                                               (SELINUX_ERROR,
> >                                                "%s: Multiple different
specifications for %s  (%s and %s).\n",
> > -                                              path,
curr_spec->regex_str,
> > -                                              spec_arr[jj].lr.ctx_raw,
> > -                                              curr_spec->lr.ctx_raw);
> > +                                              path,
curr_spec->regex_str.str,
> > +
spec_arr[jj].lr.ctx_raw.str,
> > +
curr_spec->lr.ctx_raw.str);
> >                               } else {
> >                                       COMPAT_LOG
> >                                               (SELINUX_ERROR,
> >                                                "%s: Multiple same
specifications for %s.\n",
> > -                                              path,
curr_spec->regex_str);
> > +                                              path,
curr_spec->regex_str.str);
> >                               }
> >                       }
> >               }
> > @@ -475,12 +474,13 @@ static int read_binary_file(struct selabel_handle
*rec)
> >                       goto out;
> >               }
> >
> > -             spec->lr.ctx_raw = str_buf;
> > +             spec->lr.ctx_raw.str = str_buf;
> > +             spec->lr.ctx_raw.len = entry_len -1;
> >
> > -             if (strcmp(spec->lr.ctx_raw, "<<none>>") &&
rec->validating) {
> > +             if (rec->validating && strcmp(spec->lr.ctx_raw.str,
"<<none>>")) {
> >                       if (selabel_validate(rec, &spec->lr) < 0) {
> >                               selinux_log(SELINUX_ERROR, "%s: context
%s is invalid\n",
> > -                                             data->path,
spec->lr.ctx_raw);
> > +                                             data->path,
spec->lr.ctx_raw.str);
> >                               errno = EINVAL;
> >                               free(str_buf);
> >                               goto out;
> > @@ -492,14 +492,16 @@ static int read_binary_file(struct selabel_handle
*rec)
> >               if (err < 0 || !entry_len)
> >                       goto out;
> >
> > -             spec->regex_str = (char *) map_area->next_addr;
> > +             spec->regex_str.str = (char *) map_area->next_addr;
> >               err = next_entry(NULL, map_area, entry_len);
> >               if (err < 0)
> >                       goto out;
> >
> > -             if (spec->regex_str[entry_len - 1] != '\0')
> > +             if (spec->regex_str.str[entry_len - 1] != '\0')
> >                       goto out;
> >
> > +             spec->regex_str.len = entry_len - 1;
> > +
> >               /* Process mode */
> >               if (version >= SELINUX_COMPILED_FCONTEXT_MODE)
> >                       err = next_entry(&mode, map_area, sizeof(mode));
> > @@ -715,11 +717,13 @@ static void closef(struct selabel_handle *rec)
> >       for (i = 0; i < data->nspec; i++) {
> >               spec = &data->spec_arr[i];
> >               free(spec->lr.ctx_trans);
> > -             free(spec->lr.ctx_raw);
> > +             free(spec->lr.ctx_raw.str);
> >               if (spec->from_mmap)
> >                       continue;
> > -             free(spec->regex_str);
> > -             free(spec->type_str);
> > +
> > +             free(spec->regex_str.str);
> > +             free(spec->type_str.str);
> > +
> >               if (spec->regcomp) {
> >                       pcre_free(spec->regex);
> >                       pcre_free_study(spec->sd);
> > @@ -767,6 +771,11 @@ static struct spec *lookup_common(struct
selabel_handle *rec,
> >       const char *prev_slash, *next_slash;
> >       unsigned int sofar = 0;
> >
> > +     struct len_str none = {
> > +                     .str = (char *)"<<none>>",
> > +                     .len = 8
> > +     };
> > +
> >       if (!data->nspec) {
> >               errno = ENOENT;
> >               goto finish;
> > @@ -834,7 +843,7 @@ static struct spec *lookup_common(struct
selabel_handle *rec,
> >               }
> >       }
> >
> > -     if (i < 0 || strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
> > +     if (i < 0 || len_str_eq(&spec_arr[i].lr.ctx_raw, &none)) {
> >               /* No matching specification. */
> >               errno = ENOENT;
> >               goto finish;
> > @@ -926,8 +935,8 @@ static enum selabel_cmp_result incomp(struct spec
*spec1, struct spec *spec2, co
> >       selinux_log(SELINUX_INFO,
> >                   "selabel_cmp: mismatched %s on entry %d: (%s, %x, %s)
vs entry %d: (%s, %x, %s)\n",
> >                   reason,
> > -                 i, spec1->regex_str, spec1->mode, spec1->lr.ctx_raw,
> > -                 j, spec2->regex_str, spec2->mode, spec2->lr.ctx_raw);
> > +                 i, spec1->regex_str.str, spec1->mode,
spec1->lr.ctx_raw.str,
> > +                 j, spec2->regex_str.str, spec2->mode,
spec2->lr.ctx_raw.str);
> >       return SELABEL_INCOMPARABLE;
> >  }
> >
> > @@ -976,7 +985,7 @@ static enum selabel_cmp_result cmp(struct
selabel_handle *h1,
> >                           memcmp(spec1->regex, spec2->regex, len1))
> >                               return incomp(spec1, spec2, "regex", i,
j);
> >               } else {
> > -                     if (strcmp(spec1->regex_str, spec2->regex_str))
> > +                     if (strcmp(spec1->regex_str.str,
spec2->regex_str.str))
> >                               return incomp(spec1, spec2, "regex_str",
i, j);
> >               }
> >
> > @@ -995,7 +1004,7 @@ static enum selabel_cmp_result cmp(struct
selabel_handle *h1,
> >                               return incomp(spec1, spec2, "stem", i, j);
> >               }
> >
> > -             if (strcmp(spec1->lr.ctx_raw, spec2->lr.ctx_raw))
> > +             if (!len_str_eq(&spec1->lr.ctx_raw, &spec2->lr.ctx_raw))
> >                       return incomp(spec1, spec2, "ctx_raw", i, j);
> >
> >               i++;
> > @@ -1020,17 +1029,17 @@ static void stats(struct selabel_handle *rec)
> >
> >       for (i = 0; i < nspec; i++) {
> >               if (spec_arr[i].matches == 0) {
> > -                     if (spec_arr[i].type_str) {
> > +                     if (spec_arr[i].type_str.str) {
> >                               COMPAT_LOG(SELINUX_WARNING,
> >                                   "Warning!  No matches for (%s, %s,
%s)\n",
> > -                                 spec_arr[i].regex_str,
> > -                                 spec_arr[i].type_str,
> > -                                 spec_arr[i].lr.ctx_raw);
> > +                                 spec_arr[i].regex_str.str,
> > +                                 spec_arr[i].type_str.str,
> > +                                 spec_arr[i].lr.ctx_raw.str);
> >                       } else {
> >                               COMPAT_LOG(SELINUX_WARNING,
> >                                   "Warning!  No matches for (%s, %s)\n",
> > -                                 spec_arr[i].regex_str,
> > -                                 spec_arr[i].lr.ctx_raw);
> > +                                 spec_arr[i].regex_str.str,
> > +                                 spec_arr[i].lr.ctx_raw.str);
> >                       }
> >               }
> >       }
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index da06164..cd021f4 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -26,10 +26,10 @@
> >
> >  /* A file security context specification. */
> >  struct spec {
> > -     struct selabel_lookup_rec lr;   /* holds contexts for lookup
result */
> > -     char *regex_str;        /* regular expession string for
diagnostics */
> > -     char *type_str;         /* type string for diagnostic messages */
> > -     pcre *regex;            /* compiled regular expression */
> > +     struct selabel_lookup_rec lr; /* holds contexts for lookup result
*/
> > +     struct len_str regex_str;     /* regular expession string for
diagnostics */
> > +     struct len_str type_str;     /* type string for diagnostic
messages */
> > +     pcre *regex;                  /* compiled regular expression */
> >       union {
> >               pcre_extra *sd; /* pointer to extra compiled stuff */
> >               pcre_extra lsd; /* used to hold the mmap'd version */
> > @@ -90,16 +90,19 @@ static inline pcre_extra *get_pcre_extra(struct
spec *spec)
> >               return spec->sd;
> >  }
> >
> > -static inline mode_t string_to_mode(char *mode)
> > +static inline mode_t string_to_mode(struct len_str *mode)
> >  {
> >       size_t len;
> >
> >       if (!mode)
> >               return 0;
> > -     len = strlen(mode);
> > -     if (mode[0] != '-' || len != 2)
> > +
> > +     len = mode->len;
> > +
> > +     if (mode->str[0] != '-' || len != 2)
> >               return -1;
> > -     switch (mode[1]) {
> > +
> > +     switch (mode->str[1]) {
> >       case 'b':
> >               return S_IFBLK;
> >       case 'c':
> > @@ -153,8 +156,8 @@ static inline void spec_hasMetaChars(struct spec
*spec)
> >       int len;
> >       char *end;
> >
> > -     c = spec->regex_str;
> > -     len = strlen(spec->regex_str);
> > +     c = spec->regex_str.str;
> > +     len = spec->regex_str.len;
> >       end = c + len;
> >
> >       spec->hasMetaChars = 0;
> > @@ -175,7 +178,7 @@ static inline void spec_hasMetaChars(struct spec
*spec)
> >               case '(':
> >               case '{':
> >                       spec->hasMetaChars = 1;
> > -                     spec->prefix_len = c - spec->regex_str;
> > +                     spec->prefix_len = c - spec->regex_str.str;
> >                       return;
> >               case '\\':      /* skip the next character */
> >                       c++;
> > @@ -327,13 +330,16 @@ static inline int compile_regex(struct saved_data
*data, struct spec *spec,
> >       if (spec->regcomp)
> >               return 0; /* already done */
> >
> > +     len = spec->regex_str.len;
> > +     reg_buf = spec->regex_str.str;
> > +
> >       /* Skip the fixed stem. */
> > -     reg_buf = spec->regex_str;
> > -     if (spec->stem_id >= 0)
> > +     if (spec->stem_id >= 0) {
> >               reg_buf += stem_arr[spec->stem_id].len;
> > +             len -= stem_arr[spec->stem_id].len;
> > +     }
> >
> >       /* Anchor the regular expression. */
> > -     len = strlen(reg_buf);
> >       cp = anchored_regex = malloc(len + 3);
> >       if (!anchored_regex)
> >               return -1;
> > @@ -375,7 +381,15 @@ static inline int process_line(struct
selabel_handle *rec,
> >                       char *line_buf, unsigned lineno)
> >  {
> >       int items, len, rc;
> > -     char *regex = NULL, *type = NULL, *context = NULL;
> > +
> > +     struct len_str regex = { 0 } , type = { 0 }, context  = { 0 };
> > +
> > +     /* XXX Export this as a const */
> > +     struct len_str none = {
> > +                     .str = (char *)"<<none>>",
> > +                     .len = 8
> > +     };
> > +
> >       struct saved_data *data = (struct saved_data *)rec->data;
> >       struct spec *spec_arr;
> >       unsigned int nspec = data->nspec;
> > @@ -399,21 +413,21 @@ static inline int process_line(struct
selabel_handle *rec,
> >                           "%s:  line %u is missing fields\n", path,
> >                           lineno);
> >               if (items == 1)
> > -                     free(regex);
> > +                     free(regex.str);
> >               errno = EINVAL;
> >               return -1;
> >       } else if (items == 2) {
> >               /* The type field is optional. */
> >               context = type;
> > -             type = 0;
> > +             memset(&type, 0, sizeof(type));
> >       }
> >
> > -     len = get_stem_from_spec(regex);
> > -     if (len && prefix && strncmp(prefix, regex, len)) {
> > +     len = get_stem_from_spec(regex.str);
> > +     if (len && prefix && strncmp(prefix, regex.str, len)) {
> >               /* Stem of regex does not match requested prefix,
discard. */
> > -             free(regex);
> > -             free(type);
> > -             free(context);
> > +             free(regex.str);
> > +             free(type.str);
> > +             free(context.str);
> >               return 0;
> >       }
> >
> > @@ -424,13 +438,13 @@ static inline int process_line(struct
selabel_handle *rec,
> >       spec_arr = data->spec_arr;
> >
> >       /* process and store the specification in spec. */
> > -     spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
> > -     spec_arr[nspec].regex_str = regex;
> > -
> > -     spec_arr[nspec].type_str = type;
> > +     spec_arr[nspec].stem_id = find_stem_from_spec(data, regex.str);
> > +     memcpy(&spec_arr[nspec].regex_str, &regex, sizeof(regex));
> > +     memcpy(&spec_arr[nspec].lr.ctx_raw, &context, sizeof(context));
> >       spec_arr[nspec].mode = 0;
> >
> > -     spec_arr[nspec].lr.ctx_raw = context;
> > +     if (type.str)
> > +             memcpy(&spec_arr[nspec].type_str, &type, sizeof(type));
> >
> >       /*
> >        * bump data->nspecs to cause closef() to cover it in its free
> > @@ -442,19 +456,19 @@ static inline int process_line(struct
selabel_handle *rec,
> >                           compile_regex(data, &spec_arr[nspec],
&errbuf)) {
> >               COMPAT_LOG(SELINUX_ERROR,
> >                          "%s:  line %u has invalid regex %s:  %s\n",
> > -                        path, lineno, regex,
> > +                        path, lineno, regex.str,
> >                          (errbuf ? errbuf : "out of memory"));
> >               errno = EINVAL;
> >               return -1;
> >       }
> >
> > -     if (type) {
> > -             mode_t mode = string_to_mode(type);
> > +     if (type.str) {
> > +             mode_t mode = string_to_mode(&type);
> >
> >               if (mode == (mode_t)-1) {
> >                       COMPAT_LOG(SELINUX_ERROR,
> >                                  "%s:  line %u has invalid file type
%s\n",
> > -                                path, lineno, type);
> > +                                path, lineno, type.str);
> >                       errno = EINVAL;
> >                       return -1;
> >               }
> > @@ -465,7 +479,7 @@ static inline int process_line(struct
selabel_handle *rec,
> >        * any meta characters in the RE */
> >       spec_hasMetaChars(&spec_arr[nspec]);
> >
> > -     if (strcmp(context, "<<none>>") && rec->validating)
> > +     if (rec->validating && !len_str_eq(&context, &none))
> >               compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
> >
> >       return 0;
> > diff --git a/libselinux/src/label_internal.h
b/libselinux/src/label_internal.h
> > index aa48fff..51aa33d 100644
> > --- a/libselinux/src/label_internal.h
> > +++ b/libselinux/src/label_internal.h
> > @@ -71,8 +71,28 @@ extern struct selabel_sub *selabel_subs_init(const
char *path,
> >                                   struct selabel_sub *list,
> >                                   struct selabel_digest *digest);
> >
> > +/*
> > + * A simple struct for tracking string lengths
> > + * with strings.
> > + */
> > +struct len_str {
> > +     size_t len;
> > +     char *str;
> > +};
> > +
> > +static inline bool len_str_eq(struct len_str *a, struct len_str *b)
> > +{
> > +     if (a->len != b->len)
> > +             return false;
> > +
> > +     if (a->str == b->str)
> > +             return true;
> > +
> > +     return !strcmp(a->str, b->str);
> > +}
> > +
> >  struct selabel_lookup_rec {
> > -     char * ctx_raw;
> > +     struct len_str ctx_raw;
> >       char * ctx_trans;
> >       int validated;
> >  };
> > diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> > index 622741b..e85e973 100644
> > --- a/libselinux/src/label_media.c
> > +++ b/libselinux/src/label_media.c
> > @@ -56,7 +56,8 @@ static int process_line(const char *path, char
*line_buf, int pass,
> >
> >       if (pass == 1) {
> >               data->spec_arr[data->nspec].key = key;
> > -             data->spec_arr[data->nspec].lr.ctx_raw = context;
> > +             data->spec_arr[data->nspec].lr.ctx_raw.str = context;
> > +             data->spec_arr[data->nspec].lr.ctx_raw.len =
strlen(context);
> >       }
> >
> >       data->nspec++;
> > @@ -159,7 +160,7 @@ static void close(struct selabel_handle *rec)
> >       for (i = 0; i < data->nspec; i++) {
> >               spec = &spec_arr[i];
> >               free(spec->key);
> > -             free(spec->lr.ctx_raw);
> > +             free(spec->lr.ctx_raw.str);
> >               free(spec->lr.ctx_trans);
> >       }
> >
> > diff --git a/libselinux/src/label_support.c
b/libselinux/src/label_support.c
> > index 26f9ef1..e9b842f 100644
> > --- a/libselinux/src/label_support.c
> > +++ b/libselinux/src/label_support.c
> > @@ -22,16 +22,17 @@
> >   *            errno will be set.
> >   *
> >   */
> > -static inline int read_spec_entry(char **entry, char **ptr, int *len,
const char **errbuf)
> > +static inline int read_spec_entry(struct len_str *entry, char **ptr,
const char **errbuf)
> >  {
> > -     *entry = NULL;
> > +     size_t len = 0;
> >       char *tmp_buf = NULL;
> >
> > +     memset(entry, 0, sizeof(*entry));
> > +
> >       while (isspace(**ptr) && **ptr != '\0')
> >               (*ptr)++;
> >
> >       tmp_buf = *ptr;
> > -     *len = 0;
> >
> >       while (!isspace(**ptr) && **ptr != '\0') {
> >               if (!isascii(**ptr)) {
> > @@ -40,13 +41,15 @@ static inline int read_spec_entry(char **entry,
char **ptr, int *len, const char
> >                       return -1;
> >               }
> >               (*ptr)++;
> > -             (*len)++;
> > +             len++;
> >       }
> >
> > -     if (*len) {
> > -             *entry = strndup(tmp_buf, *len);
> > -             if (!*entry)
> > +     if (len) {
> > +             entry->str = strndup(tmp_buf, len);
> > +             if (!entry->str)
> >                       return -1;
> > +
> > +             entry->len = len;
> >       }
> >
> >       return 0;
> > @@ -56,7 +59,7 @@ static inline int read_spec_entry(char **entry, char
**ptr, int *len, const char
> >   * line_buf - Buffer containing the spec entries .
> >   * errbuf   - Double pointer used for passing back specific error
messages.
> >   * num_args - The number of spec parameter entries to process.
> > - * ...      - A 'char **spec_entry' for each parameter.
> > + * ...      - A 'struct len_str **spec_entry' for each parameter.
> >   * returns  - The number of items processed. On error, it returns -1
with errno
> >   *            set and may set errbuf to a specific error message.
> >   *
> > @@ -65,8 +68,9 @@ static inline int read_spec_entry(char **entry, char
**ptr, int *len, const char
> >   */
> >  int hidden read_spec_entries(char *line_buf, const char **errbuf, int
num_args, ...)
> >  {
> > -     char **spec_entry, *buf_p;
> > -     int len, rc, items, entry_len = 0;
> > +     struct len_str *spec_entry;
> > +     char *buf_p;
> > +     int len, rc, items;
> >       va_list ap;
> >
> >       *errbuf = NULL;
> > @@ -93,20 +97,22 @@ int hidden read_spec_entries(char *line_buf, const
char **errbuf, int num_args,
> >
> >       items = 0;
> >       while (items < num_args) {
> > -             spec_entry = va_arg(ap, char **);
> > +             spec_entry = va_arg(ap, struct len_str *);
> >
> >               if (len - 1 == buf_p - line_buf) {
> >                       va_end(ap);
> >                       return items;
> >               }
> >
> > -             rc = read_spec_entry(spec_entry, &buf_p, &entry_len,
errbuf);
> > +             rc = read_spec_entry(spec_entry, &buf_p, errbuf);
> >               if (rc < 0) {
> >                       va_end(ap);
> >                       return rc;
> >               }
> > -             if (entry_len)
> > +
> > +             if (spec_entry->len) {
> >                       items++;
> > +             }
> >       }
> >       va_end(ap);
> >       return items;
> > diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> > index 700def1..cdbac8c 100644
> > --- a/libselinux/src/label_x.c
> > +++ b/libselinux/src/label_x.c
> > @@ -81,7 +81,8 @@ static int process_line(const char *path, char
*line_buf, int pass,
> >                       return 0;
> >               }
> >               data->spec_arr[data->nspec].key = key;
> > -             data->spec_arr[data->nspec].lr.ctx_raw = context;
> > +             data->spec_arr[data->nspec].lr.ctx_raw.str = context;
> > +             data->spec_arr[data->nspec].lr.ctx_raw.len =
strlen(context);
> >               free(type);
> >       }
> >
> > @@ -186,7 +187,7 @@ static void close(struct selabel_handle *rec)
> >       for (i = 0; i < data->nspec; i++) {
> >               spec = &spec_arr[i];
> >               free(spec->key);
> > -             free(spec->lr.ctx_raw);
> > +             free(spec->lr.ctx_raw.str);
> >               free(spec->lr.ctx_trans);
> >       }
> >
> > diff --git a/libselinux/src/matchpathcon.c
b/libselinux/src/matchpathcon.c
> > index 4764ab7..96c39b4 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -541,7 +541,7 @@ int compat_validate(struct selabel_handle *rec,
> >                   const char *path, unsigned lineno)
> >  {
> >       int rc;
> > -     char **ctx = &contexts->ctx_raw;
> > +     char **ctx = &contexts->ctx_raw.str;
> >
> >       if (myinvalidcon)
> >               rc = myinvalidcon(path, lineno, *ctx);
> >
>
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Seandroid-list-request@tycho.nsa.gov.

--94eb2c07d1eac27874053bdb66a8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PHAgZGlyPSJsdHIiPjwvcD4NCjxwIGRpcj0ibHRyIj5PbiBTZXAgNiwgMjAxNiAxMTo1OCwgJnF1
b3Q7U3RlcGhlbiBTbWFsbGV5JnF1b3Q7ICZsdDs8YSBocmVmPSJtYWlsdG86c2RzQHR5Y2hvLm5z
YS5nb3YiPnNkc0B0eWNoby5uc2EuZ292PC9hPiZndDsgd3JvdGU6PGJyPg0KJmd0Ozxicj4NCiZn
dDsgT24gMDgvMjkvMjAxNiAxMjoyMiBQTSwgPGEgaHJlZj0ibWFpbHRvOndpbGxpYW0uYy5yb2Jl
cnRzQGludGVsLmNvbSI+d2lsbGlhbS5jLnJvYmVydHNAaW50ZWwuY29tPC9hPiB3cm90ZTo8YnI+
DQomZ3Q7ICZndDsgRnJvbTogV2lsbGlhbSBSb2JlcnRzICZsdDs8YSBocmVmPSJtYWlsdG86d2ls
bGlhbS5jLnJvYmVydHNAaW50ZWwuY29tIj53aWxsaWFtLmMucm9iZXJ0c0BpbnRlbC5jb208L2E+
Jmd0Ozxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyBJIG5vdGljZWQsIHZpYSBncHJvZiwg
dGhhdCB0aGUgdGltZSBzcGVudCBpbiBub2R1cHNfc3BlY3MoKTxicj4NCiZndDsgJmd0OyBhY2Nv
dW50cyBmb3IgMTAwJSBvZiB0aGUgbGFiZWxfb3BlbigpIGNhbGwuPGJyPg0KJmd0OyAmZ3Q7PGJy
Pg0KJmd0OyAmZ3Q7IEl0IHNlZW1zIGFzIHRob3VnaCB0aGUgTl4yIGNvbXBhcmlzb24gdXNpbmcg
c3RyY21wIGlzIHZlcnk8YnI+DQomZ3Q7ICZndDsgc2xvdy48YnI+DQomZ3Q7ICZndDs8YnI+DQom
Z3Q7ICZndDsgRG8gdHdvIG1ham9yIHRoaW5nczo8YnI+DQomZ3Q7ICZndDsgMS4gbW92ZSB0aGUg
cmVjLSZndDt2YWxpZGF0aW5nIGNoZWNrIHRvIHRoZSBsZWZ0LCBjaGVjayB0aGUgc2ltcGxlPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgdGhpbmcgZmlyc3QgYmVmb3JlIHJ1bm5uaW5nIHRoZSBleHBlbnNp
dmUgc3RyY21wKCkuIHN0cmNtcCgpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgaXMgdXNlZCB0byBjaGVj
ayBzdHJpbmcgZXF1YWxpdHksIGNoZWNrIGxlbmd0aHMgZmlyc3QuPGJyPg0KJmd0OyAmZ3Q7IDIu
IHN0cmxlbigpIGlzIHVzZWQgYWxsIG92ZXIgdG8gY2FsY3VsYXRlIGxlbmd0aHMsIGp1c3Qgc3Rv
cmU8YnI+DQomZ3Q7ICZndDvCoCDCoCBpdCBpbiBhIHN0cnVjdCB3aXRoIHRoZSBzdHJpbmcgc28g
aXRzIHVzYWJsZSBlbHNld2hlcmUsIHJhdGhlcjxicj4NCiZndDsgJmd0O8KgIMKgIHRoYW4gcmVj
YWxjdWxhdGluZyBpdC48YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgdGV4dCAyMS40JSBz
cGVlZHVwOjxicj4NCiZndDsgJmd0OyBiZWZvcmUgdGV4dDogMjQ4PGJyPg0KJmd0OyAmZ3Q7IGFm
dGVyIHRleHQ6IDE5NTxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyBiaW5hcnkgMjQuNiUg
c3BlZWR1cDo8YnI+DQomZ3Q7ICZndDsgYmVmb3JlIGJpbjogMjM2PGJyPg0KJmd0OyAmZ3Q7IGFm
dGVyIGJpbjogMTc4PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IFNvbWUgdGhpbmdzIHRv
IHBvbmRlcjo8YnI+DQomZ3Q7ICZndDsgMS4gV2UgY2FuIHVzZSBDIEFCSSBzYWZlIHBvaW50ZXIg
aW5zdGVhZCBvZiBsZW5fc3RyIHN0cnVjdHVyZTxicj4NCiZndDsgJmd0O8KgIMKgIDxhIGhyZWY9
Imh0dHBzOi8vYml0YnVja2V0Lm9yZy9iaWxsY3JvYmVydHMvdHdpc3QiPmh0dHBzOi8vYml0YnVj
a2V0Lm9yZy9iaWxsY3JvYmVydHMvdHdpc3Q8L2E+PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgVGhlcmUg
YXJlIHByb3MgYW5kIGNvbnMgdG8gdGhpcyBhcHByb2FjaCwgbmFtZWx5IGlmIHNvbWVvbmU8YnI+
DQomZ3Q7ICZndDvCoCDCoCBjYWxscyBmcmVlKHgpIGluc3RlYWQgb2YgdHdpc3RfZnJlZSh4KTxi
cj4NCiZndDsgJmd0O8KgIMKgIEl0IGFsc28gY3VycmVudGx5IGhhcyAwIHN1cHBvcnQgZm9yIHN0
YWNrIGJhc2VkIHN0cmluZ3MgKHNpbXBsZTxicj4NCiZndDsgJmd0O8KgIMKgIGVub3VnaCB0byBh
ZGQpLiBJIHRoaW5rIHRoaXMgYXBwcm9hY2ggaXMgb3ZlcmtpbGwgaGVyZS48YnI+DQomZ3Q7PGJy
Pg0KJmd0OyBBZ3JlZWQuPGJyPg0KJmd0Ozxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyAy
LiBUaGUgbG9jYXRpb24gb2YgdGhlIHN0cl9sZW4gc3RydWN0IGFuZCByb3V0aW5lcyBzaG91bGQg
bGlrZWx5PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgbW92ZSBlbHNld2hlcmUuPGJyPg0KJmd0Ozxicj4N
CiZndDsgQWdyZWVkLjxicj4NCiZndDs8YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgMy4g
VGhlIGltcGFjdCBvbiBBbmRyb2lkIGlzIGN1cnJlbnRseSB1bm1lYXN1cmVkLCB0aGF0JiMzOTtz
IG5leHQuPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgQWxzbywgYmlvbmljIHVzZXMgc29tZXRoaW5nIGZy
b20gbGFiZWxfZmlsZS5oIGZvciBwcm9jZXNzaW5nPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgcHJvcGVy
dHlfY29udGV4dHMgZm9yIHRoZSBBbmRyb2lkIHByb3BlcnR5IHN1YnN5c3RlbS4uLiBzbzxicj4N
CiZndDsgJmd0O8KgIMKgIG5lZWQgdG8gZW5zdXJlIHRoYXQgYWxsIHdvcmtzIGFzIGFkdmVydGlz
ZWQgc3RpbGwuPGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IFRoaW5ncyB0byBkbzo8YnI+
DQomZ3Q7ICZndDsgMS4gQ2xlYW51cCB0aGUgY29kZSBsb2NhdGlvbnMsIGxpa2VseSBhIHV0aWwu
aCBvciBhIGxlbl9zdHIuaCw8YnI+DQomZ3Q7ICZndDvCoCDCoCBhIGJldHRlciBuYW1lIHdvdWxk
IGJlIG5pY2UuPGJyPg0KJmd0OyAmZ3Q7IDIuIFNwZWxsIGNoZWNrIHRoaXMgY29tbWl0IG1lc3Nh
Z2U8YnI+DQomZ3Q7PGJyPg0KJmd0OyBTZWVtcyBhIGJpdCBwcm9uZSB0byB0aGUgc3RyIGFuZCBs
ZW4gZmllbGRzIGdldHRpbmcgb3V0IG9mIHN5bmMgc2luY2U8YnI+DQomZ3Q7IHRoZXkgYXJlIGJv
dGggZGlyZWN0bHkgbWFuaXB1bGF0ZWQuPC9wPg0KPHAgZGlyPSJsdHIiPkFncmVlZCBJIGNhbiBo
YW5kbGUgdGhhdCBlYXNpbHkuIEFzIGxvbmcgYXMgeW91JiMzOTtyZSBPSyB3aXRoIHRoZSBnZW5l
cmFsIGNvbmNlcHQgSSYjMzk7bGwgY2xlYW4gdGhpcyB1cCBhbmQgc2VuZCBvdXQgYWZ0ZXIgdGhl
IHByb2Nlc3MgZmlsZSBjaGFuZ2VzLjwvcD4NCjxwIGRpcj0ibHRyIj4mZ3Q7PGJyPg0KJmd0OyAm
Z3Q7PGJyPg0KJmd0OyAmZ3Q7IFNpZ25lZC1vZmYtYnk6IFdpbGxpYW0gUm9iZXJ0cyAmbHQ7PGEg
aHJlZj0ibWFpbHRvOndpbGxpYW0uYy5yb2JlcnRzQGludGVsLmNvbSI+d2lsbGlhbS5jLnJvYmVy
dHNAaW50ZWwuY29tPC9hPiZndDs8YnI+DQomZ3Q7ICZndDsgLS0tPGJyPg0KJmd0OyAmZ3Q7wqAg
bGlic2VsaW51eC9zcmMvbGFiZWwuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA4ICsr
LS08YnI+DQomZ3Q7ICZndDvCoCBsaWJzZWxpbnV4L3NyYy9sYWJlbF9hbmRyb2lkX3Byb3BlcnR5
LmMgfCA0NCArKysrKysrKystLS0tLS0tLS0tPGJyPg0KJmd0OyAmZ3Q7wqAgbGlic2VsaW51eC9z
cmMvbGFiZWxfZGIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDcgKy0tPGJyPg0KJmd0OyAm
Z3Q7wqAgbGlic2VsaW51eC9zcmMvbGFiZWxfZmlsZS5jwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDYz
ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tPGJyPg0KJmd0OyAmZ3Q7wqAgbGlic2VsaW51eC9z
cmMvbGFiZWxfZmlsZS5owqAgwqAgwqAgwqAgwqAgwqAgwqB8IDc4ICsrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLTxicj4NCiZndDsgJmd0O8KgIGxpYnNlbGludXgvc3JjL2xhYmVsX2lu
dGVybmFsLmjCoCDCoCDCoCDCoCDCoHwgMjIgKysrKysrKysrLTxicj4NCiZndDsgJmd0O8KgIGxp
YnNlbGludXgvc3JjL2xhYmVsX21lZGlhLmPCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNSArKy08YnI+
DQomZ3Q7ICZndDvCoCBsaWJzZWxpbnV4L3NyYy9sYWJlbF9zdXBwb3J0LmPCoCDCoCDCoCDCoCDC
oCB8IDMyICsrKysrKysrLS0tLS0tPGJyPg0KJmd0OyAmZ3Q7wqAgbGlic2VsaW51eC9zcmMvbGFi
ZWxfeC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDUgKystPGJyPg0KJmd0OyAmZ3Q7wqAg
bGlic2VsaW51eC9zcmMvbWF0Y2hwYXRoY29uLmPCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJy
Pg0KJmd0OyAmZ3Q7wqAgMTAgZmlsZXMgY2hhbmdlZCwgMTU5IGluc2VydGlvbnMoKyksIDEwNyBk
ZWxldGlvbnMoLSk8YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgZGlmZiAtLWdpdCBhL2xp
YnNlbGludXgvc3JjL2xhYmVsLmMgYi9saWJzZWxpbnV4L3NyYy9sYWJlbC5jPGJyPg0KJmd0OyAm
Z3Q7IGluZGV4IDk2M2JmY2IuLjExMzI0ZWEgMTAwNjQ0PGJyPg0KJmd0OyAmZ3Q7IC0tLSBhL2xp
YnNlbGludXgvc3JjL2xhYmVsLmM8YnI+DQomZ3Q7ICZndDsgKysrIGIvbGlic2VsaW51eC9zcmMv
bGFiZWwuYzxicj4NCiZndDsgJmd0OyBAQCAtMjA5LDcgKzIwOSw3IEBAIGludCBzZWxhYmVsX3Zh
bGlkYXRlKHN0cnVjdCBzZWxhYmVsX2hhbmRsZSAqcmVjLDxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgaWYgKCFyZWMtJmd0O3ZhbGlkYXRpbmcgfHwgY29udGV4dHMtJmd0O3ZhbGlkYXRlZCk8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gb3V0Ozxicj4NCiZndDsgJmd0
Ozxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqByYyA9IHNlbGludXhfdmFsaWRhdGUoJmFtcDtjb250
ZXh0cy0mZ3Q7Y3R4X3Jhdyk7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoHJjID0gc2VsaW51eF92
YWxpZGF0ZSgmYW1wO2NvbnRleHRzLSZndDtjdHhfcmF3LnN0cik7PGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqBpZiAocmMgJmx0OyAwKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZ290byBvdXQ7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IEBAIC0yNDgsNyArMjQ4
LDcgQEAgc3RhdGljIGludCBzZWxhYmVsX2Zpbmkoc3RydWN0IHNlbGFiZWxfaGFuZGxlICpyZWMs
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KJmd0
OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBpZiAodHJhbnNsYXRpbmcgJmFtcDsmYW1w
OyAhbHItJmd0O2N0eF90cmFucyAmYW1wOyZhbXA7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoHNlbGludXhfcmF3X3RvX3RyYW5zX2NvbnRleHQobHItJmd0O2N0eF9yYXcsICZhbXA7bHIt
Jmd0O2N0eF90cmFucykpPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoHNlbGludXhfcmF3
X3RvX3RyYW5zX2NvbnRleHQobHItJmd0O2N0eF9yYXcuc3RyLCAmYW1wO2xyLSZndDtjdHhfdHJh
bnMpKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOzxicj4N
CiZndDsgJmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KJmd0OyAm
Z3Q7IEBAIC0zNjksNyArMzY5LDcgQEAgaW50IHNlbGFiZWxfbG9va3VwX3JhdyhzdHJ1Y3Qgc2Vs
YWJlbF9oYW5kbGUgKnJlYywgY2hhciAqKmNvbiw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoGlm
ICghbHIpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJy
Pg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCpjb24gPSBzdHJkdXAobHItJmd0
O2N0eF9yYXcpOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAqY29uID0gc3RyZHVwKGxyLSZndDtj
dHhfcmF3LnN0cik7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqByZXR1cm4gKmNvbiA/IDAgOiAt
MTs8YnI+DQomZ3Q7ICZndDvCoCB9PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IEBAIC00
MjksNyArNDI5LDcgQEAgaW50IHNlbGFiZWxfbG9va3VwX2Jlc3RfbWF0Y2hfcmF3KHN0cnVjdCBz
ZWxhYmVsX2hhbmRsZSAqcmVjLCBjaGFyICoqY29uLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKg
aWYgKCFscik8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtMTs8
YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgKmNvbiA9IHN0cmR1cChsci0m
Z3Q7Y3R4X3Jhdyk7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCpjb24gPSBzdHJkdXAobHItJmd0
O2N0eF9yYXcuc3RyKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoHJldHVybiAqY29uID8gMCA6
IC0xOzxicj4NCiZndDsgJmd0O8KgIH08YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgZGlm
ZiAtLWdpdCBhL2xpYnNlbGludXgvc3JjL2xhYmVsX2FuZHJvaWRfcHJvcGVydHkuYyBiL2xpYnNl
bGludXgvc3JjL2xhYmVsX2FuZHJvaWRfcHJvcGVydHkuYzxicj4NCiZndDsgJmd0OyBpbmRleCAy
OTBiNDM4Li5hZjBiOWE4IDEwMDY0NDxicj4NCiZndDsgJmd0OyAtLS0gYS9saWJzZWxpbnV4L3Ny
Yy9sYWJlbF9hbmRyb2lkX3Byb3BlcnR5LmM8YnI+DQomZ3Q7ICZndDsgKysrIGIvbGlic2VsaW51
eC9zcmMvbGFiZWxfYW5kcm9pZF9wcm9wZXJ0eS5jPGJyPg0KJmd0OyAmZ3Q7IEBAIC0xNiw3ICsx
Niw3IEBAPGJyPg0KJmd0OyAmZ3Q7wqAgLyogQSBwcm9wZXJ0eSBzZWN1cml0eSBjb250ZXh0IHNw
ZWNpZmljYXRpb24uICovPGJyPg0KJmd0OyAmZ3Q7wqAgdHlwZWRlZiBzdHJ1Y3Qgc3BlYyB7PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBzdHJ1Y3Qgc2VsYWJlbF9sb29rdXBfcmVjIGxyO8KgIMKg
LyogaG9sZHMgY29udGV4dHMgZm9yIGxvb2t1cCByZXN1bHQgKi88YnI+DQomZ3Q7ICZndDsgLcKg
IMKgIMKgY2hhciAqcHJvcGVydHlfa2V5O8KgIMKgIMKgIMKgIMKgIMKgIMKgLyogcHJvcGVydHkg
a2V5IHN0cmluZyAqLzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqBzdHJ1Y3QgbGVuX3N0ciBwcm9w
ZXJ0eV9rZXk7wqAgwqAgwqAgwqAgwqAgwqAgLyogcHJvcGVydHkga2V5IHN0cmluZyAqLzxicj4N
CiZndDsgJmd0O8KgIH0gc3BlY190Ozxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0O8KgIC8q
IE91ciBzdG9yZWQgY29uZmlndXJhdGlvbiAqLzxicj4NCiZndDsgJmd0OyBAQCAtMzMsMTMgKzMz
LDEzIEBAIHN0YXRpYyBpbnQgY21wKGNvbnN0IHZvaWQgKkEsIGNvbnN0IHZvaWQgKkIpPGJyPg0K
Jmd0OyAmZ3Q7wqAgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgY29uc3Qgc3RydWN0IHNwZWMg
KnNwMSA9IEEsICpzcDIgPSBCOzxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyAtwqAgwqAg
wqBpZiAoc3RybmNtcChzcDEtJmd0O3Byb3BlcnR5X2tleSwgJnF1b3Q7KiZxdW90OywgMSkgPT0g
MCk8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgaWYgKHN0cm5jbXAoc3AxLSZndDtwcm9wZXJ0eV9r
ZXkuc3RyLCAmcXVvdDsqJnF1b3Q7LCAxKSA9PSAwKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0dXJuIDE7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoGlmIChzdHJuY21w
KHNwMi0mZ3Q7cHJvcGVydHlfa2V5LCAmcXVvdDsqJnF1b3Q7LCAxKSA9PSAwKTxicj4NCiZndDsg
Jmd0OyArwqAgwqAgwqBpZiAoc3RybmNtcChzcDItJmd0O3Byb3BlcnR5X2tleS5zdHIsICZxdW90
OyomcXVvdDssIDEpID09IDApPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gLTE7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoHNpemVfdCBM
MSA9IHN0cmxlbihzcDEtJmd0O3Byb3BlcnR5X2tleSk7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDC
oHNpemVfdCBMMiA9IHN0cmxlbihzcDItJmd0O3Byb3BlcnR5X2tleSk7PGJyPg0KJmd0OyAmZ3Q7
ICvCoCDCoCDCoHNpemVfdCBMMSA9IHNwMS0mZ3Q7cHJvcGVydHlfa2V5Lmxlbjs8YnI+DQomZ3Q7
ICZndDsgK8KgIMKgIMKgc2l6ZV90IEwyID0gc3AyLSZndDtwcm9wZXJ0eV9rZXkubGVuOzxicj4N
CiZndDsgJmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgcmV0dXJuIChMMSAmbHQ7IEwyKSAt
IChMMSAmZ3Q7IEwyKTs8YnI+DQomZ3Q7ICZndDvCoCB9PGJyPg0KJmd0OyAmZ3Q7IEBAIC01Niwy
MyArNTYsMjMgQEAgc3RhdGljIGludCBub2R1cHNfc3BlY3Moc3RydWN0IHNhdmVkX2RhdGEgKmRh
dGEsIGNvbnN0IGNoYXIgKnBhdGgpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBmb3IgKGlpID0g
MDsgaWkgJmx0OyBkYXRhLSZndDtuc3BlYzsgaWkrKykgezxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgY3Vycl9zcGVjID0gJmFtcDtzcGVjX2FycltpaV07PGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgKGpqID0gaWkgKyAxOyBqaiAmbHQ7IGRhdGEt
Jmd0O25zcGVjOyBqaisrKSB7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmICghc3RyY21wKHNwZWNfYXJyW2pqXS5wcm9wZXJ0eV9rZXksPGJyPg0KJmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGN1cnJfc3BlYy0mZ3Q7cHJvcGVydHlfa2V5KSkgezxicj4NCiZndDsgJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobGVuX3N0cl9lcSgmYW1wO3Nw
ZWNfYXJyW2pqXS5wcm9wZXJ0eV9rZXksPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7Y3Vycl9z
cGVjLSZndDtwcm9wZXJ0eV9rZXkpKSB7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYyA9IC0xOzxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJybm8gPSBFSU5WQUw7
PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIChzdHJjbXAoc3BlY19hcnJbampdLmxyLmN0eF9yYXcsPGJyPg0KJmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGN1cnJfc3BlYy0mZ3Q7bHIuY3R4X3JhdykpIHs8YnI+DQomZ3Q7ICZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCFsZW5f
c3RyX2VxKCZhbXA7c3BlY19hcnJbampdLmxyLmN0eF9yYXcsPGJyPg0KJmd0OyAmZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCZhbXA7Y3Vycl9zcGVjLSZndDtsci5jdHhfcmF3KSkgezxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgc2VsaW51eF9sb2c8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChTRUxJTlVYX0VS
Uk9SLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90OyVzOiBNdWx0aXBsZSBkaWZm
ZXJlbnQgc3BlY2lmaWNhdGlvbnMgZm9yICVzwqAgKCVzIGFuZCAlcykuXG4mcXVvdDssPGJyPg0K
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXRoLCBjdXJyX3NwZWMtJmd0O3Byb3BlcnR5X2tleSw8
YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNwZWNfYXJyW2pqXS5sci5jdHhfcmF3LDxicj4N
CiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY3Vycl9zcGVjLSZndDtsci5jdHhfcmF3KTs8YnI+DQom
Z3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhdGgsIGN1cnJfc3BlYy0mZ3Q7cHJvcGVydHlfa2V5LnN0
ciw8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNwZWNfYXJyW2pqXS5sci5jdHhfcmF3LnN0
ciw8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGN1cnJfc3BlYy0mZ3Q7bHIuY3R4X3Jhdy5z
dHIpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfSBlbHNlIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGludXhfbG9nPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAoU0VMSU5VWF9FUlJPUiw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAmcXVvdDslczogTXVsdGlwbGUgc2FtZSBzcGVjaWZpY2F0aW9ucyBmb3IgJXMuXG4mcXVv
dDssPGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXRoLCBjdXJyX3NwZWMtJmd0O3Byb3Bl
cnR5X2tleSk7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXRoLCBjdXJyX3NwZWMtJmd0
O3Byb3BlcnR5X2tleS5zdHIpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fTxicj4NCiZndDsgJmd0OyBAQCAtODUsNyArODUsNyBAQCBzdGF0aWMgaW50IHByb2Nlc3NfbGlu
ZShzdHJ1Y3Qgc2VsYWJlbF9oYW5kbGUgKnJlYyw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludCBwYXNzLCB1bnNpZ25lZCBsaW5lbm8pPGJyPg0KJmd0
OyAmZ3Q7wqAgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgaW50IGl0ZW1zOzxicj4NCiZndDsg
Jmd0OyAtwqAgwqAgwqBjaGFyICpwcm9wID0gTlVMTCwgKmNvbnRleHQgPSBOVUxMOzxicj4NCiZn
dDsgJmd0OyArwqAgwqAgwqBzdHJ1Y3QgbGVuX3N0ciAqcHJvcCA9IHsgMCB9LCAqY29udGV4dCA9
IHsgMCB9Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgc3RydWN0IHNhdmVkX2RhdGEgKmRhdGEg
PSAoc3RydWN0IHNhdmVkX2RhdGEgKilyZWMtJmd0O2RhdGE7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqBzcGVjX3QgKnNwZWNfYXJyID0gZGF0YS0mZ3Q7c3BlY19hcnI7PGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgbnNwZWMgPSBkYXRhLSZndDtuc3BlYzs8YnI+DQomZ3Q7
ICZndDsgQEAgLTExOCwxNCArMTE4LDE0IEBAIHN0YXRpYyBpbnQgcHJvY2Vzc19saW5lKHN0cnVj
dCBzZWxhYmVsX2hhbmRsZSAqcmVjLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZnJlZShjb250ZXh0KTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoH0gZWxzZSBpZiAocGFz
cyA9PSAxKSB7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBPbiB0aGUg
c2Vjb25kIHBhc3MsIHByb2Nlc3MgYW5kIHN0b3JlIHRoZSBzcGVjaWZpY2F0aW9uIGluIHNwZWMu
ICovPGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoHNwZWNfYXJyW25zcGVjXS5w
cm9wZXJ0eV9rZXkgPSBwcm9wOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqBz
cGVjX2Fycltuc3BlY10ubHIuY3R4X3JhdyA9IGNvbnRleHQ7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoG1lbWNweSgmYW1wO3NwZWNfYXJyW25zcGVjXS5wcm9wZXJ0eV9rZXks
IHByb3AsIHNpemVvZigqcHJvcCkpOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqBtZW1jcHkoJmFtcDtzcGVjX2Fycltuc3BlY10ubHIuY3R4X3JhdywgY29udGV4dCwgc2l6ZW9m
KCpjb250ZXh0KSk7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAocmVjLSZndDt2YWxpZGF0aW5nKSB7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc2VsYWJlbF92YWxpZGF0ZShyZWMsICZhbXA7
c3BlY19hcnJbbnNwZWNdLmxyKSAmbHQ7IDApIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGludXhfbG9nKFNFTElOVVhfRVJS
T1IsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDslczrCoCBsaW5lICV1IGhhcyBpbnZhbGlk
IGNvbnRleHQgJXNcbiZxdW90Oyw8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGF0aCwgbGluZW5vLCBz
cGVjX2Fycltuc3BlY10ubHIuY3R4X3Jhdyk7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBhdGgsIGxp
bmVubywgc3BlY19hcnJbbnNwZWNdLmxyLmN0eF9yYXcuc3RyKTs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycm5vID0gRUlOVkFM
Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0dXJuIC0xOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfTxicj4NCiZndDsgJmd0OyBAQCAtMjMzLDggKzIzMyw4IEBAIHN0YXRpYyB2b2lk
IGNsb3NlZihzdHJ1Y3Qgc2VsYWJlbF9oYW5kbGUgKnJlYyk8YnI+DQomZ3Q7ICZndDs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBkYXRhLSZndDtuc3BlYzsgaSsr
KSB7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjID0gJmFtcDtkYXRh
LSZndDtzcGVjX2FycltpXTs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgZnJl
ZShzcGVjLSZndDtwcm9wZXJ0eV9rZXkpOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqBmcmVlKHNwZWMtJmd0O2xyLmN0eF9yYXcpOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqBmcmVlKHNwZWMtJmd0O3Byb3BlcnR5X2tleS5zdHIpOzxicj4NCiZndDsgJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKHNwZWMtJmd0O2xyLmN0eF9yYXcuc3RyKTs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWUoc3BlYy0mZ3Q7bHIuY3R4X3Ry
YW5zKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoH08YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7
ICZndDsgQEAgLTI1OSwxMSArMjU5LDExIEBAIHN0YXRpYyBzdHJ1Y3Qgc2VsYWJlbF9sb29rdXBf
cmVjICpsb29rdXAoc3RydWN0IHNlbGFiZWxfaGFuZGxlICpyZWMsPGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBmb3IgKGkg
PSAwOyBpICZsdDsgZGF0YS0mZ3Q7bnNwZWM7IGkrKykgezxicj4NCiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoc3RybmNtcChzcGVjX2FycltpXS5wcm9wZXJ0eV9rZXksIGtleSw8
YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3Ry
bGVuKHNwZWNfYXJyW2ldLnByb3BlcnR5X2tleSkpID09IDApIHs8YnI+DQomZ3Q7ICZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgKHN0cm5jbXAoc3BlY19hcnJbaV0ucHJvcGVydHlfa2V5LnN0
ciwga2V5LDxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBzcGVjX2FycltpXS5wcm9wZXJ0eV9rZXkubGVuKSA9PSAwKSB7PGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgKHN0cm5jbXAoc3BlY19hcnJbaV0ucHJvcGVydHlfa2V5LCAmcXVvdDsqJnF1b3Q7LCAx
KSA9PSAwKTxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc3RybmNtcChz
cGVjX2FycltpXS5wcm9wZXJ0eV9rZXkuc3RyLCAmcXVvdDsqJnF1b3Q7LCAxKSA9PSAwKTxicj4N
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IGRpZmYg
LS1naXQgYS9saWJzZWxpbnV4L3NyYy9sYWJlbF9kYi5jIGIvbGlic2VsaW51eC9zcmMvbGFiZWxf
ZGIuYzxicj4NCiZndDsgJmd0OyBpbmRleCAxMTU1YmNjLi5jNzAwYWNhIDEwMDY0NDxicj4NCiZn
dDsgJmd0OyAtLS0gYS9saWJzZWxpbnV4L3NyYy9sYWJlbF9kYi5jPGJyPg0KJmd0OyAmZ3Q7ICsr
KyBiL2xpYnNlbGludXgvc3JjL2xhYmVsX2RiLmM8YnI+DQomZ3Q7ICZndDsgQEAgLTE1Myw3ICsx
NTMsOCBAQCBwcm9jZXNzX2xpbmUoY29uc3QgY2hhciAqcGF0aCwgY2hhciAqbGluZV9idWYsIHVu
c2lnbmVkIGludCBsaW5lX251bSw8YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCDCoGZyZWUodHlwZSk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBzcGVjLSZndDtrZXkgPSBr
ZXk7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoHNwZWMtJmd0O2xyLmN0eF9yYXcgPSBjb250ZXh0
Ozxicj4NCiZndDsgJmd0OyArwqAgwqAgwqBzcGVjLSZndDtsci5jdHhfcmF3LnN0ciA9IGNvbnRl
eHQ7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoHNwZWMtJmd0O2xyLmN0eF9yYXcubGVuID0gc3Ry
bGVuKGNvbnRleHQpOzxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgY2F0
YWxvZy0mZ3Q7bnNwZWMrKzs8YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgQEAgLTE4MSw3
ICsxODIsNyBAQCBkYl9jbG9zZShzdHJ1Y3Qgc2VsYWJlbF9oYW5kbGUgKnJlYyk8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBjYXRhbG9nLSZndDtuc3BlYzsgaSsr
KSB7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjID0gJmFtcDtjYXRh
bG9nLSZndDtzcGVjc1tpXTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZy
ZWUoc3BlYy0mZ3Q7a2V5KTs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgZnJl
ZShzcGVjLSZndDtsci5jdHhfcmF3KTs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgZnJlZShzcGVjLSZndDtsci5jdHhfcmF3LnN0cik7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBmcmVlKHNwZWMtJmd0O2xyLmN0eF90cmFucyk7PGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBmcmVlKGNhdGFsb2cpOzxicj4N
CiZndDsgJmd0OyBAQCAtMzMzLDcgKzMzNCw3IEBAIG91dF9lcnJvcjo8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNwZWNfdMKgIMKgIMKgIMKgIMKgKnNwZWMgPSAmYW1wO2Nh
dGFsb2ctJmd0O3NwZWNzW2ldOzxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZnJlZShzcGVjLSZndDtrZXkpOzxicj4NCiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqBmcmVlKHNwZWMtJmd0O2xyLmN0eF9yYXcpOzxicj4NCiZndDsgJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKHNwZWMtJmd0O2xyLmN0eF9yYXcuc3RyKTs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWUoc3BlYy0mZ3Q7bHIuY3R4X3RyYW5z
KTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoH08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoGZy
ZWUoY2F0YWxvZyk7PGJyPg0KJmd0OyAmZ3Q7IGRpZmYgLS1naXQgYS9saWJzZWxpbnV4L3NyYy9s
YWJlbF9maWxlLmMgYi9saWJzZWxpbnV4L3NyYy9sYWJlbF9maWxlLmM8YnI+DQomZ3Q7ICZndDsg
aW5kZXggNjhjNTY2Yi4uYWRlMDdkOCAxMDA2NDQ8YnI+DQomZ3Q7ICZndDsgLS0tIGEvbGlic2Vs
aW51eC9zcmMvbGFiZWxfZmlsZS5jPGJyPg0KJmd0OyAmZ3Q7ICsrKyBiL2xpYnNlbGludXgvc3Jj
L2xhYmVsX2ZpbGUuYzxicj4NCiZndDsgJmd0OyBAQCAtNzEsMjUgKzcxLDI0IEBAIHN0YXRpYyBp
bnQgbm9kdXBzX3NwZWNzKHN0cnVjdCBzYXZlZF9kYXRhICpkYXRhLCBjb25zdCBjaGFyICpwYXRo
KTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgZm9yIChpaSA9IDA7IGlpICZsdDsgZGF0YS0mZ3Q7
bnNwZWM7IGlpKyspIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGN1cnJf
c3BlYyA9ICZhbXA7c3BlY19hcnJbaWldOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZm9yIChqaiA9IGlpICsgMTsgamogJmx0OyBkYXRhLSZndDtuc3BlYzsgamorKykgezxi
cj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoKCFzdHJj
bXAoc3BlY19hcnJbampdLnJlZ2V4X3N0ciw8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY3Vycl9zcGVjLSZndDtyZWdleF9zdHIpKTxi
cj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobGVuX3N0
cl9lcSgmYW1wO3NwZWNfYXJyW2pqXS5yZWdleF9zdHIsICZhbXA7Y3Vycl9zcGVjLSZndDtyZWdl
eF9zdHIpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAmYW1wOyZhbXA7ICghc3BlY19hcnJbampdLm1vZGUgfHwgIWN1cnJfc3BlYy0mZ3Q7bW9k
ZTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfHwgc3BlY19hcnJbampdLm1vZGUgPT0gY3Vycl9zcGVjLSZndDttb2RlKSkgezxicj4N
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmMgPSAtMTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGVycm5vID0gRUlOVkFMOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc3RyY21wKHNwZWNfYXJyW2pqXS5s
ci5jdHhfcmF3LDxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjdXJyX3NwZWMtJmd0O2xyLmN0eF9yYXcp
KSB7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmICghbGVuX3N0cl9lcSgmYW1wO3NwZWNfYXJyW2pqXS5sci5jdHhfcmF3LDxicj4N
CiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAmYW1wO2N1cnJfc3BlYy0mZ3Q7bHIuY3R4X3JhdykpIHs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoENPTVBBVF9MT0c8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChTRUxJTlVY
X0VSUk9SLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90OyVzOiBNdWx0aXBsZSBk
aWZmZXJlbnQgc3BlY2lmaWNhdGlvbnMgZm9yICVzwqAgKCVzIGFuZCAlcykuXG4mcXVvdDssPGJy
Pg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXRoLCBjdXJyX3NwZWMtJmd0O3JlZ2V4X3N0ciw8
YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNwZWNfYXJyW2pqXS5sci5jdHhfcmF3LDxicj4N
CiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY3Vycl9zcGVjLSZndDtsci5jdHhfcmF3KTs8YnI+DQom
Z3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhdGgsIGN1cnJfc3BlYy0mZ3Q7cmVnZXhfc3RyLnN0ciw8
YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNwZWNfYXJyW2pqXS5sci5jdHhfcmF3LnN0ciw8
YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGN1cnJfc3BlYy0mZ3Q7bHIuY3R4X3Jhdy5zdHIp
Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfSBlbHNlIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENPTVBBVF9MT0c8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoChTRUxJTlVYX0VSUk9SLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICZxdW90OyVzOiBNdWx0aXBsZSBzYW1lIHNwZWNpZmljYXRpb25zIGZvciAlcy5cbiZxdW90Oyw8
YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhdGgsIGN1cnJfc3BlYy0mZ3Q7cmVnZXhfc3Ry
KTs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhdGgsIGN1cnJfc3BlYy0mZ3Q7cmVnZXhf
c3RyLnN0cik7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0
OyAmZ3Q7IEBAIC00NzUsMTIgKzQ3NCwxMyBAQCBzdGF0aWMgaW50IHJlYWRfYmluYXJ5X2ZpbGUo
c3RydWN0IHNlbGFiZWxfaGFuZGxlICpyZWMpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIG91dDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoH08YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgc3BlYy0mZ3Q7bHIuY3R4X3JhdyA9IHN0cl9idWY7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoHNwZWMtJmd0O2xyLmN0eF9yYXcuc3RyID0gc3RyX2J1Zjs8YnI+DQom
Z3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgc3BlYy0mZ3Q7bHIuY3R4X3Jhdy5sZW4gPSBl
bnRyeV9sZW4gLTE7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoGlmIChzdHJjbXAoc3BlYy0mZ3Q7bHIuY3R4X3JhdywgJnF1b3Q7Jmx0OyZsdDtub25l
Jmd0OyZndDsmcXVvdDspICZhbXA7JmFtcDsgcmVjLSZndDt2YWxpZGF0aW5nKSB7PGJyPg0KJmd0
OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZWMtJmd0O3ZhbGlkYXRpbmcgJmFtcDsm
YW1wOyBzdHJjbXAoc3BlYy0mZ3Q7bHIuY3R4X3Jhdy5zdHIsICZxdW90OyZsdDsmbHQ7bm9uZSZn
dDsmZ3Q7JnF1b3Q7KSkgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgKHNlbGFiZWxfdmFsaWRhdGUocmVjLCAmYW1wO3NwZWMtJmd0O2xyKSAmbHQ7
IDApIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHNlbGludXhfbG9nKFNFTElOVVhfRVJST1IsICZxdW90OyVzOiBjb250ZXh0ICVz
IGlzIGludmFsaWRcbiZxdW90Oyw8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGF0YS0mZ3Q7
cGF0aCwgc3BlYy0mZ3Q7bHIuY3R4X3Jhdyk7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRh
dGEtJmd0O3BhdGgsIHNwZWMtJmd0O2xyLmN0eF9yYXcuc3RyKTs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycm5vID0gRUlOVkFM
Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZnJlZShzdHJfYnVmKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gb3V0Ozxicj4NCiZndDsgJmd0OyBAQCAtNDky
LDE0ICs0OTIsMTYgQEAgc3RhdGljIGludCByZWFkX2JpbmFyeV9maWxlKHN0cnVjdCBzZWxhYmVs
X2hhbmRsZSAqcmVjKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGVy
ciAmbHQ7IDAgfHwgIWVudHJ5X2xlbik8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGdvdG8gb3V0Ozxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjLSZndDtyZWdleF9zdHIgPSAoY2hhciAqKSBtYXBfYXJl
YS0mZ3Q7bmV4dF9hZGRyOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVj
LSZndDtyZWdleF9zdHIuc3RyID0gKGNoYXIgKikgbWFwX2FyZWEtJmd0O25leHRfYWRkcjs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVyciA9IG5leHRfZW50cnkoTlVMTCwg
bWFwX2FyZWEsIGVudHJ5X2xlbik7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAoZXJyICZsdDsgMCk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGdvdG8gb3V0Ozxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoc3BlYy0mZ3Q7cmVnZXhfc3RyW2VudHJ5X2xlbiAtIDFdICE9ICYj
Mzk7XDAmIzM5Oyk8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHNwZWMt
Jmd0O3JlZ2V4X3N0ci5zdHJbZW50cnlfbGVuIC0gMV0gIT0gJiMzOTtcMCYjMzk7KTxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBvdXQ7PGJyPg0K
Jmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHNwZWMtJmd0O3Jl
Z2V4X3N0ci5sZW4gPSBlbnRyeV9sZW4gLSAxOzxicj4NCiZndDsgJmd0OyArPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBQcm9jZXNzIG1vZGUgKi88YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICh2ZXJzaW9uICZndDs9IFNFTElOVVhfQ09NUElM
RURfRkNPTlRFWFRfTU9ERSk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGVyciA9IG5leHRfZW50cnkoJmFtcDttb2RlLCBtYXBfYXJlYSwgc2l6ZW9mKG1v
ZGUpKTs8YnI+DQomZ3Q7ICZndDsgQEAgLTcxNSwxMSArNzE3LDEzIEBAIHN0YXRpYyB2b2lkIGNs
b3NlZihzdHJ1Y3Qgc2VsYWJlbF9oYW5kbGUgKnJlYyk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDC
oGZvciAoaSA9IDA7IGkgJmx0OyBkYXRhLSZndDtuc3BlYzsgaSsrKSB7PGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjID0gJmFtcDtkYXRhLSZndDtzcGVjX2FycltpXTs8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWUoc3BlYy0mZ3Q7bHIuY3R4
X3RyYW5zKTs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShzcGVjLSZn
dDtsci5jdHhfcmF3KTs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShz
cGVjLSZndDtsci5jdHhfcmF3LnN0cik7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiAoc3BlYy0mZ3Q7ZnJvbV9tbWFwKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGludWU7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoGZyZWUoc3BlYy0mZ3Q7cmVnZXhfc3RyKTs8YnI+DQomZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgZnJlZShzcGVjLSZndDt0eXBlX3N0cik7PGJyPg0KJmd0OyAmZ3Q7ICs8
YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShzcGVjLSZndDtyZWdleF9z
dHIuc3RyKTs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShzcGVjLSZn
dDt0eXBlX3N0ci5zdHIpOzxicj4NCiZndDsgJmd0OyArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoc3BlYy0mZ3Q7cmVnY29tcCkgezxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGNyZV9mcmVlKHNwZWMtJmd0O3JlZ2V4KTs8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBjcmVfZnJl
ZV9zdHVkeShzcGVjLSZndDtzZCk7PGJyPg0KJmd0OyAmZ3Q7IEBAIC03NjcsNiArNzcxLDExIEBA
IHN0YXRpYyBzdHJ1Y3Qgc3BlYyAqbG9va3VwX2NvbW1vbihzdHJ1Y3Qgc2VsYWJlbF9oYW5kbGUg
KnJlYyw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoGNvbnN0IGNoYXIgKnByZXZfc2xhc2gsICpu
ZXh0X3NsYXNoOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgdW5zaWduZWQgaW50IHNvZmFyID0g
MDs8YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgc3RydWN0IGxlbl9zdHIg
bm9uZSA9IHs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
LnN0ciA9IChjaGFyICopJnF1b3Q7Jmx0OyZsdDtub25lJmd0OyZndDsmcXVvdDssPGJyPg0KJmd0
OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5sZW4gPSA4PGJyPg0KJmd0
OyAmZ3Q7ICvCoCDCoCDCoH07PGJyPg0KJmd0OyAmZ3Q7ICs8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCDCoGlmICghZGF0YS0mZ3Q7bnNwZWMpIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGVycm5vID0gRU5PRU5UOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZ290byBmaW5pc2g7PGJyPg0KJmd0OyAmZ3Q7IEBAIC04MzQsNyArODQzLDcgQEAgc3RhdGlj
IHN0cnVjdCBzcGVjICpsb29rdXBfY29tbW9uKHN0cnVjdCBzZWxhYmVsX2hhbmRsZSAqcmVjLDxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgfTxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqBpZiAoaSAmbHQ7
IDAgfHwgc3RyY21wKHNwZWNfYXJyW2ldLmxyLmN0eF9yYXcsICZxdW90OyZsdDsmbHQ7bm9uZSZn
dDsmZ3Q7JnF1b3Q7KSA9PSAwKSB7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoGlmIChpICZsdDsg
MCB8fCBsZW5fc3RyX2VxKCZhbXA7c3BlY19hcnJbaV0ubHIuY3R4X3JhdywgJmFtcDtub25lKSkg
ezxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogTm8gbWF0Y2hpbmcgc3Bl
Y2lmaWNhdGlvbi4gKi88YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycm5v
ID0gRU5PRU5UOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBmaW5p
c2g7PGJyPg0KJmd0OyAmZ3Q7IEBAIC05MjYsOCArOTM1LDggQEAgc3RhdGljIGVudW0gc2VsYWJl
bF9jbXBfcmVzdWx0IGluY29tcChzdHJ1Y3Qgc3BlYyAqc3BlYzEsIHN0cnVjdCBzcGVjICpzcGVj
MiwgY288YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoHNlbGludXhfbG9nKFNFTElOVVhfSU5GTyw8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O3NlbGFiZWxf
Y21wOiBtaXNtYXRjaGVkICVzIG9uIGVudHJ5ICVkOiAoJXMsICV4LCAlcykgdnMgZW50cnkgJWQ6
ICglcywgJXgsICVzKVxuJnF1b3Q7LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmVhc29uLDxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpLCBzcGVjMS0mZ3Q7cmVnZXhfc3RyLCBzcGVjMS0mZ3Q7bW9kZSwgc3BlYzEtJmd0O2xyLmN0
eF9yYXcsPGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGosIHNwZWMy
LSZndDtyZWdleF9zdHIsIHNwZWMyLSZndDttb2RlLCBzcGVjMi0mZ3Q7bHIuY3R4X3Jhdyk7PGJy
Pg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGksIHNwZWMxLSZndDtyZWdl
eF9zdHIuc3RyLCBzcGVjMS0mZ3Q7bW9kZSwgc3BlYzEtJmd0O2xyLmN0eF9yYXcuc3RyLDxicj4N
CiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBqLCBzcGVjMi0mZ3Q7cmVnZXhf
c3RyLnN0ciwgc3BlYzItJmd0O21vZGUsIHNwZWMyLSZndDtsci5jdHhfcmF3LnN0cik7PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqByZXR1cm4gU0VMQUJFTF9JTkNPTVBBUkFCTEU7PGJyPg0KJmd0
OyAmZ3Q7wqAgfTxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyBAQCAtOTc2LDcgKzk4NSw3
IEBAIHN0YXRpYyBlbnVtIHNlbGFiZWxfY21wX3Jlc3VsdCBjbXAoc3RydWN0IHNlbGFiZWxfaGFu
ZGxlICpoMSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoG1lbWNtcChzcGVjMS0mZ3Q7cmVnZXgsIHNwZWMyLSZndDtyZWdleCwgbGVuMSkpPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm4gaW5jb21wKHNwZWMxLCBzcGVjMiwgJnF1b3Q7cmVnZXgmcXVvdDssIGksIGopOzxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlIHs8YnI+DQomZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHN0cmNtcChzcGVjMS0mZ3Q7
cmVnZXhfc3RyLCBzcGVjMi0mZ3Q7cmVnZXhfc3RyKSk8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHN0cmNtcChzcGVjMS0mZ3Q7cmVnZXhfc3RyLnN0
ciwgc3BlYzItJmd0O3JlZ2V4X3N0ci5zdHIpKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGluY29tcChzcGVjMSwgc3Bl
YzIsICZxdW90O3JlZ2V4X3N0ciZxdW90OywgaSwgaik7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IEBAIC05OTUsNyAr
MTAwNCw3IEBAIHN0YXRpYyBlbnVtIHNlbGFiZWxfY21wX3Jlc3VsdCBjbXAoc3RydWN0IHNlbGFi
ZWxfaGFuZGxlICpoMSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBpbmNvbXAoc3BlYzEsIHNwZWMyLCAmcXVvdDtzdGVt
JnF1b3Q7LCBpLCBqKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+
DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHN0cmNt
cChzcGVjMS0mZ3Q7bHIuY3R4X3Jhdywgc3BlYzItJmd0O2xyLmN0eF9yYXcpKTxicj4NCiZndDsg
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIWxlbl9zdHJfZXEoJmFtcDtzcGVjMS0mZ3Q7
bHIuY3R4X3JhdywgJmFtcDtzcGVjMi0mZ3Q7bHIuY3R4X3JhdykpPGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gaW5jb21wKHNwZWMxLCBzcGVj
MiwgJnF1b3Q7Y3R4X3JhdyZxdW90OywgaSwgaik7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpKys7PGJyPg0KJmd0OyAmZ3Q7IEBAIC0xMDIwLDE3
ICsxMDI5LDE3IEBAIHN0YXRpYyB2b2lkIHN0YXRzKHN0cnVjdCBzZWxhYmVsX2hhbmRsZSAqcmVj
KTxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAm
bHQ7IG5zcGVjOyBpKyspIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChzcGVjX2FycltpXS5tYXRjaGVzID09IDApIHs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHNwZWNfYXJyW2ldLnR5cGVfc3RyKSB7PGJyPg0KJmd0
OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzcGVjX2FycltpXS50
eXBlX3N0ci5zdHIpIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoENPTVBBVF9MT0coU0VMSU5VWF9XQVJOSU5HLDxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
JnF1b3Q7V2FybmluZyHCoCBObyBtYXRjaGVzIGZvciAoJXMsICVzLCAlcylcbiZxdW90Oyw8YnI+
DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgc3BlY19hcnJbaV0ucmVnZXhfc3RyLDxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjX2FycltpXS50eXBlX3N0
ciw8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3BlY19hcnJbaV0ubHIuY3R4X3Jhdyk7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNwZWNfYXJyW2ld
LnJlZ2V4X3N0ci5zdHIsPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNwZWNfYXJyW2ldLnR5cGVfc3RyLnN0ciw8YnI+DQom
Z3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgc3BlY19hcnJbaV0ubHIuY3R4X3Jhdy5zdHIpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENPTVBBVF9MT0coU0VMSU5VWF9X
QVJOSU5HLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7V2FybmluZyHCoCBObyBtYXRjaGVzIGZvciAoJXMsICVz
KVxuJnF1b3Q7LDxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjX2FycltpXS5yZWdleF9zdHIsPGJyPg0KJmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNwZWNf
YXJyW2ldLmxyLmN0eF9yYXcpOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjX2FycltpXS5yZWdleF9zdHIuc3RyLDxi
cj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzcGVjX2FycltpXS5sci5jdHhfcmF3LnN0cik7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7IGRp
ZmYgLS1naXQgYS9saWJzZWxpbnV4L3NyYy9sYWJlbF9maWxlLmggYi9saWJzZWxpbnV4L3NyYy9s
YWJlbF9maWxlLmg8YnI+DQomZ3Q7ICZndDsgaW5kZXggZGEwNjE2NC4uY2QwMjFmNCAxMDA2NDQ8
YnI+DQomZ3Q7ICZndDsgLS0tIGEvbGlic2VsaW51eC9zcmMvbGFiZWxfZmlsZS5oPGJyPg0KJmd0
OyAmZ3Q7ICsrKyBiL2xpYnNlbGludXgvc3JjL2xhYmVsX2ZpbGUuaDxicj4NCiZndDsgJmd0OyBA
QCAtMjYsMTAgKzI2LDEwIEBAPGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgLyogQSBm
aWxlIHNlY3VyaXR5IGNvbnRleHQgc3BlY2lmaWNhdGlvbi4gKi88YnI+DQomZ3Q7ICZndDvCoCBz
dHJ1Y3Qgc3BlYyB7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoHN0cnVjdCBzZWxhYmVsX2xvb2t1
cF9yZWMgbHI7wqAgwqAvKiBob2xkcyBjb250ZXh0cyBmb3IgbG9va3VwIHJlc3VsdCAqLzxicj4N
CiZndDsgJmd0OyAtwqAgwqAgwqBjaGFyICpyZWdleF9zdHI7wqAgwqAgwqAgwqAgLyogcmVndWxh
ciBleHBlc3Npb24gc3RyaW5nIGZvciBkaWFnbm9zdGljcyAqLzxicj4NCiZndDsgJmd0OyAtwqAg
wqAgwqBjaGFyICp0eXBlX3N0cjvCoCDCoCDCoCDCoCDCoC8qIHR5cGUgc3RyaW5nIGZvciBkaWFn
bm9zdGljIG1lc3NhZ2VzICovPGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoHBjcmUgKnJlZ2V4O8Kg
IMKgIMKgIMKgIMKgIMKgIC8qIGNvbXBpbGVkIHJlZ3VsYXIgZXhwcmVzc2lvbiAqLzxicj4NCiZn
dDsgJmd0OyArwqAgwqAgwqBzdHJ1Y3Qgc2VsYWJlbF9sb29rdXBfcmVjIGxyOyAvKiBob2xkcyBj
b250ZXh0cyBmb3IgbG9va3VwIHJlc3VsdCAqLzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqBzdHJ1
Y3QgbGVuX3N0ciByZWdleF9zdHI7wqAgwqAgwqAvKiByZWd1bGFyIGV4cGVzc2lvbiBzdHJpbmcg
Zm9yIGRpYWdub3N0aWNzICovPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoHN0cnVjdCBsZW5fc3Ry
IHR5cGVfc3RyO8KgIMKgIMKgLyogdHlwZSBzdHJpbmcgZm9yIGRpYWdub3N0aWMgbWVzc2FnZXMg
Ki88YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgcGNyZSAqcmVnZXg7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgLyogY29tcGlsZWQgcmVndWxhciBleHByZXNzaW9uICovPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqB1bmlvbiB7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBw
Y3JlX2V4dHJhICpzZDsgLyogcG9pbnRlciB0byBleHRyYSBjb21waWxlZCBzdHVmZiAqLzxicj4N
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGNyZV9leHRyYSBsc2Q7IC8qIHVzZWQg
dG8gaG9sZCB0aGUgbW1hcCYjMzk7ZCB2ZXJzaW9uICovPGJyPg0KJmd0OyAmZ3Q7IEBAIC05MCwx
NiArOTAsMTkgQEAgc3RhdGljIGlubGluZSBwY3JlX2V4dHJhICpnZXRfcGNyZV9leHRyYShzdHJ1
Y3Qgc3BlYyAqc3BlYyk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
biBzcGVjLSZndDtzZDs8YnI+DQomZ3Q7ICZndDvCoCB9PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0
OyAmZ3Q7IC1zdGF0aWMgaW5saW5lIG1vZGVfdCBzdHJpbmdfdG9fbW9kZShjaGFyICptb2RlKTxi
cj4NCiZndDsgJmd0OyArc3RhdGljIGlubGluZSBtb2RlX3Qgc3RyaW5nX3RvX21vZGUoc3RydWN0
IGxlbl9zdHIgKm1vZGUpPGJyPg0KJmd0OyAmZ3Q7wqAgezxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgc2l6ZV90IGxlbjs8YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoGlm
ICghbW9kZSk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAwOzxi
cj4NCiZndDsgJmd0OyAtwqAgwqAgwqBsZW4gPSBzdHJsZW4obW9kZSk7PGJyPg0KJmd0OyAmZ3Q7
IC3CoCDCoCDCoGlmIChtb2RlWzBdICE9ICYjMzk7LSYjMzk7IHx8IGxlbiAhPSAyKTxicj4NCiZn
dDsgJmd0OyArPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoGxlbiA9IG1vZGUtJmd0O2xlbjs8YnI+
DQomZ3Q7ICZndDsgKzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqBpZiAobW9kZS0mZ3Q7c3RyWzBd
ICE9ICYjMzk7LSYjMzk7IHx8IGxlbiAhPSAyKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqBzd2l0Y2ggKG1vZGVb
MV0pIHs8YnI+DQomZ3Q7ICZndDsgKzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqBzd2l0Y2ggKG1v
ZGUtJmd0O3N0clsxXSkgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgY2FzZSAmIzM5O2ImIzM5
Ozo8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBTX0lGQkxLOzxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgY2FzZSAmIzM5O2MmIzM5Ozo8YnI+DQomZ3Q7ICZndDsg
QEAgLTE1Myw4ICsxNTYsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc3BlY19oYXNNZXRhQ2hhcnMo
c3RydWN0IHNwZWMgKnNwZWMpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBpbnQgbGVuOzxicj4N
CiZndDsgJmd0O8KgIMKgIMKgIMKgY2hhciAqZW5kOzxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsg
Jmd0OyAtwqAgwqAgwqBjID0gc3BlYy0mZ3Q7cmVnZXhfc3RyOzxicj4NCiZndDsgJmd0OyAtwqAg
wqAgwqBsZW4gPSBzdHJsZW4oc3BlYy0mZ3Q7cmVnZXhfc3RyKTs8YnI+DQomZ3Q7ICZndDsgK8Kg
IMKgIMKgYyA9IHNwZWMtJmd0O3JlZ2V4X3N0ci5zdHI7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDC
oGxlbiA9IHNwZWMtJmd0O3JlZ2V4X3N0ci5sZW47PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBl
bmQgPSBjICsgbGVuOzxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgc3Bl
Yy0mZ3Q7aGFzTWV0YUNoYXJzID0gMDs8YnI+DQomZ3Q7ICZndDsgQEAgLTE3NSw3ICsxNzgsNyBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgc3BlY19oYXNNZXRhQ2hhcnMoc3RydWN0IHNwZWMgKnNwZWMp
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlICYjMzk7KCYjMzk7Ojxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSAmIzM5O3smIzM5Ozo8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNwZWMtJmd0O2hh
c01ldGFDaGFycyA9IDE7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHNwZWMtJmd0O3ByZWZpeF9sZW4gPSBjIC0gc3BlYy0mZ3Q7cmVnZXhfc3RyOzxicj4N
CiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjLSZndDtwcmVm
aXhfbGVuID0gYyAtIHNwZWMtJmd0O3JlZ2V4X3N0ci5zdHI7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBjYXNlICYjMzk7XFwmIzM5OzrCoCDCoCDCoCAvKiBza2lwIHRoZSBu
ZXh0IGNoYXJhY3RlciAqLzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYysrOzxicj4NCiZndDsgJmd0OyBAQCAtMzI3LDEzICszMzAsMTYgQEAgc3RhdGlj
IGlubGluZSBpbnQgY29tcGlsZV9yZWdleChzdHJ1Y3Qgc2F2ZWRfZGF0YSAqZGF0YSwgc3RydWN0
IHNwZWMgKnNwZWMsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBpZiAoc3BlYy0mZ3Q7cmVnY29t
cCk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAwOyAvKiBhbHJl
YWR5IGRvbmUgKi88YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgbGVuID0g
c3BlYy0mZ3Q7cmVnZXhfc3RyLmxlbjs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgcmVnX2J1ZiA9
IHNwZWMtJmd0O3JlZ2V4X3N0ci5zdHI7PGJyPg0KJmd0OyAmZ3Q7ICs8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoC8qIFNraXAgdGhlIGZpeGVkIHN0ZW0uICovPGJyPg0KJmd0OyAmZ3Q7IC3CoCDC
oCDCoHJlZ19idWYgPSBzcGVjLSZndDtyZWdleF9zdHI7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDC
oGlmIChzcGVjLSZndDtzdGVtX2lkICZndDs9IDApPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoGlm
IChzcGVjLSZndDtzdGVtX2lkICZndDs9IDApIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJlZ19idWYgKz0gc3RlbV9hcnJbc3BlYy0mZ3Q7c3RlbV9pZF0ubGVuOzxicj4N
CiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBsZW4gLT0gc3RlbV9hcnJbc3BlYy0mZ3Q7
c3RlbV9pZF0ubGVuOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAvKiBBbmNob3IgdGhlIHJlZ3VsYXIgZXhwcmVzc2lvbi4g
Ki88YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgbGVuID0gc3RybGVuKHJlZ19idWYpOzxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgIMKgY3AgPSBhbmNob3JlZF9yZWdleCA9IG1hbGxvYyhsZW4gKyAzKTs8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoGlmICghYW5jaG9yZWRfcmVnZXgpPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KJmd0OyAmZ3Q7IEBAIC0z
NzUsNyArMzgxLDE1IEBAIHN0YXRpYyBpbmxpbmUgaW50IHByb2Nlc3NfbGluZShzdHJ1Y3Qgc2Vs
YWJlbF9oYW5kbGUgKnJlYyw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNoYXIgKmxpbmVfYnVmLCB1bnNpZ25lZCBsaW5lbm8pPGJyPg0KJmd0OyAmZ3Q7
wqAgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgaW50IGl0ZW1zLCBsZW4sIHJjOzxicj4NCiZn
dDsgJmd0OyAtwqAgwqAgwqBjaGFyICpyZWdleCA9IE5VTEwsICp0eXBlID0gTlVMTCwgKmNvbnRl
eHQgPSBOVUxMOzxicj4NCiZndDsgJmd0OyArPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoHN0cnVj
dCBsZW5fc3RyIHJlZ2V4ID0geyAwIH0gLCB0eXBlID0geyAwIH0sIGNvbnRleHTCoCA9IHsgMCB9
Ozxicj4NCiZndDsgJmd0OyArPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoC8qIFhYWCBFeHBvcnQg
dGhpcyBhcyBhIGNvbnN0ICovPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoHN0cnVjdCBsZW5fc3Ry
IG5vbmUgPSB7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oC5zdHIgPSAoY2hhciAqKSZxdW90OyZsdDsmbHQ7bm9uZSZndDsmZ3Q7JnF1b3Q7LDxicj4NCiZn
dDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubGVuID0gODxicj4NCiZn
dDsgJmd0OyArwqAgwqAgwqB9Ozxicj4NCiZndDsgJmd0OyArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqBzdHJ1Y3Qgc2F2ZWRfZGF0YSAqZGF0YSA9IChzdHJ1Y3Qgc2F2ZWRfZGF0YSAqKXJlYy0m
Z3Q7ZGF0YTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoHN0cnVjdCBzcGVjICpzcGVjX2Fycjs8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoHVuc2lnbmVkIGludCBuc3BlYyA9IGRhdGEtJmd0O25z
cGVjOzxicj4NCiZndDsgJmd0OyBAQCAtMzk5LDIxICs0MTMsMjEgQEAgc3RhdGljIGlubGluZSBp
bnQgcHJvY2Vzc19saW5lKHN0cnVjdCBzZWxhYmVsX2hhbmRsZSAqcmVjLDxicj4NCiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7JXM6wqAgbGlu
ZSAldSBpcyBtaXNzaW5nIGZpZWxkc1xuJnF1b3Q7LCBwYXRoLDxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbGluZW5vKTs8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChpdGVtcyA9PSAxKTxicj4NCiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKHJlZ2V4KTs8YnI+DQomZ3Q7ICZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShyZWdleC5zdHIpOzxicj4N
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJybm8gPSBFSU5WQUw7PGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqB9IGVsc2UgaWYgKGl0ZW1zID09IDIpIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoC8qIFRoZSB0eXBlIGZpZWxkIGlzIG9wdGlvbmFsLiAqLzxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGV4dCA9IHR5cGU7PGJyPg0KJmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoHR5cGUgPSAwOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqBtZW1zZXQoJmFtcDt0eXBlLCAwLCBzaXplb2YodHlwZSkpOzxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqBs
ZW4gPSBnZXRfc3RlbV9mcm9tX3NwZWMocmVnZXgpOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqBp
ZiAobGVuICZhbXA7JmFtcDsgcHJlZml4ICZhbXA7JmFtcDsgc3RybmNtcChwcmVmaXgsIHJlZ2V4
LCBsZW4pKSB7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoGxlbiA9IGdldF9zdGVtX2Zyb21fc3Bl
YyhyZWdleC5zdHIpOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqBpZiAobGVuICZhbXA7JmFtcDsg
cHJlZml4ICZhbXA7JmFtcDsgc3RybmNtcChwcmVmaXgsIHJlZ2V4LnN0ciwgbGVuKSkgezxicj4N
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogU3RlbSBvZiByZWdleCBkb2VzIG5v
dCBtYXRjaCByZXF1ZXN0ZWQgcHJlZml4LCBkaXNjYXJkLiAqLzxicj4NCiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqBmcmVlKHJlZ2V4KTs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgZnJlZSh0eXBlKTs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
ZnJlZShjb250ZXh0KTs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShy
ZWdleC5zdHIpOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKHR5cGUu
c3RyKTs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShjb250ZXh0LnN0
cik7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoH08YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgQEAgLTQy
NCwxMyArNDM4LDEzIEBAIHN0YXRpYyBpbmxpbmUgaW50IHByb2Nlc3NfbGluZShzdHJ1Y3Qgc2Vs
YWJlbF9oYW5kbGUgKnJlYyw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoHNwZWNfYXJyID0gZGF0
YS0mZ3Q7c3BlY19hcnI7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAv
KiBwcm9jZXNzIGFuZCBzdG9yZSB0aGUgc3BlY2lmaWNhdGlvbiBpbiBzcGVjLiAqLzxicj4NCiZn
dDsgJmd0OyAtwqAgwqAgwqBzcGVjX2Fycltuc3BlY10uc3RlbV9pZCA9IGZpbmRfc3RlbV9mcm9t
X3NwZWMoZGF0YSwgcmVnZXgpOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqBzcGVjX2Fycltuc3Bl
Y10ucmVnZXhfc3RyID0gcmVnZXg7PGJyPg0KJmd0OyAmZ3Q7IC08YnI+DQomZ3Q7ICZndDsgLcKg
IMKgIMKgc3BlY19hcnJbbnNwZWNdLnR5cGVfc3RyID0gdHlwZTs8YnI+DQomZ3Q7ICZndDsgK8Kg
IMKgIMKgc3BlY19hcnJbbnNwZWNdLnN0ZW1faWQgPSBmaW5kX3N0ZW1fZnJvbV9zcGVjKGRhdGEs
IHJlZ2V4LnN0cik7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoG1lbWNweSgmYW1wO3NwZWNfYXJy
W25zcGVjXS5yZWdleF9zdHIsICZhbXA7cmVnZXgsIHNpemVvZihyZWdleCkpOzxicj4NCiZndDsg
Jmd0OyArwqAgwqAgwqBtZW1jcHkoJmFtcDtzcGVjX2Fycltuc3BlY10ubHIuY3R4X3JhdywgJmFt
cDtjb250ZXh0LCBzaXplb2YoY29udGV4dCkpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgc3Bl
Y19hcnJbbnNwZWNdLm1vZGUgPSAwOzxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyAtwqAg
wqAgwqBzcGVjX2Fycltuc3BlY10ubHIuY3R4X3JhdyA9IGNvbnRleHQ7PGJyPg0KJmd0OyAmZ3Q7
ICvCoCDCoCDCoGlmICh0eXBlLnN0cik8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgbWVtY3B5KCZhbXA7c3BlY19hcnJbbnNwZWNdLnR5cGVfc3RyLCAmYW1wO3R5cGUsIHNpemVv
Zih0eXBlKSk7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAvKjxicj4N
CiZndDsgJmd0O8KgIMKgIMKgIMKgICogYnVtcCBkYXRhLSZndDtuc3BlY3MgdG8gY2F1c2UgY2xv
c2VmKCkgdG8gY292ZXIgaXQgaW4gaXRzIGZyZWU8YnI+DQomZ3Q7ICZndDsgQEAgLTQ0MiwxOSAr
NDU2LDE5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHByb2Nlc3NfbGluZShzdHJ1Y3Qgc2VsYWJlbF9o
YW5kbGUgKnJlYyw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNvbXBpbGVfcmVnZXgoZGF0YSwgJmFtcDtzcGVjX2Fycltuc3BlY10sICZhbXA7
ZXJyYnVmKSkgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQ09NUEFUX0xP
RyhTRUxJTlVYX0VSUk9SLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICZxdW90OyVzOsKgIGxpbmUgJXUgaGFzIGludmFsaWQgcmVnZXggJXM6wqAg
JXNcbiZxdW90Oyw8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHBhdGgsIGxpbmVubywgcmVnZXgsPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXRoLCBsaW5lbm8sIHJlZ2V4LnN0ciw8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAoZXJyYnVmID8gZXJy
YnVmIDogJnF1b3Q7b3V0IG9mIG1lbW9yeSZxdW90OykpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZXJybm8gPSBFSU5WQUw7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqB9PGJyPg0KJmd0
OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoGlmICh0eXBlKSB7PGJyPg0KJmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoG1vZGVfdCBtb2RlID0gc3RyaW5nX3RvX21vZGUodHlwZSk7
PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoGlmICh0eXBlLnN0cikgezxicj4NCiZndDsgJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqBtb2RlX3QgbW9kZSA9IHN0cmluZ190b19tb2RlKCZhbXA7dHlw
ZSk7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiAobW9kZSA9PSAobW9kZV90KS0xKSB7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBDT01QQVRfTE9HKFNFTElOVVhfRVJST1IsPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7
JXM6wqAgbGluZSAldSBoYXMgaW52YWxpZCBmaWxlIHR5cGUgJXNcbiZxdW90Oyw8YnI+DQomZ3Q7
ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBh
dGgsIGxpbmVubywgdHlwZSk7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXRoLCBsaW5lbm8sIHR5cGUuc3RyKTs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycm5vID0gRUlOVkFM
Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
IC0xOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0
OyBAQCAtNDY1LDcgKzQ3OSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHByb2Nlc3NfbGluZShzdHJ1
Y3Qgc2VsYWJlbF9oYW5kbGUgKnJlYyw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCAqIGFueSBt
ZXRhIGNoYXJhY3RlcnMgaW4gdGhlIFJFICovPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBzcGVj
X2hhc01ldGFDaGFycygmYW1wO3NwZWNfYXJyW25zcGVjXSk7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0K
Jmd0OyAmZ3Q7IC3CoCDCoCDCoGlmIChzdHJjbXAoY29udGV4dCwgJnF1b3Q7Jmx0OyZsdDtub25l
Jmd0OyZndDsmcXVvdDspICZhbXA7JmFtcDsgcmVjLSZndDt2YWxpZGF0aW5nKTxicj4NCiZndDsg
Jmd0OyArwqAgwqAgwqBpZiAocmVjLSZndDt2YWxpZGF0aW5nICZhbXA7JmFtcDsgIWxlbl9zdHJf
ZXEoJmFtcDtjb250ZXh0LCAmYW1wO25vbmUpKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgY29tcGF0X3ZhbGlkYXRlKHJlYywgJmFtcDtzcGVjX2Fycltuc3BlY10ubHIsIHBh
dGgsIGxpbmVubyk7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqByZXR1
cm4gMDs8YnI+DQomZ3Q7ICZndDsgZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvc3JjL2xhYmVsX2lu
dGVybmFsLmggYi9saWJzZWxpbnV4L3NyYy9sYWJlbF9pbnRlcm5hbC5oPGJyPg0KJmd0OyAmZ3Q7
IGluZGV4IGFhNDhmZmYuLjUxYWEzM2QgMTAwNjQ0PGJyPg0KJmd0OyAmZ3Q7IC0tLSBhL2xpYnNl
bGludXgvc3JjL2xhYmVsX2ludGVybmFsLmg8YnI+DQomZ3Q7ICZndDsgKysrIGIvbGlic2VsaW51
eC9zcmMvbGFiZWxfaW50ZXJuYWwuaDxicj4NCiZndDsgJmd0OyBAQCAtNzEsOCArNzEsMjggQEAg
ZXh0ZXJuIHN0cnVjdCBzZWxhYmVsX3N1YiAqc2VsYWJlbF9zdWJzX2luaXQoY29uc3QgY2hhciAq
cGF0aCw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBzZWxhYmVsX3N1YiAqbGlzdCw8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVj
dCBzZWxhYmVsX2RpZ2VzdCAqZGlnZXN0KTs8YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsg
Ky8qPGJyPg0KJmd0OyAmZ3Q7ICsgKiBBIHNpbXBsZSBzdHJ1Y3QgZm9yIHRyYWNraW5nIHN0cmlu
ZyBsZW5ndGhzPGJyPg0KJmd0OyAmZ3Q7ICsgKiB3aXRoIHN0cmluZ3MuPGJyPg0KJmd0OyAmZ3Q7
ICsgKi88YnI+DQomZ3Q7ICZndDsgK3N0cnVjdCBsZW5fc3RyIHs8YnI+DQomZ3Q7ICZndDsgK8Kg
IMKgIMKgc2l6ZV90IGxlbjs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgY2hhciAqc3RyOzxicj4N
CiZndDsgJmd0OyArfTs8YnI+DQomZ3Q7ICZndDsgKzxicj4NCiZndDsgJmd0OyArc3RhdGljIGlu
bGluZSBib29sIGxlbl9zdHJfZXEoc3RydWN0IGxlbl9zdHIgKmEsIHN0cnVjdCBsZW5fc3RyICpi
KTxicj4NCiZndDsgJmd0OyArezxicj4NCiZndDsgJmd0OyArwqAgwqAgwqBpZiAoYS0mZ3Q7bGVu
ICE9IGItJmd0O2xlbik8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
IGZhbHNlOzxicj4NCiZndDsgJmd0OyArPGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoGlmIChhLSZn
dDtzdHIgPT0gYi0mZ3Q7c3RyKTxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gdHJ1ZTs8YnI+DQomZ3Q7ICZndDsgKzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqByZXR1
cm4gIXN0cmNtcChhLSZndDtzdHIsIGItJmd0O3N0cik7PGJyPg0KJmd0OyAmZ3Q7ICt9PGJyPg0K
Jmd0OyAmZ3Q7ICs8YnI+DQomZ3Q7ICZndDvCoCBzdHJ1Y3Qgc2VsYWJlbF9sb29rdXBfcmVjIHs8
YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgY2hhciAqIGN0eF9yYXc7PGJyPg0KJmd0OyAmZ3Q7ICvC
oCDCoCDCoHN0cnVjdCBsZW5fc3RyIGN0eF9yYXc7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBj
aGFyICogY3R4X3RyYW5zOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgaW50IHZhbGlkYXRlZDs8
YnI+DQomZ3Q7ICZndDvCoCB9Ozxicj4NCiZndDsgJmd0OyBkaWZmIC0tZ2l0IGEvbGlic2VsaW51
eC9zcmMvbGFiZWxfbWVkaWEuYyBiL2xpYnNlbGludXgvc3JjL2xhYmVsX21lZGlhLmM8YnI+DQom
Z3Q7ICZndDsgaW5kZXggNjIyNzQxYi4uZTg1ZTk3MyAxMDA2NDQ8YnI+DQomZ3Q7ICZndDsgLS0t
IGEvbGlic2VsaW51eC9zcmMvbGFiZWxfbWVkaWEuYzxicj4NCiZndDsgJmd0OyArKysgYi9saWJz
ZWxpbnV4L3NyYy9sYWJlbF9tZWRpYS5jPGJyPg0KJmd0OyAmZ3Q7IEBAIC01Niw3ICs1Niw4IEBA
IHN0YXRpYyBpbnQgcHJvY2Vzc19saW5lKGNvbnN0IGNoYXIgKnBhdGgsIGNoYXIgKmxpbmVfYnVm
LCBpbnQgcGFzcyw8YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoGlmIChw
YXNzID09IDEpIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRhdGEtJmd0
O3NwZWNfYXJyW2RhdGEtJmd0O25zcGVjXS5rZXkgPSBrZXk7PGJyPg0KJmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCDCoGRhdGEtJmd0O3NwZWNfYXJyW2RhdGEtJmd0O25zcGVjXS5sci5jdHhf
cmF3ID0gY29udGV4dDs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZGF0YS0m
Z3Q7c3BlY19hcnJbZGF0YS0mZ3Q7bnNwZWNdLmxyLmN0eF9yYXcuc3RyID0gY29udGV4dDs8YnI+
DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZGF0YS0mZ3Q7c3BlY19hcnJbZGF0YS0m
Z3Q7bnNwZWNdLmxyLmN0eF9yYXcubGVuID0gc3RybGVuKGNvbnRleHQpOzxicj4NCiZndDsgJmd0
O8KgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgZGF0
YS0mZ3Q7bnNwZWMrKzs8YnI+DQomZ3Q7ICZndDsgQEAgLTE1OSw3ICsxNjAsNyBAQCBzdGF0aWMg
dm9pZCBjbG9zZShzdHJ1Y3Qgc2VsYWJlbF9oYW5kbGUgKnJlYyk8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBkYXRhLSZndDtuc3BlYzsgaSsrKSB7PGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjID0gJmFtcDtzcGVjX2FycltpXTs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWUoc3BlYy0mZ3Q7a2V5KTs8YnI+
DQomZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShzcGVjLSZndDtsci5jdHhfcmF3
KTs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShzcGVjLSZndDtsci5j
dHhfcmF3LnN0cik7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKHNw
ZWMtJmd0O2xyLmN0eF90cmFucyk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqB9PGJyPg0KJmd0
OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IGRpZmYgLS1naXQgYS9saWJzZWxpbnV4L3NyYy9sYWJlbF9z
dXBwb3J0LmMgYi9saWJzZWxpbnV4L3NyYy9sYWJlbF9zdXBwb3J0LmM8YnI+DQomZ3Q7ICZndDsg
aW5kZXggMjZmOWVmMS4uZTliODQyZiAxMDA2NDQ8YnI+DQomZ3Q7ICZndDsgLS0tIGEvbGlic2Vs
aW51eC9zcmMvbGFiZWxfc3VwcG9ydC5jPGJyPg0KJmd0OyAmZ3Q7ICsrKyBiL2xpYnNlbGludXgv
c3JjL2xhYmVsX3N1cHBvcnQuYzxicj4NCiZndDsgJmd0OyBAQCAtMjIsMTYgKzIyLDE3IEBAPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAqwqAgwqAgwqAgwqAgwqAgwqAgZXJybm8gd2lsbCBiZSBzZXQuPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAqPGJyPg0KJmd0OyAmZ3Q7wqAgwqAqLzxicj4NCiZndDsgJmd0OyAt
c3RhdGljIGlubGluZSBpbnQgcmVhZF9zcGVjX2VudHJ5KGNoYXIgKiplbnRyeSwgY2hhciAqKnB0
ciwgaW50ICpsZW4sIGNvbnN0IGNoYXIgKiplcnJidWYpPGJyPg0KJmd0OyAmZ3Q7ICtzdGF0aWMg
aW5saW5lIGludCByZWFkX3NwZWNfZW50cnkoc3RydWN0IGxlbl9zdHIgKmVudHJ5LCBjaGFyICoq
cHRyLCBjb25zdCBjaGFyICoqZXJyYnVmKTxicj4NCiZndDsgJmd0O8KgIHs8YnI+DQomZ3Q7ICZn
dDsgLcKgIMKgIMKgKmVudHJ5ID0gTlVMTDs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgc2l6ZV90
IGxlbiA9IDA7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBjaGFyICp0bXBfYnVmID0gTlVMTDs8
YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgbWVtc2V0KGVudHJ5LCAwLCBz
aXplb2YoKmVudHJ5KSk7PGJyPg0KJmd0OyAmZ3Q7ICs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDC
oHdoaWxlIChpc3NwYWNlKCoqcHRyKSAmYW1wOyZhbXA7ICoqcHRyICE9ICYjMzk7XDAmIzM5Oyk8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCgqcHRyKSsrOzxicj4NCiZndDsg
Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgdG1wX2J1ZiA9ICpwdHI7PGJyPg0KJmd0OyAm
Z3Q7IC3CoCDCoCDCoCpsZW4gPSAwOzxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgd2hpbGUgKCFpc3NwYWNlKCoqcHRyKSAmYW1wOyZhbXA7ICoqcHRyICE9ICYjMzk7XDAm
IzM5Oykgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCFpc2FzY2lp
KCoqcHRyKSkgezxicj4NCiZndDsgJmd0OyBAQCAtNDAsMTMgKzQxLDE1IEBAIHN0YXRpYyBpbmxp
bmUgaW50IHJlYWRfc3BlY19lbnRyeShjaGFyICoqZW50cnksIGNoYXIgKipwdHIsIGludCAqbGVu
LCBjb25zdCBjaGFyPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXR1cm4gLTE7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoKnB0cikrKzs8YnI+DQomZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgKCpsZW4pKys7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoGxlbisrOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgfTxicj4NCiZndDsg
Jmd0Ozxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqBpZiAoKmxlbikgezxicj4NCiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAqZW50cnkgPSBzdHJuZHVwKHRtcF9idWYsICpsZW4pOzxicj4N
CiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoISplbnRyeSk8YnI+DQomZ3Q7ICZn
dDsgK8KgIMKgIMKgaWYgKGxlbikgezxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqBlbnRyeS0mZ3Q7c3RyID0gc3RybmR1cCh0bXBfYnVmLCBsZW4pOzxicj4NCiZndDsgJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIWVudHJ5LSZndDtzdHIpPGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KJmd0OyAmZ3Q7
ICs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZW50cnktJmd0O2xlbiA9IGxl
bjs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoH08YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCDCoHJldHVybiAwOzxicj4NCiZndDsgJmd0OyBAQCAtNTYsNyArNTksNyBAQCBz
dGF0aWMgaW5saW5lIGludCByZWFkX3NwZWNfZW50cnkoY2hhciAqKmVudHJ5LCBjaGFyICoqcHRy
LCBpbnQgKmxlbiwgY29uc3QgY2hhcjxicj4NCiZndDsgJmd0O8KgIMKgKiBsaW5lX2J1ZiAtIEJ1
ZmZlciBjb250YWluaW5nIHRoZSBzcGVjIGVudHJpZXMgLjxicj4NCiZndDsgJmd0O8KgIMKgKiBl
cnJidWbCoCDCoC0gRG91YmxlIHBvaW50ZXIgdXNlZCBmb3IgcGFzc2luZyBiYWNrIHNwZWNpZmlj
IGVycm9yIG1lc3NhZ2VzLjxicj4NCiZndDsgJmd0O8KgIMKgKiBudW1fYXJncyAtIFRoZSBudW1i
ZXIgb2Ygc3BlYyBwYXJhbWV0ZXIgZW50cmllcyB0byBwcm9jZXNzLjxicj4NCiZndDsgJmd0OyAt
ICogLi4uwqAgwqAgwqAgLSBBICYjMzk7Y2hhciAqKnNwZWNfZW50cnkmIzM5OyBmb3IgZWFjaCBw
YXJhbWV0ZXIuPGJyPg0KJmd0OyAmZ3Q7ICsgKiAuLi7CoCDCoCDCoCAtIEEgJiMzOTtzdHJ1Y3Qg
bGVuX3N0ciAqKnNwZWNfZW50cnkmIzM5OyBmb3IgZWFjaCBwYXJhbWV0ZXIuPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAqIHJldHVybnPCoCAtIFRoZSBudW1iZXIgb2YgaXRlbXMgcHJvY2Vzc2VkLiBPbiBl
cnJvciwgaXQgcmV0dXJucyAtMSB3aXRoIGVycm5vPGJyPg0KJmd0OyAmZ3Q7wqAgwqAqwqAgwqAg
wqAgwqAgwqAgwqAgc2V0IGFuZCBtYXkgc2V0IGVycmJ1ZiB0byBhIHNwZWNpZmljIGVycm9yIG1l
c3NhZ2UuPGJyPg0KJmd0OyAmZ3Q7wqAgwqAqPGJyPg0KJmd0OyAmZ3Q7IEBAIC02NSw4ICs2OCw5
IEBAIHN0YXRpYyBpbmxpbmUgaW50IHJlYWRfc3BlY19lbnRyeShjaGFyICoqZW50cnksIGNoYXIg
KipwdHIsIGludCAqbGVuLCBjb25zdCBjaGFyPGJyPg0KJmd0OyAmZ3Q7wqAgwqAqLzxicj4NCiZn
dDsgJmd0O8KgIGludCBoaWRkZW4gcmVhZF9zcGVjX2VudHJpZXMoY2hhciAqbGluZV9idWYsIGNv
bnN0IGNoYXIgKiplcnJidWYsIGludCBudW1fYXJncywgLi4uKTxicj4NCiZndDsgJmd0O8KgIHs8
YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgY2hhciAqKnNwZWNfZW50cnksICpidWZfcDs8YnI+DQom
Z3Q7ICZndDsgLcKgIMKgIMKgaW50IGxlbiwgcmMsIGl0ZW1zLCBlbnRyeV9sZW4gPSAwOzxicj4N
CiZndDsgJmd0OyArwqAgwqAgwqBzdHJ1Y3QgbGVuX3N0ciAqc3BlY19lbnRyeTs8YnI+DQomZ3Q7
ICZndDsgK8KgIMKgIMKgY2hhciAqYnVmX3A7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoGludCBs
ZW4sIHJjLCBpdGVtczs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoHZhX2xpc3QgYXA7PGJyPg0K
Jmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAqZXJyYnVmID0gTlVMTDs8YnI+DQom
Z3Q7ICZndDsgQEAgLTkzLDIwICs5NywyMiBAQCBpbnQgaGlkZGVuIHJlYWRfc3BlY19lbnRyaWVz
KGNoYXIgKmxpbmVfYnVmLCBjb25zdCBjaGFyICoqZXJyYnVmLCBpbnQgbnVtX2FyZ3MsPGJyPg0K
Jmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBpdGVtcyA9IDA7PGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqB3aGlsZSAoaXRlbXMgJmx0OyBudW1fYXJncykgezxicj4NCiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjX2VudHJ5ID0gdmFfYXJnKGFwLCBjaGFyICoqKTs8
YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgc3BlY19lbnRyeSA9IHZhX2FyZyhh
cCwgc3RydWN0IGxlbl9zdHIgKik7PGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpZiAobGVuIC0gMSA9PSBidWZfcCAtIGxpbmVfYnVmKSB7PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YV9lbmQoYXApOzxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGl0
ZW1zOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0
Ozxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqByYyA9IHJlYWRfc3BlY19lbnRy
eShzcGVjX2VudHJ5LCAmYW1wO2J1Zl9wLCAmYW1wO2VudHJ5X2xlbiwgZXJyYnVmKTs8YnI+DQom
Z3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmMgPSByZWFkX3NwZWNfZW50cnkoc3BlY19l
bnRyeSwgJmFtcDtidWZfcCwgZXJyYnVmKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmIChyYyAmbHQ7IDApIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHZhX2VuZChhcCk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmM7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChlbnRy
eV9sZW4pPGJyPg0KJmd0OyAmZ3Q7ICs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgKHNwZWNfZW50cnktJmd0O2xlbikgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaXRlbXMrKzs8YnI+DQomZ3Q7ICZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgfTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgdmFfZW5kKGFwKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoHJldHVybiBpdGVtczs8
YnI+DQomZ3Q7ICZndDsgZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvc3JjL2xhYmVsX3guYyBiL2xp
YnNlbGludXgvc3JjL2xhYmVsX3guYzxicj4NCiZndDsgJmd0OyBpbmRleCA3MDBkZWYxLi5jZGJh
YzhjIDEwMDY0NDxicj4NCiZndDsgJmd0OyAtLS0gYS9saWJzZWxpbnV4L3NyYy9sYWJlbF94LmM8
YnI+DQomZ3Q7ICZndDsgKysrIGIvbGlic2VsaW51eC9zcmMvbGFiZWxfeC5jPGJyPg0KJmd0OyAm
Z3Q7IEBAIC04MSw3ICs4MSw4IEBAIHN0YXRpYyBpbnQgcHJvY2Vzc19saW5lKGNvbnN0IGNoYXIg
KnBhdGgsIGNoYXIgKmxpbmVfYnVmLCBpbnQgcGFzcyw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAwOzxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGF0
YS0mZ3Q7c3BlY19hcnJbZGF0YS0mZ3Q7bnNwZWNdLmtleSA9IGtleTs8YnI+DQomZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgZGF0YS0mZ3Q7c3BlY19hcnJbZGF0YS0mZ3Q7bnNwZWNdLmxy
LmN0eF9yYXcgPSBjb250ZXh0Ozxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBk
YXRhLSZndDtzcGVjX2FycltkYXRhLSZndDtuc3BlY10ubHIuY3R4X3Jhdy5zdHIgPSBjb250ZXh0
Ozxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBkYXRhLSZndDtzcGVjX2Fycltk
YXRhLSZndDtuc3BlY10ubHIuY3R4X3Jhdy5sZW4gPSBzdHJsZW4oY29udGV4dCk7PGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKHR5cGUpOzxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgIMKgfTxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyBAQCAtMTg2LDcgKzE4Nyw3
IEBAIHN0YXRpYyB2b2lkIGNsb3NlKHN0cnVjdCBzZWxhYmVsX2hhbmRsZSAqcmVjKTxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IGRhdGEtJmd0O25zcGVjOyBpKysp
IHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNwZWMgPSAmYW1wO3NwZWNf
YXJyW2ldOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShzcGVjLSZn
dDtrZXkpOzxicj4NCiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKHNwZWMtJmd0
O2xyLmN0eF9yYXcpOzxicj4NCiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKHNw
ZWMtJmd0O2xyLmN0eF9yYXcuc3RyKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGZyZWUoc3BlYy0mZ3Q7bHIuY3R4X3RyYW5zKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDC
oH08YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsgZGlmZiAtLWdpdCBhL2xpYnNlbGludXgv
c3JjL21hdGNocGF0aGNvbi5jIGIvbGlic2VsaW51eC9zcmMvbWF0Y2hwYXRoY29uLmM8YnI+DQom
Z3Q7ICZndDsgaW5kZXggNDc2NGFiNy4uOTZjMzliNCAxMDA2NDQ8YnI+DQomZ3Q7ICZndDsgLS0t
IGEvbGlic2VsaW51eC9zcmMvbWF0Y2hwYXRoY29uLmM8YnI+DQomZ3Q7ICZndDsgKysrIGIvbGli
c2VsaW51eC9zcmMvbWF0Y2hwYXRoY29uLmM8YnI+DQomZ3Q7ICZndDsgQEAgLTU0MSw3ICs1NDEs
NyBAQCBpbnQgY29tcGF0X3ZhbGlkYXRlKHN0cnVjdCBzZWxhYmVsX2hhbmRsZSAqcmVjLDxicj4N
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3QgY2hhciAqcGF0aCwg
dW5zaWduZWQgbGluZW5vKTxicj4NCiZndDsgJmd0O8KgIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCDCoGludCByYzs8YnI+DQomZ3Q7ICZndDsgLcKgIMKgIMKgY2hhciAqKmN0eCA9ICZhbXA7Y29u
dGV4dHMtJmd0O2N0eF9yYXc7PGJyPg0KJmd0OyAmZ3Q7ICvCoCDCoCDCoGNoYXIgKipjdHggPSAm
YW1wO2NvbnRleHRzLSZndDtjdHhfcmF3LnN0cjs8YnI+DQomZ3Q7ICZndDs8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCDCoGlmIChteWludmFsaWRjb24pPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByYyA9IG15aW52YWxpZGNvbihwYXRoLCBsaW5lbm8sICpjdHgpOzxicj4NCiZn
dDsgJmd0Ozxicj4NCiZndDs8YnI+DQomZ3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fPGJyPg0KJmd0OyBTZWFuZHJvaWQtbGlzdCBtYWlsaW5nIGxpc3Q8
YnI+DQomZ3Q7IDxhIGhyZWY9Im1haWx0bzpTZWFuZHJvaWQtbGlzdEB0eWNoby5uc2EuZ292Ij5T
ZWFuZHJvaWQtbGlzdEB0eWNoby5uc2EuZ292PC9hPjxicj4NCiZndDsgVG8gdW5zdWJzY3JpYmUs
IHNlbmQgZW1haWwgdG8gPGEgaHJlZj0ibWFpbHRvOlNlYW5kcm9pZC1saXN0LWxlYXZlQHR5Y2hv
Lm5zYS5nb3YiPlNlYW5kcm9pZC1saXN0LWxlYXZlQHR5Y2hvLm5zYS5nb3Y8L2E+Ljxicj4NCiZn
dDsgVG8gZ2V0IGhlbHAsIHNlbmQgYW4gZW1haWwgY29udGFpbmluZyAmcXVvdDtoZWxwJnF1b3Q7
IHRvIDxhIGhyZWY9Im1haWx0bzpTZWFuZHJvaWQtbGlzdC1yZXF1ZXN0QHR5Y2hvLm5zYS5nb3Yi
PlNlYW5kcm9pZC1saXN0LXJlcXVlc3RAdHljaG8ubnNhLmdvdjwvYT4uPGJyPjwvcD4NCg==
--94eb2c07d1eac27874053bdb66a8--
