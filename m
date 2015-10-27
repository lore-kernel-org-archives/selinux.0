Subject: Re: [PATCH v2] fix memory leaks and uninitialized jump
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov
References: <1445971745-24079-1-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <562FC7BD.7040800@tycho.nsa.gov>
Date: Tue, 27 Oct 2015 14:51:41 -0400
MIME-Version: 1.0
In-Reply-To: <1445971745-24079-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/27/2015 02:49 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>

Subject line after [PATCH] should start with "libselinux: label_file:" 
or similar prefix identifying affected component.

>
> Some error's were reported by valgrind (below) fix them. The test
> cases on which these leaks were detected:
>
> 1. properly formed file_contexts file.
> 2. malformed file_contexts file, unknown type.
> 3. malformed file_contexts file, type that fails on validate callback.
> 4. malformed file_contexts file, invalid regex.
> 5. malformed file_contexts file, invalid mode.
>
> ==3819== Conditional jump or move depends on uninitialised value(s)
> ==3819==    at 0x12A682: closef (label_file.c:577)
> ==3819==    by 0x12A196: selabel_close (label.c:163)
> ==3819==    by 0x10A2FD: cleanup (checkfc.c:218)
> ==3819==    by 0x5089258: __run_exit_handlers (exit.c:82)
> ==3819==    by 0x50892A4: exit (exit.c:104)
> ==3819==    by 0x10A231: main (checkfc.c:361)
> ==3819==  Uninitialised value was created by a heap allocation
> ==3819==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==3819==    by 0x4C2CF1F: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==3819==    by 0x12BB31: process_file (label_file.h:273)
> ==3819==    by 0x12A2BA: selabel_file_init (label_file.c:522)
> ==3819==    by 0x12A0BB: selabel_open (label.c:88)
> ==3819==    by 0x10A038: main (checkfc.c:292)
> ==3819==
> ==3819==
> ==3819== HEAP SUMMARY:
> ==3819==     in use at exit: 729 bytes in 19 blocks
> ==3819==   total heap usage: 21,126 allocs, 21,107 frees, 923,854 bytes allocated
> ==3819==
> ==3819== 81 bytes in 1 blocks are definitely lost in loss record 1 of 2
> ==3819==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==3819==    by 0x50D5839: strdup (strdup.c:42)
> ==3819==    by 0x12A2A6: selabel_file_init (label_file.c:517)
> ==3819==    by 0x12A0BB: selabel_open (label.c:88)
> ==3819==    by 0x10A038: main (checkfc.c:292)
> ==3819==
>
> ==4238== 40 bytes in 1 blocks are definitely lost in loss record 1 of 6
> ==4238==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==4238==    by 0x12A1D2: selabel_file_init (label_file.c:886)
> ==4238==    by 0x12A0BB: selabel_open (label.c:88)
> ==4238==    by 0x10A038: main (checkfc.c:292)
> ==4238==
> ==4238== 81 bytes in 1 blocks are definitely lost in loss record 2 of 6
> ==4238==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==4238==    by 0x50D5839: strdup (strdup.c:42)
> ==4238==    by 0x12A2A6: selabel_file_init (label_file.c:517)
> ==4238==    by 0x12A0BB: selabel_open (label.c:88)
> ==4238==    by 0x10A038: main (checkfc.c:292)
> ==4238==
> ==4238== 386 bytes in 24 blocks are definitely lost in loss record 3 of 6
> ==4238==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==4238==    by 0x50D5889: strndup (strndup.c:45)
> ==4238==    by 0x12CDDF: read_spec_entries (label_support.c:37)
> ==4238==    by 0x12B72D: process_file (label_file.h:392)
> ==4238==    by 0x12A2BA: selabel_file_init (label_file.c:522)
> ==4238==    by 0x12A0BB: selabel_open (label.c:88)
> ==4238==    by 0x10A038: main (checkfc.c:292)
> ==4238==
> ==4238== 648 bytes in 18 blocks are definitely lost in loss record 4 of 6
> ==4238==    at 0x4C2CC70: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==4238==    by 0x117C9B: avtab_insert_node (avtab.c:105)
> ==4238==    by 0x117C10: avtab_insert (avtab.c:163)
> ==4238==    by 0x11880A: avtab_read_item (avtab.c:566)
> ==4238==    by 0x118BD3: avtab_read (avtab.c:600)
> ==4238==    by 0x125BDD: policydb_read (policydb.c:3854)
> ==4238==    by 0x109F87: main (checkfc.c:273)
> ==4238==
> ==4238== 1,095 bytes in 12 blocks are definitely lost in loss record 5 of 6
> ==4238==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==4238==    by 0x12D8D1: pcre_compile2 (pcre_compile.c:9217)
> ==4238==    by 0x12B239: compile_regex (label_file.h:357)
> ==4238==    by 0x12B9C7: process_file (label_file.h:429)
> ==4238==    by 0x12A2BA: selabel_file_init (label_file.c:522)
> ==4238==    by 0x12A0BB: selabel_open (label.c:88)
> ==4238==    by 0x10A038: main (checkfc.c:292)
> ==4238==
> ==4238== 1,296 bytes in 12 blocks are definitely lost in loss record 6 of 6
> ==4238==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==4238==    by 0x13EBE5: pcre_study (pcre_study.c:1565)
> ==4238==    by 0x12B25D: compile_regex (label_file.h:366)
> ==4238==    by 0x12B9C7: process_file (label_file.h:429)
> ==4238==    by 0x12A2BA: selabel_file_init (label_file.c:522)
> ==4238==    by 0x12A0BB: selabel_open (label.c:88)
> ==4238==    by 0x10A038: main (checkfc.c:292)
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>   libselinux/src/label.c      |  1 +
>   libselinux/src/label_file.c |  5 ++++-
>   libselinux/src/label_file.h | 21 ++++++++++++++-------
>   3 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index c656fda..963bfcb 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -338,6 +338,7 @@ struct selabel_handle *selabel_open(unsigned int backend,
>   	rec->digest = selabel_is_digest_set(opts, nopts, rec->digest);
>
>   	if ((*initfuncs[backend])(rec, opts, nopts)) {
> +		free(rec->spec_file);
>   		free(rec);
>   		rec = NULL;
>   	}
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 1a0c15f..071d902 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -507,6 +507,8 @@ out:
>   	return rc;
>   }
>
> +static void closef(struct selabel_handle *rec);
> +
>   static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>   		unsigned n)
>   {
> @@ -580,7 +582,8 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>
>   finish:
>   	if (status)
> -		free(data->spec_arr);
> +		closef(rec);
> +
>   	return status;
>   }
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 2492826..4ec808b 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -278,6 +278,7 @@ static inline int store_stem(struct saved_data *data, char *buf, int stem_len)
>   	}
>   	data->stem_arr[num].len = stem_len;
>   	data->stem_arr[num].buf = buf;
> +	data->stem_arr[num].from_mmap = 0;
>   	data->num_stems++;
>
>   	return num;
> @@ -425,6 +426,19 @@ static inline int process_line(struct selabel_handle *rec,
>   	/* process and store the specification in spec. */
>   	spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
>   	spec_arr[nspec].regex_str = regex;
> +
> +	/* Convert the type string to a mode format */

This comment can stay down below with the actual type/mode conversion, 
or get dropped altogether, but doesn't belong here (no converting 
happening here).

