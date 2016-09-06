MIME-Version: 1.0
In-Reply-To: <be59b52a-0086-ee0c-e2e7-0037aa673759@tycho.nsa.gov>
References: <1473177066-25068-1-git-send-email-william.c.roberts@intel.com>
 <be59b52a-0086-ee0c-e2e7-0037aa673759@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 6 Sep 2016 13:06:46 -0700
Message-ID: <CAFftDdqZH8OobTUtUdixwontnOE7qF3vgeeky6huRvb5-h-eeg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: clean up process file
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11475d4e1e6884053bdc5631
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11475d4e1e6884053bdc5631
Content-Type: text/plain; charset=UTF-8

On Sep 6, 2016 13:01, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 09/06/2016 11:51 AM, william.c.roberts@intel.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > The current process_file() code will open the file
> > twice on the case of a binary file, correct this.
> >
> > The general flow through process_file() was a bit
> > difficult to read, streamline the routine to be
> > more readable.
> >
> > Detailed statistics of before and after:
> >
> > Source lines of code reported by cloc on modified files:
> > before: 1090
> > after: 1102
> >
> > Object size difference:
> > before: 195530 bytes
> > after:  195563 bytes
>
> Old logic would use the .bin file as long as it is not older than the
> base file; new logic will only use the .bin file if it is newer.  The
> end result on my system was that it was using the text file instead.

I'm not following here. I spent a lot of time with strace comparing old vs
new behavior here. If x and x.bin exist, it should use x.bin if it's newer
or the same age as x? Is that correct?

>
> Also, there are some memory leaks in there; run it under valgrind, e.g.
> valgrind --leak-check=full matchpathcon /etc

OK I'll run that test.

