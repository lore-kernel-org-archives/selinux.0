Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t48LYLUw025487
 for <selinux@tycho.nsa.gov>; Fri, 8 May 2015 17:34:21 -0400
Received: by obbkp3 with SMTP id kp3so64744531obb.3
 for <selinux@tycho.nsa.gov>; Fri, 08 May 2015 14:34:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <554CD0C5.3050007@tycho.nsa.gov>
References: <1431096669-14399-1-git-send-email-jwcart2@tycho.nsa.gov>
 <554CCEC3.6070102@tycho.nsa.gov> <554CD0C5.3050007@tycho.nsa.gov>
Date: Fri, 8 May 2015 14:34:18 -0700
Message-ID: <CABXk95BNA-hZnOGHaTZSa=CN0ONUoBQ5qrKpuvA5NCBiNRF=kw@mail.gmail.com>
Subject: Re: [PATCH v4] Replace fmemopen() with internal function in libsepol.
From: Jeffrey Vander Stoep <jeffv@google.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c2af906f2918051598ca0c
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c2af906f2918051598ca0c
Content-Type: text/plain; charset=UTF-8

Thank you!

Up for review on AOSP: https://android-review.googlesource.com/#/c/149966/

On Fri, May 8, 2015 at 8:05 AM, James Carter <jwcart2@tycho.nsa.gov> wrote:

