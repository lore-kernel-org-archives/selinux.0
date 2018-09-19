Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8JJLWfF012281
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 15:21:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5-v6so6936253otl.5
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 12:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180919190856.58147-1-nnk@google.com>
In-Reply-To: <20180919190856.58147-1-nnk@google.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 19 Sep 2018 12:21:01 -0700
Message-ID: <CAFftDdqzPBP_C9JUaxeUd0Vrqw02quuT1B1_yJWBamEVhf8cxw@mail.gmail.com>
To: Nick Kralevich <nnk@google.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="0000000000007d198f05763e4ff3"
Subject: Re: [PATCH] checkpolicy: remove extraneous policy build
 noise
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--0000000000007d198f05763e4ff3
Content-Type: text/plain; charset="UTF-8"

Some people might be checking this output since it's been there so long,
-s would be a good way to go.

Alternatively, a way to bring back this information via a verbose option -V
could
be considered.

Either way, a simple logging mechanism analogous to
LOGV/LOGW/LOGE could be useful, I wonder what subordinate routines
are logging. IIRC it was all fprintf(stderr) stuff in libselinux proper as
you allude
to in the redirection of stdout comment. We don't need to address this in
this
patch, but we may want to consider it at some point.

I would lean towards a silent flag as it's backwards compatible,
but noting that it doesn't suppress subordinate callers.

I would also yield that opinion, as removing it works for me.

On Wed, Sep 19, 2018 at 12:13 PM Nick Kralevich via Selinux <
selinux@tycho.nsa.gov> wrote:

