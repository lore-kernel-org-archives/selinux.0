MIME-Version: 1.0
In-Reply-To: <562FB6FC.8060303@tycho.nsa.gov>
References: <1445884356-11059-1-git-send-email-william.c.roberts@intel.com>
 <562FB6FC.8060303@tycho.nsa.gov>
Date: Tue, 27 Oct 2015 11:05:47 -0700
Message-ID: <CAFftDdq=FqZmX51nwiN3ifm7TGx-4pH7jq_afZU14V_WkDfQYA@mail.gmail.com>
Subject: Re: [PATCH] fix memory leaks and uninitialized jump
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1140ff2a634946052319ed96
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140ff2a634946052319ed96
Content-Type: text/plain; charset=UTF-8

On Oct 27, 2015 10:42 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> Subject: [PATCH] libselinux: label_file: fix memory leaks and
uninitialized jump
>
>
> On 10/26/2015 02:32 PM, william.c.roberts@intel.com wrote:
>>
>> From: William Roberts <william.c.roberts@intel.com>
>>
>>      Some error's were reported by valgrind (below) fix them. The test
>>      cases on which these leaks were detected:
>
>
> Why do you have leading space in the subject line and every line of the
description?
>
>
>>
>>      1. properly formed file_contexts file.
>>      2. malformed file_contexts file, unknown type.
>>      3. malformed file_contexts file, type that fails on validate
callback.
>>      4. malformed file_contexts file, invalid regex.
>>      5. malformed file_contexts file, invalid mode.
>>
>>      ==3819== Conditional jump or move depends on uninitialised value(s)
>>      ==3819==    at 0x12A682: closef (label_file.c:577)
>>      ==3819==    by 0x12A196: selabel_close (label.c:163)
>>      ==3819==    by 0x10A2FD: cleanup (checkfc.c:218)
>>      ==3819==    by 0x5089258: __run_exit_handlers (exit.c:82)
>>      ==3819==    by 0x50892A4: exit (exit.c:104)
>>      ==3819==    by 0x10A231: main (checkfc.c:361)
>>      ==3819==  Uninitialised value was created by a heap allocation
>>      ==3819==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>      ==3819==    by 0x4C2CF1F: realloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>      ==3819==    by 0x12BB31: process_file (label_file.h:273)
>>      ==3819==    by 0x12A2BA: selabel_file_init (label_file.c:522)
>>      ==3819==    by 0x12A0BB: selabel_open (label.c:88)
>>      ==3819==    by 0x10A038: main (checkfc.c:292)
>>      ==3819==
>>      ==3819==
>>      ==3819== HEAP SUMMARY:
>>      ==3819==     in use at exit: 729 bytes in 19 blocks
>>      ==3819==   total heap usage: 21,126 allocs, 21,107 frees, 923,854
bytes allocated
>>      ==3819==
>>      ==3819== 81 bytes in 1 blocks are definitely lost in loss record 1
of 2
>>      ==3819==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>      ==3819==    by 0x50D5839: strdup (strdup.c:42)
>>      ==3819==    by 0x12A2A6: selabel_file_init (label_file.c:517)
>>      ==3819==    by 0x12A0BB: selabel_open (label.c:88)
>>      ==3819==    by 0x10A038: main (checkfc.c:292)
>>      ==3819==
>>
>>      ==4238== 40 bytes in 1 blocks are definitely lost in loss record 1
of 6
>>      ==4238==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>      ==4238==    by 0x12A1D2: selabel_file_init (label_file.c:886)
>>      ==4238==    by 0x12A0BB: selabel_open (label.c:88)
>>      ==4238==    by 0x10A038: main (checkfc.c:292)
>>      ==4238==
>>      ==4238== 81 bytes in 1 blocks are definitely lost in loss record 2
of 6
>>      ==4238==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>      ==4238==    by 0x50D5839: strdup (strdup.c:42)
>>      ==4238==    by 0x12A2A6: selabel_file_init (label_file.c:517)
>>      ==4238==    by 0x12A0BB: selabel_open (label.c:88)
>>      ==4238==    by 0x10A038: main (checkfc.c:292)
>>      ==4238==
>>      ==4238== 386 bytes in 24 blocks are definitely lost in loss record
3 of 6
>>      ==4238==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>      ==4238==    by 0x50D5889: strndup (strndup.c:45)
>>      ==4238==    by 0x12CDDF: read_spec_entries (label_support.c:37)
>>      ==4238==    by 0x12B72D: process_file (label_file.h:392)
>>      ==4238==    by 0x12A2BA: selabel_file_init (label_file.c:522)
>>      ==4238==    by 0x12A0BB: selabel_open (label.c:88)
>>      ==4238==    by 0x10A038: main (checkfc.c:292)
>>      ==4238==
>>      ==4238== 648 bytes in 18 blocks are definitely lost in loss record
4 of 6
>>      ==4238==    at 0x4C2CC70: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>      ==4238==    by 0x117C9B: avtab_insert_node (avtab.c:105)
>>      ==4238==    by 0x117C10: avtab_insert (avtab.c:163)
>>      ==4238==    by 0x11880A: avtab_read_item (avtab.c:566)
>>      ==4238==    by 0x118BD3: avtab_read (avtab.c:600)
>>      ==4238==    by 0x125BDD: policydb_read (policydb.c:3854)
>>      ==4238==    by 0x109F87: main (checkfc.c:273)
>>      ==4238==
>>      ==4238== 1,095 bytes in 12 blocks are definitely lost in loss
record 5 of 6
>>      ==4238==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>      ==4238==    by 0x12D8D1: pcre_compile2 (pcre_compile.c:9217)
>>      ==4238==    by 0x12B239: compile_regex (label_file.h:357)
>>      ==4238==    by 0x12B9C7: process_file (label_file.h:429)
>>      ==4238==    by 0x12A2BA: selabel_file_init (label_file.c:522)
>>      ==4238==    by 0x12A0BB: selabel_open (label.c:88)
>>      ==4238==    by 0x10A038: main (checkfc.c:292)
>>      ==4238==
>>      ==4238== 1,296 bytes in 12 blocks are definitely lost in loss
record 6 of 6
>>      ==4238==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>      ==4238==    by 0x13EBE5: pcre_study (pcre_study.c:1565)
>>      ==4238==    by 0x12B25D: compile_regex (label_file.h:366)
>>      ==4238==    by 0x12B9C7: process_file (label_file.h:429)
>>      ==4238==    by 0x12A2BA: selabel_file_init (label_file.c:522)
>>      ==4238==    by 0x12A0BB: selabel_open (label.c:88)
>>      ==4238==    by 0x10A038: main (checkfc.c:292)
>>
>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> ---
>>   libselinux/src/label.c      |  1 +
>>   libselinux/src/label_file.c |  5 ++++-
>>   libselinux/src/label_file.h | 22 ++++++++++++++--------
>>   3 files changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
>> index c656fda..963bfcb 100644
>> --- a/libselinux/src/label.c
>> +++ b/libselinux/src/label.c
>> @@ -338,6 +338,7 @@ struct selabel_handle *selabel_open(unsigned int
backend,
>>         rec->digest = selabel_is_digest_set(opts, nopts, rec->digest);
>>
>>         if ((*initfuncs[backend])(rec, opts, nopts)) {
>> +               free(rec->spec_file);
>>                 free(rec);
>>                 rec = NULL;
>>         }
>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>> index 1a0c15f..071d902 100644
>> --- a/libselinux/src/label_file.c
>> +++ b/libselinux/src/label_file.c
>> @@ -507,6 +507,8 @@ out:
>>         return rc;
>>   }
>>
>> +static void closef(struct selabel_handle *rec);
>> +
>>   static int init(struct selabel_handle *rec, const struct selinux_opt
*opts,
>>                 unsigned n)
>>   {
>> @@ -580,7 +582,8 @@ static int init(struct selabel_handle *rec, const
struct selinux_opt *opts,
>>
>>   finish:
>>         if (status)
>> -               free(data->spec_arr);
>> +               closef(rec);
>> +
>>         return status;
>>   }
>>
>> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
>> index 2492826..a85b9bd 100644
>> --- a/libselinux/src/label_file.h
>> +++ b/libselinux/src/label_file.h
>> @@ -278,6 +278,7 @@ static inline int store_stem(struct saved_data
*data, char *buf, int stem_len)
>>         }
>>         data->stem_arr[num].len = stem_len;
>>         data->stem_arr[num].buf = buf;
>> +       data->stem_arr[num].from_mmap = 0;
>>         data->num_stems++;
>>
>>         return num;
>> @@ -425,6 +426,19 @@ static inline int process_line(struct
selabel_handle *rec,
>>         /* process and store the specification in spec. */
>>         spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
>>         spec_arr[nspec].regex_str = regex;
>> +
>> +       /* Convert the type string to a mode format */
>
>
> Technically we should leave this comment line down where it was, at the
point that we actually convert the type string to a mode.
>
>
>> +       spec_arr[nspec].type_str = type;
>> +       spec_arr[nspec].mode = 0;
>> +
>> +       spec_arr[nspec].lr.ctx_raw = context;
>> +
>> +       /*
>> +        * bump data->nspecs to cause closef() to cover it in its free
>> +        * but do not bump nspec since it's used below.
>> +        */
>> +       data->nspec++;
>> +
>>         if (rec->validating &&
>>                             compile_regex(data, &spec_arr[nspec],
&errbuf)) {
>>                 COMPAT_LOG(SELINUX_ERROR,
>> @@ -435,9 +449,6 @@ static inline int process_line(struct selabel_handle
*rec,
>>                 return -1;
>>         }
>>
>> -       /* Convert the type string to a mode format */
>> -       spec_arr[nspec].type_str = type;
>> -       spec_arr[nspec].mode = 0;
>>         if (type) {
>>                 mode_t mode = string_to_mode(type);
>>
>> @@ -445,14 +456,11 @@ static inline int process_line(struct
selabel_handle *rec,
>>                         COMPAT_LOG(SELINUX_ERROR,
>>                                    "%s:  line %u has invalid file type
%s\n",
>>                                    path, lineno, type);
>> -                       errno = EINVAL;
>
>
> Don't want to remove this.

Yes definitely not. That crept in on version 8 of the patch on gerrit you
+1'd. Cannot believe we missed that.

>
>
>>                         return -1;
>>                 }
>>                 spec_arr[nspec].mode = mode;
>>         }
>>
>> -       spec_arr[nspec].lr.ctx_raw = context;
>> -
>>         /* Determine if specification has
>>          * any meta characters in the RE */
>>         spec_hasMetaChars(&spec_arr[nspec]);
>> @@ -460,8 +468,6 @@ static inline int process_line(struct selabel_handle
*rec,
>>         if (strcmp(context, "<<none>>") && rec->validating)
>>                 compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
>>
>> -       data->nspec = ++nspec;
>> -
>>         return 0;
>>   }
>>
>>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a1140ff2a634946052319ed96
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Oct 27, 2015 10:42 AM, &quot;Stephen Smalley&quot; &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; Subject: [PATCH] libselinux: label_file: fix memory leaks and uninitia=
lized jump<br>
&gt;<br>
&gt;<br>
&gt; On 10/26/2015 02:32 PM, <a href=3D"mailto:william.c.roberts@intel.com"=
>william.c.roberts@intel.com</a> wrote:<br>
&gt;&gt;<br>
&gt;&gt; From: William Roberts &lt;<a href=3D"mailto:william.c.roberts@inte=
l.com">william.c.roberts@intel.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0Some error&#39;s were reported by valgrind (be=
low) fix them. The test<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0cases on which these leaks were detected:<br>
&gt;<br>
&gt;<br>
&gt; Why do you have leading space in the subject line and every line of th=
e description?<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A01. properly formed file_contexts file.<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A02. malformed file_contexts file, unknown type.=
<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A03. malformed file_contexts file, type that fai=
ls on validate callback.<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A04. malformed file_contexts file, invalid regex=
.<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A05. malformed file_contexts file, invalid mode.=
<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D Conditional jump or move depe=
nds on uninitialised value(s)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 at 0x12A682: clo=
sef (label_file.c:577)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12A196: sel=
abel_close (label.c:163)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x10A2FD: cle=
anup (checkfc.c:218)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x5089258: __=
run_exit_handlers (exit.c:82)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x50892A4: ex=
it (exit.c:104)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x10A231: mai=
n (checkfc.c:361)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 Uninitialised value was=
 created by a heap allocation<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80: ma=
lloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x4C2CF1F: re=
alloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12BB31: pro=
cess_file (label_file.h:273)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12A2BA: sel=
abel_file_init (label_file.c:522)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12A0BB: sel=
abel_open (label.c:88)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x10A038: mai=
n (checkfc.c:292)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D HEAP SUMMARY:<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 =C2=A0in use at =
exit: 729 bytes in 19 blocks<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0total heap usage:=
 21,126 allocs, 21,107 frees, 923,854 bytes allocated<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D 81 bytes in 1 blocks are defi=
nitely lost in loss record 1 of 2<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80: ma=
lloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x50D5839: st=
rdup (strdup.c:42)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12A2A6: sel=
abel_file_init (label_file.c:517)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12A0BB: sel=
abel_open (label.c:88)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x10A038: mai=
n (checkfc.c:292)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 40 bytes in 1 blocks are defi=
nitely lost in loss record 1 of 6<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80: ma=
lloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A1D2: sel=
abel_file_init (label_file.c:886)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A0BB: sel=
abel_open (label.c:88)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x10A038: mai=
n (checkfc.c:292)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 81 bytes in 1 blocks are defi=
nitely lost in loss record 2 of 6<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80: ma=
lloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x50D5839: st=
rdup (strdup.c:42)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A2A6: sel=
abel_file_init (label_file.c:517)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A0BB: sel=
abel_open (label.c:88)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x10A038: mai=
n (checkfc.c:292)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 386 bytes in 24 blocks are de=
finitely lost in loss record 3 of 6<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80: ma=
lloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x50D5889: st=
rndup (strndup.c:45)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12CDDF: rea=
d_spec_entries (label_support.c:37)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12B72D: pro=
cess_file (label_file.h:392)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A2BA: sel=
abel_file_init (label_file.c:522)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A0BB: sel=
abel_open (label.c:88)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x10A038: mai=
n (checkfc.c:292)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 648 bytes in 18 blocks are de=
finitely lost in loss record 4 of 6<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2CC70: ca=
lloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x117C9B: avt=
ab_insert_node (avtab.c:105)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x117C10: avt=
ab_insert (avtab.c:163)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x11880A: avt=
ab_read_item (avtab.c:566)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x118BD3: avt=
ab_read (avtab.c:600)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x125BDD: pol=
icydb_read (policydb.c:3854)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x109F87: mai=
n (checkfc.c:273)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 1,095 bytes in 12 blocks are =
definitely lost in loss record 5 of 6<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80: ma=
lloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12D8D1: pcr=
e_compile2 (pcre_compile.c:9217)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12B239: com=
pile_regex (label_file.h:357)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12B9C7: pro=
cess_file (label_file.h:429)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A2BA: sel=
abel_file_init (label_file.c:522)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A0BB: sel=
abel_open (label.c:88)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x10A038: mai=
n (checkfc.c:292)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 1,296 bytes in 12 blocks are =
definitely lost in loss record 6 of 6<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80: ma=
lloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x13EBE5: pcr=
e_study (pcre_study.c:1565)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12B25D: com=
pile_regex (label_file.h:366)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12B9C7: pro=
cess_file (label_file.h:429)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A2BA: sel=
abel_file_init (label_file.c:522)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A0BB: sel=
abel_open (label.c:88)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x10A038: mai=
n (checkfc.c:292)<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william.c.rob=
erts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 libselinux/src/label.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;&gt; =C2=A0 libselinux/src/label_file.c |=C2=A0 5 ++++-<br>
&gt;&gt; =C2=A0 libselinux/src/label_file.h | 22 ++++++++++++++--------<br>
&gt;&gt; =C2=A0 3 files changed, 19 insertions(+), 9 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/libselinux/src/label.c b/libselinux/src/label.c<br>
&gt;&gt; index c656fda..963bfcb 100644<br>
&gt;&gt; --- a/libselinux/src/label.c<br>
&gt;&gt; +++ b/libselinux/src/label.c<br>
&gt;&gt; @@ -338,6 +338,7 @@ struct selabel_handle *selabel_open(unsigned i=
nt backend,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 rec-&gt;digest =3D selabel_is_digest_s=
et(opts, nopts, rec-&gt;digest);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((*initfuncs[backend])(rec, opts, n=
opts)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(rec-&=
gt;spec_file);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(rec);=
<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rec =3D NU=
LL;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; diff --git a/libselinux/src/label_file.c b/libselinux/src/label_fi=
le.c<br>
&gt;&gt; index 1a0c15f..071d902 100644<br>
&gt;&gt; --- a/libselinux/src/label_file.c<br>
&gt;&gt; +++ b/libselinux/src/label_file.c<br>
&gt;&gt; @@ -507,6 +507,8 @@ out:<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br>
&gt;&gt; =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; +static void closef(struct selabel_handle *rec);<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 static int init(struct selabel_handle *rec, const struct se=
linux_opt *opts,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned n=
)<br>
&gt;&gt; =C2=A0 {<br>
&gt;&gt; @@ -580,7 +582,8 @@ static int init(struct selabel_handle *rec, co=
nst struct selinux_opt *opts,<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 finish:<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(data-=
&gt;spec_arr);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0closef(rec=
);<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return status;<br>
&gt;&gt; =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/libselinux/src/label_file.h b/libselinux/src/label_fi=
le.h<br>
&gt;&gt; index 2492826..a85b9bd 100644<br>
&gt;&gt; --- a/libselinux/src/label_file.h<br>
&gt;&gt; +++ b/libselinux/src/label_file.h<br>
&gt;&gt; @@ -278,6 +278,7 @@ static inline int store_stem(struct saved_data=
 *data, char *buf, int stem_len)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;stem_arr[num].len =3D stem_le=
n;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;stem_arr[num].buf =3D buf;<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;stem_arr[num].from_mmap =3D 0=
;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;num_stems++;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return num;<br>
&gt;&gt; @@ -425,6 +426,19 @@ static inline int process_line(struct selabel=
_handle *rec,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* process and store the specification=
 in spec. */<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_arr[nspec].stem_id =3D find_stem_=
from_spec(data, regex);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_arr[nspec].regex_str =3D regex;<b=
r>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Convert the type string to a mode f=
ormat */<br>
&gt;<br>
&gt;<br>
&gt; Technically we should leave this comment line down where it was, at th=
e point that we actually convert the type string to a mode.<br>
&gt;<br>
&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].type_str =3D type;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].mode =3D 0;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].lr.ctx_raw =3D context=
;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * bump data-&gt;nspecs to cause close=
f() to cover it in its free<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * but do not bump nspec since it&#39;=
s used below.<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;nspec++;<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rec-&gt;validating &amp;&amp;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compile_regex(data, &amp;spec_arr[nspec], &=
amp;errbuf)) {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COMPAT_LOG=
(SELINUX_ERROR,<br>
&gt;&gt; @@ -435,9 +449,6 @@ static inline int process_line(struct selabel_=
handle *rec,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;=
<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Convert the type string to a mode f=
ormat */<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].type_str =3D type;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].mode =3D 0;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (type) {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_t mod=
e =3D string_to_mode(type);<br>
&gt;&gt;<br>
&gt;&gt; @@ -445,14 +456,11 @@ static inline int process_line(struct selabe=
l_handle *rec,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 COMPAT_LOG(SELINUX_ERROR,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%s:=C2=A0 =
line %u has invalid file type %s\n&quot;,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path, lineno, ty=
pe);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0errno =3D EINVAL;<br>
&gt;<br>
&gt;<br>
&gt; Don&#39;t want to remove this.</p>
<p dir=3D"ltr">Yes definitely not. That crept in on version 8 of the patch =
on gerrit you +1&#39;d. Cannot believe we missed that.<br></p>
<p dir=3D"ltr">&gt;<br>
&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return -1;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_arr[n=
spec].mode =3D mode;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].lr.ctx_raw =3D context=
;<br>
&gt;&gt; -<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Determine if specification has<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* any meta characters in the RE =
*/<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_hasMetaChars(&amp;spec_arr[nspec]=
);<br>
&gt;&gt; @@ -460,8 +468,6 @@ static inline int process_line(struct selabel_=
handle *rec,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(context, &quot;&lt;&lt;none=
&gt;&gt;&quot;) &amp;&amp; rec-&gt;validating)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compat_val=
idate(rec, &amp;spec_arr[nspec].lr, path, lineno);<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;nspec =3D ++nspec;<br>
&gt;&gt; -<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;&gt; =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</p>

--001a1140ff2a634946052319ed96--
