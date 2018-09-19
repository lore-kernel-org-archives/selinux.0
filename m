MIME-Version: 1.0
References: <20180919190856.58147-1-nnk@google.com>
 <CAFftDdqzPBP_C9JUaxeUd0Vrqw02quuT1B1_yJWBamEVhf8cxw@mail.gmail.com>
 <576303e8-6711-8c81-c7a6-ad0c0f58aff9@tycho.nsa.gov>
In-Reply-To: <576303e8-6711-8c81-c7a6-ad0c0f58aff9@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 19 Sep 2018 12:41:59 -0700
Message-ID: <CAFftDdrP=XEVz4kH2ZMn7W5w-w=bFDbesgucdhmyw1u9cZ5S4Q@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Nick Kralevich <nnk@google.com>, selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="0000000000007aa6af05763e9a90"
Subject: Re: [PATCH] checkpolicy: remove extraneous policy build
 noise
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--0000000000007aa6af05763e9a90
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 19, 2018 at 12:36 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/19/2018 03:21 PM, William Roberts wrote:
> > Some people might be checking this output since it's been there so long,
> > -s would be a good way to go.
> >
> > Alternatively, a way to bring back this information via a verbose option
> > -V could
> > be considered.
> >
> > Either way, a simple logging mechanism analogous to
> > LOGV/LOGW/LOGE could be useful, I wonder what subordinate routines
> > are logging. IIRC it was all fprintf(stderr) stuff in libselinux proper
> > as you allude
> > to in the redirection of stdout comment. We don't need to address this
> > in this
> > patch, but we may want to consider it at some point.
> >
> > I would lean towards a silent flag as it's backwards compatible,
> > but noting that it doesn't suppress subordinate callers.
> >
> > I would also yield that opinion, as removing it works for me.
>
> I'm ok dropping the output unless someone knows of an existing user that
> relies upon it (which I can't really envision).
>

Why don't we extend the review period to 72 hours, and ill apply this
Friday unless we hear of this breaking someone. Essentially
consider this a soft-ack.


>
> With regard to subordinate routines, libsepol has sepol_debug(0) or
> sepol_msg_set_callback() to suppress or redirect its logging.



> checkpolicy doesn't use libselinux but it likewise has
> selinux_set_callback().
>

What about things like:
libselinux/src/load_policy.c:299: fprintf(stderr, "libselinux:  %s\n",
errormsg);

Also utils and others are using fprintf directly.... perhaps something we
wish to make common
across utilities and subordinate libs.


> >
> > On Wed, Sep 19, 2018 at 12:13 PM Nick Kralevich via Selinux
> > <selinux@tycho.nsa.gov <mailto:selinux@tycho.nsa.gov>> wrote:
> >
> >     Reduce noise when calling the checkpolicy command line. In Android,
> this
> >     creates unnecessary build noise which we'd like to avoid.
> >
> >     https://en.wikipedia.org/wiki/Unix_philosophy
> >
> >        Rule of Silence
> >        Developers should design programs so that they do not print
> >        unnecessary output. This rule aims to allow other programs
> >        and developers to pick out the information they need from a
> >        program's output without having to parse verbosity.
> >
> >     An alternative approach would be to add a -s (silent) option to these
> >     tools, or to have the Android build system redirect stdout to
> /dev/null.
> >
> >     Signed-off-by: Nick Kralevich <nnk@google.com <mailto:nnk@google.com
> >>
> >     ---
> >       checkpolicy/checkmodule.c |  8 --------
> >       checkpolicy/checkpolicy.c | 11 -----------
> >       2 files changed, 19 deletions(-)
> >
> >     diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
> >     index 46ce258f..8edc1f8c 100644
> >     --- a/checkpolicy/checkmodule.c
> >     +++ b/checkpolicy/checkmodule.c
> >     @@ -228,7 +228,6 @@ int main(int argc, char **argv)
> >                      if (optind != argc)
> >                              usage(argv[0]);
> >              }
> >     -       printf("%s:  loading policy configuration from %s\n",
> >     argv[0], file);
> >
> >              /* Set policydb and sidtab used by libsepol service
> functions
> >                 to my structures, so that I can directly populate and
> >     @@ -302,8 +301,6 @@ int main(int argc, char **argv)
> >
> >              sepol_sidtab_destroy(&sidtab);
> >
> >     -       printf("%s:  policy configuration loaded\n", argv[0]);
> >     -
> >              if (outfile) {
> >                      FILE *outfp = fopen(outfile, "w");
> >
> >     @@ -313,16 +310,11 @@ int main(int argc, char **argv)
> >                      }
> >
> >                      if (!cil) {
> >     -                       printf("%s:  writing binary representation
> >     (version %d) to %s\n",
> >     -                                  argv[0], policyvers, outfile);
> >     -
> >                              if (write_binary_policy(&modpolicydb,
> >     outfp) != 0) {
> >                                      fprintf(stderr, "%s:  error writing
> >     %s\n", argv[0], outfile);
> >                                      exit(1);
> >                              }
> >                      } else {
> >     -                       printf("%s:  writing CIL to %s\n",argv[0],
> >     outfile);
> >     -
> >                              if (sepol_module_policydb_to_cil(outfp,
> >     &modpolicydb, 0) != 0) {
> >                                      fprintf(stderr, "%s:  error writing
> >     %s\n", argv[0], outfile);
> >                                      exit(1);
> >     diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> >     index fbda4558..12c4c405 100644
> >     --- a/checkpolicy/checkpolicy.c
> >     +++ b/checkpolicy/checkpolicy.c
> >     @@ -512,8 +512,6 @@ int main(int argc, char **argv)
> >                      if (optind != argc)
> >                              usage(argv[0]);
> >              }
> >     -       printf("%s:  loading policy configuration from %s\n",
> >     argv[0], file);
> >     -
> >              /* Set policydb and sidtab used by libsepol service
> functions
> >                 to my structures, so that I can directly populate and
> >                 manipulate them. */
> >     @@ -623,8 +621,6 @@ int main(int argc, char **argv)
> >              if (policydb_load_isids(&policydb, &sidtab))
> >                      exit(1);
> >
> >     -       printf("%s:  policy configuration loaded\n", argv[0]);
> >     -
> >              if (outfile) {
> >                      outfp = fopen(outfile, "w");
> >                      if (!outfp) {
> >     @@ -636,8 +632,6 @@ int main(int argc, char **argv)
> >
> >                      if (!cil) {
> >                              if (!conf) {
> >     -                               printf("%s:  writing binary
> >     representation (version %d) to %s\n", argv[0], policyvers, outfile);
> >     -
> >                                      policydb.policy_type = POLICY_KERN;
> >
> >                                      policy_file_init(&pf);
> >     @@ -645,8 +639,6 @@ int main(int argc, char **argv)
> >                                      pf.fp = outfp;
> >                                      ret = policydb_write(&policydb,
> &pf);
> >                              } else {
> >     -                               printf("%s:  writing policy.conf to
> >     %s\n",
> >     -                                      argv[0], outfile);
> >                                      ret =
> >     sepol_kernel_policydb_to_conf(outfp, policydbp);
> >                              }
> >                              if (ret) {
> >     @@ -655,7 +647,6 @@ int main(int argc, char **argv)
> >                                      exit(1);
> >                              }
> >                      } else {
> >     -                       printf("%s:  writing CIL to %s\n",argv[0],
> >     outfile);
> >                              if (binary) {
> >                                      ret =
> >     sepol_kernel_policydb_to_cil(outfp, policydbp);
> >                              } else {
> >     @@ -894,8 +885,6 @@ int main(int argc, char **argv)
> >                              FGETS(ans, sizeof(ans), stdin);
> >                              pathlen = strlen(ans);
> >                              ans[pathlen - 1] = 0;
> >     -                       printf("%s:  loading policy configuration
> >     from %s\n",
> >     -                              argv[0], ans);
> >                              fd = open(ans, O_RDONLY);
> >                              if (fd < 0) {
> >                                      fprintf(stderr, "Can't open '%s':
> >     %s\n",
> >     --
> >     2.19.0.397.gdd90340f6a-goog
> >
> >     _______________________________________________
> >     Selinux mailing list
> >     Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
> >     To unsubscribe, send email to Selinux-leave@tycho.nsa.gov
> >     <mailto:Selinux-leave@tycho.nsa.gov>.
> >     To get help, send an email containing "help" to
> >     Selinux-request@tycho.nsa.gov <mailto:Selinux-request@tycho.nsa.gov
> >.
> >
> >
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
> >
>
>

--0000000000007aa6af05763e9a90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr">On Wed, Sep 19, 2018 at 12:36 PM Stephen Smalley &lt;<a href=3D"=
mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On 09/19/2018 03:21 PM, William =
Roberts wrote:<br>
&gt; Some people might be checking this output since it&#39;s been there so=
 long,<br>
&gt; -s would be a good way to go.<br>
&gt; <br>
&gt; Alternatively, a way to bring back this information via a verbose opti=
on <br>
&gt; -V could<br>
&gt; be considered.<br>
&gt; <br>
&gt; Either way, a simple logging mechanism analogous to<br>
&gt; LOGV/LOGW/LOGE could be useful, I wonder what subordinate routines<br>
&gt; are logging. IIRC it was all fprintf(stderr) stuff in libselinux prope=
r <br>
&gt; as you allude<br>
&gt; to in the redirection of stdout comment. We don&#39;t need to address =
this <br>
&gt; in this<br>
&gt; patch, but we may want to consider it at some point.<br>
&gt; <br>
&gt; I would lean towards a silent flag as it&#39;s backwards compatible,<b=
r>
&gt; but noting that it doesn&#39;t suppress subordinate callers.<br>
&gt; <br>
&gt; I would also yield that opinion, as removing it works for me.<br>
<br>
I&#39;m ok dropping the output unless someone knows of an existing user tha=
t <br>
relies upon it (which I can&#39;t really envision).<br></blockquote><div><b=
r></div><div>Why don&#39;t we extend the review period to 72 hours, and ill=
 apply this</div><div>Friday unless we hear of this breaking someone. Essen=
tially</div><div>consider this a soft-ack.</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
With regard to subordinate routines, libsepol has sepol_debug(0) or <br>
sepol_msg_set_callback() to suppress or redirect its logging.</blockquote><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
checkpolicy doesn&#39;t use libselinux but it likewise has <br>
selinux_set_callback().<br></blockquote><div><br></div><div>What about thin=
gs like:</div><div><div>libselinux/src/load_policy.c:299:<span style=3D"whi=
te-space:pre">		</span>fprintf(stderr, &quot;libselinux:=C2=A0 %s\n&quot;, =
errormsg);</div></div><div><br></div><div>Also utils and others are using f=
printf directly.... perhaps something we wish to make common</div><div>acro=
ss utilities and subordinate libs.</div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><br>
&gt; <br>
&gt; On Wed, Sep 19, 2018 at 12:13 PM Nick Kralevich via Selinux <br>
&gt; &lt;<a href=3D"mailto:selinux@tycho.nsa.gov" target=3D"_blank">selinux=
@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:selinux@tycho.nsa.gov" targ=
et=3D"_blank">selinux@tycho.nsa.gov</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Reduce noise when calling the checkpolicy command l=
ine. In Android, this<br>
&gt;=C2=A0 =C2=A0 =C2=A0creates unnecessary build noise which we&#39;d like=
 to avoid.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://en.wikipedia.org/wiki/Unix_philo=
sophy" rel=3D"noreferrer" target=3D"_blank">https://en.wikipedia.org/wiki/U=
nix_philosophy</a><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Rule of Silence<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Developers should design programs so that t=
hey do not print<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 unnecessary output. This rule aims to allow=
 other programs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 and developers to pick out the information =
they need from a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 program&#39;s output without having to pars=
e verbosity.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0An alternative approach would be to add a -s (silen=
t) option to these<br>
&gt;=C2=A0 =C2=A0 =C2=A0tools, or to have the Android build system redirect=
 stdout to /dev/null.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Nick Kralevich &lt;<a href=3D"mailto=
:nnk@google.com" target=3D"_blank">nnk@google.com</a> &lt;mailto:<a href=3D=
"mailto:nnk@google.com" target=3D"_blank">nnk@google.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0checkpolicy/checkmodule.c |=C2=A0 8 --------=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0checkpolicy/checkpolicy.c | 11 -----------<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A02 files changed, 19 deletions(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/checkpolicy/checkmodule.c b/checkpolic=
y/checkmodule.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 46ce258f..8edc1f8c 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/checkpolicy/checkmodule.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/checkpolicy/checkmodule.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -228,7 +228,6 @@ int main(int argc, char **argv)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (optind !=3D argc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usage(argv[0]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 =
loading policy configuration from %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0argv[0], file);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set policydb and si=
dtab used by libsepol service functions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to my str=
uctures, so that I can directly populate and<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -302,8 +301,6 @@ int main(int argc, char **argv)=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sepol_sidtab_destroy(&=
amp;sidtab);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 =
policy configuration loaded\n&quot;, argv[0]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (outfile) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 FILE *outfp =3D fopen(outfile, &quot;w&quot;);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -313,16 +310,11 @@ int main(int argc, char **arg=
v)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (!cil) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 writing binary rep=
resentation<br>
&gt;=C2=A0 =C2=A0 =C2=A0(version %d) to %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv[=
0], policyvers, outfile);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (write_binary_policy(&amp;modpolicydb=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0outfp) !=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stde=
rr, &quot;%s:=C2=A0 error writing<br>
&gt;=C2=A0 =C2=A0 =C2=A0%s\n&quot;, argv[0], outfile);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 writing CIL to %s\=
n&quot;,argv[0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0outfile);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sepol_module_policydb_to_cil(outfp,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;modpolicydb, 0) !=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stde=
rr, &quot;%s:=C2=A0 error writing<br>
&gt;=C2=A0 =C2=A0 =C2=A0%s\n&quot;, argv[0], outfile);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/checkpolicy/checkpolicy.c b/checkpolic=
y/checkpolicy.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index fbda4558..12c4c405 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/checkpolicy/checkpolicy.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/checkpolicy/checkpolicy.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -512,8 +512,6 @@ int main(int argc, char **argv)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (optind !=3D argc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usage(argv[0]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 =
loading policy configuration from %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0argv[0], file);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set policydb and si=
dtab used by libsepol service functions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to my str=
uctures, so that I can directly populate and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0manipulat=
e them. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -623,8 +621,6 @@ int main(int argc, char **argv)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (policydb_load_isid=
s(&amp;policydb, &amp;sidtab))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 exit(1);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 =
policy configuration loaded\n&quot;, argv[0]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (outfile) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 outfp =3D fopen(outfile, &quot;w&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (!outfp) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -636,8 +632,6 @@ int main(int argc, char **argv)=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (!cil) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!conf) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;=
%s:=C2=A0 writing binary<br>
&gt;=C2=A0 =C2=A0 =C2=A0representation (version %d) to %s\n&quot;, argv[0],=
 policyvers, outfile);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 policydb.pol=
icy_type =3D POLICY_KERN;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 policy_file_=
init(&amp;pf);<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -645,8 +639,6 @@ int main(int argc, char **argv)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pf.fp =3D ou=
tfp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D poli=
cydb_write(&amp;policydb, &amp;pf);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;=
%s:=C2=A0 writing policy.conf to<br>
&gt;=C2=A0 =C2=A0 =C2=A0%s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 argv[0], outfile);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0sepol_kernel_policydb_to_conf(outfp, policydbp);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -655,7 +647,6 @@ int main(int argc, char **argv)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 writing CIL to %s\=
n&quot;,argv[0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0outfile);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (binary) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0sepol_kernel_policydb_to_cil(outfp, policydbp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -894,8 +885,6 @@ int main(int argc, char **argv)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FGETS(ans, sizeof(ans), stdin);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pathlen =3D strlen(ans);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ans[pathlen - 1] =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%s:=C2=A0 loading policy con=
figuration<br>
&gt;=C2=A0 =C2=A0 =C2=A0from %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv[0], ans);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D open(ans, O_RDONLY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stde=
rr, &quot;Can&#39;t open &#39;%s&#39;: <br>
&gt;=C2=A0 =C2=A0 =C2=A0%s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.19.0.397.gdd90340f6a-goog<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0_______________________________________________<br>
&gt;=C2=A0 =C2=A0 =C2=A0Selinux mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"=
_blank">Selinux@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:Selinux@tych=
o.nsa.gov" target=3D"_blank">Selinux@tycho.nsa.gov</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0To unsubscribe, send email to <a href=3D"mailto:Sel=
inux-leave@tycho.nsa.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>&gt;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0To get help, send an email containing &quot;help&qu=
ot; to<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:Selinux-request@tycho.nsa.gov" ta=
rget=3D"_blank">Selinux-request@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mai=
lto:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.=
nsa.gov</a>&gt;.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tyc=
ho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tych=
o.nsa.gov</a>.<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--0000000000007aa6af05763e9a90--