> Applied.
>
>
> On 05/08/2015 10:57 AM, Stephen Smalley wrote:
>
>> On 05/08/2015 10:51 AM, James Carter wrote:
>>
>>> Created a new function, get_line(), to replace the use of fmemopen()
>>> and getline() in module_to_cil.c since fmemopen() is not available
>>> on Darwin.
>>>
>>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>>>
>>
>> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>>
>>  ---
>>>   libsepol/src/module_to_cil.c | 122
>>> +++++++++++++++++++++++--------------------
>>>   1 file changed, 65 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
>>> index d1d2efe..8d16d3e 100644
>>> --- a/libsepol/src/module_to_cil.c
>>> +++ b/libsepol/src/module_to_cil.c
>>> @@ -107,6 +107,44 @@ static void cil_println(int indent, const char
>>> *fmt, ...)
>>>         }
>>>   }
>>>
>>> +static int get_line(char **start, char *end, char **line)
>>> +{
>>> +       int rc = 1;
>>> +       char *p = NULL;
>>> +       size_t len = 0;
>>> +
>>> +       *line = NULL;
>>> +
>>> +       for (p = *start; p < end && isspace(*p); p++);
>>> +
>>> +       *start = p;
>>> +
>>> +       for (len = 0; p < end && *p != '\n' && *p != '\0'; p++, len++);
>>> +
>>> +       if (len == 0) {
>>> +               rc = 0;
>>> +               goto exit;
>>> +       }
>>> +
>>> +       *line = malloc(len+1);
>>> +       if (*line == NULL) {
>>> +               log_err("Out of memory");
>>> +               rc = -1;
>>> +               goto exit;
>>> +       }
>>> +
>>> +       memcpy(*line, *start, len);
>>> +       (*line)[len] = '\0';
>>> +
>>> +       *start = p;
>>> +
>>> +       return rc;
>>> +
>>> +exit:
>>> +       *start = NULL;
>>> +       return rc;
>>> +}
>>> +
>>>   struct map_args {
>>>         struct policydb *pdb;
>>>         struct avrule_block *block;
>>> @@ -2907,14 +2945,11 @@ exit:
>>>   static int seusers_to_cil(struct sepol_module_package *mod_pkg)
>>>   {
>>>         int rc = -1;
>>> -       FILE *fp = NULL;
>>>         char *seusers = sepol_module_package_get_seusers(mod_pkg);
>>>         size_t seusers_len =
>>> sepol_module_package_get_seusers_len(mod_pkg);
>>> -       size_t len = 0;
>>> +       char *cur = seusers;
>>> +       char *end = seusers + seusers_len;
>>>         char *line = NULL;
>>> -       ssize_t line_len = 0;
>>> -       char *buf = NULL;
>>> -
>>>         char *user = NULL;
>>>         char *seuser = NULL;
>>>         char *level = NULL;
>>> @@ -2924,19 +2959,12 @@ static int seusers_to_cil(struct
>>> sepol_module_package *mod_pkg)
>>>                 return 0;
>>>         }
>>>
>>> -       fp = fmemopen(seusers, seusers_len, "r");
>>> -
>>> -       while ((line_len = getline(&line, &len, fp)) != -1) {
>>> -               buf = line;
>>> -               buf[line_len - 1] = '\0';
>>> -               while (*buf && isspace(buf[0])) {
>>> -                       buf++;
>>> -               }
>>> -               if (buf[0] == '#' || buf[0] == '\0') {
>>> +       while ((rc = get_line(&cur, end, &line)) > 0) {
>>> +               if (line[0] == '#') {
>>>                         continue;
>>>                 }
>>>
>>> -               matched = sscanf(buf, "%m[^:]:%m[^:]:%ms", &user,
>>> &seuser, &level);
>>> +               matched = sscanf(line, "%m[^:]:%m[^:]:%ms", &user,
>>> &seuser, &level);
>>>
>>>                 if (matched < 2 || matched > 3) {
>>>                         log_err("Invalid seuser line: %s", line);
>>> @@ -2964,20 +2992,17 @@ static int seusers_to_cil(struct
>>> sepol_module_package *mod_pkg)
>>>                 free(user);
>>>                 free(seuser);
>>>                 free(level);
>>> +               free(line);
>>>                 user = seuser = level = NULL;
>>>         }
>>> -       if (ferror(fp)) {
>>> +
>>> +       if (rc == -1) {
>>>                 cil_printf("Failed to read seusers\n");
>>> -               rc = -1;
>>>                 goto exit;
>>>         }
>>>
>>>         rc = 0;
>>> -
>>>   exit:
>>> -       if (fp != NULL) {
>>> -               fclose(fp);
>>> -       }
>>>         free(line);
>>>         free(user);
>>>         free(seuser);
>>> @@ -3002,10 +3027,9 @@ static int user_extra_to_cil(struct
>>> sepol_module_package *mod_pkg)
>>>         int rc = -1;
>>>         char *userx = sepol_module_package_get_user_extra(mod_pkg);
>>>         size_t userx_len =
>>> sepol_module_package_get_user_extra_len(mod_pkg);
>>> -       FILE *fp = NULL;
>>> -       size_t len = 0;
>>> -       char *line = NULL;
>>> -       ssize_t line_len = 0;
>>> +       char *cur = userx;
>>> +       char *end = userx + userx_len;
>>> +       char *line;
>>>         int matched;
>>>         char *user = NULL;
>>>         char *prefix = NULL;
>>> @@ -3014,10 +3038,10 @@ static int user_extra_to_cil(struct
>>> sepol_module_package *mod_pkg)
>>>                 return 0;
>>>         }
>>>
>>> -       fp = fmemopen(userx, userx_len, "r");
>>> -
>>> -       while ((line_len = getline(&line, &len, fp)) != -1) {
>>> -               line[line_len - 1] = '\0';
>>> +       while ((rc = get_line(&cur, end, &line)) > 0) {
>>> +               if (line[0] == '#') {
>>> +                       continue;
>>> +               }
>>>
>>>                 matched = sscanf(line, "user %ms prefix %m[^;];", &user,
>>> &prefix);
>>>                 if (matched != 2) {
>>> @@ -3029,20 +3053,17 @@ static int user_extra_to_cil(struct
>>> sepol_module_package *mod_pkg)
>>>                 cil_println(0, "(userprefix %s %s)", user, prefix);
>>>                 free(user);
>>>                 free(prefix);
>>> -               user = prefix = NULL;
>>> +               free(line);
>>> +               user = prefix = line = NULL;
>>>         }
>>>
>>> -       if (ferror(fp)) {
>>> +       if (rc == -1) {
>>>                 cil_printf("Failed to read user_extra\n");
>>> -               rc = -1;
>>>                 goto exit;
>>>         }
>>>
>>>         rc = 0;
>>>   exit:
>>> -       if (fp != NULL) {
>>> -               fclose(fp);
>>> -       }
>>>         free(line);
>>>         free(user);
>>>         free(prefix);
>>> @@ -3055,11 +3076,9 @@ static int file_contexts_to_cil(struct
>>> sepol_module_package *mod_pkg)
>>>         int rc = -1;
>>>         char *fc = sepol_module_package_get_file_contexts(mod_pkg);
>>>         size_t fc_len =
>>> sepol_module_package_get_file_contexts_len(mod_pkg);
>>> -       FILE *fp = NULL;
>>> -       size_t len = 0;
>>> +       char *cur = fc;
>>> +       char *end = fc + fc_len;
>>>         char *line = NULL;
>>> -       char *buf = NULL;
>>> -       ssize_t line_len = 0;
>>>         int matched;
>>>         char *regex = NULL;
>>>         char *mode = NULL;
>>> @@ -3070,20 +3089,12 @@ static int file_contexts_to_cil(struct
>>> sepol_module_package *mod_pkg)
>>>                 return 0;
>>>         }
>>>
>>> -       fp = fmemopen(fc, fc_len, "r");
>>> -       while ((line_len = getline(&line, &len, fp)) != -1) {
>>> -               buf = line;
>>> -               if (buf[line_len - 1] == '\n') {
>>> -                       buf[line_len - 1] = '\0';
>>> -               }
>>> -               while (*buf && isspace(buf[0])) {
>>> -                       buf++;
>>> -               }
>>> -               if (buf[0] == '#' || buf[0] == '\0') {
>>> +       while ((rc = get_line(&cur, end, &line)) > 0) {
>>> +               if (line[0] == '#') {
>>>                         continue;
>>>                 }
>>>
>>> -               matched = sscanf(buf, "%ms %ms %ms", &regex, &mode,
>>> &context);
>>> +               matched = sscanf(line, "%ms %ms %ms", &regex, &mode,
>>> &context);
>>>                 if (matched < 2 || matched > 3) {
>>>                         rc = -1;
>>>                         log_err("Invalid file context line: %s", line);
>>> @@ -3130,12 +3141,12 @@ static int file_contexts_to_cil(struct
>>> sepol_module_package *mod_pkg)
>>>                 free(regex);
>>>                 free(mode);
>>>                 free(context);
>>> -               regex = mode = context = NULL;
>>> +               free(line);
>>> +               regex = mode = context = line = NULL;
>>>         }
>>>
>>> -       if (ferror(fp)) {
>>> -               cil_printf("Failed to read user_extra\n");
>>> -               rc = -1;
>>> +       if (rc == -1) {
>>> +               cil_printf("Failed to read file_contexts_to_cil\n");
>>>                 goto exit;
>>>         }
>>>
>>> @@ -3145,9 +3156,6 @@ exit:
>>>         free(regex);
>>>         free(mode);
>>>         free(context);
>>> -       if (fp != NULL) {
>>> -               fclose(fp);
>>> -       }
>>>
>>>         return rc;
>>>   }
>>>
>>>
>>
>>
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a11c2af906f2918051598ca0c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+VGhhbmsgeW91ITxkaXY+PGJyPjwvZGl2PjxkaXY+VXAgZm9yIHJldmll
dyBvbiBBT1NQOsKgPGEgaHJlZj0iaHR0cHM6Ly9hbmRyb2lkLXJldmlldy5nb29nbGVzb3VyY2Uu
Y29tLyMvYy8xNDk5NjYvIj5odHRwczovL2FuZHJvaWQtcmV2aWV3Lmdvb2dsZXNvdXJjZS5jb20v
Iy9jLzE0OTk2Ni88L2E+PC9kaXY+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48
ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gRnJpLCBNYXkgOCwgMjAxNSBhdCA4OjA1IEFNLCBK
YW1lcyBDYXJ0ZXIgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86andjYXJ0MkB0
eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+andjYXJ0MkB0eWNoby5uc2EuZ292PC9hPiZn
dDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxl
ZnQ6MWV4Ij5BcHBsaWVkLjxkaXYgY2xhc3M9IkhPRW5aYiI+PGRpdiBjbGFzcz0iaDUiPjxicj4N
Cjxicj4NCk9uIDA1LzA4LzIwMTUgMTA6NTcgQU0sIFN0ZXBoZW4gU21hbGxleSB3cm90ZTo8YnI+
DQo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhl
eDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCk9uIDA1LzA4
LzIwMTUgMTA6NTEgQU0sIEphbWVzIENhcnRlciB3cm90ZTo8YnI+DQo8YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHgg
I2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCkNyZWF0ZWQgYSBuZXcgZnVuY3Rpb24sIGdl
dF9saW5lKCksIHRvIHJlcGxhY2UgdGhlIHVzZSBvZiBmbWVtb3BlbigpPGJyPg0KYW5kIGdldGxp
bmUoKSBpbiBtb2R1bGVfdG9fY2lsLmMgc2luY2UgZm1lbW9wZW4oKSBpcyBub3QgYXZhaWxhYmxl
PGJyPg0Kb24gRGFyd2luLjxicj4NCjxicj4NClNpZ25lZC1vZmYtYnk6IEphbWVzIENhcnRlciAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmp3Y2FydDJAdHljaG8ubnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsi
Pmp3Y2FydDJAdHljaG8ubnNhLmdvdjwvYT4mZ3Q7PGJyPg0KPC9ibG9ja3F1b3RlPg0KPGJyPg0K
QWNrZWQtYnk6wqAgU3RlcGhlbiBTbWFsbGV5ICZsdDs8YSBocmVmPSJtYWlsdG86c2RzQHR5Y2hv
Lm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5zZHNAdHljaG8ubnNhLmdvdjwvYT4mZ3Q7PGJyPg0K
PGJyPg0KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAw
IC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQotLS08
YnI+DQrCoCBsaWJzZXBvbC9zcmMvbW9kdWxlX3RvX2NpbC5jIHwgMTIyICsrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+DQrCoCAxIGZpbGUgY2hhbmdlZCwgNjUg
aW5zZXJ0aW9ucygrKSwgNTcgZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2xp
YnNlcG9sL3NyYy9tb2R1bGVfdG9fY2lsLmMgYi9saWJzZXBvbC9zcmMvbW9kdWxlX3RvX2NpbC5j
PGJyPg0KaW5kZXggZDFkMmVmZS4uOGQxNmQzZSAxMDA2NDQ8YnI+DQotLS0gYS9saWJzZXBvbC9z
cmMvbW9kdWxlX3RvX2NpbC5jPGJyPg0KKysrIGIvbGlic2Vwb2wvc3JjL21vZHVsZV90b19jaWwu
Yzxicj4NCkBAIC0xMDcsNiArMTA3LDQ0IEBAIHN0YXRpYyB2b2lkIGNpbF9wcmludGxuKGludCBp
bmRlbnQsIGNvbnN0IGNoYXIgKmZtdCwgLi4uKTxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQrCoCB9
PGJyPg0KPGJyPg0KK3N0YXRpYyBpbnQgZ2V0X2xpbmUoY2hhciAqKnN0YXJ0LCBjaGFyICplbmQs
IGNoYXIgKipsaW5lKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgaW50IHJjID0gMTs8YnI+DQor
wqAgwqAgwqAgwqBjaGFyICpwID0gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqBzaXplX3QgbGVuID0g
MDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgKmxpbmUgPSBOVUxMOzxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqBmb3IgKHAgPSAqc3RhcnQ7IHAgJmx0OyBlbmQgJmFtcDsmYW1wOyBpc3NwYWNlKCpw
KTsgcCsrKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgKnN0YXJ0ID0gcDs8YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgZm9yIChsZW4gPSAwOyBwICZsdDsgZW5kICZhbXA7JmFtcDsgKnAgIT0gJiMz
OTtcbiYjMzk7ICZhbXA7JmFtcDsgKnAgIT0gJiMzOTtcMCYjMzk7OyBwKyssIGxlbisrKTs8YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGxlbiA9PSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmMgPSAwOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXhpdDs8
YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCpsaW5lID0gbWFsbG9j
KGxlbisxKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAoKmxpbmUgPT0gTlVMTCkgezxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGxvZ19lcnIoJnF1b3Q7T3V0IG9mIG1lbW9yeSZxdW90Oyk7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmMgPSAtMTs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBnb3RvIGV4aXQ7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqBtZW1jcHkoKmxpbmUsICpzdGFydCwgbGVuKTs8YnI+DQorwqAgwqAgwqAgwqAoKmxpbmUp
W2xlbl0gPSAmIzM5O1wwJiMzOTs7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCpzdGFydCA9IHA7
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiByYzs8YnI+DQorPGJyPg0KK2V4aXQ6PGJy
Pg0KK8KgIMKgIMKgIMKgKnN0YXJ0ID0gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gcmM7
PGJyPg0KK308YnI+DQorPGJyPg0KwqAgc3RydWN0IG1hcF9hcmdzIHs8YnI+DQrCoCDCoCDCoCDC
oCBzdHJ1Y3QgcG9saWN5ZGIgKnBkYjs8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgYXZydWxlX2Js
b2NrICpibG9jazs8YnI+DQpAQCAtMjkwNywxNCArMjk0NSwxMSBAQCBleGl0Ojxicj4NCsKgIHN0
YXRpYyBpbnQgc2V1c2Vyc190b19jaWwoc3RydWN0IHNlcG9sX21vZHVsZV9wYWNrYWdlICptb2Rf
cGtnKTxicj4NCsKgIHs8YnI+DQrCoCDCoCDCoCDCoCBpbnQgcmMgPSAtMTs8YnI+DQotwqAgwqAg
wqAgwqBGSUxFICpmcCA9IE5VTEw7PGJyPg0KwqAgwqAgwqAgwqAgY2hhciAqc2V1c2VycyA9IHNl
cG9sX21vZHVsZV9wYWNrYWdlX2dldF9zZXVzZXJzKG1vZF9wa2cpOzxicj4NCsKgIMKgIMKgIMKg
IHNpemVfdCBzZXVzZXJzX2xlbiA9IHNlcG9sX21vZHVsZV9wYWNrYWdlX2dldF9zZXVzZXJzX2xl
bihtb2RfcGtnKTs8YnI+DQotwqAgwqAgwqAgwqBzaXplX3QgbGVuID0gMDs8YnI+DQorwqAgwqAg
wqAgwqBjaGFyICpjdXIgPSBzZXVzZXJzOzxicj4NCivCoCDCoCDCoCDCoGNoYXIgKmVuZCA9IHNl
dXNlcnMgKyBzZXVzZXJzX2xlbjs8YnI+DQrCoCDCoCDCoCDCoCBjaGFyICpsaW5lID0gTlVMTDs8
YnI+DQotwqAgwqAgwqAgwqBzc2l6ZV90IGxpbmVfbGVuID0gMDs8YnI+DQotwqAgwqAgwqAgwqBj
aGFyICpidWYgPSBOVUxMOzxicj4NCi08YnI+DQrCoCDCoCDCoCDCoCBjaGFyICp1c2VyID0gTlVM
TDs8YnI+DQrCoCDCoCDCoCDCoCBjaGFyICpzZXVzZXIgPSBOVUxMOzxicj4NCsKgIMKgIMKgIMKg
IGNoYXIgKmxldmVsID0gTlVMTDs8YnI+DQpAQCAtMjkyNCwxOSArMjk1OSwxMiBAQCBzdGF0aWMg
aW50IHNldXNlcnNfdG9fY2lsKHN0cnVjdCBzZXBvbF9tb2R1bGVfcGFja2FnZSAqbW9kX3BrZyk8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gMDs8YnI+DQrCoCDCoCDCoCDCoCB9
PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgZnAgPSBmbWVtb3BlbihzZXVzZXJzLCBzZXVzZXJzX2xl
biwgJnF1b3Q7ciZxdW90Oyk7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoHdoaWxlICgobGluZV9s
ZW4gPSBnZXRsaW5lKCZhbXA7bGluZSwgJmFtcDtsZW4sIGZwKSkgIT0gLTEpIHs8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBidWYgPSBsaW5lOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGJ1ZltsaW5lX2xlbiAtIDFdID0gJiMzOTtcMCYjMzk7Ozxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHdoaWxlICgqYnVmICZhbXA7JmFtcDsgaXNzcGFjZShidWZbMF0pKSB7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnVmKys7PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChidWZbMF0g
PT0gJiMzOTsjJiMzOTsgfHwgYnVmWzBdID09ICYjMzk7XDAmIzM5Oykgezxicj4NCivCoCDCoCDC
oCDCoHdoaWxlICgocmMgPSBnZXRfbGluZSgmYW1wO2N1ciwgZW5kLCAmYW1wO2xpbmUpKSAmZ3Q7
IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobGluZVswXSA9PSAmIzM5OyMm
IzM5Oykgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVl
Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBtYXRjaGVkID0gc3NjYW5mKGJ1ZiwgJnF1b3Q7JW1bXjpdOiVtW146XTolbXMm
cXVvdDssICZhbXA7dXNlciwgJmFtcDtzZXVzZXIsICZhbXA7bGV2ZWwpOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoG1hdGNoZWQgPSBzc2NhbmYobGluZSwgJnF1b3Q7JW1bXjpdOiVtW146
XTolbXMmcXVvdDssICZhbXA7dXNlciwgJmFtcDtzZXVzZXIsICZhbXA7bGV2ZWwpOzxicj4NCjxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChtYXRjaGVkICZsdDsgMiB8fCBtYXRjaGVk
ICZndDsgMykgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxvZ19l
cnIoJnF1b3Q7SW52YWxpZCBzZXVzZXIgbGluZTogJXMmcXVvdDssIGxpbmUpOzxicj4NCkBAIC0y
OTY0LDIwICsyOTkyLDE3IEBAIHN0YXRpYyBpbnQgc2V1c2Vyc190b19jaWwoc3RydWN0IHNlcG9s
X21vZHVsZV9wYWNrYWdlICptb2RfcGtnKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZy
ZWUodXNlcik7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnJlZShzZXVzZXIpOzxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZyZWUobGV2ZWwpOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGZyZWUobGluZSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdXNlciA9
IHNldXNlciA9IGxldmVsID0gTlVMTDs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KLcKgIMKgIMKg
IMKgaWYgKGZlcnJvcihmcCkpIHs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJjID09IC0x
KSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2lsX3ByaW50ZigmcXVvdDtGYWlsZWQg
dG8gcmVhZCBzZXVzZXJzXG4mcXVvdDspOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJj
ID0gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBleGl0Ozxicj4NCsKgIMKg
IMKgIMKgIH08YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCByYyA9IDA7PGJyPg0KLTxicj4NCsKgIGV4
aXQ6PGJyPg0KLcKgIMKgIMKgIMKgaWYgKGZwICE9IE5VTEwpIHs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBmY2xvc2UoZnApOzxicj4NCi3CoCDCoCDCoCDCoH08YnI+DQrCoCDCoCDCoCDC
oCBmcmVlKGxpbmUpOzxicj4NCsKgIMKgIMKgIMKgIGZyZWUodXNlcik7PGJyPg0KwqAgwqAgwqAg
wqAgZnJlZShzZXVzZXIpOzxicj4NCkBAIC0zMDAyLDEwICszMDI3LDkgQEAgc3RhdGljIGludCB1
c2VyX2V4dHJhX3RvX2NpbChzdHJ1Y3Qgc2Vwb2xfbW9kdWxlX3BhY2thZ2UgKm1vZF9wa2cpPGJy
Pg0KwqAgwqAgwqAgwqAgaW50IHJjID0gLTE7PGJyPg0KwqAgwqAgwqAgwqAgY2hhciAqdXNlcngg
PSBzZXBvbF9tb2R1bGVfcGFja2FnZV9nZXRfdXNlcl9leHRyYShtb2RfcGtnKTs8YnI+DQrCoCDC
oCDCoCDCoCBzaXplX3QgdXNlcnhfbGVuID0gc2Vwb2xfbW9kdWxlX3BhY2thZ2VfZ2V0X3VzZXJf
ZXh0cmFfbGVuKG1vZF9wa2cpOzxicj4NCi3CoCDCoCDCoCDCoEZJTEUgKmZwID0gTlVMTDs8YnI+
DQotwqAgwqAgwqAgwqBzaXplX3QgbGVuID0gMDs8YnI+DQotwqAgwqAgwqAgwqBjaGFyICpsaW5l
ID0gTlVMTDs8YnI+DQotwqAgwqAgwqAgwqBzc2l6ZV90IGxpbmVfbGVuID0gMDs8YnI+DQorwqAg
wqAgwqAgwqBjaGFyICpjdXIgPSB1c2VyeDs8YnI+DQorwqAgwqAgwqAgwqBjaGFyICplbmQgPSB1
c2VyeCArIHVzZXJ4X2xlbjs8YnI+DQorwqAgwqAgwqAgwqBjaGFyICpsaW5lOzxicj4NCsKgIMKg
IMKgIMKgIGludCBtYXRjaGVkOzxicj4NCsKgIMKgIMKgIMKgIGNoYXIgKnVzZXIgPSBOVUxMOzxi
cj4NCsKgIMKgIMKgIMKgIGNoYXIgKnByZWZpeCA9IE5VTEw7PGJyPg0KQEAgLTMwMTQsMTAgKzMw
MzgsMTAgQEAgc3RhdGljIGludCB1c2VyX2V4dHJhX3RvX2NpbChzdHJ1Y3Qgc2Vwb2xfbW9kdWxl
X3BhY2thZ2UgKm1vZF9wa2cpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIDA7
PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCi3CoCDCoCDCoCDCoGZwID0gZm1lbW9wZW4o
dXNlcngsIHVzZXJ4X2xlbiwgJnF1b3Q7ciZxdW90Oyk7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDC
oHdoaWxlICgobGluZV9sZW4gPSBnZXRsaW5lKCZhbXA7bGluZSwgJmFtcDtsZW4sIGZwKSkgIT0g
LTEpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBsaW5lW2xpbmVfbGVuIC0gMV0gPSAm
IzM5O1wwJiMzOTs7PGJyPg0KK8KgIMKgIMKgIMKgd2hpbGUgKChyYyA9IGdldF9saW5lKCZhbXA7
Y3VyLCBlbmQsICZhbXA7bGluZSkpICZndDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIChsaW5lWzBdID09ICYjMzk7IyYjMzk7KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgY29udGludWU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG1hdGNoZWQgPSBzc2NhbmYobGlu
ZSwgJnF1b3Q7dXNlciAlbXMgcHJlZml4ICVtW147XTsmcXVvdDssICZhbXA7dXNlciwgJmFtcDtw
cmVmaXgpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChtYXRjaGVkICE9IDIpIHs8
YnI+DQpAQCAtMzAyOSwyMCArMzA1MywxNyBAQCBzdGF0aWMgaW50IHVzZXJfZXh0cmFfdG9fY2ls
KHN0cnVjdCBzZXBvbF9tb2R1bGVfcGFja2FnZSAqbW9kX3BrZyk8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBjaWxfcHJpbnRsbigwLCAmcXVvdDsodXNlcnByZWZpeCAlcyAlcykmcXVvdDss
IHVzZXIsIHByZWZpeCk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnJlZSh1c2VyKTs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcmVlKHByZWZpeCk7PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgdXNlciA9IHByZWZpeCA9IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZnJlZShsaW5lKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1c2VyID0g
cHJlZml4ID0gbGluZSA9IE5VTEw7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCi3CoCDC
oCDCoCDCoGlmIChmZXJyb3IoZnApKSB7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJjID09IC0xKSB7
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2lsX3ByaW50ZigmcXVvdDtGYWlsZWQgdG8g
cmVhZCB1c2VyX2V4dHJhXG4mcXVvdDspOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJj
ID0gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBleGl0Ozxicj4NCsKgIMKg
IMKgIMKgIH08YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCByYyA9IDA7PGJyPg0KwqAgZXhpdDo8YnI+
DQotwqAgwqAgwqAgwqBpZiAoZnAgIT0gTlVMTCkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGZjbG9zZShmcCk7PGJyPg0KLcKgIMKgIMKgIMKgfTxicj4NCsKgIMKgIMKgIMKgIGZyZWUo
bGluZSk7PGJyPg0KwqAgwqAgwqAgwqAgZnJlZSh1c2VyKTs8YnI+DQrCoCDCoCDCoCDCoCBmcmVl
KHByZWZpeCk7PGJyPg0KQEAgLTMwNTUsMTEgKzMwNzYsOSBAQCBzdGF0aWMgaW50IGZpbGVfY29u
dGV4dHNfdG9fY2lsKHN0cnVjdCBzZXBvbF9tb2R1bGVfcGFja2FnZSAqbW9kX3BrZyk8YnI+DQrC
oCDCoCDCoCDCoCBpbnQgcmMgPSAtMTs8YnI+DQrCoCDCoCDCoCDCoCBjaGFyICpmYyA9IHNlcG9s
X21vZHVsZV9wYWNrYWdlX2dldF9maWxlX2NvbnRleHRzKG1vZF9wa2cpOzxicj4NCsKgIMKgIMKg
IMKgIHNpemVfdCBmY19sZW4gPSBzZXBvbF9tb2R1bGVfcGFja2FnZV9nZXRfZmlsZV9jb250ZXh0
c19sZW4obW9kX3BrZyk7PGJyPg0KLcKgIMKgIMKgIMKgRklMRSAqZnAgPSBOVUxMOzxicj4NCi3C
oCDCoCDCoCDCoHNpemVfdCBsZW4gPSAwOzxicj4NCivCoCDCoCDCoCDCoGNoYXIgKmN1ciA9IGZj
Ozxicj4NCivCoCDCoCDCoCDCoGNoYXIgKmVuZCA9IGZjICsgZmNfbGVuOzxicj4NCsKgIMKgIMKg
IMKgIGNoYXIgKmxpbmUgPSBOVUxMOzxicj4NCi3CoCDCoCDCoCDCoGNoYXIgKmJ1ZiA9IE5VTEw7
PGJyPg0KLcKgIMKgIMKgIMKgc3NpemVfdCBsaW5lX2xlbiA9IDA7PGJyPg0KwqAgwqAgwqAgwqAg
aW50IG1hdGNoZWQ7PGJyPg0KwqAgwqAgwqAgwqAgY2hhciAqcmVnZXggPSBOVUxMOzxicj4NCsKg
IMKgIMKgIMKgIGNoYXIgKm1vZGUgPSBOVUxMOzxicj4NCkBAIC0zMDcwLDIwICszMDg5LDEyIEBA
IHN0YXRpYyBpbnQgZmlsZV9jb250ZXh0c190b19jaWwoc3RydWN0IHNlcG9sX21vZHVsZV9wYWNr
YWdlICptb2RfcGtnKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAwOzxicj4N
CsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQotwqAgwqAgwqAgwqBmcCA9IGZtZW1vcGVuKGZjLCBm
Y19sZW4sICZxdW90O3ImcXVvdDspOzxicj4NCi3CoCDCoCDCoCDCoHdoaWxlICgobGluZV9sZW4g
PSBnZXRsaW5lKCZhbXA7bGluZSwgJmFtcDtsZW4sIGZwKSkgIT0gLTEpIHs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBidWYgPSBsaW5lOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChidWZbbGluZV9sZW4gLSAxXSA9PSAmIzM5O1xuJiMzOTspIHs8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBidWZbbGluZV9sZW4gLSAxXSA9ICYjMzk7XDAmIzM5
Ozs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgd2hpbGUgKCpidWYgJmFtcDsmYW1wOyBpc3NwYWNlKGJ1ZlswXSkpIHs8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBidWYrKzs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB9PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGJ1ZlswXSA9PSAm
IzM5OyMmIzM5OyB8fCBidWZbMF0gPT0gJiMzOTtcMCYjMzk7KSB7PGJyPg0KK8KgIMKgIMKgIMKg
d2hpbGUgKChyYyA9IGdldF9saW5lKCZhbXA7Y3VyLCBlbmQsICZhbXA7bGluZSkpICZndDsgMCkg
ezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChsaW5lWzBdID09ICYjMzk7IyYjMzk7
KSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29udGludWU7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoG1hdGNoZWQgPSBzc2NhbmYoYnVmLCAmcXVvdDslbXMgJW1zICVtcyZxdW90OywgJmFt
cDtyZWdleCwgJmFtcDttb2RlLCAmYW1wO2NvbnRleHQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoG1hdGNoZWQgPSBzc2NhbmYobGluZSwgJnF1b3Q7JW1zICVtcyAlbXMmcXVvdDssICZh
bXA7cmVnZXgsICZhbXA7bW9kZSwgJmFtcDtjb250ZXh0KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBpZiAobWF0Y2hlZCAmbHQ7IDIgfHwgbWF0Y2hlZCAmZ3Q7IDMpIHs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYyA9IC0xOzxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxvZ19lcnIoJnF1b3Q7SW52YWxpZCBmaWxlIGNvbnRl
eHQgbGluZTogJXMmcXVvdDssIGxpbmUpOzxicj4NCkBAIC0zMTMwLDEyICszMTQxLDEyIEBAIHN0
YXRpYyBpbnQgZmlsZV9jb250ZXh0c190b19jaWwoc3RydWN0IHNlcG9sX21vZHVsZV9wYWNrYWdl
ICptb2RfcGtnKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZyZWUocmVnZXgpOzxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZyZWUobW9kZSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZnJlZShjb250ZXh0KTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZWdl
eCA9IG1vZGUgPSBjb250ZXh0ID0gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBm
cmVlKGxpbmUpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlZ2V4ID0gbW9kZSA9IGNv
bnRleHQgPSBsaW5lID0gTlVMTDs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KLcKgIMKg
IMKgIMKgaWYgKGZlcnJvcihmcCkpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjaWxf
cHJpbnRmKCZxdW90O0ZhaWxlZCB0byByZWFkIHVzZXJfZXh0cmFcbiZxdW90Oyk7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmMgPSAtMTs8YnI+DQorwqAgwqAgwqAgwqBpZiAocmMgPT0g
LTEpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjaWxfcHJpbnRmKCZxdW90O0ZhaWxl
ZCB0byByZWFkIGZpbGVfY29udGV4dHNfdG9fY2lsXG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGdvdG8gZXhpdDs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KQEAg
LTMxNDUsOSArMzE1Niw2IEBAIGV4aXQ6PGJyPg0KwqAgwqAgwqAgwqAgZnJlZShyZWdleCk7PGJy
Pg0KwqAgwqAgwqAgwqAgZnJlZShtb2RlKTs8YnI+DQrCoCDCoCDCoCDCoCBmcmVlKGNvbnRleHQp
Ozxicj4NCi3CoCDCoCDCoCDCoGlmIChmcCAhPSBOVUxMKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZmNsb3NlKGZwKTs8YnI+DQotwqAgwqAgwqAgwqB9PGJyPg0KPGJyPg0KwqAgwqAg
wqAgwqAgcmV0dXJuIHJjOzxicj4NCsKgIH08YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+DQo8YnI+
DQo8YnI+DQo8L2Jsb2NrcXVvdGU+DQo8YnI+DQo8YnI+PC9kaXY+PC9kaXY+PHNwYW4gY2xhc3M9
IkhPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPg0KLS0gPGJyPg0KSmFtZXMgQ2FydGVyICZs
dDs8YSBocmVmPSJtYWlsdG86andjYXJ0MkB0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+
andjYXJ0MkB0eWNoby5uc2EuZ292PC9hPiZndDs8YnI+DQpOYXRpb25hbCBTZWN1cml0eSBBZ2Vu
Y3k8L2ZvbnQ+PC9zcGFuPjxkaXYgY2xhc3M9IkhPRW5aYiI+PGRpdiBjbGFzcz0iaDUiPjxicj4N
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPg0KU2Vs
aW51eCBtYWlsaW5nIGxpc3Q8YnI+DQo8YSBocmVmPSJtYWlsdG86U2VsaW51eEB0eWNoby5uc2Eu
Z292IiB0YXJnZXQ9Il9ibGFuayI+U2VsaW51eEB0eWNoby5uc2EuZ292PC9hPjxicj4NClRvIHVu
c3Vic2NyaWJlLCBzZW5kIGVtYWlsIHRvIDxhIGhyZWY9Im1haWx0bzpTZWxpbnV4LWxlYXZlQHR5
Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5TZWxpbnV4LWxlYXZlQHR5Y2hvLm5zYS5nb3Y8
L2E+Ljxicj4NClRvIGdldCBoZWxwLCBzZW5kIGFuIGVtYWlsIGNvbnRhaW5pbmcgJnF1b3Q7aGVs
cCZxdW90OyB0byA8YSBocmVmPSJtYWlsdG86U2VsaW51eC1yZXF1ZXN0QHR5Y2hvLm5zYS5nb3Yi
IHRhcmdldD0iX2JsYW5rIj5TZWxpbnV4LXJlcXVlc3RAdHljaG8ubnNhLmdvdjwvYT4uPGJyPg0K
PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4NCg==
--001a11c2af906f2918051598ca0c--