> Reduce noise when calling the checkpolicy command line. In Android, this
> creates unnecessary build noise which we'd like to avoid.
>
> https://en.wikipedia.org/wiki/Unix_philosophy
>
>   Rule of Silence
>   Developers should design programs so that they do not print
>   unnecessary output. This rule aims to allow other programs
>   and developers to pick out the information they need from a
>   program's output without having to parse verbosity.
>
> An alternative approach would be to add a -s (silent) option to these
> tools, or to have the Android build system redirect stdout to /dev/null.
>
> Signed-off-by: Nick Kralevich <nnk@google.com>
> ---
>  checkpolicy/checkmodule.c |  8 --------
>  checkpolicy/checkpolicy.c | 11 -----------
>  2 files changed, 19 deletions(-)
>
> diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
> index 46ce258f..8edc1f8c 100644
> --- a/checkpolicy/checkmodule.c
> +++ b/checkpolicy/checkmodule.c
> @@ -228,7 +228,6 @@ int main(int argc, char **argv)
>                 if (optind != argc)
>                         usage(argv[0]);
>         }
> -       printf("%s:  loading policy configuration from %s\n", argv[0],
> file);
>
>         /* Set policydb and sidtab used by libsepol service functions
>            to my structures, so that I can directly populate and
> @@ -302,8 +301,6 @@ int main(int argc, char **argv)
>
>         sepol_sidtab_destroy(&sidtab);
>
> -       printf("%s:  policy configuration loaded\n", argv[0]);
> -
>         if (outfile) {
>                 FILE *outfp = fopen(outfile, "w");
>
> @@ -313,16 +310,11 @@ int main(int argc, char **argv)
>                 }
>
>                 if (!cil) {
> -                       printf("%s:  writing binary representation
> (version %d) to %s\n",
> -                                  argv[0], policyvers, outfile);
> -
>                         if (write_binary_policy(&modpolicydb, outfp) != 0)
> {
>                                 fprintf(stderr, "%s:  error writing %s\n",
> argv[0], outfile);
>                                 exit(1);
>                         }
>                 } else {
> -                       printf("%s:  writing CIL to %s\n",argv[0],
> outfile);
> -
>                         if (sepol_module_policydb_to_cil(outfp,
> &modpolicydb, 0) != 0) {
>                                 fprintf(stderr, "%s:  error writing %s\n",
> argv[0], outfile);
>                                 exit(1);
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index fbda4558..12c4c405 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -512,8 +512,6 @@ int main(int argc, char **argv)
>                 if (optind != argc)
>                         usage(argv[0]);
>         }
> -       printf("%s:  loading policy configuration from %s\n", argv[0],
> file);
> -
>         /* Set policydb and sidtab used by libsepol service functions
>            to my structures, so that I can directly populate and
>            manipulate them. */
> @@ -623,8 +621,6 @@ int main(int argc, char **argv)
>         if (policydb_load_isids(&policydb, &sidtab))
>                 exit(1);
>
> -       printf("%s:  policy configuration loaded\n", argv[0]);
> -
>         if (outfile) {
>                 outfp = fopen(outfile, "w");
>                 if (!outfp) {
> @@ -636,8 +632,6 @@ int main(int argc, char **argv)
>
>                 if (!cil) {
>                         if (!conf) {
> -                               printf("%s:  writing binary representation
> (version %d) to %s\n", argv[0], policyvers, outfile);
> -
>                                 policydb.policy_type = POLICY_KERN;
>
>                                 policy_file_init(&pf);
> @@ -645,8 +639,6 @@ int main(int argc, char **argv)
>                                 pf.fp = outfp;
>                                 ret = policydb_write(&policydb, &pf);
>                         } else {
> -                               printf("%s:  writing policy.conf to %s\n",
> -                                      argv[0], outfile);
>                                 ret = sepol_kernel_policydb_to_conf(outfp,
> policydbp);
>                         }
>                         if (ret) {
> @@ -655,7 +647,6 @@ int main(int argc, char **argv)
>                                 exit(1);
>                         }
>                 } else {
> -                       printf("%s:  writing CIL to %s\n",argv[0],
> outfile);
>                         if (binary) {
>                                 ret = sepol_kernel_policydb_to_cil(outfp,
> policydbp);
>                         } else {
> @@ -894,8 +885,6 @@ int main(int argc, char **argv)
>                         FGETS(ans, sizeof(ans), stdin);
>                         pathlen = strlen(ans);
>                         ans[pathlen - 1] = 0;
> -                       printf("%s:  loading policy configuration from
> %s\n",
> -                              argv[0], ans);
>                         fd = open(ans, O_RDONLY);
>                         if (fd < 0) {
>                                 fprintf(stderr, "Can't open '%s':  %s\n",
> --
> 2.19.0.397.gdd90340f6a-goog
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--0000000000007d198f05763e4ff3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Some people might be checking this output since it&#39;s b=
een there so long,<div>-s would be a good way to go.</div><div><br></div><d=
iv>Alternatively, a way to bring back this information via a verbose option=
 -V could</div><div>be considered.</div><div><br></div><div>Either way, a s=
imple logging mechanism analogous to</div><div>LOGV/LOGW/LOGE could be usef=
ul, I wonder what subordinate routines</div><div>are logging. IIRC it was a=
ll fprintf(stderr) stuff in libselinux proper as you allude</div><div>to in=
 the redirection of stdout comment. We don&#39;t need to address this in th=
is</div><div>patch, but we may want to consider it at some point.</div><div=
><br></div><div>I would lean towards a silent flag as it&#39;s backwards co=
mpatible,</div><div>but noting that it doesn&#39;t suppress subordinate cal=
lers.</div><div><br></div><div>I would also yield that opinion, as removing=
 it works for me.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On W=
ed, Sep 19, 2018 at 12:13 PM Nick Kralevich via Selinux &lt;<a href=3D"mail=
to:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">Reduce noise when calling the checkpolicy comma=
nd line. In Android, this<br>
creates unnecessary build noise which we&#39;d like to avoid.<br>
<br>
<a href=3D"https://en.wikipedia.org/wiki/Unix_philosophy" rel=3D"noreferrer=
" target=3D"_blank">https://en.wikipedia.org/wiki/Unix_philosophy</a><br>
<br>
=C2=A0 Rule of Silence<br>
=C2=A0 Developers should design programs so that they do not print<br>
=C2=A0 unnecessary output. This rule aims to allow other programs<br>
=C2=A0 and developers to pick out the information they need from a<br>
=C2=A0 program&#39;s output without having to parse verbosity.<br>
<br>
An alternative approach would be to add a -s (silent) option to these<br>
tools, or to have the Android build system redirect stdout to /dev/null.<br=
>
<br>
Signed-off-by: Nick Kralevich &lt;<a href=3D"mailto:nnk@google.com" target=
=3D"_blank">nnk@google.com</a>&gt;<br>
---<br>
=C2=A0checkpolicy/checkmodule.c |=C2=A0 8 --------<br>
=C2=A0checkpolicy/checkpolicy.c | 11 -----------<br>
=C2=A02 files changed, 19 deletions(-)<br>
<br>
diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c<br>
index 46ce258f..8edc1f8c 100644<br>
--- a/checkpolicy/checkmodule.c<br>
+++ b/checkpolicy/checkmodule.c<br>
@@ -228,7 +228,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (optind !=3D arg=
c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 usage(argv[0]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 loading policy configura=
tion from %s\n&quot;, argv[0], file);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set policydb and sidtab used by libsepol ser=
vice functions<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to my structures, so that I can di=
rectly populate and<br>
@@ -302,8 +301,6 @@ int main(int argc, char **argv)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sepol_sidtab_destroy(&amp;sidtab);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 policy configuration loa=
ded\n&quot;, argv[0]);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (outfile) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *outfp =3D fop=
en(outfile, &quot;w&quot;);<br>
<br>
@@ -313,16 +310,11 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cil) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printf(&quot;%s:=C2=A0 writing binary representation (version %d)=
 to %s\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv[0], policyvers, outfile)=
;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (write_binary_policy(&amp;modpolicydb, outfp) !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;%s:=C2=A0 erro=
r writing %s\n&quot;, argv[0], outfile);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printf(&quot;%s:=C2=A0 writing CIL to %s\n&quot;,argv[0], outfile=
);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (sepol_module_policydb_to_cil(outfp, &amp;modpolicydb, 0) !=
=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;%s:=C2=A0 erro=
r writing %s\n&quot;, argv[0], outfile);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c<br>
index fbda4558..12c4c405 100644<br>
--- a/checkpolicy/checkpolicy.c<br>
+++ b/checkpolicy/checkpolicy.c<br>
@@ -512,8 +512,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (optind !=3D arg=
c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 usage(argv[0]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 loading policy configura=
tion from %s\n&quot;, argv[0], file);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set policydb and sidtab used by libsepol ser=
vice functions<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to my structures, so that I can di=
rectly populate and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0manipulate them. */<br>
@@ -623,8 +621,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (policydb_load_isids(&amp;policydb, &amp;sid=
tab))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 policy configuration loa=
ded\n&quot;, argv[0]);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (outfile) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outfp =3D fopen(out=
file, &quot;w&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!outfp) {<br>
@@ -636,8 +632,6 @@ int main(int argc, char **argv)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cil) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!conf) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 writing binary=
 representation (version %d) to %s\n&quot;, argv[0], policyvers, outfile);<=
br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 policydb.policy_type =3D POLICY_KERN=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 policy_file_init(&amp;pf);<br>
@@ -645,8 +639,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pf.fp =3D outfp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D policydb_write(&amp;policydb=
, &amp;pf);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 writing policy=
.conf to %s\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv[0], outfil=
e);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D sepol_kernel_policydb_to_con=
f(outfp, policydbp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (ret) {<br>
@@ -655,7 +647,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printf(&quot;%s:=C2=A0 writing CIL to %s\n&quot;,argv[0], outfile=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (binary) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D sepol_kernel_policydb_to_cil=
(outfp, policydbp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 } else {<br>
@@ -894,8 +885,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 FGETS(ans, sizeof(ans), stdin);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pathlen =3D strlen(ans);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ans[pathlen - 1] =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printf(&quot;%s:=C2=A0 loading policy configuration from %s\n&quo=
t;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv[0], ans);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fd =3D open(ans, O_RDONLY);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (fd &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Can&#39;t open=
 &#39;%s&#39;:=C2=A0 %s\n&quot;,<br>
-- <br>
2.19.0.397.gdd90340f6a-goog<br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</blockquote></div></div>

--0000000000007d198f05763e4ff3--