> +	spec_arr[nspec].type_str = type;
> +	spec_arr[nspec].mode = 0;
> +
> +	spec_arr[nspec].lr.ctx_raw = context;
> +
> +	/*
> +	 * bump data->nspecs to cause closef() to cover it in its free
> +	 * but do not bump nspec since it's used below.
> +	 */
> +	data->nspec++;
> +
>   	if (rec->validating &&
>   			    compile_regex(data, &spec_arr[nspec], &errbuf)) {
>   		COMPAT_LOG(SELINUX_ERROR,
> @@ -435,9 +449,6 @@ static inline int process_line(struct selabel_handle *rec,
>   		return -1;
>   	}
>
> -	/* Convert the type string to a mode format */
> -	spec_arr[nspec].type_str = type;
> -	spec_arr[nspec].mode = 0;
>   	if (type) {
>   		mode_t mode = string_to_mode(type);
>
> @@ -451,8 +462,6 @@ static inline int process_line(struct selabel_handle *rec,
>   		spec_arr[nspec].mode = mode;
>   	}
>
> -	spec_arr[nspec].lr.ctx_raw = context;
> -
>   	/* Determine if specification has
>   	 * any meta characters in the RE */
>   	spec_hasMetaChars(&spec_arr[nspec]);
> @@ -460,8 +469,6 @@ static inline int process_line(struct selabel_handle *rec,
>   	if (strcmp(context, "<<none>>") && rec->validating)
>   		compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
>
> -	data->nspec = ++nspec;
> -
>   	return 0;
>   }
>
>
