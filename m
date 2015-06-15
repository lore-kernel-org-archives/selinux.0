Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5FETPSa001416
 for <selinux@tycho.nsa.gov>; Mon, 15 Jun 2015 10:29:26 -0400
Date: Mon, 15 Jun 2015 14:26:18 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <324718826.2171993.1434378378522.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <557EDBAE.3030604@tycho.nsa.gov>
References: <557EDBAE.3030604@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: Enhance file context support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> On Monday, 15 June 2015, 15:06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 06/15/2015 08:33 AM, Richard Haines wrote:
>>  Update file contexts generation and loading to use common code. Also fix
>>  to correct sort order.
> 
> What do you mean by "correct sort order", and where is this changed in

> this patch?

I'll reword as the correction removed the "status = 0;" so a failure
would never be detected:

status = sort_specs(data);

-    status = 0;
> 
>> 
>>  The file labeling code has also had minor formatting, white space
>>  removal etc. changes.
>> 
>>  These changes bring file context processing in line with Android [1]
>>  apart from some minor build differences.
>> 
>>  label_file.c - Move process_line function to label_file.h
>>  sefcontext_compile.c - Update to use common process_line code. Now frees
>>  all malloc'ed memory, checked by valgrind. Also added optional -o 
> output
>>  file parameter - updated man page to reflect this change.
>> 
>>  [1] https://android-review.googlesource.com/#/c/153580/
>> 
>>  Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>  ---
>>   libselinux/man/man8/sefcontext_compile.8 |  49 +++++-
>>   libselinux/src/label_file.c              | 171 +++-----------------
>>   libselinux/src/label_file.h              | 156 +++++++++++++++++-
>>   libselinux/src/label_internal.h          |   2 +-
>>   libselinux/utils/sefcontext_compile.c    | 268 
> ++++++++++++++++---------------
>>   5 files changed, 354 insertions(+), 292 deletions(-)
>> 
>>  diff --git a/libselinux/man/man8/sefcontext_compile.8 
> b/libselinux/man/man8/sefcontext_compile.8
>>  index 810d22a..584c4c6 100644
>>  --- a/libselinux/man/man8/sefcontext_compile.8
>>  +++ b/libselinux/man/man8/sefcontext_compile.8
>>  @@ -1,15 +1,56 @@
>>  -.TH "sefcontext_compile" "8" "27 Jun 2013" 
> "dwalsh@redhat.com" "SELinux Command Line documentation"
>>  +.TH "sefcontext_compile" "8" "12 Jun 2015" 
> "dwalsh@redhat.com" "SELinux Command Line documentation"
>>   .SH "NAME"
>>   sefcontext_compile \- compile file context regular expression files
>>   .
>>   .SH "SYNOPSIS"
>>  -.B sefcontext_compile inputfile
>>  +.B sefcontext_compile
>>  +.RB [ \-o
>>  +.IR outputfile ]
>>  +.I inputfile
>>   .
>>   .SH "DESCRIPTION"
>>  -sefcontext_compile is used libsemanage to compile file context regular 
> expressions into prce format.  sefcontext_compile writes the compiled prce file 
> with the .bin suffix appended "inputfile".bin.  This compiled file is 
> used by libselinux file labeling functions.
>>  +.B sefcontext_compile
>>  +is used to compile file context regular expressions into
>>  +.BR prce (3)
>>  +format.
>>  +.sp
>>  +The compiled file is used by libselinux file labeling functions.
>>  +.sp
>>  +By default
>>  +.B sefcontext_compile
>>  +writes the compiled prce file with the
>>  +.B .bin
>>  +suffix appended (e.g. \fIinputfile\fB.bin\fR).
>>  +.SH OPTIONS
>>  +.TP
>>  +.B \-o
>>  +Specify an
>>  +.I outputfile
>>  +that must be a fully qualified file name as the
>>  +.B .bin
>>  +suffix is not automatically added.
>>  +.
>>  +.SH "RETURN VALUE"
>>  +On error -1 is returned.  On success 0 is returned.
>>  
>>  -.SH "EXAMPLE"
>>  +.SH "EXAMPLES"
>>  +.B Example 1:
>>  +.br
>>   sefcontext_compile /etc/selinux/targeted/contexts/files/file_contexts
>>  +.sp
>>  +Results in the following file being generated:
>>  +.RS
>>  +/etc/selinux/targeted/contexts/files/file_contexts.bin
>>  +.RE
>>  +.sp
>>  +.B Example 2:
>>  +.br
>>  +sefcontext_compile -o new_fc.bin 
> /etc/selinux/targeted/contexts/files/file_contexts
>>  +.sp
>>  +Results in the following file being generated in the cwd:
>>  +.RS
>>  +new_fc.bin
>>  +.RE
>>   .
>>   .SH AUTHOR
>>   Dan Walsh, <dwalsh@redhat.com>
>>  diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>>  index 60aae66..1d6c36e 100644
>>  --- a/libselinux/src/label_file.c
>>  +++ b/libselinux/src/label_file.c
>>  @@ -15,13 +15,11 @@
>>   #include <limits.h>
>>   #include <stdint.h>
>>   #include <pcre.h>
>>  -
>>  -#include <linux/limits.h>
>>  -
>>  +#include <unistd.h>
>>   #include <sys/mman.h>
>>   #include <sys/types.h>
>>   #include <sys/stat.h>
>>  -#include <unistd.h>
>>  +
>>   #include "callbacks.h"
>>   #include "label_internal.h"
>>   #include "label_file.h"
>>  @@ -72,12 +70,14 @@ static int nodups_specs(struct saved_data *data, const 
> char *path)
>>       for (ii = 0; ii < data->nspec; ii++) {
>>           curr_spec = &spec_arr[ii];
>>           for (jj = ii + 1; jj < data->nspec; jj++) {
>>  -            if ((!strcmp(spec_arr[jj].regex_str, curr_spec->regex_str))
>>  +            if ((!strcmp(spec_arr[jj].regex_str,
>>  +                curr_spec->regex_str))
>>                   && (!spec_arr[jj].mode || !curr_spec->mode
>>                   || spec_arr[jj].mode == curr_spec->mode)) {
>>                   rc = -1;
>>                   errno = EINVAL;
>>  -                if (strcmp(spec_arr[jj].lr.ctx_raw, 
> curr_spec->lr.ctx_raw)) {
>>  +                if (strcmp(spec_arr[jj].lr.ctx_raw,
>>  +                        curr_spec->lr.ctx_raw)) {
>>                       COMPAT_LOG
>>                           (SELINUX_ERROR,
>>                            "%s: Multiple different specifications for 
> %s  (%s and %s).\n",
>>  @@ -96,136 +96,8 @@ static int nodups_specs(struct saved_data *data, const 
> char *path)
>>       return rc;
>>   }
>>  
>>  -static int compile_regex(struct saved_data *data, struct spec *spec, const 
> char **errbuf)
>>  -{
>>  -    const char *tmperrbuf;
>>  -    char *reg_buf, *anchored_regex, *cp;
>>  -    struct stem *stem_arr = data->stem_arr;
>>  -    size_t len;
>>  -    int erroff;
>>  -
>>  -    if (spec->regcomp)
>>  -        return 0; /* already done */
>>  -
>>  -    /* Skip the fixed stem. */
>>  -    reg_buf = spec->regex_str;
>>  -    if (spec->stem_id >= 0)
>>  -        reg_buf += stem_arr[spec->stem_id].len;
>>  -
>>  -    /* Anchor the regular expression. */
>>  -    len = strlen(reg_buf);
>>  -    cp = anchored_regex = malloc(len + 3);
>>  -    if (!anchored_regex)
>>  -        return -1;
>>  -
>>  -    /* Create ^...$ regexp.  */
>>  -    *cp++ = '^';
>>  -    cp = mempcpy(cp, reg_buf, len);
>>  -    *cp++ = '$';
>>  -    *cp = '\0';
>>  -
>>  -    /* Compile the regular expression. */
>>  -    spec->regex = pcre_compile(anchored_regex, PCRE_DOTALL, 
> &tmperrbuf, &erroff, NULL);
>>  -    free(anchored_regex);
>>  -    if (!spec->regex) {
>>  -        if (errbuf)
>>  -            *errbuf=tmperrbuf;
>>  -        return -1;
>>  -    }
>>  -
>>  -    spec->sd = pcre_study(spec->regex, 0, &tmperrbuf);
>>  -    if (!spec->sd && tmperrbuf) {
>>  -        if (errbuf)
>>  -            *errbuf=tmperrbuf;
>>  -        return -1;
>>  -    }
>>  -
>>  -    /* Done. */
>>  -    spec->regcomp = 1;
>>  -
>>  -    return 0;
>>  -}
>>  -
>>  -static int process_line(struct selabel_handle *rec,
>>  -            const char *path, const char *prefix,
>>  -            char *line_buf, unsigned lineno)
>>  -{
>>  -    int items, len, rc;
>>  -    char *regex = NULL, *type = NULL, *context = NULL;
>>  -    struct saved_data *data = (struct saved_data *)rec->data;
>>  -    struct spec *spec_arr;
>>  -    unsigned int nspec = data->nspec;
>>  -    const char *errbuf = NULL;
>>  -
>>  -    items = read_spec_entries(line_buf, 3, &regex, &type, 
> &context);
>>  -    if (items <= 0)
>>  -        return items;
>>  -
>>  -    if (items < 2) {
>>  -        COMPAT_LOG(SELINUX_WARNING,
>>  -                "%s:  line %u is missing fields, 
> skipping\n", path,
>>  -                lineno);
>>  -        if (items == 1)
>>  -            free(regex);
>>  -        return 0;
>>  -    } else if (items == 2) {
>>  -        /* The type field is optional. */
>>  -        free(context);
>>  -        context = type;
>>  -        type = 0;
>>  -    }
>>  -
>>  -    len = get_stem_from_spec(regex);
>>  -    if (len && prefix && strncmp(prefix, regex, len)) 
> {
>>  -        /* Stem of regex does not match requested prefix, discard. */
>>  -        free(regex);
>>  -        free(type);
>>  -        free(context);
>>  -        return 0;
>>  -    }
>>  -
>>  -    rc = grow_specs(data);
>>  -    if (rc)
>>  -        return rc;
>>  -
>>  -    spec_arr = data->spec_arr;
>>  -
>>  -    /* process and store the specification in spec. */
>>  -    spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
>>  -    spec_arr[nspec].regex_str = regex;
>>  -    if (rec->validating && compile_regex(data, 
> &spec_arr[nspec], &errbuf)) {
>>  -        COMPAT_LOG(SELINUX_WARNING, "%s:  line %u has invalid regex 
> %s:  %s\n",
>>  -               path, lineno, regex, (errbuf ? errbuf : "out of 
> memory"));
>>  -    }
>>  -
>>  -    /* Convert the type string to a mode format */
>>  -    spec_arr[nspec].type_str = type;
>>  -    spec_arr[nspec].mode = 0;
>>  -    if (type) {
>>  -        mode_t mode = string_to_mode(type);
>>  -        if (mode == (mode_t)-1) {
>>  -            COMPAT_LOG(SELINUX_WARNING, "%s:  line %u has invalid 
> file type %s\n",
>>  -                   path, lineno, type);
>>  -            mode = 0;
>>  -        }
>>  -        spec_arr[nspec].mode = mode;
>>  -    }
>>  -
>>  -    spec_arr[nspec].lr.ctx_raw = context;
>>  -
>>  -    /* Determine if specification has
>>  -     * any meta characters in the RE */
>>  -    spec_hasMetaChars(&spec_arr[nspec]);
>>  -
>>  -    if (strcmp(context, "<<none>>") && 
> rec->validating)
>>  -        compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
>>  -
>>  -    data->nspec = ++nspec;
>>  -
>>  -    return 0;
>>  -}
>>  -
>>  -static int load_mmap(struct selabel_handle *rec, const char *path, struct 
> stat *sb)
>>  +static int load_mmap(struct selabel_handle *rec, const char *path,
>>  +                            struct stat *sb)
>>   {
>>       struct saved_data *data = (struct saved_data *)rec->data;
>>       char mmap_path[PATH_MAX + 1];
>>  @@ -259,12 +131,6 @@ static int load_mmap(struct selabel_handle *rec, const 
> char *path, struct stat *
>>           return -1;
>>       }
>>  
>>  -    if (mmap_stat.st_mtime == sb->st_mtime &&
>>  -        mmap_stat.st_mtim.tv_nsec < sb->st_mtim.tv_nsec) {
>>  -        close(mmapfd);
>>  -        return -1;
>>  -    }
>>  -
>>       /* ok, read it in... */
>>       len = mmap_stat.st_size;
>>       len += (sysconf(_SC_PAGE_SIZE) - 1);
>>  @@ -460,7 +326,7 @@ static int load_mmap(struct selabel_handle *rec, const 
> char *path, struct stat *
>>           if (rc < 0)
>>               goto err;
>>  
>>  -        if (stem_id < 0 || stem_id >= stem_map_len)
>>  +        if (stem_id < 0 || stem_id >= (int32_t)stem_map_len)
>>               spec->stem_id = -1;
>>            else
>>               spec->stem_id = stem_map[stem_id];
>>  @@ -520,19 +386,21 @@ err:
>>       return rc;
>>   }
>>  
>>  -static int process_file(const char *path, const char *suffix, struct 
> selabel_handle *rec, const char *prefix)
>>  +static int process_file(const char *path, const char *suffix,
>>  +              struct selabel_handle *rec, const char *prefix)
>>   {
>>       FILE *fp;
>>       struct stat sb;
>>       unsigned int lineno;
>>  -    size_t line_len;
>>  +    size_t line_len = 0;
>>       char *line_buf = NULL;
>>       int rc;
>>       char stack_path[PATH_MAX + 1];
>>  
>>       /* append the path suffix if we have one */
>>       if (suffix) {
>>  -        rc = snprintf(stack_path, sizeof(stack_path), "%s.%s", 
> path, suffix);
>>  +        rc = snprintf(stack_path, sizeof(stack_path),
>>  +                        "%s.%s", path, suffix);
>>           if (rc >= (int)sizeof(stack_path)) {
>>               errno = ENAMETOOLONG;
>>               return -1;
>>  @@ -563,13 +431,13 @@ static int process_file(const char *path, const char 
> *suffix, struct selabel_han
>>       while (getline(&line_buf, &line_len, fp) > 0) {
>>           rc = process_line(rec, path, prefix, line_buf, ++lineno);
>>           if (rc)
>>  -            return rc;
>>  +            goto out;
>>       }
>>  +
>>   out:
>>       free(line_buf);
>>       fclose(fp);
>>  -
>>  -    return 0;
>>  +    return rc;
>>   }
>>  
>>   static int init(struct selabel_handle *rec, struct selinux_opt *opts,
>>  @@ -609,7 +477,7 @@ static int init(struct selabel_handle *rec, struct 
> selinux_opt *opts,
>>  
>>       rec->spec_file = strdup(path);
>>  
>>  -    /* 
>>  +    /*
>>        * The do detailed validation of the input and fill the spec array
>>        */
>>       status = process_file(path, NULL, rec, prefix);
>>  @@ -634,7 +502,6 @@ static int init(struct selabel_handle *rec, struct 
> selinux_opt *opts,
>>  
>>       status = sort_specs(data);
>>  

>>  -    status = 0;
This was always set to 0 so error not detected


>>   finish:

--------------------- snip -------------
