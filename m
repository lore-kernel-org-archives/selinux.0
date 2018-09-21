Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8LJqRax004006
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 15:52:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so12431714ois.1
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 12:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180919190856.58147-1-nnk@google.com>
In-Reply-To: <20180919190856.58147-1-nnk@google.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 21 Sep 2018 12:52:07 -0700
Message-ID: <CAFftDdq2q21fAFyK+Wy1jKFNAN1rS9NF10QNRK3JkBNVqtLcZg@mail.gmail.com>
To: Nick Kralevich <nnk@google.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="0000000000000e4aa5057666fae8"
Subject: Re: [PATCH] checkpolicy: remove extraneous policy build
 noise
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--0000000000000e4aa5057666fae8
Content-Type: text/plain; charset="UTF-8"

merged: https://github.com/SELinuxProject/selinux/pull/99

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

--0000000000000e4aa5057666fae8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+bWVyZ2VkOsKgPGEgaHJlZj0iaHR0cHM6Ly9n
aXRodWIuY29tL1NFTGludXhQcm9qZWN0L3NlbGludXgvcHVsbC85OSI+aHR0cHM6Ly9naXRodWIu
Y29tL1NFTGludXhQcm9qZWN0L3NlbGludXgvcHVsbC85OTwvYT48YnI+PGJyPjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBXZWQsIFNlcCAxOSwgMjAxOCBhdCAxMjox
MyBQTSBOaWNrIEtyYWxldmljaCB2aWEgU2VsaW51eCAmbHQ7PGEgaHJlZj0ibWFpbHRvOnNlbGlu
dXhAdHljaG8ubnNhLmdvdiI+c2VsaW51eEB0eWNoby5uc2EuZ292PC9hPiZndDsgd3JvdGU6PGJy
PjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRk
aW5nLWxlZnQ6MWV4Ij5SZWR1Y2Ugbm9pc2Ugd2hlbiBjYWxsaW5nIHRoZSBjaGVja3BvbGljeSBj
b21tYW5kIGxpbmUuIEluIEFuZHJvaWQsIHRoaXM8YnI+DQpjcmVhdGVzIHVubmVjZXNzYXJ5IGJ1
aWxkIG5vaXNlIHdoaWNoIHdlJiMzOTtkIGxpa2UgdG8gYXZvaWQuPGJyPg0KPGJyPg0KPGEgaHJl
Zj0iaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvVW5peF9waGlsb3NvcGh5IiByZWw9Im5v
cmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9V
bml4X3BoaWxvc29waHk8L2E+PGJyPg0KPGJyPg0KwqAgUnVsZSBvZiBTaWxlbmNlPGJyPg0KwqAg
RGV2ZWxvcGVycyBzaG91bGQgZGVzaWduIHByb2dyYW1zIHNvIHRoYXQgdGhleSBkbyBub3QgcHJp
bnQ8YnI+DQrCoCB1bm5lY2Vzc2FyeSBvdXRwdXQuIFRoaXMgcnVsZSBhaW1zIHRvIGFsbG93IG90
aGVyIHByb2dyYW1zPGJyPg0KwqAgYW5kIGRldmVsb3BlcnMgdG8gcGljayBvdXQgdGhlIGluZm9y
bWF0aW9uIHRoZXkgbmVlZCBmcm9tIGE8YnI+DQrCoCBwcm9ncmFtJiMzOTtzIG91dHB1dCB3aXRo
b3V0IGhhdmluZyB0byBwYXJzZSB2ZXJib3NpdHkuPGJyPg0KPGJyPg0KQW4gYWx0ZXJuYXRpdmUg
YXBwcm9hY2ggd291bGQgYmUgdG8gYWRkIGEgLXMgKHNpbGVudCkgb3B0aW9uIHRvIHRoZXNlPGJy
Pg0KdG9vbHMsIG9yIHRvIGhhdmUgdGhlIEFuZHJvaWQgYnVpbGQgc3lzdGVtIHJlZGlyZWN0IHN0
ZG91dCB0byAvZGV2L251bGwuPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogTmljayBLcmFsZXZp
Y2ggJmx0OzxhIGhyZWY9Im1haWx0bzpubmtAZ29vZ2xlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm5u
a0Bnb29nbGUuY29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGNoZWNrcG9saWN5L2NoZWNrbW9k
dWxlLmMgfMKgIDggLS0tLS0tLS08YnI+DQrCoGNoZWNrcG9saWN5L2NoZWNrcG9saWN5LmMgfCAx
MSAtLS0tLS0tLS0tLTxicj4NCsKgMiBmaWxlcyBjaGFuZ2VkLCAxOSBkZWxldGlvbnMoLSk8YnI+
DQo8YnI+DQpkaWZmIC0tZ2l0IGEvY2hlY2twb2xpY3kvY2hlY2ttb2R1bGUuYyBiL2NoZWNrcG9s
aWN5L2NoZWNrbW9kdWxlLmM8YnI+DQppbmRleCA0NmNlMjU4Zi4uOGVkYzFmOGMgMTAwNjQ0PGJy
Pg0KLS0tIGEvY2hlY2twb2xpY3kvY2hlY2ttb2R1bGUuYzxicj4NCisrKyBiL2NoZWNrcG9saWN5
L2NoZWNrbW9kdWxlLmM8YnI+DQpAQCAtMjI4LDcgKzIyOCw2IEBAIGludCBtYWluKGludCBhcmdj
LCBjaGFyICoqYXJndik8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAob3B0aW5kICE9
IGFyZ2MpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdXNhZ2UoYXJn
dlswXSk7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCDCoCDCoHByaW50ZigmcXVvdDsl
czrCoCBsb2FkaW5nIHBvbGljeSBjb25maWd1cmF0aW9uIGZyb20gJXNcbiZxdW90OywgYXJndlsw
XSwgZmlsZSk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgLyogU2V0IHBvbGljeWRiIGFuZCBzaWR0
YWIgdXNlZCBieSBsaWJzZXBvbCBzZXJ2aWNlIGZ1bmN0aW9uczxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgdG8gbXkgc3RydWN0dXJlcywgc28gdGhhdCBJIGNhbiBkaXJlY3RseSBwb3B1bGF0ZSBhbmQ8
YnI+DQpAQCAtMzAyLDggKzMwMSw2IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndik8
YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBzZXBvbF9zaWR0YWJfZGVzdHJveSgmYW1wO3NpZHRhYik7
PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgcHJpbnRmKCZxdW90OyVzOsKgIHBvbGljeSBjb25maWd1
cmF0aW9uIGxvYWRlZFxuJnF1b3Q7LCBhcmd2WzBdKTs8YnI+DQotPGJyPg0KwqAgwqAgwqAgwqAg
aWYgKG91dGZpbGUpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBGSUxFICpvdXRmcCA9
IGZvcGVuKG91dGZpbGUsICZxdW90O3cmcXVvdDspOzxicj4NCjxicj4NCkBAIC0zMTMsMTYgKzMx
MCwxMSBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICghY2ls
KSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnRmKCZxdW90
OyVzOsKgIHdyaXRpbmcgYmluYXJ5IHJlcHJlc2VudGF0aW9uICh2ZXJzaW9uICVkKSB0byAlc1xu
JnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBhcmd2WzBdLCBwb2xpY3l2ZXJzLCBvdXRmaWxlKTs8YnI+DQotPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHdyaXRlX2JpbmFyeV9wb2xpY3koJmFt
cDttb2Rwb2xpY3lkYiwgb3V0ZnApICE9IDApIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7JXM6wqAgZXJy
b3Igd3JpdGluZyAlc1xuJnF1b3Q7LCBhcmd2WzBdLCBvdXRmaWxlKTs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBleGl0KDEpOzxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB9IGVsc2Ugezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBy
aW50ZigmcXVvdDslczrCoCB3cml0aW5nIENJTCB0byAlc1xuJnF1b3Q7LGFyZ3ZbMF0sIG91dGZp
bGUpOzxicj4NCi08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAo
c2Vwb2xfbW9kdWxlX3BvbGljeWRiX3RvX2NpbChvdXRmcCwgJmFtcDttb2Rwb2xpY3lkYiwgMCkg
IT0gMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGZwcmludGYoc3RkZXJyLCAmcXVvdDslczrCoCBlcnJvciB3cml0aW5nICVzXG4mcXVvdDss
IGFyZ3ZbMF0sIG91dGZpbGUpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGV4aXQoMSk7PGJyPg0KZGlmZiAtLWdpdCBhL2NoZWNrcG9saWN5L2No
ZWNrcG9saWN5LmMgYi9jaGVja3BvbGljeS9jaGVja3BvbGljeS5jPGJyPg0KaW5kZXggZmJkYTQ1
NTguLjEyYzRjNDA1IDEwMDY0NDxicj4NCi0tLSBhL2NoZWNrcG9saWN5L2NoZWNrcG9saWN5LmM8
YnI+DQorKysgYi9jaGVja3BvbGljeS9jaGVja3BvbGljeS5jPGJyPg0KQEAgLTUxMiw4ICs1MTIs
NiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgaWYgKG9wdGluZCAhPSBhcmdjKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHVzYWdlKGFyZ3ZbMF0pOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQotwqAg
wqAgwqAgwqBwcmludGYoJnF1b3Q7JXM6wqAgbG9hZGluZyBwb2xpY3kgY29uZmlndXJhdGlvbiBm
cm9tICVzXG4mcXVvdDssIGFyZ3ZbMF0sIGZpbGUpOzxicj4NCi08YnI+DQrCoCDCoCDCoCDCoCAv
KiBTZXQgcG9saWN5ZGIgYW5kIHNpZHRhYiB1c2VkIGJ5IGxpYnNlcG9sIHNlcnZpY2UgZnVuY3Rp
b25zPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqB0byBteSBzdHJ1Y3R1cmVzLCBzbyB0aGF0IEkgY2Fu
IGRpcmVjdGx5IHBvcHVsYXRlIGFuZDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgbWFuaXB1bGF0ZSB0
aGVtLiAqLzxicj4NCkBAIC02MjMsOCArNjIxLDYgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
Kiphcmd2KTxicj4NCsKgIMKgIMKgIMKgIGlmIChwb2xpY3lkYl9sb2FkX2lzaWRzKCZhbXA7cG9s
aWN5ZGIsICZhbXA7c2lkdGFiKSk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBleGl0KDEp
Ozxicj4NCjxicj4NCi3CoCDCoCDCoCDCoHByaW50ZigmcXVvdDslczrCoCBwb2xpY3kgY29uZmln
dXJhdGlvbiBsb2FkZWRcbiZxdW90OywgYXJndlswXSk7PGJyPg0KLTxicj4NCsKgIMKgIMKgIMKg
IGlmIChvdXRmaWxlKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgb3V0ZnAgPSBmb3Bl
bihvdXRmaWxlLCAmcXVvdDt3JnF1b3Q7KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBp
ZiAoIW91dGZwKSB7PGJyPg0KQEAgLTYzNiw4ICs2MzIsNiBAQCBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFjaWwp
IHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIWNvbmYpIHs8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmlu
dGYoJnF1b3Q7JXM6wqAgd3JpdGluZyBiaW5hcnkgcmVwcmVzZW50YXRpb24gKHZlcnNpb24gJWQp
IHRvICVzXG4mcXVvdDssIGFyZ3ZbMF0sIHBvbGljeXZlcnMsIG91dGZpbGUpOzxicj4NCi08YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwb2xpY3lk
Yi5wb2xpY3lfdHlwZSA9IFBPTElDWV9LRVJOOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBvbGljeV9maWxlX2luaXQoJmFtcDtwZik7
PGJyPg0KQEAgLTY0NSw4ICs2MzksNiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcGYu
ZnAgPSBvdXRmcDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCByZXQgPSBwb2xpY3lkYl93cml0ZSgmYW1wO3BvbGljeWRiLCAmYW1wO3BmKTs8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9IGVsc2Ugezxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ZigmcXVvdDsl
czrCoCB3cml0aW5nIHBvbGljeS5jb25mIHRvICVzXG4mcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFyZ3ZbMF0sIG91
dGZpbGUpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHJldCA9IHNlcG9sX2tlcm5lbF9wb2xpY3lkYl90b19jb25mKG91dGZwLCBwb2xpY3lkYnAp
Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAocmV0KSB7PGJyPg0KQEAgLTY1NSw3ICs2
NDcsNiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXhpdCgxKTs8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfSBlbHNlIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmlu
dGYoJnF1b3Q7JXM6wqAgd3JpdGluZyBDSUwgdG8gJXNcbiZxdW90Oyxhcmd2WzBdLCBvdXRmaWxl
KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoYmluYXJ5KSB7
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0
ID0gc2Vwb2xfa2VybmVsX3BvbGljeWRiX3RvX2NpbChvdXRmcCwgcG9saWN5ZGJwKTs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9IGVsc2Ugezxicj4NCkBAIC04OTQs
OCArODg1LDYgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KTxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEZHRVRTKGFucywgc2l6ZW9mKGFucyksIHN0ZGlu
KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXRobGVuID0gc3Ry
bGVuKGFucyk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYW5zW3Bh
dGhsZW4gLSAxXSA9IDA7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cHJpbnRmKCZxdW90OyVzOsKgIGxvYWRpbmcgcG9saWN5IGNvbmZpZ3VyYXRpb24gZnJvbSAlc1xu
JnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBhcmd2WzBdLCBhbnMpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGZkID0gb3BlbihhbnMsIE9fUkRPTkxZKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBpZiAoZmQgJmx0OyAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihzdGRlcnIsICZxdW90O0NhbiYjMzk7dCBv
cGVuICYjMzk7JXMmIzM5OzrCoCAlc1xuJnF1b3Q7LDxicj4NCi0tIDxicj4NCjIuMTkuMC4zOTcu
Z2RkOTAzNDBmNmEtZ29vZzxicj4NCjxicj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fPGJyPg0KU2VsaW51eCBtYWlsaW5nIGxpc3Q8YnI+DQo8YSBocmVm
PSJtYWlsdG86U2VsaW51eEB0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+U2VsaW51eEB0
eWNoby5uc2EuZ292PC9hPjxicj4NClRvIHVuc3Vic2NyaWJlLCBzZW5kIGVtYWlsIHRvIDxhIGhy
ZWY9Im1haWx0bzpTZWxpbnV4LWxlYXZlQHR5Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5T
ZWxpbnV4LWxlYXZlQHR5Y2hvLm5zYS5nb3Y8L2E+Ljxicj4NClRvIGdldCBoZWxwLCBzZW5kIGFu
IGVtYWlsIGNvbnRhaW5pbmcgJnF1b3Q7aGVscCZxdW90OyB0byA8YSBocmVmPSJtYWlsdG86U2Vs
aW51eC1yZXF1ZXN0QHR5Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5TZWxpbnV4LXJlcXVl
c3RAdHljaG8ubnNhLmdvdjwvYT4uPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjwvZGl2
Pg0K
--0000000000000e4aa5057666fae8--
