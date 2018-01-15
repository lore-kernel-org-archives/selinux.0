Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0FHWcAT000981
 for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2018 12:32:38 -0500
Received: by mail-it0-f46.google.com with SMTP id c16so1710177itc.5
 for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2018 09:32:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAB9W1A3dOC7G9-=Y1i4Fb=JnQuOO26+dV794nQKZk+cj-A+DXQ@mail.gmail.com>
References: <20180114153436.21916-1-richard_c_haines@btinternet.com>
 <CAB9W1A1RmO4jbo-yyZPUNhLU6S9e3C0rmY3ZOLR8TNGd+vx_Xg@mail.gmail.com>
 <CAB9W1A3dOC7G9-=Y1i4Fb=JnQuOO26+dV794nQKZk+cj-A+DXQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Mon, 15 Jan 2018 12:32:28 -0500
Message-ID: <CAB9W1A3F67LHE9bG7C2y7hnoXkxh51RLyvtnsOd98DaSSnohww@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a114411d29f50ec0562d3ffeb"
Subject: Re: [PATCH] libsemanage: Allow tmp files to be kept if a compile fails
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114411d29f50ec0562d3ffeb
Content-Type: text/plain; charset="UTF-8"

On Jan 14, 2018 10:36 AM, "Richard Haines" <richard_c_haines@btinternet.com>
wrote:

Add new option to semanage.conf that allows the tmp build files
to be kept for debugging when building policy.


Would it be better to just retain the files by default if there is an
error?


Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libsemanage/man/man5/semanage.conf.5 |  8 ++++++++
 libsemanage/src/conf-parse.y         | 15 ++++++++++++++-
 libsemanage/src/conf-scan.l          |  1 +
 libsemanage/src/direct_api.c         | 21 ++++++++++++---------
 libsemanage/src/semanage_conf.h      |  1 +
 5 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/
semanage.conf.5
index 8f8de55a..10cab65a 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -121,6 +121,14 @@ and by default it is set to "false".
 Please note that since this option deletes all HLL files, an updated HLL
compiler will not be able to recompile the original HLL file into CIL.
 In order to compile the original HLL file into CIL, the same HLL file will
need to be reinstalled.

+.TP
+.B retain-tmp
+When set to "true", tmp directories (the sandbox at
\fBstore-root/\fR[\fIpolicy-store\fR]\fB/tmp \fRand/or the final policy at
\fBstore-root/final/\fR[\fIpolicy-store\fR]) will be retained after
compilation to allow debugging of any build errors. Note that on a
successful build the sandbox becomes \fBstore-root/\fR[\fIpolicy-
store\fR]\fB/active\fR.
+.br
+The
+.B retain-tmp
+option can be set to either "true" or "false" and by default it is set to
"false".
+
 .SH "SEE ALSO"
 .TP
 semanage(8)
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b527e893..f098e55d 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -61,7 +61,7 @@ static int parse_errors;

 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS
SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT
 %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START
DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
-%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
+%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL RETAIN_TMP
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
@@ -95,6 +95,7 @@ single_opt:     module_store
        |       bzip_blocksize
        |       bzip_small
        |       remove_hll
