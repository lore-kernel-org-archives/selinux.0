MIME-Version: 1.0
In-Reply-To: <562FB902.7060009@tycho.nsa.gov>
References: <1445884356-11059-1-git-send-email-william.c.roberts@intel.com>
 <476DC76E7D1DF2438D32BFADF679FC56010AC179@ORSMSX103.amr.corp.intel.com>
 <562FB902.7060009@tycho.nsa.gov>
Date: Tue, 27 Oct 2015 15:18:45 -0700
Message-ID: <CAFftDdoJcCH2HZb9a29TPsuivKxBieDr6X4X0yhY4=-MKyTN+A@mail.gmail.com>
Subject: Re: [PATCH] fix memory leaks and uninitialized jump
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, William Roberts <william.c.roberts@intel.com>
Content-Type: multipart/alternative; boundary=001a11c3c6be0d211105231d769f
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c3c6be0d211105231d769f
Content-Type: text/plain; charset=UTF-8

On Oct 27, 2015 10:52 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 10/26/2015 02:42 PM, Roberts, William C wrote:
>>
>> Shouldn't;
>>    compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
>>
>> in process_line() cause a failure? Right now the return code is being
ignored.
>
>
> I think it is historical.  Originally we had it bail on error.  Red Hat
had problems with that because they would ship a file_contexts file that
had an invalid context or the user would have one bad entry in
file_contexts.local or a local module (maybe due to a policy change that
removed a type, so it might have been valid originally and then became
invalid), and suddenly restorecon/setfiles/rpm/... couldn't label anything
at all, leading to unlabeled files and possibly an unbootable system.  So
then we took the error handling to the validate callback, where setfiles or
sefcontext_compile can make it a fatal error but you can still label most
files (the ones that match valid entries) when they get installed via rpm
or using restorecon.

Well it would be nice to reconcile this with Android. What's the plan
there? Runtime option, ifdef, etc?

What's the plan on removing backends unused on Android?

