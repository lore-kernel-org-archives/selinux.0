Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93KIPk2001177
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 16:18:25 -0400
Received: by mail-qt0-f177.google.com with SMTP id f6so29356320qtd.2
 for <selinux@tycho.nsa.gov>; Mon, 03 Oct 2016 13:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <1475524323-29138-1-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1475524323-29138-1-git-send-email-jwcart2@tycho.nsa.gov>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Mon, 03 Oct 2016 20:18:13 +0000
Message-ID: <CABXk95Be3cSX6Xzq8Uox+9t4aT2pQZmpfe=j+swvBt-nqW1+Mw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Add support for converting extended permissions
 to CIL
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1144831e586ce0053dfba55c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1144831e586ce0053dfba55c
Content-Type: text/plain; charset=UTF-8

Once this gets submitted I'll do a pull on upstream into AOSP.

On Mon, Oct 3, 2016 at 12:52 PM James Carter <jwcart2@tycho.nsa.gov> wrote:

> Checkpolicy has an option to produce CIL output and is dependent on
> the policydb-to-CIL conversion in libsepol for that option. Add
> support for converting extended permissions to CIL so that checlpolicy
> can generate CIL.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/src/module_to_cil.c | 115
> +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 111 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 508a861..556d11e 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -609,6 +609,103 @@ exit:
>         return rc;
>  }
>
> +#define next_bit_in_range(i, p) ((i + 1 < sizeof(p)*8) && xperm_test((i +
> 1), p))
> +
> +static int xperms_to_cil(const av_extended_perms_t *xperms)
> +{
> +       uint16_t value;
> +       uint16_t low_bit;
> +       uint16_t low_value;
> +       unsigned int bit;
> +       unsigned int in_range = 0;
> +       int first = 1;
> +
> +       if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
> +               && (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
> +               return -1;
> +
> +       for (bit = 0; bit < sizeof(xperms->perms)*8; bit++) {
> +               if (!xperm_test(bit, xperms->perms))
> +                       continue;
> +
> +               if (in_range && next_bit_in_range(bit, xperms->perms)) {
> +                       /* continue until high value found */
> +                       continue;
> +               } else if (next_bit_in_range(bit, xperms->perms)) {
> +                       /* low value */
> +                       low_bit = bit;
> +                       in_range = 1;
> +                       continue;
> +               }
> +
> +               if (!first)
> +                       cil_printf(" ");
> +               else
> +                       first = 0;
> +
> +               if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
> +                       value = xperms->driver<<8 | bit;
> +                       low_value = xperms->driver<<8 | low_bit;
> +                       if (in_range) {
> +                               cil_printf("(range 0x%hx 0x%hx)",
> low_value, value);
> +                               in_range = 0;
> +                       } else {
> +                               cil_printf("0x%hx", value);
> +                       }
> +               } else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
> +                       value = bit << 8;
> +                       low_value = low_bit << 8;
> +                       if (in_range) {
> +                               cil_printf("(range 0x%hx 0x%hx)",
> low_value, (uint16_t) (value|0xff));
> +                               in_range = 0;
> +                       } else {
> +                               cil_printf("(range 0x%hx 0x%hx)", value,
> (uint16_t) (value|0xff));
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int avrulex_to_cil(int indent, struct policydb *pdb, uint32_t
> type, const char *src, const char *tgt, const class_perm_node_t
> *classperms, const av_extended_perms_t *xperms)
> +{
> +       int rc = -1;
> +       const char *rule;
> +       const struct class_perm_node *classperm;
> +
> +       switch (type) {
> +       case AVRULE_XPERMS_ALLOWED:
> +               rule = "allowxperm";
> +               break;
> +       case AVRULE_XPERMS_AUDITALLOW:
> +               rule = "auditallowxperm";
> +               break;
> +       case AVRULE_XPERMS_DONTAUDIT:
> +               rule = "dontauditxperm";
> +               break;
> +       case AVRULE_XPERMS_NEVERALLOW:
> +               rule = "neverallowxperm";
> +               break;
> +       default:
> +               log_err("Unknown avrule xperm type: %i", type);
> +               rc = -1;
> +               goto exit;
> +       }
> +
> +       for (classperm = classperms; classperm != NULL; classperm =
> classperm->next) {
> +               cil_indent(indent);
> +               cil_printf("(%s %s %s %s (%s (", rule, src, tgt,
> +                          "ioctl",
> pdb->p_class_val_to_name[classperm->tclass - 1]);
> +               xperms_to_cil(xperms);
> +               cil_printf("))\n");
> +       }
> +
> +       return 0;
> +
> +exit:
> +       return rc;
> +}
> +
>  static int num_digits(int n)
>  {
>         int num = 1;
> @@ -1077,7 +1174,8 @@ static int avrule_list_to_cil(int indent, struct
> policydb *pdb, struct avrule *a
>         struct type_set *ts;
>
>         for (avrule = avrule_list; avrule != NULL; avrule = avrule->next) {
> -               if (avrule->specified == AVRULE_NEVERALLOW &&
> avrule->source_filename) {
> +               if ((avrule->specified &
> (AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW)) &&
> +                   avrule->source_filename) {
>                         cil_println(0, ";;* lmx %lu
> %s\n",avrule->source_line, avrule->source_filename);
>                 }
>
> @@ -1095,14 +1193,22 @@ static int avrule_list_to_cil(int indent, struct
> policydb *pdb, struct avrule *a
>
>                 for (s = 0; s < num_snames; s++) {
>                         for (t = 0; t < num_tnames; t++) {
> -                               rc = avrule_to_cil(indent, pdb,
> avrule->specified, snames[s], tnames[t], avrule->perms);
> +                               if (avrule->specified & AVRULE_XPERMS) {
> +                                       rc = avrulex_to_cil(indent, pdb,
> avrule->specified, snames[s], tnames[t], avrule->perms, avrule->xperms);
> +                               } else {
> +                                       rc = avrule_to_cil(indent, pdb,
> avrule->specified, snames[s], tnames[t], avrule->perms);
> +                               }
>                                 if (rc != 0) {
>                                         goto exit;
>                                 }
>                         }
>
>                         if (avrule->flags & RULE_SELF) {
> -                               rc = avrule_to_cil(indent, pdb,
> avrule->specified, snames[s], "self", avrule->perms);
> +                               if (avrule->specified & AVRULE_XPERMS) {
> +                                       rc = avrulex_to_cil(indent, pdb,
> avrule->specified, snames[s], "self", avrule->perms, avrule->xperms);
> +                               } else {
> +                                       rc = avrule_to_cil(indent, pdb,
> avrule->specified, snames[s], "self", avrule->perms);
> +                               }
>                                 if (rc != 0) {
>                                         goto exit;
>                                 }
> @@ -1112,7 +1218,8 @@ static int avrule_list_to_cil(int indent, struct
> policydb *pdb, struct avrule *a
>                 names_destroy(&snames, &num_snames);
>                 names_destroy(&tnames, &num_tnames);
>
> -               if (avrule->specified == AVRULE_NEVERALLOW &&
> avrule->source_filename) {
> +               if ((avrule->specified &
> (AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW)) &&
> +                   avrule->source_filename) {
>                         cil_println(0, ";;* lme\n");
>                 }
>         }
> --
> 2.7.4
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a1144831e586ce0053dfba55c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+T25jZSB0aGlzIGdldHMgc3VibWl0dGVkIEkmIzM5O2xsIGRvIGEgcHVs
bCBvbiB1cHN0cmVhbSBpbnRvIEFPU1AuPC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3Rl
Ij48ZGl2IGRpcj0ibHRyIj5PbiBNb24sIE9jdCAzLCAyMDE2IGF0IDEyOjUyIFBNIEphbWVzIENh
cnRlciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmp3Y2FydDJAdHljaG8ubnNhLmdvdiI+andjYXJ0MkB0
eWNoby5uc2EuZ292PC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2Nj
IHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPkNoZWNrcG9saWN5IGhhcyBhbiBvcHRpb24gdG8gcHJv
ZHVjZSBDSUwgb3V0cHV0IGFuZCBpcyBkZXBlbmRlbnQgb248YnIgY2xhc3M9ImdtYWlsX21zZyI+
DQp0aGUgcG9saWN5ZGItdG8tQ0lMIGNvbnZlcnNpb24gaW4gbGlic2Vwb2wgZm9yIHRoYXQgb3B0
aW9uLiBBZGQ8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQpzdXBwb3J0IGZvciBjb252ZXJ0aW5nIGV4
dGVuZGVkIHBlcm1pc3Npb25zIHRvIENJTCBzbyB0aGF0IGNoZWNscG9saWN5PGJyIGNsYXNzPSJn
bWFpbF9tc2ciPg0KY2FuIGdlbmVyYXRlIENJTC48YnIgY2xhc3M9ImdtYWlsX21zZyI+DQo8YnIg
Y2xhc3M9ImdtYWlsX21zZyI+DQpTaWduZWQtb2ZmLWJ5OiBKYW1lcyBDYXJ0ZXIgJmx0OzxhIGhy
ZWY9Im1haWx0bzpqd2NhcnQyQHR5Y2hvLm5zYS5nb3YiIGNsYXNzPSJnbWFpbF9tc2ciIHRhcmdl
dD0iX2JsYW5rIj5qd2NhcnQyQHR5Y2hvLm5zYS5nb3Y8L2E+Jmd0OzxiciBjbGFzcz0iZ21haWxf
bXNnIj4NCi0tLTxiciBjbGFzcz0iZ21haWxfbXNnIj4NCsKgbGlic2Vwb2wvc3JjL21vZHVsZV90
b19jaWwuYyB8IDExNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KwqAxIGZpbGUgY2hhbmdlZCwgMTExIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KPGJyIGNsYXNzPSJnbWFp
bF9tc2ciPg0KZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9tb2R1bGVfdG9fY2lsLmMgYi9saWJz
ZXBvbC9zcmMvbW9kdWxlX3RvX2NpbC5jPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KaW5kZXggNTA4
YTg2MS4uNTU2ZDExZSAxMDA2NDQ8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQotLS0gYS9saWJzZXBv
bC9zcmMvbW9kdWxlX3RvX2NpbC5jPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KKysrIGIvbGlic2Vw
b2wvc3JjL21vZHVsZV90b19jaWwuYzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCkBAIC02MDksNiAr
NjA5LDEwMyBAQCBleGl0OjxiciBjbGFzcz0iZ21haWxfbXNnIj4NCsKgIMKgIMKgIMKgIHJldHVy
biByYzs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQrCoH08YnIgY2xhc3M9ImdtYWlsX21zZyI+DQo8
YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorI2RlZmluZSBuZXh0X2JpdF9pbl9yYW5nZShpLCBwKSAo
KGkgKyAxICZsdDsgc2l6ZW9mKHApKjgpICZhbXA7JmFtcDsgeHBlcm1fdGVzdCgoaSArIDEpLCBw
KSk8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK3N0YXRp
YyBpbnQgeHBlcm1zX3RvX2NpbChjb25zdCBhdl9leHRlbmRlZF9wZXJtc190ICp4cGVybXMpPGJy
IGNsYXNzPSJnbWFpbF9tc2ciPg0KK3s8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAg
wqB1aW50MTZfdCB2YWx1ZTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqB1aW50
MTZfdCBsb3dfYml0OzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoHVpbnQxNl90
IGxvd192YWx1ZTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqB1bnNpZ25lZCBp
bnQgYml0OzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoHVuc2lnbmVkIGludCBp
bl9yYW5nZSA9IDA7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgaW50IGZpcnN0
ID0gMTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8Kg
IMKgIMKgIMKgaWYgKCh4cGVybXMtJmd0O3NwZWNpZmllZCAhPSBBVlRBQl9YUEVSTVNfSU9DVExG
VU5DVElPTik8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAm
YW1wOyZhbXA7ICh4cGVybXMtJmd0O3NwZWNpZmllZCAhPSBBVlRBQl9YUEVSTVNfSU9DVExEUklW
RVIpKTxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
biAtMTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8Kg
IMKgIMKgIMKgZm9yIChiaXQgPSAwOyBiaXQgJmx0OyBzaXplb2YoeHBlcm1zLSZndDtwZXJtcykq
ODsgYml0KyspIHs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAoIXhwZXJtX3Rlc3QoYml0LCB4cGVybXMtJmd0O3Blcm1zKSk8YnIgY2xhc3M9ImdtYWls
X21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTs8YnIg
Y2xhc3M9ImdtYWlsX21zZyI+DQorPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgKGluX3JhbmdlICZhbXA7JmFtcDsgbmV4dF9iaXRfaW5fcmFuZ2UoYml0
LCB4cGVybXMtJmd0O3Blcm1zKSkgezxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIGNvbnRpbnVlIHVudGlsIGhpZ2ggdmFsdWUgZm91
bmQgKi88YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBjb250aW51ZTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB9IGVsc2UgaWYgKG5leHRfYml0X2luX3JhbmdlKGJpdCwgeHBlcm1zLSZndDtwZXJt
cykpIHs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAvKiBsb3cgdmFsdWUgKi88YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBsb3dfYml0ID0gYml0OzxiciBjbGFzcz0iZ21haWxf
bXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGluX3JhbmdlID0gMTs8
YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBjb250aW51ZTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB9PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KKzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmICghZmlyc3QpPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2lsX3ByaW50ZigmcXVvdDsgJnF1b3Q7
KTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbHNlPGJy
IGNsYXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Zmlyc3QgPSAwOzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCis8YnIgY2xhc3M9ImdtYWlsX21zZyI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoeHBlcm1zLSZndDtzcGVjaWZpZWQgJmFtcDsg
QVZUQUJfWFBFUk1TX0lPQ1RMRlVOQ1RJT04pIHs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWx1ZSA9IHhwZXJtcy0mZ3Q7ZHJpdmVy
Jmx0OyZsdDs4IHwgYml0OzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGxvd192YWx1ZSA9IHhwZXJtcy0mZ3Q7ZHJpdmVyJmx0OyZsdDs4
IHwgbG93X2JpdDs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoaW5fcmFuZ2UpIHs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjaWxfcHJpbnRmKCZx
dW90OyhyYW5nZSAweCVoeCAweCVoeCkmcXVvdDssIGxvd192YWx1ZSwgdmFsdWUpOzxiciBjbGFz
cz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGluX3JhbmdlID0gMDs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9IGVsc2UgezxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNpbF9wcmludGYo
JnF1b3Q7MHglaHgmcXVvdDssIHZhbHVlKTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlIGlmICh4cGVybXMtJmd0O3NwZWNpZmllZCAmYW1w
OyBBVlRBQl9YUEVSTVNfSU9DVExEUklWRVIpIHs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWx1ZSA9IGJpdCAmbHQ7Jmx0OyA4Ozxi
ciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGxvd192YWx1ZSA9IGxvd19iaXQgJmx0OyZsdDsgODs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoaW5fcmFuZ2UpIHs8YnIgY2xh
c3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBjaWxfcHJpbnRmKCZxdW90OyhyYW5nZSAweCVoeCAweCVoeCkmcXVvdDssIGxvd192
YWx1ZSwgKHVpbnQxNl90KSAodmFsdWV8MHhmZikpOzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGluX3JhbmdlID0g
MDs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9IGVsc2UgezxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNpbF9wcmludGYoJnF1b3Q7KHJhbmdlIDB4JWh4
IDB4JWh4KSZxdW90OywgdmFsdWUsICh1aW50MTZfdCkgKHZhbHVlfDB4ZmYpKTs8YnIgY2xhc3M9
ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyIGNs
YXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxiciBjbGFzcz0iZ21h
aWxfbXNnIj4NCivCoCDCoCDCoCDCoH08YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorPGJyIGNsYXNz
PSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgcmV0dXJuIDA7PGJyIGNsYXNzPSJnbWFpbF9tc2ci
Pg0KK308YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK3N0
YXRpYyBpbnQgYXZydWxleF90b19jaWwoaW50IGluZGVudCwgc3RydWN0IHBvbGljeWRiICpwZGIs
IHVpbnQzMl90IHR5cGUsIGNvbnN0IGNoYXIgKnNyYywgY29uc3QgY2hhciAqdGd0LCBjb25zdCBj
bGFzc19wZXJtX25vZGVfdCAqY2xhc3NwZXJtcywgY29uc3QgYXZfZXh0ZW5kZWRfcGVybXNfdCAq
eHBlcm1zKTxiciBjbGFzcz0iZ21haWxfbXNnIj4NCit7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0K
K8KgIMKgIMKgIMKgaW50IHJjID0gLTE7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKg
IMKgY29uc3QgY2hhciAqcnVsZTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqBj
b25zdCBzdHJ1Y3QgY2xhc3NfcGVybV9ub2RlICpjbGFzc3Blcm07PGJyIGNsYXNzPSJnbWFpbF9t
c2ciPg0KKzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoHN3aXRjaCAodHlwZSkg
ezxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoGNhc2UgQVZSVUxFX1hQRVJNU19B
TExPV0VEOjxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ1
bGUgPSAmcXVvdDthbGxvd3hwZXJtJnF1b3Q7OzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDC
oCDCoGNhc2UgQVZSVUxFX1hQRVJNU19BVURJVEFMTE9XOjxiciBjbGFzcz0iZ21haWxfbXNnIj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ1bGUgPSAmcXVvdDthdWRpdGFsbG93eHBlcm0mcXVv
dDs7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7
PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgY2FzZSBBVlJVTEVfWFBFUk1TX0RP
TlRBVURJVDo8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
dWxlID0gJnF1b3Q7ZG9udGF1ZGl0eHBlcm0mcXVvdDs7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8Kg
IMKgIMKgIMKgY2FzZSBBVlJVTEVfWFBFUk1TX05FVkVSQUxMT1c6PGJyIGNsYXNzPSJnbWFpbF9t
c2ciPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnVsZSA9ICZxdW90O25ldmVyYWxsb3d4cGVy
bSZxdW90Ozs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBi
cmVhazs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqBkZWZhdWx0OjxiciBjbGFz
cz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxvZ19lcnIoJnF1b3Q7VW5r
bm93biBhdnJ1bGUgeHBlcm0gdHlwZTogJWkmcXVvdDssIHR5cGUpOzxiciBjbGFzcz0iZ21haWxf
bXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJjID0gLTE7PGJyIGNsYXNzPSJnbWFpbF9t
c2ciPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBleGl0OzxiciBjbGFzcz0iZ21haWxf
bXNnIj4NCivCoCDCoCDCoCDCoH08YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorPGJyIGNsYXNzPSJn
bWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgZm9yIChjbGFzc3Blcm0gPSBjbGFzc3Blcm1zOyBjbGFz
c3Blcm0gIT0gTlVMTDsgY2xhc3NwZXJtID0gY2xhc3NwZXJtLSZndDtuZXh0KSB7PGJyIGNsYXNz
PSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2lsX2luZGVudChpbmRlbnQp
OzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNpbF9wcmlu
dGYoJnF1b3Q7KCVzICVzICVzICVzICglcyAoJnF1b3Q7LCBydWxlLCBzcmMsIHRndCw8YnIgY2xh
c3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
JnF1b3Q7aW9jdGwmcXVvdDssIHBkYi0mZ3Q7cF9jbGFzc192YWxfdG9fbmFtZVtjbGFzc3Blcm0t
Jmd0O3RjbGFzcyAtIDFdKTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB4cGVybXNfdG9fY2lsKHhwZXJtcyk7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY2lsX3ByaW50ZigmcXVvdDspKVxuJnF1b3Q7KTs8YnIgY2xh
c3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqB9PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KKzxi
ciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoHJldHVybiAwOzxiciBjbGFzcz0iZ21h
aWxfbXNnIj4NCis8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorZXhpdDo8YnIgY2xhc3M9ImdtYWls
X21zZyI+DQorwqAgwqAgwqAgwqByZXR1cm4gcmM7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK308
YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KwqBzdGF0aWMg
aW50IG51bV9kaWdpdHMoaW50IG4pPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KwqB7PGJyIGNsYXNz
PSJnbWFpbF9tc2ciPg0KwqAgwqAgwqAgwqAgaW50IG51bSA9IDE7PGJyIGNsYXNzPSJnbWFpbF9t
c2ciPg0KQEAgLTEwNzcsNyArMTE3NCw4IEBAIHN0YXRpYyBpbnQgYXZydWxlX2xpc3RfdG9fY2ls
KGludCBpbmRlbnQsIHN0cnVjdCBwb2xpY3lkYiAqcGRiLCBzdHJ1Y3QgYXZydWxlICphPGJyIGNs
YXNzPSJnbWFpbF9tc2ciPg0KwqAgwqAgwqAgwqAgc3RydWN0IHR5cGVfc2V0ICp0czs8YnIgY2xh
c3M9ImdtYWlsX21zZyI+DQo8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQrCoCDCoCDCoCDCoCBmb3Ig
KGF2cnVsZSA9IGF2cnVsZV9saXN0OyBhdnJ1bGUgIT0gTlVMTDsgYXZydWxlID0gYXZydWxlLSZn
dDtuZXh0KSB7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgKGF2cnVsZS0mZ3Q7c3BlY2lmaWVkID09IEFWUlVMRV9ORVZFUkFMTE9XICZhbXA7JmFtcDsg
YXZydWxlLSZndDtzb3VyY2VfZmlsZW5hbWUpIHs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoKGF2cnVsZS0mZ3Q7c3BlY2lmaWVkICZhbXA7IChBVlJV
TEVfTkVWRVJBTExPV3xBVlJVTEVfWFBFUk1TX05FVkVSQUxMT1cpKSAmYW1wOyZhbXA7PGJyIGNs
YXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYXZydWxlLSZn
dDtzb3VyY2VfZmlsZW5hbWUpIHs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjaWxfcHJpbnRsbigwLCAmcXVvdDs7OyogbG14ICVsdSAl
c1xuJnF1b3Q7LGF2cnVsZS0mZ3Q7c291cmNlX2xpbmUsIGF2cnVsZS0mZ3Q7c291cmNlX2ZpbGVu
YW1lKTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJy
IGNsYXNzPSJnbWFpbF9tc2ciPg0KPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KQEAgLTEwOTUsMTQg
KzExOTMsMjIgQEAgc3RhdGljIGludCBhdnJ1bGVfbGlzdF90b19jaWwoaW50IGluZGVudCwgc3Ry
dWN0IHBvbGljeWRiICpwZGIsIHN0cnVjdCBhdnJ1bGUgKmE8YnIgY2xhc3M9ImdtYWlsX21zZyI+
DQo8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmb3IgKHMg
PSAwOyBzICZsdDsgbnVtX3NuYW1lczsgcysrKSB7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZm9yICh0ID0gMDsgdCAmbHQ7IG51bV90
bmFtZXM7IHQrKykgezxiciBjbGFzcz0iZ21haWxfbXNnIj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJjID0gYXZydWxlX3RvX2NpbChpbmRlbnQsIHBk
YiwgYXZydWxlLSZndDtzcGVjaWZpZWQsIHNuYW1lc1tzXSwgdG5hbWVzW3RdLCBhdnJ1bGUtJmd0
O3Blcm1zKTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoYXZydWxlLSZndDtzcGVjaWZpZWQgJmFtcDsgQVZS
VUxFX1hQRVJNUykgezxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJjID0gYXZydWxleF90b19j
aWwoaW5kZW50LCBwZGIsIGF2cnVsZS0mZ3Q7c3BlY2lmaWVkLCBzbmFtZXNbc10sIHRuYW1lc1t0
XSwgYXZydWxlLSZndDtwZXJtcywgYXZydWxlLSZndDt4cGVybXMpOzxiciBjbGFzcz0iZ21haWxf
bXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0g
ZWxzZSB7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmMgPSBhdnJ1bGVfdG9fY2lsKGluZGVu
dCwgcGRiLCBhdnJ1bGUtJmd0O3NwZWNpZmllZCwgc25hbWVzW3NdLCB0bmFtZXNbdF0sIGF2cnVs
ZS0mZ3Q7cGVybXMpOzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnIgY2xhc3M9ImdtYWlsX21zZyI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAocmMgIT0gMCkg
ezxiciBjbGFzcz0iZ21haWxfbXNnIj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXhpdDs8YnIgY2xhc3M9ImdtYWlsX21z
ZyI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJy
IGNsYXNzPSJnbWFpbF9tc2ciPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fTxiciBjbGFzcz0iZ21haWxfbXNnIj4NCjxiciBjbGFzcz0iZ21haWxfbXNnIj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChhdnJ1bGUtJmd0O2ZsYWdzICZhbXA7IFJV
TEVfU0VMRikgezxiciBjbGFzcz0iZ21haWxfbXNnIj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJjID0gYXZydWxlX3RvX2NpbChpbmRlbnQsIHBkYiwg
YXZydWxlLSZndDtzcGVjaWZpZWQsIHNuYW1lc1tzXSwgJnF1b3Q7c2VsZiZxdW90OywgYXZydWxl
LSZndDtwZXJtcyk7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGF2cnVsZS0mZ3Q7c3BlY2lmaWVkICZhbXA7
IEFWUlVMRV9YUEVSTVMpIHs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYyA9IGF2cnVsZXhf
dG9fY2lsKGluZGVudCwgcGRiLCBhdnJ1bGUtJmd0O3NwZWNpZmllZCwgc25hbWVzW3NdLCAmcXVv
dDtzZWxmJnF1b3Q7LCBhdnJ1bGUtJmd0O3Blcm1zLCBhdnJ1bGUtJmd0O3hwZXJtcyk7PGJyIGNs
YXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfSBlbHNlIHs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYyA9IGF2cnVsZV90
b19jaWwoaW5kZW50LCBwZGIsIGF2cnVsZS0mZ3Q7c3BlY2lmaWVkLCBzbmFtZXNbc10sICZxdW90
O3NlbGYmcXVvdDssIGF2cnVsZS0mZ3Q7cGVybXMpOzxiciBjbGFzcz0iZ21haWxfbXNnIj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnIgY2xhc3M9
ImdtYWlsX21zZyI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpZiAocmMgIT0gMCkgezxiciBjbGFzcz0iZ21haWxfbXNnIj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXhpdDs8
YnIgY2xhc3M9ImdtYWlsX21zZyI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB9PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KQEAgLTExMTIsNyArMTIxOCw4
IEBAIHN0YXRpYyBpbnQgYXZydWxlX2xpc3RfdG9fY2lsKGludCBpbmRlbnQsIHN0cnVjdCBwb2xp
Y3lkYiAqcGRiLCBzdHJ1Y3QgYXZydWxlICphPGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgbmFtZXNfZGVzdHJveSgmYW1wO3NuYW1lcywgJmFtcDtudW1fc25h
bWVzKTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuYW1l
c19kZXN0cm95KCZhbXA7dG5hbWVzLCAmYW1wO251bV90bmFtZXMpOzxiciBjbGFzcz0iZ21haWxf
bXNnIj4NCjxiciBjbGFzcz0iZ21haWxfbXNnIj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChhdnJ1bGUtJmd0O3NwZWNpZmllZCA9PSBBVlJVTEVfTkVWRVJBTExPVyAmYW1wOyZhbXA7IGF2
cnVsZS0mZ3Q7c291cmNlX2ZpbGVuYW1lKSB7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgKChhdnJ1bGUtJmd0O3NwZWNpZmllZCAmYW1wOyAoQVZSVUxF
X05FVkVSQUxMT1d8QVZSVUxFX1hQRVJNU19ORVZFUkFMTE9XKSkgJmFtcDsmYW1wOzxiciBjbGFz
cz0iZ21haWxfbXNnIj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGF2cnVsZS0mZ3Q7
c291cmNlX2ZpbGVuYW1lKSB7PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgY2lsX3ByaW50bG4oMCwgJnF1b3Q7OzsqIGxtZVxuJnF1b3Q7
KTs8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyIGNs
YXNzPSJnbWFpbF9tc2ciPg0KwqAgwqAgwqAgwqAgfTxiciBjbGFzcz0iZ21haWxfbXNnIj4NCi0t
PGJyIGNsYXNzPSJnbWFpbF9tc2ciPg0KMi43LjQ8YnIgY2xhc3M9ImdtYWlsX21zZyI+DQo8YnIg
Y2xhc3M9ImdtYWlsX21zZyI+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXzxiciBjbGFzcz0iZ21haWxfbXNnIj4NClNlbGludXggbWFpbGluZyBsaXN0PGJy
IGNsYXNzPSJnbWFpbF9tc2ciPg0KPGEgaHJlZj0ibWFpbHRvOlNlbGludXhAdHljaG8ubnNhLmdv
diIgY2xhc3M9ImdtYWlsX21zZyIgdGFyZ2V0PSJfYmxhbmsiPlNlbGludXhAdHljaG8ubnNhLmdv
djwvYT48YnIgY2xhc3M9ImdtYWlsX21zZyI+DQpUbyB1bnN1YnNjcmliZSwgc2VuZCBlbWFpbCB0
byA8YSBocmVmPSJtYWlsdG86U2VsaW51eC1sZWF2ZUB0eWNoby5uc2EuZ292IiBjbGFzcz0iZ21h
aWxfbXNnIiB0YXJnZXQ9Il9ibGFuayI+U2VsaW51eC1sZWF2ZUB0eWNoby5uc2EuZ292PC9hPi48
YnIgY2xhc3M9ImdtYWlsX21zZyI+DQpUbyBnZXQgaGVscCwgc2VuZCBhbiBlbWFpbCBjb250YWlu
aW5nICZxdW90O2hlbHAmcXVvdDsgdG8gPGEgaHJlZj0ibWFpbHRvOlNlbGludXgtcmVxdWVzdEB0
eWNoby5uc2EuZ292IiBjbGFzcz0iZ21haWxfbXNnIiB0YXJnZXQ9Il9ibGFuayI+U2VsaW51eC1y
ZXF1ZXN0QHR5Y2hvLm5zYS5nb3Y8L2E+LjxiciBjbGFzcz0iZ21haWxfbXNnIj4NCjwvYmxvY2tx
dW90ZT48L2Rpdj4NCg==
--001a1144831e586ce0053dfba55c--