+       |       retain_tmp
         ;

 module_store:   MODULE_STORE '=' ARG {
@@ -268,6 +269,17 @@ remove_hll:  REMOVE_HLL'=' ARG {
        free($3);
 }

+retain_tmp:  RETAIN_TMP'=' ARG {
+       if (strcasecmp($3, "false") == 0) {
+               current_conf->retain_tmp = 0;
+       } else if (strcasecmp($3, "true") == 0) {
+               current_conf->retain_tmp = 1;
+       } else {
+               yyerror("retain-tmp can only be 'true' or 'false'");
+       }
+       free($3);
+}
+
 command_block:
                 command_start external_opts BLOCK_END  {
                         if (new_external->path == NULL) {
@@ -352,6 +364,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
        conf->bzip_small = 0;
        conf->ignore_module_cache = 0;
        conf->remove_hll = 0;
+       conf->retain_tmp = 0;

        conf->save_previous = 0;
        conf->save_linked = 0;
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index 607bbf0b..e26c3494 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
 bzip-blocksize return BZIP_BLOCKSIZE;
 bzip-small     return BZIP_SMALL;
 remove-hll     return REMOVE_HLL;
+retain-tmp     return RETAIN_TMP;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
 "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index a455612f..5d2a443c 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -326,7 +326,10 @@ static void semanage_direct_destroy(semanage_handle_t
* sh
 static int semanage_direct_disconnect(semanage_handle_t * sh)
 {
        /* destroy transaction */
-       if (sh->is_in_transaction) {
+       if (sh->is_in_transaction)
+               semanage_release_trans_lock(sh);


Is it safe to release the trans lock before deleting the sandbox?

+
+       if (!sh->conf->retain_tmp && sh->is_in_transaction) {
                /* destroy sandbox */
                if (semanage_remove_directory
                    (semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL)) < 0) {
@@ -342,7 +345,6 @@ static int semanage_direct_disconnect(semanage_handle_t
* sh)
                                                SEMANAGE_FINAL_TOPLEVEL));
                        return -1;
                }
-               semanage_release_trans_lock(sh);
        }

        /* Release object databases: local modifications */
@@ -1639,13 +1641,14 @@ cleanup:

        free(fc_buffer);

-       /* regardless if the commit was successful or not, remove the
-          sandbox if it is still there */
-       semanage_remove_directory(semanage_path
-                                 (SEMANAGE_TMP, SEMANAGE_TOPLEVEL));
-       semanage_remove_directory(semanage_final_path
-                                 (SEMANAGE_FINAL_TMP,
-                                  SEMANAGE_FINAL_TOPLEVEL));
+       /* Delete sandbox unless requested by semanage.conf */
+       if (!sh->conf->retain_tmp) {
+               semanage_remove_directory(semanage_path
+                                         (SEMANAGE_TMP,
SEMANAGE_TOPLEVEL));
+               semanage_remove_directory(semanage_final_path
+                                         (SEMANAGE_FINAL_TMP,
+                                          SEMANAGE_FINAL_TOPLEVEL));
+       }
        umask(mask);

        return retval;
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_
conf.h
index c99ac8c7..f7bba754 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -46,6 +46,7 @@ typedef struct semanage_conf {
        int bzip_blocksize;
        int bzip_small;
        int remove_hll;
+       int retain_tmp;
        int ignore_module_cache;
        char *ignoredirs;       /* ";" separated of list for genhomedircon
to ignore */
        struct external_prog *load_policy;
--
2.14.3

--001a114411d29f50ec0562d3ffeb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
">On Jan 14, 2018 10:36 AM, &quot;Richard Haines&quot; &lt;<a href=3D"mailt=
o:richard_c_haines@btinternet.com">richard_c_haines@btinternet.com</a>&gt; =
wrote:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Add new option to s=
emanage.conf that allows the tmp build files<br>
to be kept for debugging when building policy.</blockquote></div></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Would it be better to just =
retain the files by default if there is an error?=C2=A0</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"></div><div dir=3D"auto"><div class=3D"gmail=
_extra"><div class=3D"gmail_quote"><blockquote class=3D"quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Richard Haines &lt;<a href=3D"mailto:richard_c_haines@btinte=
rnet.com">richard_c_haines@btinternet.<wbr>com</a>&gt;<br>
---<br>
=C2=A0libsemanage/man/man5/semanage.<wbr>conf.5 |=C2=A0 8 ++++++++<br>
=C2=A0libsemanage/src/conf-parse.y=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 ++=
++++++++++++-<br>
=C2=A0libsemanage/src/conf-scan.l=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 1 +<br>
=C2=A0libsemanage/src/direct_api.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 21 ++=
++++++++++---------<br>
=C2=A0libsemanage/src/semanage_conf.<wbr>h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<=
br>
=C2=A05 files changed, 36 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/libsemanage/man/man5/<wbr>semanage.conf.5 b/libsemanage/man/ma=
n5/<wbr>semanage.conf.5<br>
index 8f8de55a..10cab65a 100644<br>
--- a/libsemanage/man/man5/<wbr>semanage.conf.5<br>
+++ b/libsemanage/man/man5/<wbr>semanage.conf.5<br>
@@ -121,6 +121,14 @@ and by default it is set to &quot;false&quot;.<br>
=C2=A0Please note that since this option deletes all HLL files, an updated =
HLL compiler will not be able to recompile the original HLL file into CIL.<=
br>
=C2=A0In order to compile the original HLL file into CIL, the same HLL file=
 will need to be reinstalled.<br>
<br>
+.TP<br>
+.B retain-tmp<br>
+When set to &quot;true&quot;, tmp directories (the sandbox at \fBstore-roo=
t/\fR[\fIpolicy-<wbr>store\fR]\fB/tmp \fRand/or the final policy at \fBstor=
e-root/final/\fR[\<wbr>fIpolicy-store\fR]) will be retained after compilati=
on to allow debugging of any build errors. Note that on a successful build =
the sandbox becomes \fBstore-root/\fR[\fIpolicy-<wbr>store\fR]\fB/active\fR=
.<br>
+.br<br>
+The<br>
+.B retain-tmp<br>
+option can be set to either &quot;true&quot; or &quot;false&quot; and by d=
efault it is set to &quot;false&quot;.<br>
+<br>
=C2=A0.SH &quot;SEE ALSO&quot;<br>
=C2=A0.TP<br>
=C2=A0semanage(8)<br>
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y<br=
>
index b527e893..f098e55d 100644<br>
--- a/libsemanage/src/conf-parse.y<br>
+++ b/libsemanage/src/conf-parse.y<br>
@@ -61,7 +61,7 @@ static int parse_errors;<br>
<br>
=C2=A0%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE=
_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT<br>
=C2=A0%token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISA=
BLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS<br>
-%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL<br>
+%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL RETAIN_TMP<br>
=C2=A0%token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK=
_END<br>
=C2=A0%token PROG_PATH PROG_ARGS<br>
=C2=A0%token &lt;s&gt; ARG<br>
@@ -95,6 +95,7 @@ single_opt:=C2=A0 =C2=A0 =C2=A0module_store<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0bzip_blocksize<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0bzip_small<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0remove_hll<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0retain_tmp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;<br>
<br>
=C2=A0module_store:=C2=A0 =C2=A0MODULE_STORE &#39;=3D&#39; ARG {<br>
@@ -268,6 +269,17 @@ remove_hll:=C2=A0 REMOVE_HLL&#39;=3D&#39; ARG {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free($3);<br>
=C2=A0}<br>
<br>
+retain_tmp:=C2=A0 RETAIN_TMP&#39;=3D&#39; ARG {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcasecmp($3, &quot;false&quot;) =3D=3D 0)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current_conf-&gt;re=
tain_tmp =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (strcasecmp($3, &quot;true&quot;) =3D=
=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current_conf-&gt;re=
tain_tmp =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0yyerror(&quot;retai=
n-tmp can only be &#39;true&#39; or &#39;false&#39;&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0free($3);<br>
+}<br>
+<br>
=C2=A0command_block:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command_start=
 external_opts BLOCK_END=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (new_external-&gt;path =3D=3D NULL) {<br>
@@ -352,6 +364,7 @@ static int semanage_conf_init(semanage_<wbr>conf_t * co=
nf)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 conf-&gt;bzip_small =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 conf-&gt;ignore_module_cache =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 conf-&gt;remove_hll =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0conf-&gt;retain_tmp =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 conf-&gt;save_previous =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 conf-&gt;save_linked =3D 0;<br>
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l<br>
index 607bbf0b..e26c3494 100644<br>
--- a/libsemanage/src/conf-scan.l<br>
+++ b/libsemanage/src/conf-scan.l<br>
@@ -54,6 +54,7 @@ handle-unknown=C2=A0 =C2=A0 return HANDLE_UNKNOWN;<br>
=C2=A0bzip-blocksize return BZIP_BLOCKSIZE;<br>
=C2=A0bzip-small=C2=A0 =C2=A0 =C2=A0return BZIP_SMALL;<br>
=C2=A0remove-hll=C2=A0 =C2=A0 =C2=A0return REMOVE_HLL;<br>
+retain-tmp=C2=A0 =C2=A0 =C2=A0return RETAIN_TMP;<br>
=C2=A0&quot;[load_policy]&quot;=C2=A0 =C2=A0return LOAD_POLICY_START;<br>
=C2=A0&quot;[setfiles]&quot;=C2=A0 =C2=A0 =C2=A0 return SETFILES_START;<br>
=C2=A0&quot;[sefcontext_compile]&quot;=C2=A0 =C2=A0 =C2=A0 return SEFCONTEX=
T_COMPILE_START;<br>
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c<br=
>
index a455612f..5d2a443c 100644<br>
--- a/libsemanage/src/direct_api.c<br>
+++ b/libsemanage/src/direct_api.c<br>
@@ -326,7 +326,10 @@ static void semanage_direct_destroy(<wbr>semanage_hand=
le_t * sh<br>
=C2=A0static int semanage_direct_disconnect(<wbr>semanage_handle_t * sh)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* destroy transaction */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (sh-&gt;is_in_transaction) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (sh-&gt;is_in_transaction)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage_release_tr=
ans_lock(<wbr>sh);<br></blockquote></div></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Is it safe to release the trans lock before deletin=
g the sandbox?=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!sh-&gt;conf-&gt;retain_tmp &amp;&amp; sh-&=
gt;is_in_transaction) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* destroy sandbox =
*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (semanage_remove=
_directory<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (sema=
nage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL)) &lt; 0) {<br>
@@ -342,7 +345,6 @@ static int semanage_direct_disconnect(<wbr>semanage_han=
dle_t * sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 SEMANAGE_FINAL_TOPLEVEL));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage_release_tr=
ans_lock(<wbr>sh);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Release object databases: local modification=
s */<br>
@@ -1639,13 +1641,14 @@ cleanup:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(fc_buffer);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* regardless if the commit was successful or n=
ot, remove the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sandbox if it is still there */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0semanage_remove_directory(<wbr>semanage_path<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(SEMANAGE_TMP, SEMANAGE_TOPLEV=
EL));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0semanage_remove_directory(<wbr>semanage_final_p=
ath<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(SEMANAGE_FINAL_TMP,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SEMANAGE_FINAL_TOPLEVEL));<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Delete sandbox unless requested by semanage.=
conf */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!sh-&gt;conf-&gt;retain_tmp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage_remove_dir=
ectory(<wbr>semanage_path<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(S=
EMANAGE_TMP, SEMANAGE_TOPLEVEL));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage_remove_dir=
ectory(<wbr>semanage_final_path<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(S=
EMANAGE_FINAL_TMP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 S=
EMANAGE_FINAL_TOPLEVEL));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 umask(mask);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;<br>
diff --git a/libsemanage/src/semanage_<wbr>conf.h b/libsemanage/src/semanag=
e_<wbr>conf.h<br>
index c99ac8c7..f7bba754 100644<br>
--- a/libsemanage/src/semanage_<wbr>conf.h<br>
+++ b/libsemanage/src/semanage_<wbr>conf.h<br>
@@ -46,6 +46,7 @@ typedef struct semanage_conf {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int bzip_blocksize;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int bzip_small;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int remove_hll;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int retain_tmp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ignore_module_cache;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *ignoredirs;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
&quot;;&quot; separated of list for genhomedircon to ignore */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct external_prog *load_policy;<br>
<font color=3D"#888888">--<br>
2.14.3<br>
<br>
<br>
</font></blockquote></div><br></div></div></div>

--001a114411d29f50ec0562d3ffeb--