>
>
>>
>> Bill
>>
>>> -----Original Message-----
>>> From: Roberts, William C
>>> Sent: Monday, October 26, 2015 11:33 AM
>>> To: selinux@tycho.nsa.gov
>>> Cc: sds@tycho.nsa.gov; Roberts, William C
>>> Subject: [PATCH] fix memory leaks and uninitialized jump
>>>
>>> From: William Roberts <william.c.roberts@intel.com>
>>>
>>>      Some error's were reported by valgrind (below) fix them. The test
>>>      cases on which these leaks were detected:
>>>
>>>      1. properly formed file_contexts file.
>>>      2. malformed file_contexts file, unknown type.
>>>      3. malformed file_contexts file, type that fails on validate
callback.
>>>      4. malformed file_contexts file, invalid regex.
>>>      5. malformed file_contexts file, invalid mode.
>>>
>>>      ==3819== Conditional jump or move depends on uninitialised value(s)
>>>      ==3819==    at 0x12A682: closef (label_file.c:577)
>>>      ==3819==    by 0x12A196: selabel_close (label.c:163)
>>>      ==3819==    by 0x10A2FD: cleanup (checkfc.c:218)
>>>      ==3819==    by 0x5089258: __run_exit_handlers (exit.c:82)
>>>      ==3819==    by 0x50892A4: exit (exit.c:104)
>>>      ==3819==    by 0x10A231: main (checkfc.c:361)
>>>      ==3819==  Uninitialised value was created by a heap allocation
>>>      ==3819==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-
>>> amd64-linux.so)
>>>      ==3819==    by 0x4C2CF1F: realloc (in
/usr/lib/valgrind/vgpreload_memcheck-
>>> amd64-linux.so)
>>>      ==3819==    by 0x12BB31: process_file (label_file.h:273)
>>>      ==3819==    by 0x12A2BA: selabel_file_init (label_file.c:522)
>>>      ==3819==    by 0x12A0BB: selabel_open (label.c:88)
>>>      ==3819==    by 0x10A038: main (checkfc.c:292)
>>>      ==3819==
>>>      ==3819==
>>>      ==3819== HEAP SUMMARY:
>>>      ==3819==     in use at exit: 729 bytes in 19 blocks
>>>      ==3819==   total heap usage: 21,126 allocs, 21,107 frees, 923,854
bytes allocated
>>>      ==3819==
>>>      ==3819== 81 bytes in 1 blocks are definitely lost in loss record 1
of 2
>>>      ==3819==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-
>>> amd64-linux.so)
>>>      ==3819==    by 0x50D5839: strdup (strdup.c:42)
>>>      ==3819==    by 0x12A2A6: selabel_file_init (label_file.c:517)
>>>      ==3819==    by 0x12A0BB: selabel_open (label.c:88)
>>>      ==3819==    by 0x10A038: main (checkfc.c:292)
>>>      ==3819==
>>>
>>>      ==4238== 40 bytes in 1 blocks are definitely lost in loss record 1
of 6
>>>      ==4238==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-
>>> amd64-linux.so)
>>>      ==4238==    by 0x12A1D2: selabel_file_init (label_file.c:886)
>>>      ==4238==    by 0x12A0BB: selabel_open (label.c:88)
>>>      ==4238==    by 0x10A038: main (checkfc.c:292)
>>>      ==4238==
>>>      ==4238== 81 bytes in 1 blocks are definitely lost in loss record 2
of 6
>>>      ==4238==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-
>>> amd64-linux.so)
>>>      ==4238==    by 0x50D5839: strdup (strdup.c:42)
>>>      ==4238==    by 0x12A2A6: selabel_file_init (label_file.c:517)
>>>      ==4238==    by 0x12A0BB: selabel_open (label.c:88)
>>>      ==4238==    by 0x10A038: main (checkfc.c:292)
>>>      ==4238==
>>>      ==4238== 386 bytes in 24 blocks are definitely lost in loss record
3 of 6
>>>      ==4238==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-
>>> amd64-linux.so)
>>>      ==4238==    by 0x50D5889: strndup (strndup.c:45)
>>>      ==4238==    by 0x12CDDF: read_spec_entries (label_support.c:37)
>>>      ==4238==    by 0x12B72D: process_file (label_file.h:392)
>>>      ==4238==    by 0x12A2BA: selabel_file_init (label_file.c:522)
>>>      ==4238==    by 0x12A0BB: selabel_open (label.c:88)
>>>      ==4238==    by 0x10A038: main (checkfc.c:292)
>>>      ==4238==
>>>      ==4238== 648 bytes in 18 blocks are definitely lost in loss record
4 of 6
>>>      ==4238==    at 0x4C2CC70: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-
>>> amd64-linux.so)
>>>      ==4238==    by 0x117C9B: avtab_insert_node (avtab.c:105)
>>>      ==4238==    by 0x117C10: avtab_insert (avtab.c:163)
>>>      ==4238==    by 0x11880A: avtab_read_item (avtab.c:566)
>>>      ==4238==    by 0x118BD3: avtab_read (avtab.c:600)
>>>      ==4238==    by 0x125BDD: policydb_read (policydb.c:3854)
>>>      ==4238==    by 0x109F87: main (checkfc.c:273)
>>>      ==4238==
>>>      ==4238== 1,095 bytes in 12 blocks are definitely lost in loss
record 5 of 6
>>>      ==4238==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-
>>> amd64-linux.so)
>>>      ==4238==    by 0x12D8D1: pcre_compile2 (pcre_compile.c:9217)
>>>      ==4238==    by 0x12B239: compile_regex (label_file.h:357)
>>>      ==4238==    by 0x12B9C7: process_file (label_file.h:429)
>>>      ==4238==    by 0x12A2BA: selabel_file_init (label_file.c:522)
>>>      ==4238==    by 0x12A0BB: selabel_open (label.c:88)
>>>      ==4238==    by 0x10A038: main (checkfc.c:292)
>>>      ==4238==
>>>      ==4238== 1,296 bytes in 12 blocks are definitely lost in loss
record 6 of 6
>>>      ==4238==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-
>>> amd64-linux.so)
>>>      ==4238==    by 0x13EBE5: pcre_study (pcre_study.c:1565)
>>>      ==4238==    by 0x12B25D: compile_regex (label_file.h:366)
>>>      ==4238==    by 0x12B9C7: process_file (label_file.h:429)
>>>      ==4238==    by 0x12A2BA: selabel_file_init (label_file.c:522)
>>>      ==4238==    by 0x12A0BB: selabel_open (label.c:88)
>>>      ==4238==    by 0x10A038: main (checkfc.c:292)
>>>
>>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>>> ---
>>>   libselinux/src/label.c      |  1 +
>>>   libselinux/src/label_file.c |  5 ++++-
>>>   libselinux/src/label_file.h | 22 ++++++++++++++--------
>>>   3 files changed, 19 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/libselinux/src/label.c b/libselinux/src/label.c index
c656fda..963bfcb
>>> 100644
>>> --- a/libselinux/src/label.c
>>> +++ b/libselinux/src/label.c
>>> @@ -338,6 +338,7 @@ struct selabel_handle *selabel_open(unsigned int
>>> backend,
>>>         rec->digest = selabel_is_digest_set(opts, nopts, rec->digest);
>>>
>>>         if ((*initfuncs[backend])(rec, opts, nopts)) {
>>> +               free(rec->spec_file);
>>>                 free(rec);
>>>                 rec = NULL;
>>>         }
>>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index
>>> 1a0c15f..071d902 100644
>>> --- a/libselinux/src/label_file.c
>>> +++ b/libselinux/src/label_file.c
>>> @@ -507,6 +507,8 @@ out:
>>>         return rc;
>>>   }
>>>
>>> +static void closef(struct selabel_handle *rec);
>>> +
>>>   static int init(struct selabel_handle *rec, const struct selinux_opt
*opts,
>>>                 unsigned n)
>>>   {
>>> @@ -580,7 +582,8 @@ static int init(struct selabel_handle *rec, const
struct
>>> selinux_opt *opts,
>>>
>>>   finish:
>>>         if (status)
>>> -               free(data->spec_arr);
>>> +               closef(rec);
>>> +
>>>         return status;
>>>   }
>>>
>>> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index
>>> 2492826..a85b9bd 100644
>>> --- a/libselinux/src/label_file.h
>>> +++ b/libselinux/src/label_file.h
>>> @@ -278,6 +278,7 @@ static inline int store_stem(struct saved_data
*data, char
>>> *buf, int stem_len)
>>>         }
>>>         data->stem_arr[num].len = stem_len;
>>>         data->stem_arr[num].buf = buf;
>>> +       data->stem_arr[num].from_mmap = 0;
>>>         data->num_stems++;
>>>
>>>         return num;
>>> @@ -425,6 +426,19 @@ static inline int process_line(struct
selabel_handle *rec,
>>>         /* process and store the specification in spec. */
>>>         spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
>>>         spec_arr[nspec].regex_str = regex;
>>> +
>>> +       /* Convert the type string to a mode format */
>>> +       spec_arr[nspec].type_str = type;
>>> +       spec_arr[nspec].mode = 0;
>>> +
>>> +       spec_arr[nspec].lr.ctx_raw = context;
>>> +
>>> +       /*
>>> +        * bump data->nspecs to cause closef() to cover it in its free
>>> +        * but do not bump nspec since it's used below.
>>> +        */
>>> +       data->nspec++;
>>> +
>>>         if (rec->validating &&
>>>                             compile_regex(data, &spec_arr[nspec],
&errbuf)) {
>>>                 COMPAT_LOG(SELINUX_ERROR,
>>> @@ -435,9 +449,6 @@ static inline int process_line(struct
selabel_handle *rec,
>>>                 return -1;
>>>         }
>>>
>>> -       /* Convert the type string to a mode format */
>>> -       spec_arr[nspec].type_str = type;
>>> -       spec_arr[nspec].mode = 0;
>>>         if (type) {
>>>                 mode_t mode = string_to_mode(type);
>>>
>>> @@ -445,14 +456,11 @@ static inline int process_line(struct
selabel_handle *rec,
>>>                         COMPAT_LOG(SELINUX_ERROR,
>>>                                    "%s:  line %u has invalid file type
%s\n",
>>>                                    path, lineno, type);
>>> -                       errno = EINVAL;
>>>                         return -1;
>>>                 }
>>>                 spec_arr[nspec].mode = mode;
>>>         }
>>>
>>> -       spec_arr[nspec].lr.ctx_raw = context;
>>> -
>>>         /* Determine if specification has
>>>          * any meta characters in the RE */
>>>         spec_hasMetaChars(&spec_arr[nspec]);
>>> @@ -460,8 +468,6 @@ static inline int process_line(struct
selabel_handle *rec,
>>>         if (strcmp(context, "<<none>>") && rec->validating)
>>>                 compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
>>>
>>> -       data->nspec = ++nspec;
>>> -
>>>         return 0;
>>>   }
>>>
>>> --
>>> 1.9.1
>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.
>>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a11c3c6be0d211105231d769f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Oct 27, 2015 10:52 AM, &quot;Stephen Smalley&quot; &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 10/26/2015 02:42 PM, Roberts, William C wrote:<br>
&gt;&gt;<br>
&gt;&gt; Shouldn&#39;t;<br>
&gt;&gt; =C2=A0 =C2=A0compat_validate(rec, &amp;spec_arr[nspec].lr, path, l=
ineno);<br>
&gt;&gt;<br>
&gt;&gt; in process_line() cause a failure? Right now the return code is be=
ing ignored.<br>
&gt;<br>
&gt;<br>
&gt; I think it is historical.=C2=A0 Originally we had it bail on error.=C2=
=A0 Red Hat had problems with that because they would ship a file_contexts =
file that had an invalid context or the user would have one bad entry in fi=
le_contexts.local or a local module (maybe due to a policy change that remo=
ved a type, so it might have been valid originally and then became invalid)=
, and suddenly restorecon/setfiles/rpm/... couldn&#39;t label anything at a=
ll, leading to unlabeled files and possibly an unbootable system.=C2=A0 So =
then we took the error handling to the validate callback, where setfiles or=
 sefcontext_compile can make it a fatal error but you can still label most =
files (the ones that match valid entries) when they get installed via rpm o=
r using restorecon.</p>
<p dir=3D"ltr">Well it would be nice to reconcile this with Android. What&#=
39;s the plan there? Runtime option, ifdef, etc?</p>
<p dir=3D"ltr">What&#39;s the plan on removing backends unused on Android?<=
br></p>
<p dir=3D"ltr">&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Bill<br>
&gt;&gt;<br>
&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt; From: Roberts, William C<br>
&gt;&gt;&gt; Sent: Monday, October 26, 2015 11:33 AM<br>
&gt;&gt;&gt; To: <a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa=
.gov</a><br>
&gt;&gt;&gt; Cc: <a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>=
; Roberts, William C<br>
&gt;&gt;&gt; Subject: [PATCH] fix memory leaks and uninitialized jump<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; From: William Roberts &lt;<a href=3D"mailto:william.c.roberts@=
intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0Some error&#39;s were reported by valgrind=
 (below) fix them. The test<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0cases on which these leaks were detected:<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A01. properly formed file_contexts file.<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A02. malformed file_contexts file, unknown t=
ype.<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A03. malformed file_contexts file, type that=
 fails on validate callback.<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A04. malformed file_contexts file, invalid r=
egex.<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A05. malformed file_contexts file, invalid m=
ode.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D Conditional jump or move =
depends on uninitialised value(s)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 at 0x12A682:=
 closef (label_file.c:577)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12A196:=
 selabel_close (label.c:163)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x10A2FD:=
 cleanup (checkfc.c:218)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x5089258=
: __run_exit_handlers (exit.c:82)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x50892A4=
: exit (exit.c:104)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x10A231:=
 main (checkfc.c:361)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 Uninitialised value=
 was created by a heap allocation<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80=
: malloc (in /usr/lib/valgrind/vgpreload_memcheck-<br>
&gt;&gt;&gt; amd64-linux.so)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x4C2CF1F=
: realloc (in /usr/lib/valgrind/vgpreload_memcheck-<br>
&gt;&gt;&gt; amd64-linux.so)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12BB31:=
 process_file (label_file.h:273)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12A2BA:=
 selabel_file_init (label_file.c:522)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12A0BB:=
 selabel_open (label.c:88)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x10A038:=
 main (checkfc.c:292)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D HEAP SUMMARY:<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 =C2=A0in use=
 at exit: 729 bytes in 19 blocks<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0total heap us=
age: 21,126 allocs, 21,107 frees, 923,854 bytes allocated<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D 81 bytes in 1 blocks are =
definitely lost in loss record 1 of 2<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80=
: malloc (in /usr/lib/valgrind/vgpreload_memcheck-<br>
&gt;&gt;&gt; amd64-linux.so)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x50D5839=
: strdup (strdup.c:42)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12A2A6:=
 selabel_file_init (label_file.c:517)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x12A0BB:=
 selabel_open (label.c:88)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D=C2=A0 =C2=A0 by 0x10A038:=
 main (checkfc.c:292)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D3819=3D=3D<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 40 bytes in 1 blocks are =
definitely lost in loss record 1 of 6<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80=
: malloc (in /usr/lib/valgrind/vgpreload_memcheck-<br>
&gt;&gt;&gt; amd64-linux.so)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A1D2:=
 selabel_file_init (label_file.c:886)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A0BB:=
 selabel_open (label.c:88)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x10A038:=
 main (checkfc.c:292)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 81 bytes in 1 blocks are =
definitely lost in loss record 2 of 6<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80=
: malloc (in /usr/lib/valgrind/vgpreload_memcheck-<br>
&gt;&gt;&gt; amd64-linux.so)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x50D5839=
: strdup (strdup.c:42)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A2A6:=
 selabel_file_init (label_file.c:517)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A0BB:=
 selabel_open (label.c:88)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x10A038:=
 main (checkfc.c:292)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 386 bytes in 24 blocks ar=
e definitely lost in loss record 3 of 6<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80=
: malloc (in /usr/lib/valgrind/vgpreload_memcheck-<br>
&gt;&gt;&gt; amd64-linux.so)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x50D5889=
: strndup (strndup.c:45)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12CDDF:=
 read_spec_entries (label_support.c:37)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12B72D:=
 process_file (label_file.h:392)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A2BA:=
 selabel_file_init (label_file.c:522)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A0BB:=
 selabel_open (label.c:88)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x10A038:=
 main (checkfc.c:292)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 648 bytes in 18 blocks ar=
e definitely lost in loss record 4 of 6<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2CC70=
: calloc (in /usr/lib/valgrind/vgpreload_memcheck-<br>
&gt;&gt;&gt; amd64-linux.so)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x117C9B:=
 avtab_insert_node (avtab.c:105)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x117C10:=
 avtab_insert (avtab.c:163)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x11880A:=
 avtab_read_item (avtab.c:566)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x118BD3:=
 avtab_read (avtab.c:600)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x125BDD:=
 policydb_read (policydb.c:3854)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x109F87:=
 main (checkfc.c:273)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 1,095 bytes in 12 blocks =
are definitely lost in loss record 5 of 6<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80=
: malloc (in /usr/lib/valgrind/vgpreload_memcheck-<br>
&gt;&gt;&gt; amd64-linux.so)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12D8D1:=
 pcre_compile2 (pcre_compile.c:9217)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12B239:=
 compile_regex (label_file.h:357)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12B9C7:=
 process_file (label_file.h:429)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A2BA:=
 selabel_file_init (label_file.c:522)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A0BB:=
 selabel_open (label.c:88)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x10A038:=
 main (checkfc.c:292)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D 1,296 bytes in 12 blocks =
are definitely lost in loss record 6 of 6<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 at 0x4C2AB80=
: malloc (in /usr/lib/valgrind/vgpreload_memcheck-<br>
&gt;&gt;&gt; amd64-linux.so)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x13EBE5:=
 pcre_study (pcre_study.c:1565)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12B25D:=
 compile_regex (label_file.h:366)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12B9C7:=
 process_file (label_file.h:429)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A2BA:=
 selabel_file_init (label_file.c:522)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x12A0BB:=
 selabel_open (label.c:88)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=3D=3D4238=3D=3D=C2=A0 =C2=A0 by 0x10A038:=
 main (checkfc.c:292)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william.c=
.roberts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; =C2=A0 libselinux/src/label.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<=
br>
&gt;&gt;&gt; =C2=A0 libselinux/src/label_file.c |=C2=A0 5 ++++-<br>
&gt;&gt;&gt; =C2=A0 libselinux/src/label_file.h | 22 ++++++++++++++--------=
<br>
&gt;&gt;&gt; =C2=A0 3 files changed, 19 insertions(+), 9 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/libselinux/src/label.c b/libselinux/src/label.c i=
ndex c656fda..963bfcb<br>
&gt;&gt;&gt; 100644<br>
&gt;&gt;&gt; --- a/libselinux/src/label.c<br>
&gt;&gt;&gt; +++ b/libselinux/src/label.c<br>
&gt;&gt;&gt; @@ -338,6 +338,7 @@ struct selabel_handle *selabel_open(unsign=
ed int<br>
&gt;&gt;&gt; backend,<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 rec-&gt;digest =3D selabel_is_dige=
st_set(opts, nopts, rec-&gt;digest);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((*initfuncs[backend])(rec, opt=
s, nopts)) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(r=
ec-&gt;spec_file);<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(r=
ec);<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rec =
=3D NULL;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; diff --git a/libselinux/src/label_file.c b/libselinux/src/labe=
l_file.c index<br>
&gt;&gt;&gt; 1a0c15f..071d902 100644<br>
&gt;&gt;&gt; --- a/libselinux/src/label_file.c<br>
&gt;&gt;&gt; +++ b/libselinux/src/label_file.c<br>
&gt;&gt;&gt; @@ -507,6 +507,8 @@ out:<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br>
&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +static void closef(struct selabel_handle *rec);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; =C2=A0 static int init(struct selabel_handle *rec, const struc=
t selinux_opt *opts,<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsign=
ed n)<br>
&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt; @@ -580,7 +582,8 @@ static int init(struct selabel_handle *rec=
, const struct<br>
&gt;&gt;&gt; selinux_opt *opts,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0 finish:<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status)<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(d=
ata-&gt;spec_arr);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0closef=
(rec);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return status;<br>
&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/libselinux/src/label_file.h b/libselinux/src/labe=
l_file.h index<br>
&gt;&gt;&gt; 2492826..a85b9bd 100644<br>
&gt;&gt;&gt; --- a/libselinux/src/label_file.h<br>
&gt;&gt;&gt; +++ b/libselinux/src/label_file.h<br>
&gt;&gt;&gt; @@ -278,6 +278,7 @@ static inline int store_stem(struct saved_=
data *data, char<br>
&gt;&gt;&gt; *buf, int stem_len)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;stem_arr[num].len =3D ste=
m_len;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;stem_arr[num].buf =3D buf=
;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;stem_arr[num].from_mmap =
=3D 0;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;num_stems++;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return num;<br>
&gt;&gt;&gt; @@ -425,6 +426,19 @@ static inline int process_line(struct sel=
abel_handle *rec,<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* process and store the specifica=
tion in spec. */<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_arr[nspec].stem_id =3D find_s=
tem_from_spec(data, regex);<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_arr[nspec].regex_str =3D rege=
x;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Convert the type string to a mo=
de format */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].type_str =3D type;=
<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].mode =3D 0;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].lr.ctx_raw =3D con=
text;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * bump data-&gt;nspecs to cause c=
losef() to cover it in its free<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * but do not bump nspec since it&=
#39;s used below.<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;nspec++;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rec-&gt;validating &amp;&amp;<=
br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compile_regex(data, &amp;spec_arr[nspec=
], &amp;errbuf)) {<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COMPAT=
_LOG(SELINUX_ERROR,<br>
&gt;&gt;&gt; @@ -435,9 +449,6 @@ static inline int process_line(struct sela=
bel_handle *rec,<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return=
 -1;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Convert the type string to a mo=
de format */<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].type_str =3D type;=
<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].mode =3D 0;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (type) {<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_t=
 mode =3D string_to_mode(type);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; @@ -445,14 +456,11 @@ static inline int process_line(struct se=
label_handle *rec,<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 COMPAT_LOG(SELINUX_ERROR,<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%s:=C2=
=A0 line %u has invalid file type %s\n&quot;,<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path, lineno=
, type);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EINVAL;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_a=
rr[nspec].mode =3D mode;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].lr.ctx_raw =3D con=
text;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Determine if specification has<=
br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* any meta characters in the=
 RE */<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_hasMetaChars(&amp;spec_arr[ns=
pec]);<br>
&gt;&gt;&gt; @@ -460,8 +468,6 @@ static inline int process_line(struct sela=
bel_handle *rec,<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(context, &quot;&lt;&lt;=
none&gt;&gt;&quot;) &amp;&amp; rec-&gt;validating)<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compat=
_validate(rec, &amp;spec_arr[nspec].lr, path, lineno);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;nspec =3D ++nspec;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 1.9.1<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Selinux mailing list<br>
&gt;&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>=
<br>
&gt;&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tych=
o.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt;&gt; To get help, send an email containing &quot;help&quot; to <a href=
=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>=
.<br>
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

--001a11c3c6be0d211105231d769f--