>
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libselinux/src/label_file.c | 264
++++++++++++++++++++++++--------------------
> >  libselinux/src/label_file.h |   1 +
> >  2 files changed, 147 insertions(+), 118 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index c89bb35..26b1b87 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -97,62 +97,44 @@ static int nodups_specs(struct saved_data *data,
const char *path)
> >       return rc;
> >  }
> >
> > -static int load_mmap(struct selabel_handle *rec, const char *path,
> > -                                 struct stat *sb, bool isbinary,
> > -                                 struct selabel_digest *digest)
> > +static int process_text_file(FILE *fp, const char *prefix, struct
selabel_handle *rec)
> > +{
> > +     /*
> > +      * Then do detailed validation of the input and fill the spec
array
> > +      */
> > +     int rc;
> > +     size_t line_len;
> > +     unsigned lineno = 0;
> > +     char *line_buf = NULL;
> > +     struct saved_data *data = (struct saved_data *)rec->data;
> > +
> > +     while (getline(&line_buf, &line_len, fp) > 0) {
> > +             rc = process_line(rec, data->path, prefix, line_buf,
++lineno);
> > +             if (rc)
> > +                     goto out;
> > +     }
> > +     rc = 0;
> > +out:
> > +     free(line_buf);
> > +     return rc;
> > +}
> > +
> > +static int load_mmap(FILE *fp, size_t len, struct selabel_handle *rec)
> >  {
> >       struct saved_data *data = (struct saved_data *)rec->data;
> > -     char mmap_path[PATH_MAX + 1];
> > -     int mmapfd;
> >       int rc;
> > -     struct stat mmap_stat;
> >       char *addr, *str_buf;
> > -     size_t len;
> >       int *stem_map;
> >       struct mmap_area *mmap_area;
> >       uint32_t i, magic, version;
> >       uint32_t entry_len, stem_map_len, regex_array_len;
> >
> > -     if (isbinary) {
> > -             len = strlen(path);
> > -             if (len >= sizeof(mmap_path))
> > -                     return -1;
> > -             strcpy(mmap_path, path);
> > -     } else {
> > -             rc = snprintf(mmap_path, sizeof(mmap_path), "%s.bin",
path);
> > -             if (rc >= (int)sizeof(mmap_path))
> > -                     return -1;
> > -     }
> > -
> > -     mmapfd = open(mmap_path, O_RDONLY | O_CLOEXEC);
> > -     if (mmapfd < 0)
> > -             return -1;
> > -
> > -     rc = fstat(mmapfd, &mmap_stat);
> > -     if (rc < 0) {
> > -             close(mmapfd);
> > -             return -1;
> > -     }
> > -
> > -     /* if mmap is old, ignore it */
> > -     if (mmap_stat.st_mtime < sb->st_mtime) {
> > -             close(mmapfd);
> > -             return -1;
> > -     }
> > -
> > -     /* ok, read it in... */
> > -     len = mmap_stat.st_size;
> > -     len += (sysconf(_SC_PAGE_SIZE) - 1);
> > -     len &= ~(sysconf(_SC_PAGE_SIZE) - 1);
> > -
> >       mmap_area = malloc(sizeof(*mmap_area));
> >       if (!mmap_area) {
> > -             close(mmapfd);
> >               return -1;
> >       }
> >
> > -     addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, mmapfd, 0);
> > -     close(mmapfd);
> > +     addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fileno(fp), 0);
> >       if (addr == MAP_FAILED) {
> >               free(mmap_area);
> >               perror("mmap");
> > @@ -306,7 +288,7 @@ static int load_mmap(struct selabel_handle *rec,
const char *path,
> >               if (strcmp(spec->lr.ctx_raw, "<<none>>") &&
rec->validating) {
> >                       if (selabel_validate(rec, &spec->lr) < 0) {
> >                               selinux_log(SELINUX_ERROR,
> > -                                         "%s: context %s is
invalid\n", mmap_path, spec->lr.ctx_raw);
> > +                                         "%s: context %s is
invalid\n", data->path, spec->lr.ctx_raw);
> >                               goto err;
> >                       }
> >               }
> > @@ -408,105 +390,150 @@ static int load_mmap(struct selabel_handle
*rec, const char *path,
> >               data->nspec++;
> >       }
> >
> > -     rc = digest_add_specfile(digest, NULL, addr, mmap_stat.st_size,
> > -
 mmap_path);
> > -     if (rc)
> > -             goto err;
> > -
> >  err:
> >       free(stem_map);
> >
> >       return rc;
> >  }
> >
> > -static int process_file(const char *path, const char *suffix,
> > -                       struct selabel_handle *rec,
> > -                       const char *prefix, struct selabel_digest
*digest)
> > -{
> > -     FILE *fp;
> > +struct file_details {
> > +     const char *suffix;
> >       struct stat sb;
> > -     unsigned int lineno;
> > -     size_t line_len = 0;
> > -     char *line_buf = NULL;
> > +};
> > +
> > +static char *rolling_append(char *current, const char *suffix, size_t
max)
> > +{
> > +     size_t size;
> > +     size_t suffix_size;
> > +     size_t current_size;
> > +
> > +     if (!suffix)
> > +             return current;
> > +
> > +     /*
> > +      * Overflow check that the following
> > +      * arithmatec will not overflow or
> > +      */
> > +     current_size = strlen(current);
> > +     suffix_size = strlen(suffix);
> > +
> > +     size = current_size + suffix_size;
> > +     if (size < current_size || size < suffix_size)
> > +             return NULL;
> > +
> > +     /* ensure space for the '.' and the '\0' characters. */
> > +     if (size >= (SIZE_MAX - 2))
> > +             return NULL;
> > +
> > +     size += 2;
> > +
> > +     if (size > max)
> > +             return NULL;
> > +
> > +     /* Append any given suffix */
> > +     char *to = stpcpy(&current[current_size], ".");
> > +     strcat(to, suffix);
> > +
> > +     return current;
> > +}
> > +
> > +static bool fcontext_is_binary(FILE *fp)
> > +{
> > +     uint32_t magic;
> > +
> > +     size_t len = fread(&magic, sizeof(magic), 1, fp);
> > +     rewind(fp);
> > +
> > +     return (len && (magic == SELINUX_MAGIC_COMPILED_FCONTEXT));
> > +}
> > +
> > +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > +
> > +static FILE *open_file(const char *path, const char *suffix,
> > +        char **save_path, struct stat *sb)
> > +{
> > +     unsigned i;
> >       int rc;
> >       char stack_path[PATH_MAX + 1];
> > -     bool isbinary = false;
> > -     uint32_t magic;
> >
> > -     /* append the path suffix if we have one */
> > -     if (suffix) {
> > -             rc = snprintf(stack_path, sizeof(stack_path),
> > -                                         "%s.%s", path, suffix);
> > -             if (rc >= (int)sizeof(stack_path)) {
> > -                     errno = ENAMETOOLONG;
> > -                     return -1;
> > -             }
> > -             path = stack_path;
> > +     struct file_details *found = NULL;
> > +     char found_path[sizeof(stack_path)];
> > +
> > +     /*
> > +      * Rolling append of suffix. Try to open with path.suffix then the
> > +      * next as path.suffix.suffix and so forth.
> > +      */
> > +     struct file_details fdetails[2] = {
> > +                     { .suffix = suffix },
> > +                     { .suffix = "bin" }
> > +     };
> > +
> > +     rc = snprintf(stack_path, sizeof(stack_path), "%s", path);
> > +     if (rc >= (int) sizeof(stack_path)) {
> > +             errno = ENAMETOOLONG;
> > +             return NULL;
> >       }
> >
> > -     /* Open the specification file. */
> > -     fp = fopen(path, "r");
> > -     if (fp) {
> > -             __fsetlocking(fp, FSETLOCKING_BYCALLER);
> > +     for (i = 0; i < ARRAY_SIZE(fdetails); i++) {
> >
> > -             if (fstat(fileno(fp), &sb) < 0)
> > -                     return -1;
> > -             if (!S_ISREG(sb.st_mode)) {
> > -                     errno = EINVAL;
> > -                     return -1;
> > -             }
> > +             /* This handles the case if suffix is null */
> > +             path = rolling_append(stack_path, fdetails[i].suffix,
> > +                     sizeof(stack_path));
> > +             if (!path)
> > +                     return NULL;
> >
> > -             magic = 0;
> > -             if (fread(&magic, sizeof magic, 1, fp) != 1) {
> > -                     if (ferror(fp)) {
> > -                             errno = EINVAL;
> > -                             fclose(fp);
> > -                             return -1;
> > -                     }
> > -                     clearerr(fp);
> > +             rc = stat(path, &fdetails[i].sb);
> > +             if (rc)
> > +                     continue;
> > +
> > +             /* first file thing found, just take it */
> > +             if (!found) {
> > +                     strcpy(found_path, path);
> > +                     found = &fdetails[i];
> > +                     continue;
> >               }
> >
> > -             if (magic == SELINUX_MAGIC_COMPILED_FCONTEXT) {
> > -                     /* file_contexts.bin format */
> > -                     fclose(fp);
> > -                     fp = NULL;
> > -                     isbinary = true;
> > -             } else {
> > -                     rewind(fp);
> > +             /* next possible finds, keep picking the newest file */
> > +             if (fdetails[i].sb.st_mtime > found->sb.st_mtime) {
> > +                     found = &fdetails[i];
> > +                     strcpy(found_path, path);
> >               }
> > -     } else {
> > -             /*
> > -              * Text file does not exist, so clear the timestamp
> > -              * so that we will always pass the timestamp comparison
> > -              * with the bin file in load_mmap().
> > -              */
> > -             sb.st_mtime = 0;
> >       }
> >
> > -     rc = load_mmap(rec, path, &sb, isbinary, digest);
> > -     if (rc == 0)
> > -             goto out;
> > +     if (!found) {
> > +             errno = ENOENT;
> > +             return NULL;
> > +     }
> > +     *save_path = strdup(found_path);
> > +     if (!*save_path)
> > +             return NULL;
> >
> > -     if (!fp)
> > -             return -1; /* no text or bin file */
> > +     memcpy(sb, &found->sb, sizeof(*sb));
> > +     return fopen(found_path, "r");
> > +}
> >
> > -     /*
> > -      * Then do detailed validation of the input and fill the spec
array
> > -      */
> > -     lineno = 0;
> > -     rc = 0;
> > -     while (getline(&line_buf, &line_len, fp) > 0) {
> > -             rc = process_line(rec, path, prefix, line_buf, ++lineno);
> > -             if (rc)
> > -                     goto out;
> > -     }
> > +static int process_file(const char *path, const char *suffix,
> > +                       struct selabel_handle *rec,
> > +                       const char *prefix, struct selabel_digest
*digest)
> > +{
> > +     FILE *fp;
> > +     struct stat sb;
> > +     int rc;
> > +     struct saved_data *data = (struct saved_data *)rec->data;
> >
> > -     rc = digest_add_specfile(digest, fp, NULL, sb.st_size, path);
> > +     fp = open_file(path, suffix, &data->path, &sb);
> > +     if (fp == NULL)
> > +             return -1;
> >
> > +     rc = fcontext_is_binary(fp) ?
> > +                     load_mmap(fp, sb.st_size, rec) :
> > +                     process_text_file(fp, prefix, rec);
> > +     if (rc < 0)
> > +             goto out;
> > +
> > +     rc = digest_add_specfile(digest, fp, NULL, sb.st_size, path);
> >  out:
> > -     free(line_buf);
> > -     if (fp)
> > -             fclose(fp);
> > +     fclose(fp);
> >       return rc;
> >  }
> >
> > @@ -634,6 +661,7 @@ static void closef(struct selabel_handle *rec)
> >               area = area->next;
> >               free(last_area);
> >       }
> > +     free(data->path);
> >       free(data);
> >  }
> >
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index 6d1e890..fe5dc60 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -76,6 +76,7 @@ struct saved_data {
> >       int num_stems;
> >       int alloc_stems;
> >       struct mmap_area *mmap_areas;
> > +     char *path;
> >  };
> >
> >  static inline pcre_extra *get_pcre_extra(struct spec *spec)
> >
>
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Seandroid-list-request@tycho.nsa.gov.

--001a11475d4e1e6884053bdc5631
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 6, 2016 13:01, &quot;Stephen Smalley&quot; &lt;<a hre=
f=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 09/06/2016 11:51 AM, <a href=3D"mailto:william.c.roberts@intel.com"=
>william.c.roberts@intel.com</a> wrote:<br>
&gt; &gt; From: William Roberts &lt;<a href=3D"mailto:william.c.roberts@int=
el.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; The current process_file() code will open the file<br>
&gt; &gt; twice on the case of a binary file, correct this.<br>
&gt; &gt;<br>
&gt; &gt; The general flow through process_file() was a bit<br>
&gt; &gt; difficult to read, streamline the routine to be<br>
&gt; &gt; more readable.<br>
&gt; &gt;<br>
&gt; &gt; Detailed statistics of before and after:<br>
&gt; &gt;<br>
&gt; &gt; Source lines of code reported by cloc on modified files:<br>
&gt; &gt; before: 1090<br>
&gt; &gt; after: 1102<br>
&gt; &gt;<br>
&gt; &gt; Object size difference:<br>
&gt; &gt; before: 195530 bytes<br>
&gt; &gt; after:=C2=A0 195563 bytes<br>
&gt;<br>
&gt; Old logic would use the .bin file as long as it is not older than the<=
br>
&gt; base file; new logic will only use the .bin file if it is newer.=C2=A0=
 The<br>
&gt; end result on my system was that it was using the text file instead.</=
p>
<p dir=3D"ltr">I&#39;m not following here. I spent a lot of time with strac=
e comparing old vs new behavior here. If x and x.bin exist, it should use x=
.bin if it&#39;s newer or the same age as x? Is that correct?</p>
<p dir=3D"ltr">&gt;<br>
&gt; Also, there are some memory leaks in there; run it under valgrind, e.g=
.<br>
&gt; valgrind --leak-check=3Dfull matchpathcon /etc</p>
<p dir=3D"ltr">OK I&#39;ll run that test.</p>
<p dir=3D"ltr">&gt;<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william.c.ro=
berts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 libselinux/src/label_file.c | 264 ++++++++++++++++++++++++-=
-------------------<br>
&gt; &gt;=C2=A0 libselinux/src/label_file.h |=C2=A0 =C2=A01 +<br>
&gt; &gt;=C2=A0 2 files changed, 147 insertions(+), 118 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/libselinux/src/label_file.c b/libselinux/src/label_f=
ile.c<br>
&gt; &gt; index c89bb35..26b1b87 100644<br>
&gt; &gt; --- a/libselinux/src/label_file.c<br>
&gt; &gt; +++ b/libselinux/src/label_file.c<br>
&gt; &gt; @@ -97,62 +97,44 @@ static int nodups_specs(struct saved_data *da=
ta, const char *path)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -static int load_mmap(struct selabel_handle *rec, const char *pat=
h,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stat *sb, boo=
l isbinary,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct selabel_diges=
t *digest)<br>
&gt; &gt; +static int process_text_file(FILE *fp, const char *prefix, struc=
t selabel_handle *rec)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * Then do detailed validation of the input =
and fill the spec array<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0size_t line_len;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned lineno =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0char *line_buf =3D NULL;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct saved_data *data =3D (struct saved_da=
ta *)rec-&gt;data;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0while (getline(&amp;line_buf, &amp;line_len,=
 fp) &gt; 0) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D process_l=
ine(rec, data-&gt;path, prefix, line_buf, ++lineno);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto out;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0rc =3D 0;<br>
&gt; &gt; +out:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0free(line_buf);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static int load_mmap(FILE *fp, size_t len, struct selabel_handle=
 *rec)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct saved_data *data =3D (struct sav=
ed_data *)rec-&gt;data;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0char mmap_path[PATH_MAX + 1];<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0int mmapfd;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0struct stat mmap_stat;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *addr, *str_buf;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0size_t len;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int *stem_map;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmap_area *mmap_area;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t i, magic, version;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t entry_len, stem_map_len, regex=
_array_len;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (isbinary) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D strlen(p=
ath);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &gt;=3D =
sizeof(mmap_path))<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -1;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(mmap_path=
, path);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D snprintf(=
mmap_path, sizeof(mmap_path), &quot;%s.bin&quot;, path);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &gt;=3D (=
int)sizeof(mmap_path))<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -1;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0mmapfd =3D open(mmap_path, O_RDONLY | O_CLOE=
XEC);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (mmapfd &lt; 0)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0rc =3D fstat(mmapfd, &amp;mmap_stat);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (rc &lt; 0) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(mmapfd);<b=
r>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0/* if mmap is old, ignore it */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (mmap_stat.st_mtime &lt; sb-&gt;st_mtime)=
 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(mmapfd);<b=
r>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0/* ok, read it in... */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0len =3D mmap_stat.st_size;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0len +=3D (sysconf(_SC_PAGE_SIZE) - 1);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0len &amp;=3D ~(sysconf(_SC_PAGE_SIZE) - 1);<=
br>
&gt; &gt; -<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mmap_area =3D malloc(sizeof(*mmap_area)=
);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mmap_area) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(mmapfd);<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0addr =3D mmap(NULL, len, PROT_READ, MAP_PRIV=
ATE, mmapfd, 0);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0close(mmapfd);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0addr =3D mmap(NULL, len, PROT_READ, MAP_PRIV=
ATE, fileno(fp), 0);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (addr =3D=3D MAP_FAILED) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(mmap_a=
rea);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(&quo=
t;mmap&quot;);<br>
&gt; &gt; @@ -306,7 +288,7 @@ static int load_mmap(struct selabel_handle *r=
ec, const char *path,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(=
spec-&gt;lr.ctx_raw, &quot;&lt;&lt;none&gt;&gt;&quot;) &amp;&amp; rec-&gt;v=
alidating) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (selabel_validate(rec, &amp;spec-&gt;lr) &lt; 0) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selinux_log(SELINUX_ERROR,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;%s: context %s is invalid\n&quot;, mmap_path, spec-&gt;lr.c=
tx_raw);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;%s: context %s is invalid\n&quot;, data-&gt;path, spec-&gt;=
lr.ctx_raw);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; @@ -408,105 +390,150 @@ static int load_mmap(struct selabel_handl=
e *rec, const char *path,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;ns=
pec++;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0rc =3D digest_add_specfile(digest, NULL, add=
r, mmap_stat.st_size,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0mmap_path);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; &gt; -<br>
&gt; &gt;=C2=A0 err:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0free(stem_map);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -static int process_file(const char *path, const char *suffix,<br=
>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct selabel_handle *rec,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0const char *prefix, struct selabel_digest *digest)<br>
&gt; &gt; -{<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0FILE *fp;<br>
&gt; &gt; +struct file_details {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0const char *suffix;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct stat sb;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0unsigned int lineno;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0size_t line_len =3D 0;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0char *line_buf =3D NULL;<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +static char *rolling_append(char *current, const char *suffix, s=
ize_t max)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0size_t size;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0size_t suffix_size;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0size_t current_size;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (!suffix)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return current;<=
br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * Overflow check that the following<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * arithmatec will not overflow or<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0current_size =3D strlen(current);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0suffix_size =3D strlen(suffix);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0size =3D current_size + suffix_size;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (size &lt; current_size || size &lt; suff=
ix_size)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0/* ensure space for the &#39;.&#39; and the =
&#39;\0&#39; characters. */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (size &gt;=3D (SIZE_MAX - 2))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0size +=3D 2;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (size &gt; max)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0/* Append any given suffix */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0char *to =3D stpcpy(&amp;current[current_siz=
e], &quot;.&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0strcat(to, suffix);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0return current;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static bool fcontext_is_binary(FILE *fp)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0uint32_t magic;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0size_t len =3D fread(&amp;magic, sizeof(magi=
c), 1, fp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0rewind(fp);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0return (len &amp;&amp; (magic =3D=3D SELINUX=
_MAGIC_COMPILED_FCONTEXT));<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))<br>
&gt; &gt; +<br>
&gt; &gt; +static FILE *open_file(const char *path, const char *suffix,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char **save_path, struct stat *sb)<b=
r>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned i;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char stack_path[PATH_MAX + 1];<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0bool isbinary =3D false;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0uint32_t magic;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0/* append the path suffix if we have one */<=
br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (suffix) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D snprintf(=
stack_path, sizeof(stack_path),<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;%s.%s&quot;, path, suffix);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &gt;=3D (=
int)sizeof(stack_path)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0errno =3D ENAMETOOLONG;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -1;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D stack_p=
ath;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct file_details *found =3D NULL;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0char found_path[sizeof(stack_path)];<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * Rolling append of suffix. Try to open wit=
h path.suffix then the<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * next as path.suffix.suffix and so forth.<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct file_details fdetails[2] =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0{ .suffix =3D suffix },<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0{ .suffix =3D &quot;bin&quot; }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0rc =3D snprintf(stack_path, sizeof(stack_pat=
h), &quot;%s&quot;, path);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (rc &gt;=3D (int) sizeof(stack_path)) {<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENAMET=
OOLONG;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0/* Open the specification file. */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0fp =3D fopen(path, &quot;r&quot;);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (fp) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__fsetlocking(fp=
, FSETLOCKING_BYCALLER);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(fdetails); i=
++) {<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fstat(fileno=
(fp), &amp;sb) &lt; 0)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -1;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!S_ISREG(sb.=
st_mode)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0errno =3D EINVAL;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -1;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* This handles =
the case if suffix is null */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D rolling=
_append(stack_path, fdetails[i].suffix,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sizeof(stack_path));<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!path)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return NULL;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0magic =3D 0;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fread(&amp;m=
agic, sizeof magic, 1, fp) !=3D 1) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (ferror(fp)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EINVAL;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fclose(fp);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0clearerr(fp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D stat(path=
, &amp;fdetails[i].sb);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0continue;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* first file th=
ing found, just take it */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!found) {<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0strcpy(found_path, path);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0found =3D &amp;fdetails[i];<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0continue;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (magic =3D=3D=
 SELINUX_MAGIC_COMPILED_FCONTEXT) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* file_contexts.bin format */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0fclose(fp);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0fp =3D NULL;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0isbinary =3D true;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0rewind(fp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* next possible=
 finds, keep picking the newest file */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fdetails[i].=
sb.st_mtime &gt; found-&gt;sb.st_mtime) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0found =3D &amp;fdetails[i];<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0strcpy(found_path, path);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Text file doe=
s not exist, so clear the timestamp<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * so that we wi=
ll always pass the timestamp comparison<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * with the bin =
file in load_mmap().<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sb.st_mtime =3D =
0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0rc =3D load_mmap(rec, path, &amp;sb, isbinar=
y, digest);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (rc =3D=3D 0)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (!found) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENOENT=
;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0*save_path =3D strdup(found_path);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (!*save_path)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (!fp)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1; /* no=
 text or bin file */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0memcpy(sb, &amp;found-&gt;sb, sizeof(*sb));<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0return fopen(found_path, &quot;r&quot;);<br>
&gt; &gt; +}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 * Then do detailed validation of the input =
and fill the spec array<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0lineno =3D 0;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0rc =3D 0;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0while (getline(&amp;line_buf, &amp;line_len,=
 fp) &gt; 0) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D process_l=
ine(rec, path, prefix, line_buf, ++lineno);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto out;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +static int process_file(const char *path, const char *suffix,<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct selabel_handle *rec,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0const char *prefix, struct selabel_digest *digest)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0FILE *fp;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct stat sb;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct saved_data *data =3D (struct saved_da=
ta *)rec-&gt;data;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0rc =3D digest_add_specfile(digest, fp, NULL,=
 sb.st_size, path);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0fp =3D open_file(path, suffix, &amp;data-&gt=
;path, &amp;sb);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (fp =3D=3D NULL)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0rc =3D fcontext_is_binary(fp) ?<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0load_mmap(fp, sb.st_size, rec) :<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0process_text_file(fp, prefix, rec);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (rc &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0rc =3D digest_add_specfile(digest, fp, NULL,=
 sb.st_size, path);<br>
&gt; &gt;=C2=A0 out:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0free(line_buf);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (fp)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fclose(fp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0fclose(fp);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; @@ -634,6 +661,7 @@ static void closef(struct selabel_handle *rec=
)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0area =3D ar=
ea-&gt;next;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(last_a=
rea);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0free(data-&gt;path);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0free(data);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/libselinux/src/label_file.h b/libselinux/src/label_f=
ile.h<br>
&gt; &gt; index 6d1e890..fe5dc60 100644<br>
&gt; &gt; --- a/libselinux/src/label_file.h<br>
&gt; &gt; +++ b/libselinux/src/label_file.h<br>
&gt; &gt; @@ -76,6 +76,7 @@ struct saved_data {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int num_stems;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int alloc_stems;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmap_area *mmap_areas;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0char *path;<br>
&gt; &gt;=C2=A0 };<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static inline pcre_extra *get_pcre_extra(struct spec *spec)=
<br>
&gt; &gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Seandroid-list mailing list<br>
&gt; <a href=3D"mailto:Seandroid-list@tycho.nsa.gov">Seandroid-list@tycho.n=
sa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leave@t=
ycho.nsa.gov">Seandroid-list-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Seandroid-list-request@tycho.nsa.gov">Seandroid-list-request@tycho.ns=
a.gov</a>.<br></p>

--001a11475d4e1e6884053bdc5631--
