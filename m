To: William Roberts <bill.c.roberts@gmail.com>
Cc: Nick Kralevich <nnk@google.com>, selinux <selinux@tycho.nsa.gov>
References: <20180919190856.58147-1-nnk@google.com>
 <CAFftDdqzPBP_C9JUaxeUd0Vrqw02quuT1B1_yJWBamEVhf8cxw@mail.gmail.com>
 <576303e8-6711-8c81-c7a6-ad0c0f58aff9@tycho.nsa.gov>
 <CAFftDdrP=XEVz4kH2ZMn7W5w-w=bFDbesgucdhmyw1u9cZ5S4Q@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b71ba78a-f8db-f605-1280-3f062c0eb324@tycho.nsa.gov>
Date: Wed, 19 Sep 2018 15:48:00 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdrP=XEVz4kH2ZMn7W5w-w=bFDbesgucdhmyw1u9cZ5S4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] checkpolicy: remove extraneous policy build noise
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/19/2018 03:41 PM, William Roberts wrote:
> 
> 
> On Wed, Sep 19, 2018 at 12:36 PM Stephen Smalley <sds@tycho.nsa.gov 
> <mailto:sds@tycho.nsa.gov>> wrote:
> 
>     On 09/19/2018 03:21 PM, William Roberts wrote:
>      > Some people might be checking this output since it's been there
>     so long,
>      > -s would be a good way to go.
>      >
>      > Alternatively, a way to bring back this information via a verbose
>     option
>      > -V could
>      > be considered.
>      >
>      > Either way, a simple logging mechanism analogous to
>      > LOGV/LOGW/LOGE could be useful, I wonder what subordinate routines
>      > are logging. IIRC it was all fprintf(stderr) stuff in libselinux
>     proper
>      > as you allude
>      > to in the redirection of stdout comment. We don't need to address
>     this
>      > in this
>      > patch, but we may want to consider it at some point.
>      >
>      > I would lean towards a silent flag as it's backwards compatible,
>      > but noting that it doesn't suppress subordinate callers.
>      >
>      > I would also yield that opinion, as removing it works for me.
> 
>     I'm ok dropping the output unless someone knows of an existing user
>     that
>     relies upon it (which I can't really envision).
> 
> 
> Why don't we extend the review period to 72 hours, and ill apply this
> Friday unless we hear of this breaking someone. Essentially
> consider this a soft-ack.
> 
> 
>     With regard to subordinate routines, libsepol has sepol_debug(0) or
>     sepol_msg_set_callback() to suppress or redirect its logging.
> 
>     checkpolicy doesn't use libselinux but it likewise has
>     selinux_set_callback().
> 
> 
> What about things like:
> libselinux/src/load_policy.c:299:fprintf(stderr, "libselinux:  %s\n", 
> errormsg);

Yes, there are a few lingering cases that ought to be converted over to 
selinux_log().

> 
> Also utils and others are using fprintf directly.... perhaps something 
> we wish to make common
> across utilities and subordinate libs.

No, it is completely appropriate for the utilities to do it directly. 
Only the library should be using the callbacks.

> 
> 
>      >
>      > On Wed, Sep 19, 2018 at 12:13 PM Nick Kralevich via Selinux
>      > <selinux@tycho.nsa.gov <mailto:selinux@tycho.nsa.gov>
>     <mailto:selinux@tycho.nsa.gov <mailto:selinux@tycho.nsa.gov>>> wrote:
>      >
>      >     Reduce noise when calling the checkpolicy command line. In
>     Android, this
>      >     creates unnecessary build noise which we'd like to avoid.
>      >
>      > https://en.wikipedia.org/wiki/Unix_philosophy
>      >
>      >        Rule of Silence
>      >        Developers should design programs so that they do not print
>      >        unnecessary output. This rule aims to allow other programs
>      >        and developers to pick out the information they need from a
>      >        program's output without having to parse verbosity.
>      >
>      >     An alternative approach would be to add a -s (silent) option
>     to these
>      >     tools, or to have the Android build system redirect stdout to
>     /dev/null.
>      >
>      >     Signed-off-by: Nick Kralevich <nnk@google.com
>     <mailto:nnk@google.com> <mailto:nnk@google.com <mailto:nnk@google.com>>>
>      >     ---
>      >       checkpolicy/checkmodule.c |  8 --------
>      >       checkpolicy/checkpolicy.c | 11 -----------
>      >       2 files changed, 19 deletions(-)
>      >
>      >     diff --git a/checkpolicy/checkmodule.c
>     b/checkpolicy/checkmodule.c
>      >     index 46ce258f..8edc1f8c 100644
>      >     --- a/checkpolicy/checkmodule.c
>      >     +++ b/checkpolicy/checkmodule.c
>      >     @@ -228,7 +228,6 @@ int main(int argc, char **argv)
>      >                      if (optind != argc)
>      >                              usage(argv[0]);
>      >              }
>      >     -       printf("%s:  loading policy configuration from %s\n",
>      >     argv[0], file);
>      >
>      >              /* Set policydb and sidtab used by libsepol service
>     functions
>      >                 to my structures, so that I can directly populate and
>      >     @@ -302,8 +301,6 @@ int main(int argc, char **argv)
>      >
>      >              sepol_sidtab_destroy(&sidtab);
>      >
>      >     -       printf("%s:  policy configuration loaded\n", argv[0]);
>      >     -
>      >              if (outfile) {
>      >                      FILE *outfp = fopen(outfile, "w");
>      >
>      >     @@ -313,16 +310,11 @@ int main(int argc, char **argv)
>      >                      }
>      >
>      >                      if (!cil) {
>      >     -                       printf("%s:  writing binary
>     representation
>      >     (version %d) to %s\n",
>      >     -                                  argv[0], policyvers, outfile);
>      >     -
>      >                              if (write_binary_policy(&modpolicydb,
>      >     outfp) != 0) {
>      >                                      fprintf(stderr, "%s:  error
>     writing
>      >     %s\n", argv[0], outfile);
>      >                                      exit(1);
>      >                              }
>      >                      } else {
>      >     -                       printf("%s:  writing CIL to
>     %s\n",argv[0],
>      >     outfile);
>      >     -
>      >                              if (sepol_module_policydb_to_cil(outfp,
>      >     &modpolicydb, 0) != 0) {
>      >                                      fprintf(stderr, "%s:  error
>     writing
>      >     %s\n", argv[0], outfile);
>      >                                      exit(1);
>      >     diff --git a/checkpolicy/checkpolicy.c
>     b/checkpolicy/checkpolicy.c
>      >     index fbda4558..12c4c405 100644
>      >     --- a/checkpolicy/checkpolicy.c
>      >     +++ b/checkpolicy/checkpolicy.c
>      >     @@ -512,8 +512,6 @@ int main(int argc, char **argv)
>      >                      if (optind != argc)
>      >                              usage(argv[0]);
>      >              }
>      >     -       printf("%s:  loading policy configuration from %s\n",
>      >     argv[0], file);
>      >     -
>      >              /* Set policydb and sidtab used by libsepol service
>     functions
>      >                 to my structures, so that I can directly populate and
>      >                 manipulate them. */
>      >     @@ -623,8 +621,6 @@ int main(int argc, char **argv)
>      >              if (policydb_load_isids(&policydb, &sidtab))
>      >                      exit(1);
>      >
>      >     -       printf("%s:  policy configuration loaded\n", argv[0]);
>      >     -
>      >              if (outfile) {
>      >                      outfp = fopen(outfile, "w");
>      >                      if (!outfp) {
>      >     @@ -636,8 +632,6 @@ int main(int argc, char **argv)
>      >
>      >                      if (!cil) {
>      >                              if (!conf) {
>      >     -                               printf("%s:  writing binary
>      >     representation (version %d) to %s\n", argv[0], policyvers,
>     outfile);
>      >     -
>      >                                      policydb.policy_type =
>     POLICY_KERN;
>      >
>      >                                      policy_file_init(&pf);
>      >     @@ -645,8 +639,6 @@ int main(int argc, char **argv)
>      >                                      pf.fp = outfp;
>      >                                      ret =
>     policydb_write(&policydb, &pf);
>      >                              } else {
>      >     -                               printf("%s:  writing
>     policy.conf to
>      >     %s\n",
>      >     -                                      argv[0], outfile);
>      >                                      ret =
>      >     sepol_kernel_policydb_to_conf(outfp, policydbp);
>      >                              }
>      >                              if (ret) {
>      >     @@ -655,7 +647,6 @@ int main(int argc, char **argv)
>      >                                      exit(1);
>      >                              }
>      >                      } else {
>      >     -                       printf("%s:  writing CIL to
>     %s\n",argv[0],
>      >     outfile);
>      >                              if (binary) {
>      >                                      ret =
>      >     sepol_kernel_policydb_to_cil(outfp, policydbp);
>      >                              } else {
>      >     @@ -894,8 +885,6 @@ int main(int argc, char **argv)
>      >                              FGETS(ans, sizeof(ans), stdin);
>      >                              pathlen = strlen(ans);
>      >                              ans[pathlen - 1] = 0;
>      >     -                       printf("%s:  loading policy configuration
>      >     from %s\n",
>      >     -                              argv[0], ans);
>      >                              fd = open(ans, O_RDONLY);
>      >                              if (fd < 0) {
>      >                                      fprintf(stderr, "Can't open
>     '%s':
>      >     %s\n",
>      >     --
>      >     2.19.0.397.gdd90340f6a-goog
>      >
>      >     _______________________________________________
>      >     Selinux mailing list
>      > Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
>     <mailto:Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>>
>      >     To unsubscribe, send email to Selinux-leave@tycho.nsa.gov
>     <mailto:Selinux-leave@tycho.nsa.gov>
>      >     <mailto:Selinux-leave@tycho.nsa.gov
>     <mailto:Selinux-leave@tycho.nsa.gov>>.
>      >     To get help, send an email containing "help" to
>      > Selinux-request@tycho.nsa.gov
>     <mailto:Selinux-request@tycho.nsa.gov>
>     <mailto:Selinux-request@tycho.nsa.gov
>     <mailto:Selinux-request@tycho.nsa.gov>>.
>      >
>      >
>      >
>      > _______________________________________________
>      > Selinux mailing list
>      > Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
>      > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov
>     <mailto:Selinux-leave@tycho.nsa.gov>.
>      > To get help, send an email containing "help" to
>     Selinux-request@tycho.nsa.gov <mailto:Selinux-request@tycho.nsa.gov>.
>      >
> 
