MIME-Version: 1.0
In-Reply-To: <20170911180439.26437-1-dcashman@android.com>
References: <20170911180439.26437-1-dcashman@android.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 11 Sep 2017 14:51:44 -0700
Message-ID: <CAFftDdpojUWWMO+Rjjv_vgT+7Zx8-ee2J57qGAsE1vpZ6j53qw@mail.gmail.com>
To: Daniel Cashman <dcashman@android.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 James Carter <jwcart2@tycho.nsa.gov>, Daniel Cashman <dcashman@google.com>
Content-Type: multipart/alternative; boundary="94eb2c056102cded260558f0ee02"
Subject: Re: [PATCH] selinux: libselinux: Enable multiple input
 files to selabel_open.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c056102cded260558f0ee02
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 11, 2017 at 11:04 AM, Daniel Cashman <dcashman@android.com>
wrote:

> From: Dan Cashman <dcashman@google.com>
>
> The file_contexts labeling backend, specified in label_file.c, currently
> assumes
> that only one path will be specified as an option to selabel_open().  The
> split
> of platform and non-platform policy on device, however, will necessitate
> the
> loading of two disparate policy files.  Rather than combining the files
> and then
> calling the existing API on a newly-formed file, just add the ability to
> specify
> multiple files to use.  Order of opt specification to selabel_open matters.
>
> This corresponds to AOSP commit 50400d38203e4db08314168e60c281cc61a717a8,
> which
> lead to a fork with upstream, which we'd like to correct.
>
> Signed-off-by: Dan Cashman <dcashman@android.com>
> ---
>  libselinux/src/label.c          |  21 +++++---
>  libselinux/src/label_file.c     | 104 +++++++++++++++++++++++++++++-
> ----------
>  libselinux/src/label_internal.h |   5 +-
>  3 files changed, 94 insertions(+), 36 deletions(-)
>
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 48f4d2d6..0dfa054c 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -143,7 +143,11 @@ static int selabel_fini(struct selabel_handle *rec,
>                             struct selabel_lookup_rec *lr,
>                             int translating)
>  {
> -       if (compat_validate(rec, lr, rec->spec_file, 0))
> +       char *path = NULL;
> +
> +       if (rec->spec_files)
> +               path = rec->spec_files[0];
> +       if (compat_validate(rec, lr, path, 0))
>                 return -1;
>
>         if (translating && !lr->ctx_trans &&
> @@ -226,11 +230,9 @@ struct selabel_handle *selabel_open(unsigned int
> backend,
>         rec->digest = selabel_is_digest_set(opts, nopts, rec->digest);
>
>         if ((*initfuncs[backend])(rec, opts, nopts)) {
> -               free(rec->spec_file);
> -               free(rec);
> +               selabel_close(rec);
>                 rec = NULL;
>         }
> -
>  out:
>         return rec;
>  }
> @@ -337,10 +339,17 @@ int selabel_digest(struct selabel_handle *rec,
>
>  void selabel_close(struct selabel_handle *rec)
>  {
> +       size_t i;
> +
> +       if (rec->spec_files) {
> +               for (i = 0; i < rec->spec_files_len; i++)
> +                       free(rec->spec_files[i]);
> +               free(rec->spec_files);
> +       }
>         if (rec->digest)
>                 selabel_digest_fini(rec->digest);
> -       rec->func_close(rec);
> -       free(rec->spec_file);
> +       if (rec->func_close)
> +               rec->func_close(rec);
>         free(rec);
>  }
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 560d8c3d..b3b36bc2 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -709,28 +709,61 @@ static int init(struct selabel_handle *rec, const
> struct selinux_opt *opts,
>                 unsigned n)
>  {
>         struct saved_data *data = (struct saved_data *)rec->data;
> -       const char *path = NULL;
> +       size_t num_paths = 0;
> +       char **path = NULL;
>         const char *prefix = NULL;
> -       int status = -1, baseonly = 0;
> +       int status = -1;
> +       size_t i;
> +       bool baseonly = false;
> +       bool path_provided;
>
>         /* Process arguments */
> -       while (n--)
> -               switch(opts[n].type) {
> +       i = n;
> +       while (i--)
> +               switch(opts[i].type) {
>                 case SELABEL_OPT_PATH:
> -                       path = opts[n].value;
> +                       num_paths++;
>                         break;
>                 case SELABEL_OPT_SUBSET:
> -                       prefix = opts[n].value;
> +                       prefix = opts[i].value;
>                         break;
>                 case SELABEL_OPT_BASEONLY:
> -                       baseonly = !!opts[n].value;
> +                       baseonly = !!opts[i].value;
>                         break;
>                 }
>
> +       if (!num_paths) {
> +               num_paths = 1;
> +               path_provided = false;
> +       } else {
> +               path_provided = true;
> +       }
> +
> +       path = calloc(num_paths, sizeof(*path));
> +       if (path == NULL) {
> +               goto finish;
> +       }
> +       rec->spec_files = path;
> +       rec->spec_files_len = num_paths;
> +
> +       if (path_provided) {
> +               for (i = 0; i < n; i++) {
> +                       switch(opts[i].type) {
>

Weird way to do an if/else?


> +                       case SELABEL_OPT_PATH:
> +                               *path = strdup(opts[i].value);
> +                               if (*path == NULL)
> +                                       goto finish;
> +                               path++;
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +               }
> +       }
>  #if !defined(BUILD_HOST) && !defined(ANDROID)
>         char subs_file[PATH_MAX + 1];
>         /* Process local and distribution substitution files */
> -       if (!path) {
> +       if (!path_provided) {
>                 status = selabel_subs_init(
>                         selinux_file_context_subs_dist_path(),
>                         rec->digest, &data->dist_subs);
> @@ -740,43 +773,52 @@ static int init(struct selabel_handle *rec, const
> struct selinux_opt *opts,
>                         rec->digest, &data->subs);
>                 if (status)
>                         goto finish;
> -               path = selinux_file_context_path();
> +               rec->spec_files[0] = strdup(selinux_file_context_path());
> +               if (rec->spec_files[0] == NULL)
> +                       goto finish;
>         } else {
> -               snprintf(subs_file, sizeof(subs_file), "%s.subs_dist",
> path);
> -               status = selabel_subs_init(subs_file, rec->digest,
> +               for (i = 0; i < num_paths; i++) {
> +                       snprintf(subs_file, sizeof(subs_file),
> "%s.subs_dist", rec->spec_files[i]);
> +                       status = selabel_subs_init(subs_file, rec->digest,
>                                            &data->dist_subs);
> -               if (status)
> -                       goto finish;
> -               snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
> -               status = selabel_subs_init(subs_file, rec->digest,
> +                       if (status)
> +                               goto finish;
> +                       snprintf(subs_file, sizeof(subs_file), "%s.subs",
> rec->spec_files[i]);
> +                       status = selabel_subs_init(subs_file, rec->digest,
>                                            &data->subs);
> -               if (status)
> -                       goto finish;
> +                       if (status)
> +                               goto finish;
> +               }
> +       }
> +#else
> +       if (!path_provided) {
> +               selinux_log(SELINUX_ERROR, "No path given to file labeling
> backend\n");
> +               goto finish;
>         }
> -
>  #endif
> -       rec->spec_file = strdup(path);
>
>         /*
> -        * The do detailed validation of the input and fill the spec array
> +        * Do detailed validation of the input and fill the spec array
>          */
> -       status = process_file(path, NULL, rec, prefix, rec->digest);
> -       if (status)
> -               goto finish;
> -
> -       if (rec->validating) {
> -               status = nodups_specs(data, path);
> +       for (i = 0; i < num_paths; i++) {
> +               status = process_file(rec->spec_files[i], NULL, rec,
> prefix, rec->digest);
>                 if (status)
>                         goto finish;
> +
> +               if (rec->validating) {
> +                       status = nodups_specs(data, rec->spec_files[i]);
> +                       if (status)
> +                               goto finish;
> +               }
>         }
>
>         if (!baseonly) {
> -               status = process_file(path, "homedirs", rec, prefix,
> +               status = process_file(rec->spec_files[0], "homedirs",
> rec, prefix,
>                                                             rec->digest);
>                 if (status && errno != ENOENT)
>                         goto finish;
>
> -               status = process_file(path, "local", rec, prefix,
> +               status = process_file(rec->spec_files[0], "local", rec,
> prefix,
>                                                             rec->digest);
>                 if (status && errno != ENOENT)
>                         goto finish;
> @@ -804,6 +846,12 @@ static void closef(struct selabel_handle *rec)
>         struct stem *stem;
>         unsigned int i;
>
> +       if (!data)
> +               return;
> +
> +       /* make sure successive ->func_close() calls are harmless */
> +       rec->data = NULL;
> +
>         selabel_subs_fini(data->subs);
>         selabel_subs_fini(data->dist_subs);
>
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_
> internal.h
> index c55efb75..43b63513 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -98,10 +98,11 @@ struct selabel_handle {
>         void *data;
>
>         /*
> -        * The main spec file used. Note for file contexts the local and/or
> +        * The main spec file(s) used. Note for file contexts the local
> and/or
>          * homedirs could also have been used to resolve a context.
>          */
> -       char *spec_file;
> +       size_t spec_files_len;
> +       char **spec_files;
>
>         /* ptr to SHA1 hash information if SELABEL_OPT_DIGEST set */
>         struct selabel_digest *digest;
> --
> 2.14.1.581.gf28d330327-goog
>
>
all in all, I have no major gripes with this. Ack.

--94eb2c056102cded260558f0ee02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgU2VwIDExLCAyMDE3IGF0IDExOjA0IEFNLCBEYW5pZWwg
Q2FzaG1hbiA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpkY2FzaG1hbkBhbmRy
b2lkLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRjYXNobWFuQGFuZHJvaWQuY29tPC9hPiZndDs8L3Nw
YW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij5Gcm9tOiBEYW4gQ2FzaG1hbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRjYXNobWFuQGdvb2dsZS5j
b20iPmRjYXNobWFuQGdvb2dsZS5jb208L2E+Jmd0Ozxicj4NCjxicj4NClRoZSBmaWxlX2NvbnRl
eHRzIGxhYmVsaW5nIGJhY2tlbmQsIHNwZWNpZmllZCBpbiBsYWJlbF9maWxlLmMsIGN1cnJlbnRs
eSBhc3N1bWVzPGJyPg0KdGhhdCBvbmx5IG9uZSBwYXRoIHdpbGwgYmUgc3BlY2lmaWVkIGFzIGFu
IG9wdGlvbiB0byBzZWxhYmVsX29wZW4oKS7CoCBUaGUgc3BsaXQ8YnI+DQpvZiBwbGF0Zm9ybSBh
bmQgbm9uLXBsYXRmb3JtIHBvbGljeSBvbiBkZXZpY2UsIGhvd2V2ZXIsIHdpbGwgbmVjZXNzaXRh
dGUgdGhlPGJyPg0KbG9hZGluZyBvZiB0d28gZGlzcGFyYXRlIHBvbGljeSBmaWxlcy7CoCBSYXRo
ZXIgdGhhbiBjb21iaW5pbmcgdGhlIGZpbGVzIGFuZCB0aGVuPGJyPg0KY2FsbGluZyB0aGUgZXhp
c3RpbmcgQVBJIG9uIGEgbmV3bHktZm9ybWVkIGZpbGUsIGp1c3QgYWRkIHRoZSBhYmlsaXR5IHRv
IHNwZWNpZnk8YnI+DQptdWx0aXBsZSBmaWxlcyB0byB1c2UuwqAgT3JkZXIgb2Ygb3B0IHNwZWNp
ZmljYXRpb24gdG8gc2VsYWJlbF9vcGVuIG1hdHRlcnMuPGJyPg0KPGJyPg0KVGhpcyBjb3JyZXNw
b25kcyB0byBBT1NQIGNvbW1pdCA1MDQwMGQzODIwM2U0ZGIwODMxNDE2OGU2MGMyODE8d2JyPmNj
NjFhNzE3YTgsIHdoaWNoPGJyPg0KbGVhZCB0byBhIGZvcmsgd2l0aCB1cHN0cmVhbSwgd2hpY2gg
d2UmIzM5O2QgbGlrZSB0byBjb3JyZWN0Ljxicj4NCjxicj4NClNpZ25lZC1vZmYtYnk6IERhbiBD
YXNobWFuICZsdDs8YSBocmVmPSJtYWlsdG86ZGNhc2htYW5AYW5kcm9pZC5jb20iPmRjYXNobWFu
QGFuZHJvaWQuY29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGxpYnNlbGludXgvc3JjL2xhYmVs
LmPCoCDCoCDCoCDCoCDCoCB8wqAgMjEgKysrKystLS08YnI+DQrCoGxpYnNlbGludXgvc3JjL2xh
YmVsX2ZpbGUuY8KgIMKgIMKgfCAxMDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystPHdi
cj4tLS0tLS0tLS0tPGJyPg0KwqBsaWJzZWxpbnV4L3NyYy9sYWJlbF9pbnRlcm5hbC48d2JyPmgg
fMKgIMKgNSArLTxicj4NCsKgMyBmaWxlcyBjaGFuZ2VkLCA5NCBpbnNlcnRpb25zKCspLCAzNiBk
ZWxldGlvbnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvbGlic2VsaW51eC9zcmMvbGFiZWwu
YyBiL2xpYnNlbGludXgvc3JjL2xhYmVsLmM8YnI+DQppbmRleCA0OGY0ZDJkNi4uMGRmYTA1NGMg
MTAwNjQ0PGJyPg0KLS0tIGEvbGlic2VsaW51eC9zcmMvbGFiZWwuYzxicj4NCisrKyBiL2xpYnNl
bGludXgvc3JjL2xhYmVsLmM8YnI+DQpAQCAtMTQzLDcgKzE0MywxMSBAQCBzdGF0aWMgaW50IHNl
bGFiZWxfZmluaShzdHJ1Y3Qgc2VsYWJlbF9oYW5kbGUgKnJlYyw8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3Qgc2VsYWJlbF9sb29rdXBfcmVjICps
ciw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQgdHJh
bnNsYXRpbmcpPGJyPg0KwqB7PGJyPg0KLcKgIMKgIMKgIMKgaWYgKGNvbXBhdF92YWxpZGF0ZShy
ZWMsIGxyLCByZWMtJmd0O3NwZWNfZmlsZSwgMCkpPGJyPg0KK8KgIMKgIMKgIMKgY2hhciAqcGF0
aCA9IE5VTEw7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChyZWMtJmd0O3NwZWNfZmlsZXMp
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGF0aCA9IHJlYy0mZ3Q7c3BlY19maWxlc1sw
XTs8YnI+DQorwqAgwqAgwqAgwqBpZiAoY29tcGF0X3ZhbGlkYXRlKHJlYywgbHIsIHBhdGgsIDAp
KTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAtMTs8YnI+DQo8YnI+DQrCoCDC
oCDCoCDCoCBpZiAodHJhbnNsYXRpbmcgJmFtcDsmYW1wOyAhbHItJmd0O2N0eF90cmFucyAmYW1w
OyZhbXA7PGJyPg0KQEAgLTIyNiwxMSArMjMwLDkgQEAgc3RydWN0IHNlbGFiZWxfaGFuZGxlICpz
ZWxhYmVsX29wZW4odW5zaWduZWQgaW50IGJhY2tlbmQsPGJyPg0KwqAgwqAgwqAgwqAgcmVjLSZn
dDtkaWdlc3QgPSBzZWxhYmVsX2lzX2RpZ2VzdF9zZXQob3B0cywgbm9wdHMsIHJlYy0mZ3Q7ZGln
ZXN0KTs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBpZiAoKCppbml0ZnVuY3NbYmFja2VuZF0pKHJl
Yywgb3B0cywgbm9wdHMpKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShyZWMt
Jmd0O3NwZWNfZmlsZSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShyZWMpOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGFiZWxfY2xvc2UocmVjKTs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCByZWMgPSBOVUxMOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQot
PGJyPg0KwqBvdXQ6PGJyPg0KwqAgwqAgwqAgwqAgcmV0dXJuIHJlYzs8YnI+DQrCoH08YnI+DQpA
QCAtMzM3LDEwICszMzksMTcgQEAgaW50IHNlbGFiZWxfZGlnZXN0KHN0cnVjdCBzZWxhYmVsX2hh
bmRsZSAqcmVjLDxicj4NCjxicj4NCsKgdm9pZCBzZWxhYmVsX2Nsb3NlKHN0cnVjdCBzZWxhYmVs
X2hhbmRsZSAqcmVjKTxicj4NCsKgezxicj4NCivCoCDCoCDCoCDCoHNpemVfdCBpOzxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqBpZiAocmVjLSZndDtzcGVjX2ZpbGVzKSB7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IHJlYy0mZ3Q7c3BlY19maWxlc19sZW47
IGkrKyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKHJlYy0m
Z3Q7c3BlY19maWxlc1tpXSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZShyZWMt
Jmd0O3NwZWNfZmlsZXMpOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQrCoCDCoCDCoCDCoCBpZiAo
cmVjLSZndDtkaWdlc3QpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2VsYWJlbF9kaWdl
c3RfZmluaShyZWMtJmd0Ozx3YnI+ZGlnZXN0KTs8YnI+DQotwqAgwqAgwqAgwqByZWMtJmd0O2Z1
bmNfY2xvc2UocmVjKTs8YnI+DQotwqAgwqAgwqAgwqBmcmVlKHJlYy0mZ3Q7c3BlY19maWxlKTs8
YnI+DQorwqAgwqAgwqAgwqBpZiAocmVjLSZndDtmdW5jX2Nsb3NlKTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJlYy0mZ3Q7ZnVuY19jbG9zZShyZWMpOzxicj4NCsKgIMKgIMKgIMKgIGZy
ZWUocmVjKTs8YnI+DQrCoH08YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvbGlic2VsaW51eC9zcmMv
bGFiZWxfZmlsZS5jIGIvbGlic2VsaW51eC9zcmMvbGFiZWxfZmlsZS5jPGJyPg0KaW5kZXggNTYw
ZDhjM2QuLmIzYjM2YmMyIDEwMDY0NDxicj4NCi0tLSBhL2xpYnNlbGludXgvc3JjL2xhYmVsX2Zp
bGUuYzxicj4NCisrKyBiL2xpYnNlbGludXgvc3JjL2xhYmVsX2ZpbGUuYzxicj4NCkBAIC03MDks
MjggKzcwOSw2MSBAQCBzdGF0aWMgaW50IGluaXQoc3RydWN0IHNlbGFiZWxfaGFuZGxlICpyZWMs
IGNvbnN0IHN0cnVjdCBzZWxpbnV4X29wdCAqb3B0cyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB1bnNpZ25lZCBuKTxicj4NCsKgezxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBzYXZlZF9k
YXRhICpkYXRhID0gKHN0cnVjdCBzYXZlZF9kYXRhICopcmVjLSZndDtkYXRhOzxicj4NCi3CoCDC
oCDCoCDCoGNvbnN0IGNoYXIgKnBhdGggPSBOVUxMOzxicj4NCivCoCDCoCDCoCDCoHNpemVfdCBu
dW1fcGF0aHMgPSAwOzxicj4NCivCoCDCoCDCoCDCoGNoYXIgKipwYXRoID0gTlVMTDs8YnI+DQrC
oCDCoCDCoCDCoCBjb25zdCBjaGFyICpwcmVmaXggPSBOVUxMOzxicj4NCi3CoCDCoCDCoCDCoGlu
dCBzdGF0dXMgPSAtMSwgYmFzZW9ubHkgPSAwOzxicj4NCivCoCDCoCDCoCDCoGludCBzdGF0dXMg
PSAtMTs8YnI+DQorwqAgwqAgwqAgwqBzaXplX3QgaTs8YnI+DQorwqAgwqAgwqAgwqBib29sIGJh
c2Vvbmx5ID0gZmFsc2U7PGJyPg0KK8KgIMKgIMKgIMKgYm9vbCBwYXRoX3Byb3ZpZGVkOzxicj4N
Cjxicj4NCsKgIMKgIMKgIMKgIC8qIFByb2Nlc3MgYXJndW1lbnRzICovPGJyPg0KLcKgIMKgIMKg
IMKgd2hpbGUgKG4tLSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzd2l0Y2gob3B0c1tu
XS50eXBlKSB7PGJyPg0KK8KgIMKgIMKgIMKgaSA9IG47PGJyPg0KK8KgIMKgIMKgIMKgd2hpbGUg
KGktLSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzd2l0Y2gob3B0c1tpXS50eXBlKSB7
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2FzZSBTRUxBQkVMX09QVF9QQVRIOjxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBhdGggPSBvcHRzW25dLnZhbHVl
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG51bV9wYXRocysrOzxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGNhc2UgU0VMQUJFTF9PUFRfU1VCU0VUOjxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByZWZpeCA9IG9wdHNbbl0udmFsdWU7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJlZml4ID0gb3B0c1tpXS52YWx1
ZTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYXNlIFNFTEFCRUxfT1BUX0JBU0VPTkxZOjxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJhc2Vvbmx5ID0gISFvcHRzW25dLnZh
bHVlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJhc2Vvbmx5ID0g
ISFvcHRzW2ldLnZhbHVlOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGJyZWFrOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQorwqAgwqAg
wqAgwqBpZiAoIW51bV9wYXRocykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG51bV9w
YXRocyA9IDE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGF0aF9wcm92aWRlZCA9IGZh
bHNlOzxicj4NCivCoCDCoCDCoCDCoH0gZWxzZSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcGF0aF9wcm92aWRlZCA9IHRydWU7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqBwYXRoID0gY2FsbG9jKG51bV9wYXRocywgc2l6ZW9mKCpwYXRoKSk7PGJyPg0K
K8KgIMKgIMKgIMKgaWYgKHBhdGggPT0gTlVMTCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGdvdG8gZmluaXNoOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqByZWMt
Jmd0O3NwZWNfZmlsZXMgPSBwYXRoOzxicj4NCivCoCDCoCDCoCDCoHJlYy0mZ3Q7c3BlY19maWxl
c19sZW4gPSBudW1fcGF0aHM7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChwYXRoX3Byb3Zp
ZGVkKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IG47
IGkrKykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN3aXRjaChv
cHRzW2ldLnR5cGUpIHs8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+V2VpcmQg
d2F5IHRvIGRvIGFuIGlmL2Vsc2U/PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgY2FzZSBTRUxBQkVMX09QVF9QQVRIOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCpwYXRoID0gc3RyZHVwKG9wdHNbaV0udmFsdWUp
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
ICgqcGF0aCA9PSBOVUxMKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZmluaXNoOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBhdGgrKzs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9
PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCsKgI2lmICFkZWZpbmVkKEJVSUxEX0hPU1QpICZhbXA7
JmFtcDsgIWRlZmluZWQoQU5EUk9JRCk8YnI+DQrCoCDCoCDCoCDCoCBjaGFyIHN1YnNfZmlsZVtQ
QVRIX01BWCArIDFdOzxicj4NCsKgIMKgIMKgIMKgIC8qIFByb2Nlc3MgbG9jYWwgYW5kIGRpc3Ry
aWJ1dGlvbiBzdWJzdGl0dXRpb24gZmlsZXMgKi88YnI+DQotwqAgwqAgwqAgwqBpZiAoIXBhdGgp
IHs8YnI+DQorwqAgwqAgwqAgwqBpZiAoIXBhdGhfcHJvdmlkZWQpIHs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZWxhYmVsX3N1YnNfaW5pdCg8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZWxpbnV4X2ZpbGVfY29udGV4dF9zdWJzXzx3YnI+
ZGlzdF9wYXRoKCksPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVj
LSZndDtkaWdlc3QsICZhbXA7ZGF0YS0mZ3Q7ZGlzdF9zdWJzKTs8YnI+DQpAQCAtNzQwLDQzICs3
NzMsNTIgQEAgc3RhdGljIGludCBpbml0KHN0cnVjdCBzZWxhYmVsX2hhbmRsZSAqcmVjLCBjb25z
dCBzdHJ1Y3Qgc2VsaW51eF9vcHQgKm9wdHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgcmVjLSZndDtkaWdlc3QsICZhbXA7ZGF0YS0mZ3Q7c3Vicyk7PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHN0YXR1cyk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBnb3RvIGZpbmlzaDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBwYXRoID0gc2VsaW51eF9maWxlX2NvbnRleHRfcGF0aCgpOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJlYy0mZ3Q7c3BlY19maWxlc1swXSA9IHN0cmR1cChzZWxpbnV4X2ZpbGVfY29u
dGV4dF88d2JyPnBhdGgoKSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJlYy0m
Z3Q7c3BlY19maWxlc1swXSA9PSBOVUxMKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGdvdG8gZmluaXNoOzxicj4NCsKgIMKgIMKgIMKgIH0gZWxzZSB7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc25wcmludGYoc3Vic19maWxlLCBzaXplb2Yoc3Vic19maWxl
KSwgJnF1b3Q7JXMuc3Vic19kaXN0JnF1b3Q7LCBwYXRoKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzdGF0dXMgPSBzZWxhYmVsX3N1YnNfaW5pdChzdWJzX2ZpbGUsIHJlYy0mZ3Q7ZGln
ZXN0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBudW1f
cGF0aHM7IGkrKykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNu
cHJpbnRmKHN1YnNfZmlsZSwgc2l6ZW9mKHN1YnNfZmlsZSksICZxdW90OyVzLnN1YnNfZGlzdCZx
dW90OywgcmVjLSZndDtzcGVjX2ZpbGVzW2ldKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZWxhYmVsX3N1YnNfaW5pdChzdWJzX2ZpbGUsIHJlYy0m
Z3Q7ZGlnZXN0LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtkYXRhLSZndDtkaXN0X3N1YnMpOzxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzdGF0dXMpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZ290byBmaW5pc2g7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgc25wcmludGYoc3Vic19maWxlLCBzaXplb2Yoc3Vic19maWxlKSwgJnF1b3Q7JXMuc3VicyZx
dW90OywgcGF0aCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VsYWJl
bF9zdWJzX2luaXQoc3Vic19maWxlLCByZWMtJmd0O2RpZ2VzdCw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc3RhdHVzKTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZmluaXNoOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNucHJpbnRmKHN1YnNfZmlsZSwgc2l6ZW9mKHN1
YnNfZmlsZSksICZxdW90OyVzLnN1YnMmcXVvdDssIHJlYy0mZ3Q7c3BlY19maWxlc1tpXSk7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VsYWJlbF9z
dWJzX2luaXQoc3Vic19maWxlLCByZWMtJmd0O2RpZ2VzdCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7ZGF0
YS0mZ3Q7c3Vicyk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHN0YXR1cyk8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGZpbmlzaDs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc3RhdHVzKTxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZmluaXNoOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKyNl
bHNlPGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFwYXRoX3Byb3ZpZGVkKSB7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc2VsaW51eF9sb2coU0VMSU5VWF9FUlJPUiwgJnF1b3Q7Tm8gcGF0aCBn
aXZlbiB0byBmaWxlIGxhYmVsaW5nIGJhY2tlbmRcbiZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZ290byBmaW5pc2g7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCi08YnI+DQrC
oCNlbmRpZjxicj4NCi3CoCDCoCDCoCDCoHJlYy0mZ3Q7c3BlY19maWxlID0gc3RyZHVwKHBhdGgp
Ozxicj4NCjxicj4NCsKgIMKgIMKgIMKgIC8qPGJyPg0KLcKgIMKgIMKgIMKgICogVGhlIGRvIGRl
dGFpbGVkIHZhbGlkYXRpb24gb2YgdGhlIGlucHV0IGFuZCBmaWxsIHRoZSBzcGVjIGFycmF5PGJy
Pg0KK8KgIMKgIMKgIMKgICogRG8gZGV0YWlsZWQgdmFsaWRhdGlvbiBvZiB0aGUgaW5wdXQgYW5k
IGZpbGwgdGhlIHNwZWMgYXJyYXk8YnI+DQrCoCDCoCDCoCDCoCDCoCovPGJyPg0KLcKgIMKgIMKg
IMKgc3RhdHVzID0gcHJvY2Vzc19maWxlKHBhdGgsIE5VTEwsIHJlYywgcHJlZml4LCByZWMtJmd0
O2RpZ2VzdCk7PGJyPg0KLcKgIMKgIMKgIMKgaWYgKHN0YXR1cyk8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBnb3RvIGZpbmlzaDs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgaWYgKHJlYy0m
Z3Q7dmFsaWRhdGluZykgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IG5v
ZHVwc19zcGVjcyhkYXRhLCBwYXRoKTs8YnI+DQorwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZs
dDsgbnVtX3BhdGhzOyBpKyspIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMg
PSBwcm9jZXNzX2ZpbGUocmVjLSZndDtzcGVjX2ZpbGVzWzx3YnI+aV0sIE5VTEwsIHJlYywgcHJl
Zml4LCByZWMtJmd0O2RpZ2VzdCk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHN0
YXR1cyk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGZpbmlz
aDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJlYy0mZ3Q7dmFsaWRh
dGluZykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9
IG5vZHVwc19zcGVjcyhkYXRhLCByZWMtJmd0O3NwZWNfZmlsZXNbaV0pOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzdGF0dXMpPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBmaW5pc2g7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQrCoCDC
oCDCoCDCoCBpZiAoIWJhc2Vvbmx5KSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3Rh
dHVzID0gcHJvY2Vzc19maWxlKHBhdGgsICZxdW90O2hvbWVkaXJzJnF1b3Q7LCByZWMsIHByZWZp
eCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBwcm9jZXNzX2ZpbGUocmVj
LSZndDtzcGVjX2ZpbGVzWzx3YnI+MF0sICZxdW90O2hvbWVkaXJzJnF1b3Q7LCByZWMsIHByZWZp
eCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZWMtJmd0O2RpZ2VzdCk7
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHN0YXR1cyAmYW1wOyZhbXA7IGVycm5v
ICE9IEVOT0VOVCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3Rv
IGZpbmlzaDs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBwcm9j
ZXNzX2ZpbGUocGF0aCwgJnF1b3Q7bG9jYWwmcXVvdDssIHJlYywgcHJlZml4LDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHByb2Nlc3NfZmlsZShyZWMtJmd0O3NwZWNfZmls
ZXNbPHdicj4wXSwgJnF1b3Q7bG9jYWwmcXVvdDssIHJlYywgcHJlZml4LDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlYy0mZ3Q7ZGlnZXN0KTs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBpZiAoc3RhdHVzICZhbXA7JmFtcDsgZXJybm8gIT0gRU5PRU5UKTxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZmluaXNoOzxicj4NCkBA
IC04MDQsNiArODQ2LDEyIEBAIHN0YXRpYyB2b2lkIGNsb3NlZihzdHJ1Y3Qgc2VsYWJlbF9oYW5k
bGUgKnJlYyk8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3Qgc3RlbSAqc3RlbTs8YnI+DQrCoCDCoCDC
oCDCoCB1bnNpZ25lZCBpbnQgaTs8YnI+DQo8YnI+DQorwqAgwqAgwqAgwqBpZiAoIWRhdGEpPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOzxicj4NCis8YnI+DQorwqAgwqAgwqAg
wqAvKiBtYWtlIHN1cmUgc3VjY2Vzc2l2ZSAtJmd0O2Z1bmNfY2xvc2UoKSBjYWxscyBhcmUgaGFy
bWxlc3MgKi88YnI+DQorwqAgwqAgwqAgwqByZWMtJmd0O2RhdGEgPSBOVUxMOzxicj4NCis8YnI+
DQrCoCDCoCDCoCDCoCBzZWxhYmVsX3N1YnNfZmluaShkYXRhLSZndDtzdWJzKTs8YnI+DQrCoCDC
oCDCoCDCoCBzZWxhYmVsX3N1YnNfZmluaShkYXRhLSZndDtkaXN0Xzx3YnI+c3Vicyk7PGJyPg0K
PGJyPg0KZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvc3JjL2xhYmVsXzx3YnI+aW50ZXJuYWwuaCBi
L2xpYnNlbGludXgvc3JjL2xhYmVsXzx3YnI+aW50ZXJuYWwuaDxicj4NCmluZGV4IGM1NWVmYjc1
Li40M2I2MzUxMyAxMDA2NDQ8YnI+DQotLS0gYS9saWJzZWxpbnV4L3NyYy9sYWJlbF88d2JyPmlu
dGVybmFsLmg8YnI+DQorKysgYi9saWJzZWxpbnV4L3NyYy9sYWJlbF88d2JyPmludGVybmFsLmg8
YnI+DQpAQCAtOTgsMTAgKzk4LDExIEBAIHN0cnVjdCBzZWxhYmVsX2hhbmRsZSB7PGJyPg0KwqAg
wqAgwqAgwqAgdm9pZCAqZGF0YTs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCAvKjxicj4NCi3CoCDC
oCDCoCDCoCAqIFRoZSBtYWluIHNwZWMgZmlsZSB1c2VkLiBOb3RlIGZvciBmaWxlIGNvbnRleHRz
IHRoZSBsb2NhbCBhbmQvb3I8YnI+DQorwqAgwqAgwqAgwqAgKiBUaGUgbWFpbiBzcGVjIGZpbGUo
cykgdXNlZC4gTm90ZSBmb3IgZmlsZSBjb250ZXh0cyB0aGUgbG9jYWwgYW5kL29yPGJyPg0KwqAg
wqAgwqAgwqAgwqAqIGhvbWVkaXJzIGNvdWxkIGFsc28gaGF2ZSBiZWVuIHVzZWQgdG8gcmVzb2x2
ZSBhIGNvbnRleHQuPGJyPg0KwqAgwqAgwqAgwqAgwqAqLzxicj4NCi3CoCDCoCDCoCDCoGNoYXIg
KnNwZWNfZmlsZTs8YnI+DQorwqAgwqAgwqAgwqBzaXplX3Qgc3BlY19maWxlc19sZW47PGJyPg0K
K8KgIMKgIMKgIMKgY2hhciAqKnNwZWNfZmlsZXM7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgLyog
cHRyIHRvIFNIQTEgaGFzaCBpbmZvcm1hdGlvbiBpZiBTRUxBQkVMX09QVF9ESUdFU1Qgc2V0ICov
PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IHNlbGFiZWxfZGlnZXN0ICpkaWdlc3Q7PGJyPg0KPHNw
YW4gY2xhc3M9IkhPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPi0tPGJyPg0KMi4xNC4xLjU4
MS5nZjI4ZDMzMDMyNy1nb29nPGJyPg0KPGJyPg0KPC9mb250Pjwvc3Bhbj48L2Jsb2NrcXVvdGU+
PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSIgZGF0YS1zbWFydG1haWw9Imdt
YWlsX3NpZ25hdHVyZSI+YWxsIGluIGFsbCwgSSBoYXZlIG5vIG1ham9yIGdyaXBlcyB3aXRoIHRo
aXMuIEFjay48L2Rpdj4NCjwvZGl2PjwvZGl2Pg0K
--94eb2c056102cded260558f0ee02--
