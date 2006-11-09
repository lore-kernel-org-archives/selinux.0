Subject: Re: [PATCH] cron changes needed for MLS range checking (requires
	at least the libselinux patches)
From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1163084834.12241.293.camel@moss-spartans.epoch.ncsc.mil>
References: <1162936978.26574.20.camel@code.and.org>
	 <1162994668.3009.82.camel@moss-spartans.epoch.ncsc.mil>
	 <1163017959.29854.12.camel@code.and.org>
	 <1163019227.12241.178.camel@moss-spartans.epoch.ncsc.mil>
	 <1163023021.29854.15.camel@code.and.org>
	 <1163023990.12241.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1163029645.29854.20.camel@code.and.org>
	 <1163084834.12241.293.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TsZw39s7GUBHkaEipMRB"
Date: Thu, 09 Nov 2006 10:40:50 -0500
Message-Id: <1163086850.29854.26.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-TsZw39s7GUBHkaEipMRB
Content-Type: multipart/mixed; boundary="=-N86qcKJljDlZdSX6DqOK"


--=-N86qcKJljDlZdSX6DqOK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-09 at 10:07 -0500, Stephen Smalley wrote:
> On Wed, 2006-11-08 at 18:47 -0500, James Antill wrote:
> >  Attached is the latest cron patch.
>=20
> diff -rup vixie-cron-4.1-orig/security.c vixie-cron-4.1/security.c
> --- vixie-cron-4.1-orig/security.c	2006-11-02 22:28:04.000000000 -0500
> +++ vixie-cron-4.1/security.c	2006-11-08 17:35:27.000000000 -0500
> +static int=20
> +cron_authorize_range
> +(=20
> +	security_context_t scontext,
> +	security_context_t ucontext
> +)=09
> +{
> +#ifdef WITH_SELINUX
> +	struct av_decision avd;
> +	int retval;
> +        unsigned int bit =3D CONTEXT__CONTAINS;
> +	/*
> +	 * Since crontab files are not directly executed,
> +	 * so crond must ensure that any user specified range
> +	 * is allowed by the default users range.  It performs
> +         * an entrypoint permission check for this purpose.
> +	 */
>=20
> Still not accurate.  This check is quite different in purpose and
> rationale than the entrypoint check; it has nothing to do with the fact
> that crontab files are not directly executed.  It is just a check of
> whether the user-specified level falls within the seusers-specified
> range for that Linux user.

 Ok. I've changed the comment again.

> +static int cron_change_selinux_range( user *u,
> +                                      security_context_t ucontext )
> +{
> +	if ( is_selinux_enabled() <=3D 0 )
> +		return 0;
> +
> +	if ( u->scontext =3D=3D 0L )
> +	{
> +		if (security_getenforce() > 0)=20
> +		{
> +			log_it( u->name, getpid(),=20
> +				"NULL security context for user",=20
> +				""
> +			      );
> +			return -1;
> +		}else
> +		{
> +			log_it( u->name, getpid(),=20
> +				"NULL security context for user, "
> +				"but SELinux in permissive mode, continuing",
> +				""
> +				);
> +			return 0;
> +		}
>=20
> Another case where I don't understand why enforcing/permissive makes any
> difference.

 Because without enforcing mode we just ignore the problem and continue,
with it we error out. I think this is more of a theoretical assert type
problem anyway, but still.

> Still refers to SELINUX_ROLE_TYPE in the log message.

 Fixed.

> +	if ( setexeccon(ucontext) < 0 )=20
> +	{
> +		if (security_getenforce() > 0)=20
> +		{
> +			syslog(LOG_ERR,
> +			       "CRON (%s) ERROR:"
> +			       "Could not set exec context to %s for user",=20
> +			       u->name, (char*)ucontext
> +			      );
> +
> +			return -1;
> +		}
>=20
> Likely want to log something in the else case too so you don't just
> silently proceed under crond's own context.

 Done.

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-N86qcKJljDlZdSX6DqOK
Content-Disposition: inline; filename=vixie-cron-4.1-_60-SELinux-contains-range.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=vixie-cron-4.1-_60-SELinux-contains-range.patch;
	charset=UTF-8

T25seSBpbiB2aXhpZS1jcm9uLTQuMTogY3JvbmQucGFtLnBhbWRfY3JvbmQNCmRpZmYgLXJ1cCB2
aXhpZS1jcm9uLTQuMS1vcmlnL3NlY3VyaXR5LmMgdml4aWUtY3Jvbi00LjEvc2VjdXJpdHkuYw0K
LS0tIHZpeGllLWNyb24tNC4xLW9yaWcvc2VjdXJpdHkuYwkyMDA2LTExLTAyIDIyOjI4OjA0LjAw
MDAwMDAwMCAtMDUwMA0KKysrIHZpeGllLWNyb24tNC4xL3NlY3VyaXR5LmMJMjAwNi0xMS0wOSAx
MDozODowOC4wMDAwMDAwMDAgLTA1MDANCkBAIC0yMyw2ICsyMyw3IEBADQogDQogI2lmZGVmIFdJ
VEhfU0VMSU5VWA0KICNpbmNsdWRlIDxzZWxpbnV4L3NlbGludXguaD4NCisjaW5jbHVkZSA8c2Vs
aW51eC9jb250ZXh0Lmg+DQogI2luY2x1ZGUgPHNlbGludXgvZmxhc2suaD4NCiAjaW5jbHVkZSA8
c2VsaW51eC9hdl9wZXJtaXNzaW9ucy5oPg0KICNpbmNsdWRlIDxzZWxpbnV4L2dldF9jb250ZXh0
X2xpc3QuaD4NCkBAIC0zMCw2ICszMSwxMiBAQA0KIA0KIHN0YXRpYyBjaGFyICoqIGJ1aWxkX2Vu
dihjaGFyICoqY3JvbmVudik7DQogDQorI2lmZGVmIFdJVEhfU0VMSU5VWA0KK3N0YXRpYyBpbnQg
Y3Jvbl9jaGFuZ2Vfc2VsaW51eF9yYW5nZSggdXNlciAqdSwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNlY3VyaXR5X2NvbnRleHRfdCB1Y29udGV4dCApOw0KK3N0YXRp
YyBpbnQgY3Jvbl9nZXRfam9iX3JhbmdlKCB1c2VyICp1LCBzZWN1cml0eV9jb250ZXh0X3QgKnVj
b250ZXh0cCwgY2hhciAqKmpvYmVudiApOw0KKyNlbmRpZg0KKw0KIGludCBjcm9uX3NldF9qb2Jf
c2VjdXJpdHlfY29udGV4dCggZW50cnkgKmUsIHVzZXIgKnUsIGNoYXIgKioqam9iZW52ICkNCiB7
DQogICAgIHRpbWVfdCBtaW51dGVseV90aW1lID0gMDsNCkBAIC01OCw5ICs2NSw5IEBAIGludCBj
cm9uX3NldF9qb2Jfc2VjdXJpdHlfY29udGV4dCggZW50cnkNCiAgICAgICogd2UnbGwgbm90IGJl
IHBlcm1pdHRlZCB0byByZWFkIHRoZSBjcm9uIHNwb29sIGRpcmVjdG9yeSA6LSkNCiAgICAgICov
DQogDQotICAgIHNlY3VyaXR5X2NvbnRleHRfdCBzY29udGV4dD0wLCBmaWxlX2NvbnRleHQ9MDsg
DQorICAgIHNlY3VyaXR5X2NvbnRleHRfdCB1Y29udGV4dD0wOyANCiANCi0gICAgaWYgKCBjcm9u
X2dldF9qb2JfY29udGV4dCh1LCAmc2NvbnRleHQsICZmaWxlX2NvbnRleHQsICpqb2JlbnYpIDwg
T0sgKQ0KKyAgICBpZiAoIGNyb25fZ2V0X2pvYl9yYW5nZSh1LCAmdWNvbnRleHQsICpqb2JlbnYp
IDwgT0sgKQ0KICAgICB7DQogCXN5c2xvZyhMT0dfRVJSLCAiQ1JPTiAoJXMpIEVSUk9SOiBmYWls
ZWQgdG8gZ2V0IHNlbGludXggY29udGV4dDogJXMiLCANCiAJICAgICAgIGUtPnB3ZC0+cHdfbmFt
ZSwgc3RyZXJyb3IoZXJybm8pDQpAQCAtNzksMTYgKzg2LDE2IEBAIGludCBjcm9uX3NldF9qb2Jf
c2VjdXJpdHlfY29udGV4dCggZW50cnkNCiAgICAgfQkNCiANCiAjaWYgV0lUSF9TRUxJTlVYDQot
ICAgIGlmICggY3Jvbl9jaGFuZ2Vfc2VsaW51eF9jb250ZXh0KCB1LCBzY29udGV4dCwgZmlsZV9j
b250ZXh0ICkgIT0gMCApDQorICAgIGlmIChjcm9uX2NoYW5nZV9zZWxpbnV4X3JhbmdlKHUsIHVj
b250ZXh0KSAhPSAwKQ0KICAgICB7DQogICAgICAgICBzeXNsb2coTE9HX0lORk8sIkNST04gKCVz
KSBFUlJPUjogZmFpbGVkIHRvIGNoYW5nZSBTRUxpbnV4IGNvbnRleHQiLCANCiAJICAgICAgIGUt
PnB3ZC0+cHdfbmFtZSk7DQotCWlmICggZmlsZV9jb250ZXh0ICkNCi0JCWZyZWVjb24oZmlsZV9j
b250ZXh0KTsNCisJaWYgKCB1Y29udGV4dCApDQorCQlmcmVlY29uKHVjb250ZXh0KTsNCiAJcmV0
dXJuIC0xOw0KICAgICB9DQotICAgIGlmICggZmlsZV9jb250ZXh0ICkNCi0JZnJlZWNvbihmaWxl
X2NvbnRleHQpOw0KKyAgICBpZiAoIHVjb250ZXh0ICkNCisJZnJlZWNvbih1Y29udGV4dCk7DQog
I2VuZGlmDQogDQogICAgIGxvZ19jbG9zZSgpOw0KQEAgLTIwMSw2ICsyMDgsNyBAQCBjcm9uX2F1
dGhvcml6ZV9jb250ZXh0DQogI2lmZGVmIFdJVEhfU0VMSU5VWA0KIAlzdHJ1Y3QgYXZfZGVjaXNp
b24gYXZkOw0KIAlpbnQgcmV0dmFsOw0KKyAgICAgICAgdW5zaWduZWQgaW50IGJpdCA9IEZJTEVf
X0VOVFJZUE9JTlQ7DQogCS8qDQogCSAqIFNpbmNlIGNyb250YWIgZmlsZXMgYXJlIG5vdCBkaXJl
Y3RseSBleGVjdXRlZCwNCiAJICogY3JvbmQgbXVzdCBlbnN1cmUgdGhhdCB0aGUgY3JvbnRhYiBm
aWxlIGhhcw0KQEAgLTIwOCwxMyArMjE2LDM1IEBAIGNyb25fYXV0aG9yaXplX2NvbnRleHQNCiAJ
ICogdGhlIHVzZXIgY3JvbiBqb2IuICBJdCBwZXJmb3JtcyBhbiBlbnRyeXBvaW50DQogCSAqIHBl
cm1pc3Npb24gY2hlY2sgZm9yIHRoaXMgcHVycG9zZS4NCiAJICovDQotCXJldHZhbCA9IHNlY3Vy
aXR5X2NvbXB1dGVfYXYoc2NvbnRleHQsDQotCQkJCSAgICAgZmlsZV9jb250ZXh0LA0KLQkJCQkg
ICAgIFNFQ0NMQVNTX0ZJTEUsDQotCQkJCSAgICAgRklMRV9fRU5UUllQT0lOVCwNCi0JCQkJICAg
ICAmYXZkKTsNCisJcmV0dmFsID0gc2VjdXJpdHlfY29tcHV0ZV9hdihzY29udGV4dCwgZmlsZV9j
b250ZXh0LA0KKwkJCQkgICAgIFNFQ0NMQVNTX0ZJTEUsIGJpdCwgJmF2ZCk7DQorDQorCWlmIChy
ZXR2YWwgfHwgKChiaXQgJiBhdmQuYWxsb3dlZCkgIT0gYml0KSkNCisJCXJldHVybiAwOw0KKyNl
bmRpZg0KKwlyZXR1cm4gMTsNCit9DQorDQorc3RhdGljIGludCANCitjcm9uX2F1dGhvcml6ZV9y
YW5nZQ0KKyggDQorCXNlY3VyaXR5X2NvbnRleHRfdCBzY29udGV4dCwNCisJc2VjdXJpdHlfY29u
dGV4dF90IHVjb250ZXh0DQorKQkNCit7DQorI2lmZGVmIFdJVEhfU0VMSU5VWA0KKwlzdHJ1Y3Qg
YXZfZGVjaXNpb24gYXZkOw0KKwlpbnQgcmV0dmFsOw0KKyAgICAgICAgdW5zaWduZWQgaW50IGJp
dCA9IENPTlRFWFRfX0NPTlRBSU5TOw0KKwkvKg0KKwkgKiBTaW5jZSBjcm9udGFiIGZpbGVzIGFy
ZSBub3QgZGlyZWN0bHkgZXhlY3V0ZWQsDQorCSAqIHNvIGNyb25kIG11c3QgZW5zdXJlIHRoYXQg
YW55IHVzZXIgc3BlY2lmaWVkIHJhbmdlDQorCSAqIGZhbGxzIHdpdGhpbiB0aGUgc2V1c2Vycy1z
cGVjaWZpZWQgcmFuZ2UgZm9yIHRoYXQgTGludXggdXNlci4NCisJICovDQorCXJldHZhbCA9IHNl
Y3VyaXR5X2NvbXB1dGVfYXYoc2NvbnRleHQsIHVjb250ZXh0LA0KKwkJCQkgICAgIFNFQ0NMQVNT
X0NPTlRFWFQsIGJpdCwgJmF2ZCk7DQogDQotCWlmIChyZXR2YWwgfHwgKChGSUxFX19FTlRSWVBP
SU5UICYgYXZkLmFsbG93ZWQpICE9IEZJTEVfX0VOVFJZUE9JTlQpKQ0KKwlpZiAocmV0dmFsIHx8
ICgoYml0ICYgYXZkLmFsbG93ZWQpICE9IGJpdCkpDQogCQlyZXR1cm4gMDsNCiAjZW5kaWYNCiAJ
cmV0dXJuIDE7DQpAQCAtMjY1LDYgKzI5NSw3MCBAQCBpbnQgY3Jvbl9nZXRfam9iX2NvbnRleHQo
IHVzZXIgKnUsIHZvaWQgDQogCXJldHVybiAwOw0KIH0NCiANCisjaWYgV0lUSF9TRUxJTlVYDQor
LyogYWx3YXlzIHVzZXMgdS0+c2NvbnRleHQgYXMgdGhlIGRlZmF1bHQgcHJvY2VzcyBjb250ZXh0
LCB0aGVuIGNoYW5nZXMgdGhlDQorICAgbGV2ZWwsIGFuZCByZXR1bnMgaXQgaW4gdWNvbnRleHRw
IChvciBOVUxMIG90aGVyd2lzZSkgKi8NCitzdGF0aWMgaW50IGNyb25fZ2V0X2pvYl9yYW5nZSgg
dXNlciAqdSwgc2VjdXJpdHlfY29udGV4dF90ICp1Y29udGV4dHAsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNoYXIgKipqb2JlbnYgKQ0KK3sNCisJY2hhciAqcmFuZ2U7DQorDQor
CWlmICggaXNfc2VsaW51eF9lbmFibGVkKCkgPD0gMCApDQorCQlyZXR1cm4gMDsNCisJaWYgKCB1
Y29udGV4dHAgPT0gMEwgKQ0KKwkJcmV0dXJuIC0xOw0KKw0KKwkqdWNvbnRleHRwID0gMEw7DQor
DQorCWlmICggKHJhbmdlID0gZW52X2dldCgiTUxTX0xFVkVMIixqb2JlbnYpKSAhPSAwTCApDQor
CXsNCisJCWNoYXIgY3JvbnRhYltNQVhfRk5BTUVdOw0KKyAgICAgICAgICAgICAgICBjb250ZXh0
X3QgY2NvbjsNCisNCisJCWlmICggc3RyY21wKHUtPm5hbWUsIipzeXN0ZW0qIikgPT0gMCApDQor
CQkJc3RybmNweShjcm9udGFiLCB1LT50YWJuYW1lLCBNQVhfRk5BTUUpOw0KKwkJZWxzZQ0KKwkJ
CXNucHJpbnRmKGNyb250YWIsIE1BWF9GTkFNRSwgIiVzLyVzIiwgQ1JPTkRJUiwgdS0+dGFibmFt
ZSk7DQorICAgICAgICAgICAgICAgIA0KKyAgICAgICAgICAgICAgICBpZiAoIShjY29uID0gY29u
dGV4dF9uZXcodS0+c2NvbnRleHQpKSkNCisgICAgICAgICAgICAgICAgew0KKwkJCWxvZ19pdCh1
LT5uYW1lLCANCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2V0cGlkKCksICJjb250
ZXh0X25ldyBGQUlMRUQgZm9yIE1MU19MRVZFTCIsIA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByYW5nZSk7DQorICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KKyAg
ICAgICAgICAgICAgICB9ICAgICAgICAgICAgICAgICAgDQorDQorICAgICAgICAgICAgICAgIGlm
IChjb250ZXh0X3JhbmdlX3NldChjY29uLCByYW5nZSkpDQorICAgICAgICAgICAgICAgIHsNCisg
ICAgICAgICAgICAgICAgICAgICAgICBsb2dfaXQodS0+bmFtZSwgDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGdldHBpZCgpLCAiY29udGV4dF9yYW5nZV9zZXQgRkFJTEVEIGZvciBN
TFNfTEVWRUwiLCANCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFuZ2UpOw0KKyAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCisgICAgICAgICAgICAgICAgfQ0KKw0K
KyAgICAgICAgICAgICAgICBpZiAoISgqdWNvbnRleHQgPSBjb250ZXh0X3N0cihjY29uKSkpDQor
ICAgICAgICAgICAgICAgIHsNCisgICAgICAgICAgICAgICAgICAgICAgICBsb2dfaXQodS0+bmFt
ZSwgDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdldHBpZCgpLCAiY29udGV4dF9z
dHIgRkFJTEVEIGZvciBNTFNfTEVWRUwiLCANCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmFuZ2UpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCisgICAgICAg
ICAgICAgICAgfQ0KKw0KKyAgICAgICAgICAgICAgICBpZiAoISgqdWNvbnRleHRwID0gc3RyZHVw
KCp1Y29udGV4dHApKSkNCisgICAgICAgICAgICAgICAgew0KKyAgICAgICAgICAgICAgICAgICAg
ICAgIGxvZ19pdCh1LT5uYW1lLCANCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2V0
cGlkKCksICJzdHJkdXAgRkFJTEVEIGZvciBNTFNfTEVWRUwiLCANCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmFuZ2UpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
MTsNCisgICAgICAgICAgICAgICAgfQ0KKw0KKyAgICAgICAgICAgICAgICBjb250ZXh0X2ZyZWUo
Y2Nvbik7DQorCX0NCisNCisJcmV0dXJuIDA7DQorfQ0KKyNlbmRpZg0KKw0KIGludCBjcm9uX2No
YW5nZV9zZWxpbnV4X2NvbnRleHQoIHVzZXIgKnUsIHZvaWQgKnNjb250ZXh0LCB2b2lkICpmaWxl
X2NvbnRleHQgKQ0KIHsNCiAjaWZkZWYgV0lUSF9TRUxJTlVYDQpAQCAtMzMyLDYgKzQyNiw4NCBA
QCBpbnQgY3Jvbl9jaGFuZ2Vfc2VsaW51eF9jb250ZXh0KCB1c2VyICp1DQogCXJldHVybiAwOw0K
IH0NCiANCisjaWZkZWYgV0lUSF9TRUxJTlVYDQorc3RhdGljIGludCBjcm9uX2NoYW5nZV9zZWxp
bnV4X3JhbmdlKCB1c2VyICp1LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2VjdXJpdHlfY29udGV4dF90IHVjb250ZXh0ICkNCit7DQorCWlmICggaXNfc2VsaW51eF9l
bmFibGVkKCkgPD0gMCApDQorCQlyZXR1cm4gMDsNCisNCisJaWYgKCB1LT5zY29udGV4dCA9PSAw
TCApDQorCXsNCisJCWlmIChzZWN1cml0eV9nZXRlbmZvcmNlKCkgPiAwKSANCisJCXsNCisJCQls
b2dfaXQoIHUtPm5hbWUsIGdldHBpZCgpLCANCisJCQkJIk5VTEwgc2VjdXJpdHkgY29udGV4dCBm
b3IgdXNlciIsIA0KKwkJCQkiIg0KKwkJCSAgICAgICk7DQorCQkJcmV0dXJuIC0xOw0KKwkJfWVs
c2UNCisJCXsNCisJCQlsb2dfaXQoIHUtPm5hbWUsIGdldHBpZCgpLCANCisJCQkJIk5VTEwgc2Vj
dXJpdHkgY29udGV4dCBmb3IgdXNlciwgIg0KKwkJCQkiYnV0IFNFTGludXggaW4gcGVybWlzc2l2
ZSBtb2RlLCBjb250aW51aW5nIiwNCisJCQkJIiINCisJCQkJKTsNCisJCQlyZXR1cm4gMDsNCisJ
CX0NCisJfQ0KKwkNCisJaWYgKCB1Y29udGV4dCAmJiBzdHJjbXAodS0+c2NvbnRleHQsIHVjb250
ZXh0KSApDQorCXsJCQ0KKyAgICAgICAgICAgICAgICBpZiAoICEgY3Jvbl9hdXRob3JpemVfcmFu
Z2UoIHUtPnNjb250ZXh0LCB1Y29udGV4dCApKQ0KKwkJew0KKwkJCWlmICggc2VjdXJpdHlfZ2V0
ZW5mb3JjZSgpID4gMCApIA0KKwkJCXsNCisJCQkJc3lzbG9nKExPR19FUlIsDQorCQkJCSAgICAg
ICAiQ1JPTiAoJXMpIEVSUk9SOiINCisJCQkJICAgICAgICJVbmF1dGhvcml6ZWQgcmFuZ2UgaW4g
TUxTX0xFVkVMICVzIGZvciB1c2VyIiwgDQorCQkJCSAgICAgICB1LT5uYW1lLCAoY2hhciopdWNv
bnRleHQNCisJCQkJICAgICAgKTsNCisJCQkJcmV0dXJuIC0xOw0KKwkJCX0gZWxzZQ0KKwkJCXsN
CisJCQkJc3lzbG9nKExPR19JTkZPLA0KKwkJCQkgICAgICAgIkNST04gKCVzKSBXQVJOSU5HOiIN
CisJCQkJICAgICAgICJVbmF1dGhvcml6ZWQgcmFuZ2UgaW4gTUxTX0xFVkVMICVzIGZvciB1c2Vy
LCINCisJCQkJICAgICAgICIgYnV0IFNFTGludXggaW4gcGVybWlzc2l2ZSBtb2RlLCBjb250aW51
aW5nIiwgDQorCQkJCSAgICAgICB1LT5uYW1lLCAoY2hhciopdWNvbnRleHQNCisJCQkJICAgICAg
KTsNCisJCQl9DQorCQl9DQorCX0gDQorDQorCWlmICggc2V0ZXhlY2Nvbih1Y29udGV4dCkgPCAw
ICkgDQorCXsNCisJCWlmIChzZWN1cml0eV9nZXRlbmZvcmNlKCkgPiAwKSANCisJCXsNCisJCQlz
eXNsb2coTE9HX0VSUiwNCisJCQkgICAgICAgIkNST04gKCVzKSBFUlJPUjoiDQorCQkJICAgICAg
ICJDb3VsZCBub3Qgc2V0IGV4ZWMgY29udGV4dCB0byAlcyBmb3IgdXNlciIsIA0KKwkJCSAgICAg
ICB1LT5uYW1lLCAoY2hhciopdWNvbnRleHQNCisJCQkgICAgICApOw0KKw0KKwkJCXJldHVybiAt
MTsNCisJCX0gZWxzZQ0KKwkJew0KKwkJCXN5c2xvZyhMT0dfRVJSLA0KKwkJCSAgICAgICAiQ1JP
TiAoJXMpIEVSUk9SOiINCisJCQkgICAgICAgIkNvdWxkIG5vdCBzZXQgZXhlYyBjb250ZXh0IHRv
ICVzIGZvciB1c2VyLCAiDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIgYnV0IFNF
TGludXggaW4gcGVybWlzc2l2ZSBtb2RlLCBjb250aW51aW5nIiwgDQorCQkJICAgICAgIHUtPm5h
bWUsIChjaGFyKil1Y29udGV4dA0KKwkJCSAgICAgICk7DQorDQorCQkJcmV0dXJuIDA7DQorCQl9
DQorCX0NCisJcmV0dXJuIDA7DQorfQ0KKyNlbmRpZg0KKw0KIGludCBnZXRfc2VjdXJpdHlfY29u
dGV4dCggY29uc3QgY2hhciAqbmFtZSwgDQogCQkJICBpbnQgY3JvbnRhYl9mZCwgDQogCQkJICBz
ZWN1cml0eV9jb250ZXh0X3QgKnJjb250ZXh0LCANCk9ubHkgaW4gdml4aWUtY3Jvbi00LjE6IHNl
Y3VyaXR5LmN+DQpPbmx5IGluIHZpeGllLWNyb24tNC4xOiBzZWN1cml0eS5jLnNlY3VyaXR5DQpP
bmx5IGluIHZpeGllLWNyb24tNC4xOiBzZWN1cml0eS5jLnNlbGludXgtY29udGFpbnMtcmFuZ2UN
Cg==


--=-N86qcKJljDlZdSX6DqOK--

--=-TsZw39s7GUBHkaEipMRB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFU0wC11eXTEMrxtQRAsguAJ90aB98uSUd1ftjzu5cVkWFNvie5QCgoyHW
ywHeV0J0pmxBwPF9rs7xj5g=
=94rz
-----END PGP SIGNATURE-----

--=-TsZw39s7GUBHkaEipMRB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
