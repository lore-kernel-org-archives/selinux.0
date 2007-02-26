Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1Q1pMm4002219
	for <selinux@tycho.nsa.gov>; Sun, 25 Feb 2007 20:51:22 -0500
Received: from msp1.hitachi-sk.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1Q1qen1029613
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 01:52:41 GMT
Received: from vs1.hitachi-sk.co.jp ([133.108.252.215])
	by msp1.hitachi-sk.co.jp (unknown) with ESMTP id l1Q1qe4Z016717
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 10:52:40 +0900
Date: Mon, 26 Feb 2007 10:52:49 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: ynakam@hitachisoft.jp, busybox@busybox.net, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/8] busybox -- SELinux option support for coreutils:
 ver3
Message-Id: <20070226105249.98bf6e55.ynakam@hitachisoft.jp>
In-Reply-To: <200702241601.14214.vda.linux@googlemail.com>
References: <20070223174747.4ced9178.ynakam@hitachisoft.jp>
	<200702241601.14214.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__26_Feb_2007_10_52_49_+0900_x=rkSGZQ+uSFYXUD"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Mon__26_Feb_2007_10_52_49_+0900_x=rkSGZQ+uSFYXUD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Feb 2007 16:01:14 +0100
Denis Vlasenko  wrote:
> On Friday 23 February 2007 09:47, Yuichi Nakamura wrote:
> > [2/8] busybox-coreutils-02-copy.v3.patch
> >   - cp: -Z,-c option support. 
> >       -c option: security context is preserved during file copy.
> >   - mv 
> >     In SELinux, it is recommended to preserve security context 
> >     when file is moved. By this patch, file context is preserved 
> >     during file move.
> >   - install
> >     When file is copied by install, security context of installed file 
> >     becomes different from value configured in file_contexts file.
> >     By this patch, security context is set according to file_contexts file.
> >     -Z option: security context can be set during file copy.
> > 
> > Signed-off-by: Yuichi Nakamura <ynakam@hitachisoft.jp>
> 
>         FILEUTILS_MAKE_SOFTLINK = 0x40,
> +#if ENABLE_SELINUX
> +       FILEUTILS_PRESERVE_SECURITY_CONTEXT = 0x80,
> +       FILEUTILS_SET_SECURITY_CONTEXT = 0x100
> +#endif
>  };
> -#define FILEUTILS_CP_OPTSTR "pdRfils"
> 
> +#define FILEUTILS_CP_OPTSTR "pdRfils" USE_SELINUX("c\b")
> +
>  extern const char *applet_name;
> ...
>         { "owner",               0, NULL, 'o' },
> +#if ENABLE_SELINUX
> +       { "context",             1, NULL, 'Z' },
> +       { "preserve_context",    0, NULL, '\b'},
> +       { "preserve-context",    0, NULL, '\b'},
> +
> +#endif
>         { 0, 0, 0, 0 }
> 
> Hmmm... we typically use high ascii values for this kind
> of "fake" option chars. Example in wget.c:
> 
>         static const struct option wget_long_options[] = {
> ...
>                 { "user-agent",       required_argument, NULL, 'U' },
>                 { "passive-ftp",      no_argument, NULL, 0xff },
>                 { "header",           required_argument, NULL, 0xfe },
>                 { 0, 0, 0, 0 }
>         };
>         applet_long_options = wget_long_options;
> #endif
>         opt_complementary = "-1" USE_FEATURE_WGET_LONG_OPTIONS(":\xfe::");
>         opt = getopt32(argc, argv, "cqO:P:Y:U:",   ...);
> 
> Notice that in this example we avoid giving "strange" chars to getopt32
> *at all*, preventing our applets from having "hidden" options a-la
> "wget $'-\xff' ftp://kernel.org/".
> 
> Can you avoid passing '\b' to getopt32 in install etc?
Fixed. Using "0xff" instead.


> 
> 
> +                       bb_error_msg("warning: ignoring --preserve-context. "
> +                                        "The kernel is not SELinux-enabled.\n" );
> 
> bb_error_msg don't need trailing '\n'.
> I already mentioned that in the previous round of review.
> 
> 
> +#if ENABLE_SELINUX
> +       if ((flags & FILEUTILS_PRESERVE_SECURITY_CONTEXT) && is_selinux_enabled() > 0){
> +               security_context_t con;
> +               if (lgetfilecon (source, &con) >= 0){
> +                       if (setfscreatecon(con) < 0) {
> +                               bb_perror_msg ("cannot set setfscreatecon %s", con);
> +                               freecon(con);
> +                               return -1;
> +                       }
> +               }else{
> +                       if( errno == ENOTSUP || errno == ENODATA ) {
> +                               setfscreatecon(NULL);
> +                       } else {
> +                               bb_perror_msg ("cannot  lgetfilecon %s", source);
> +                               return -1;
> +                       }
> +               }
> +       }
> +#endif
> 
> Usage of whitespace is very different from the rest of busybox code here.
Fixed. And I found other bad usage of white space, and fixed.

> 
> --
> vda

Attached is revised patch(v4).

--
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
SELinux Policy Editor: http://seedit.sourceforge.net/


--Multipart=_Mon__26_Feb_2007_10_52_49_+0900_x=rkSGZQ+uSFYXUD
Content-Type: application/octet-stream;
 name="busybox-coreutils-copy-02.v4.patch"
Content-Disposition: attachment;
 filename="busybox-coreutils-copy-02.v4.patch"
Content-Transfer-Encoding: base64

SW5kZXg6IGluY2x1ZGUvbGliYmIuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBpbmNsdWRlL2xpYmJiLmgJKHJl
dmlzaW9uIDE3OTYxKQorKysgaW5jbHVkZS9saWJiYi5oCSh3b3JraW5nIGNvcHkpCkBAIC03Mzcs
NyArNzM3LDcgQEAKIHVpbnQzMl90ICpjcmMzMl9maWxsdGFibGUoaW50IGVuZGlhbik7CiAKIAot
ZW51bSB7CS8qIERPIE5PVCBDSEFOR0UgVEhFU0UgVkFMVUVTISAgY3AuYyBkZXBlbmRzIG9uIHRo
ZW0uICovCitlbnVtIHsJLyogRE8gTk9UIENIQU5HRSBUSEVTRSBWQUxVRVMhICBjcC5jLCBtdi5j
LCBpbnN0YWxsLmMgZGVwZW5kcyBvbiB0aGVtLiAqLwogCUZJTEVVVElMU19QUkVTRVJWRV9TVEFU
VVMgPSAxLAogCUZJTEVVVElMU19ERVJFRkVSRU5DRSA9IDIsCiAJRklMRVVUSUxTX1JFQ1VSID0g
NCwKQEAgLTc0NSw5ICs3NDUsMTMgQEAKIAlGSUxFVVRJTFNfSU5URVJBQ1RJVkUgPSAweDEwLAog
CUZJTEVVVElMU19NQUtFX0hBUkRMSU5LID0gMHgyMCwKIAlGSUxFVVRJTFNfTUFLRV9TT0ZUTElO
SyA9IDB4NDAsCisjaWYgRU5BQkxFX1NFTElOVVgKKwlGSUxFVVRJTFNfUFJFU0VSVkVfU0VDVVJJ
VFlfQ09OVEVYVCA9IDB4ODAsCisJRklMRVVUSUxTX1NFVF9TRUNVUklUWV9DT05URVhUID0gMHgx
MDAKKyNlbmRpZgogfTsKLSNkZWZpbmUgRklMRVVUSUxTX0NQX09QVFNUUiAicGRSZmlscyIKIAor
I2RlZmluZSBGSUxFVVRJTFNfQ1BfT1BUU1RSICJwZFJmaWxzIiBVU0VfU0VMSU5VWCgiYyIpCiBl
eHRlcm4gY29uc3QgY2hhciAqYXBwbGV0X25hbWU7CiBleHRlcm4gY29uc3QgY2hhciBCQl9CQU5O
RVJbXTsKIApJbmRleDogY29yZXV0aWxzL2NwLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gY29yZXV0aWxzL2Nw
LmMJKHJldmlzaW9uIDE3OTYxKQorKysgY29yZXV0aWxzL2NwLmMJKHdvcmtpbmcgY29weSkKQEAg
LTMsNiArMyw3IEBACiAgKiBNaW5pIGNwIGltcGxlbWVudGF0aW9uIGZvciBidXN5Ym94CiAgKgog
ICogQ29weXJpZ2h0IChDKSAyMDAwIGJ5IE1hdHQgS3JhYWkgPGtyYWFpQGFsdW1uaS5jYXJuZWdp
ZW1lbGxvbi5lZHU+CisgKiBTRUxpbnV4IHN1cHBvcnQgYnkgWXVpY2hpIE5ha2FtdXJhIDx5bmFr
YW1AaGl0YWNoaXNvZnQuanA+CiAgKgogICogTGljZW5zZWQgdW5kZXIgR1BMIHYyIG9yIGxhdGVy
LCBzZWUgZmlsZSBMSUNFTlNFIGluIHRoaXMgdGFyYmFsbCBmb3IgZGV0YWlscy4KICAqLwpAQCAt
NTAsNiArNTEsMTIgQEAKIAlpZiAoZmxhZ3MgJiBPUFRfSCkgLi4uIC8vIGRlcmVmIGNvbW1hbmQt
bGluZSBwYXJhbXMgb25seQogCSovCiAKKyNpZiBFTkFCTEVfU0VMSU5VWCAKKwlpZiAoZmxhZ3Mg
JiBGSUxFVVRJTFNfUFJFU0VSVkVfU0VDVVJJVFlfQ09OVEVYVCkgeworCQlzZWxpbnV4X29yX2Rp
ZSgpOworCX0KKyNlbmRpZgorCiAJZmxhZ3MgXj0gRklMRVVUSUxTX0RFUkVGRVJFTkNFOwkJLyog
VGhlIHNlbnNlIG9mIHRoaXMgZmxhZyB3YXMgcmV2ZXJzZWQuICovCiAKIAlpZiAob3B0aW5kICsg
MiA+IGFyZ2MpIHsKSW5kZXg6IGNvcmV1dGlscy9tdi5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGNvcmV1dGls
cy9tdi5jCShyZXZpc2lvbiAxNzk2MSkKKysrIGNvcmV1dGlscy9tdi5jCSh3b3JraW5nIGNvcHkp
CkBAIC0zLDYgKzMsNyBAQAogICogTWluaSBtdiBpbXBsZW1lbnRhdGlvbiBmb3IgYnVzeWJveAog
ICoKICAqIENvcHlyaWdodCAoQykgMjAwMCBieSBNYXR0IEtyYWFpIDxrcmFhaUBhbHVtbmkuY2Fy
bmVnaWVtZWxsb24uZWR1PgorICogU0VMaW51eCBzdXBwb3J0IGJ5IFl1aWNoaSBOYWthbXVyYSA8
eW5ha2FtQGhpdGFjaGlzb2Z0LmpwPgogICoKICAqIExpY2Vuc2VkIHVuZGVyIEdQTHYyIG9yIGxh
dGVyLCBzZWUgZmlsZSBMSUNFTlNFIGluIHRoaXMgdGFyYmFsbCBmb3IgZGV0YWlscy4KICAqLwpA
QCAtNDQsNiArNDUsNyBAQAogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJaW50IGRlc3RfZXhpc3Rz
OwogCWludCBzdGF0dXMgPSAwOworCWludCBjb3B5X2ZsYWcgPSAwOwogCiAjaWYgRU5BQkxFX0ZF
QVRVUkVfTVZfTE9OR19PUFRJT05TCiAJYXBwbGV0X2xvbmdfb3B0aW9ucyA9IG12X2xvbmdfb3B0
aW9uczsKQEAgLTExMyw4ICsxMTUsMTEgQEAKIAkJCQkJCWdvdG8gUkVUXzE7CiAJCQkJCX0KIAkJ
CQl9Ci0JCQkJaWYgKChjb3B5X2ZpbGUoKmFyZ3YsIGRlc3QsCi0JCQkJCUZJTEVVVElMU19SRUNV
UiB8IEZJTEVVVElMU19QUkVTRVJWRV9TVEFUVVMpID49IDApICYmCisJCQkJY29weV9mbGFnID0g
RklMRVVUSUxTX1JFQ1VSIHwgRklMRVVUSUxTX1BSRVNFUlZFX1NUQVRVUzsKKyNpZiBFTkFCTEVf
U0VMSU5VWAorCQkJCWNvcHlfZmxhZyB8PSBGSUxFVVRJTFNfUFJFU0VSVkVfU0VDVVJJVFlfQ09O
VEVYVDsKKyNlbmRpZgkJCQkKKwkJCQlpZiAoKGNvcHlfZmlsZSgqYXJndiwgZGVzdCwJY29weV9m
bGFnKSA+PSAwKSAmJgogCQkJCQkocmVtb3ZlX2ZpbGUoKmFyZ3YsIEZJTEVVVElMU19SRUNVUiB8
IEZJTEVVVElMU19GT1JDRSkgPj0gMCkpIHsKIAkJCQkJZ290byBSRVRfMDsKIAkJCQl9CkluZGV4
OiBjb3JldXRpbHMvaW5zdGFsbC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGNvcmV1dGlscy9pbnN0YWxsLmMJ
KHJldmlzaW9uIDE3OTYxKQorKysgY29yZXV0aWxzL2luc3RhbGwuYwkod29ya2luZyBjb3B5KQpA
QCAtMjEsMTAgKzIxLDUwIEBACiAJeyAiZ3JvdXAiLCAgICAgICAgICAgICAgIDAsIE5VTEwsICdn
JyB9LAogCXsgIm1vZGUiLCAgICAgICAgICAgICAgICAwLCBOVUxMLCAnbScgfSwKIAl7ICJvd25l
ciIsICAgICAgICAgICAgICAgMCwgTlVMTCwgJ28nIH0sCisjaWYgRU5BQkxFX1NFTElOVVgKKwl7
ICJjb250ZXh0IiwgICAgICAgICAgICAgMSwgTlVMTCwgJ1onIH0sCisJeyAicHJlc2VydmVfY29u
dGV4dCIsICAgIDAsIE5VTEwsIDB4ZmZ9LAorCXsgInByZXNlcnZlLWNvbnRleHQiLCAgICAwLCBO
VUxMLCAweGZmfSwKKyNlbmRpZgogCXsgMCwgMCwgMCwgMCB9CiB9OwogI2VuZGlmCiAKKworI2lm
IEVOQUJMRV9TRUxJTlVYCitzdGF0aWMgaW50IHVzZV9kZWZhdWx0X3NlbGludXhfY29udGV4dCA9
IDE7CisKK3N0YXRpYyB2b2lkIHNldGRlZmF1bHRmaWxlY29uKGNvbnN0IGNoYXIgKnBhdGgpIHsK
KwlzdHJ1Y3Qgc3RhdCBzOworCXNlY3VyaXR5X2NvbnRleHRfdCBzY29udGV4dCA9IE5VTEw7CisK
KwlpZiAoIWlzX3NlbGludXhfZW5hYmxlZCgpKSB7CisJCXJldHVybjsKKwl9CQorCWlmIChsc3Rh
dChwYXRoLCAmcykgIT0gMCkgeworCQlyZXR1cm47CisJfQorCisJaWYgKG1hdGNocGF0aGNvbihw
YXRoLCBzLnN0X21vZGUsICZzY29udGV4dCkgPCAwKSB7CisJCXJldHVybjsKKwl9CisJaWYgKHN0
cmNtcChzY29udGV4dCwgIjw8bm9uZT4+IikgPT0gMCkgeworCQlmcmVlY29uKHNjb250ZXh0KTsK
KwkJcmV0dXJuOworCX0KKworCWlmIChsc2V0ZmlsZWNvbihwYXRoLCBzY29udGV4dCkgPCAwKSB7
CisJCWlmIChlcnJubyAhPSBFTk9UU1VQKSB7CisJCQliYl9wZXJyb3JfbXNnKCJ3YXJuaW5nOiBm
YWlsZWQgdG8gY2hhbmdlIGNvbnRleHQgb2YgJXMgdG8gJXMiLCBwYXRoLCBzY29udGV4dCk7CisJ
CX0KKwl9CisKKwlmcmVlY29uKHNjb250ZXh0KTsKKwlyZXR1cm47Cit9CisKKyNlbmRpZgorCiBp
bnQgaW5zdGFsbF9tYWluKGludCBhcmdjLCBjaGFyICoqYXJndik7CiBpbnQgaW5zdGFsbF9tYWlu
KGludCBhcmdjLCBjaGFyICoqYXJndikKIHsKQEAgLTM3LDcgKzc3LDkgQEAKIAljb25zdCBjaGFy
ICptb2RlX3N0cjsKIAlpbnQgY29weV9mbGFncyA9IEZJTEVVVElMU19ERVJFRkVSRU5DRSB8IEZJ
TEVVVElMU19GT1JDRTsKIAlpbnQgcmV0ID0gRVhJVF9TVUNDRVNTLCBmbGFncywgaSwgaXNkaXI7
Ci0KKyNpZiBFTkFCTEVfU0VMSU5VWAorCXNlY3VyaXR5X2NvbnRleHRfdCBzY29udGV4dDsKKyNl
bmRpZgogCWVudW0gewogCQlPUFRfQ01EICAgICAgICAgICA9ICAweDEsCiAJCU9QVF9ESVJFQ1RP
UlkgICAgID0gIDB4MiwKQEAgLTQ2LDE1ICs4OCw0MiBAQAogCQlPUFRfR1JPVVAgICAgICAgICA9
IDB4MTAsCiAJCU9QVF9NT0RFICAgICAgICAgID0gMHgyMCwKIAkJT1BUX09XTkVSICAgICAgICAg
PSAweDQwLAorI2lmIEVOQUJMRV9TRUxJTlVYCisJCU9QVF9TRVRfU0VDVVJJVFlfQ09OVEVYVCA9
IDB4ODAsCisJCU9QVF9QUkVTRVJWRV9TRUNVUklUWV9DT05URVhUID0gMHgxMDAsCisjZW5kaWYK
IAl9OwogCiAjaWYgRU5BQkxFX0ZFQVRVUkVfSU5TVEFMTF9MT05HX09QVElPTlMKIAlhcHBsZXRf
bG9uZ19vcHRpb25zID0gaW5zdGFsbF9sb25nX29wdGlvbnM7CiAjZW5kaWYKLQlvcHRfY29tcGxl
bWVudGFyeSA9ICI/OnMtLWQ6ZC0tcyI7CisJb3B0X2NvbXBsZW1lbnRhcnkgPSAiPzpzLS1kOmQt
LXMiIFVTRV9TRUxJTlVYKCI6Wi0tXHhmZjpceGZmLS1aIik7CiAJLyogLWMgZXhpc3RzIGZvciBi
YWNrd2FyZHMgY29tcGF0aWJpbGl0eSwgaXRzIG5lZWRlZCAqLwotCWZsYWdzID0gZ2V0b3B0MzIo
YXJnYywgYXJndiwgImNkcHNnOm06bzoiLCAmZ2lkX3N0ciwgJm1vZGVfc3RyLCAmdWlkX3N0cik7
CisJZmxhZ3MgPSBnZXRvcHQzMihhcmdjLCBhcmd2LCAiY2Rwc2c6bTpvOiIgVVNFX1NFTElOVVgo
Ilo6XHhmZiIpLCAmZ2lkX3N0ciwgJm1vZGVfc3RyLCAmdWlkX3N0ciBVU0VfU0VMSU5VWCgsICZz
Y29udGV4dCkpOwogCisjaWYgRU5BQkxFX1NFTElOVVgKKwlpZiAoZmxhZ3MgJiBPUFRfUFJFU0VS
VkVfU0VDVVJJVFlfQ09OVEVYVCkgeworCQl1c2VfZGVmYXVsdF9zZWxpbnV4X2NvbnRleHQgPSAw
OworCQljb3B5X2ZsYWdzIHw9IEZJTEVVVElMU19QUkVTRVJWRV9TRUNVUklUWV9DT05URVhUOwor
CQlpZighaXNfc2VsaW51eF9lbmFibGVkKCkpIHsKKwkJCWJiX2Vycm9yX21zZygid2FybmluZzog
aWdub3JpbmcgLS1wcmVzZXJ2ZS1jb250ZXh0LiAiCisJCQkJCSAiVGhlIGtlcm5lbCBpcyBub3Qg
U0VMaW51eC1lbmFibGVkLiIpOworCQl9CisJfQorCWlmIChmbGFncyAmIE9QVF9TRVRfU0VDVVJJ
VFlfQ09OVEVYVCkgeworCQlpZighaXNfc2VsaW51eF9lbmFibGVkKCkpIHsKKwkJCWJiX2Vycm9y
X21zZygid2FybmluZzogaWdub3JpbmcgLS1jb250ZXh0ICgtWikuICIKKwkJCQkJICJUaGUga2Vy
bmVsIGlzIG5vdCBTRUxpbnV4LWVuYWJsZWQuIik7CisJCX0gZWxzZSB7CisJCQlpZiAoc2V0ZnNj
cmVhdGVjb24oc2NvbnRleHQpIDwgMCkgeworCQkJCWJiX2Vycm9yX21zZ19hbmRfZGllKCJjYW5u
b3Qgc2V0IGRlZmF1bHQgc2VjdXJpdHkgY29udGV4dCAlcyIsIHNjb250ZXh0KTsKKwkJCX0KKwkJ
fQorCQl1c2VfZGVmYXVsdF9zZWxpbnV4X2NvbnRleHQgPSAwOworCQljb3B5X2ZsYWdzIHw9IEZJ
TEVVVElMU19TRVRfU0VDVVJJVFlfQ09OVEVYVDsKKwl9CisjZW5kaWYKKwogCS8qIHByZXNlcnZl
IGFjY2VzcyBhbmQgbW9kaWZpY2F0aW9uIHRpbWUsIHRoaXMgaXMgR05VIGJlaGF2aW91ciwgQlNE
IG9ubHkgcHJlc2VydmVzIG1vZGlmaWNhdGlvbiB0aW1lICovCiAJaWYgKGZsYWdzICYgT1BUX1BS
RVNFUlZFX1RJTUUpIHsKIAkJY29weV9mbGFncyB8PSBGSUxFVVRJTFNfUFJFU0VSVkVfU1RBVFVT
OwpAQCAtMTE3LDcgKzE4NiwxMCBAQAogCQkJYmJfcGVycm9yX21zZygiY2Fubm90IGNoYW5nZSBw
ZXJtaXNzaW9ucyBvZiAlcyIsIGRlc3QpOwogCQkJcmV0ID0gRVhJVF9GQUlMVVJFOwogCQl9Ci0K
KyNpZiBFTkFCTEVfU0VMSU5VWAorCQlpZiAodXNlX2RlZmF1bHRfc2VsaW51eF9jb250ZXh0KQor
CQkJc2V0ZGVmYXVsdGZpbGVjb24oZGVzdCk7CisjZW5kaWYKIAkJLyogU2V0IHRoZSB1c2VyIGFu
ZCBncm91cCBpZCAqLwogCQlpZiAoKGZsYWdzICYgKE9QVF9PV05FUnxPUFRfR1JPVVApKQogCQkg
JiYgbGNob3duKGRlc3QsIHVpZCwgZ2lkKSA9PSAtMQpJbmRleDogbGliYmIvY29weV9maWxlLmMK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQotLS0gbGliYmIvY29weV9maWxlLmMJKHJldmlzaW9uIDE3OTYxKQorKysgbGli
YmIvY29weV9maWxlLmMJKHdvcmtpbmcgY29weSkKQEAgLTMsNiArMyw3IEBACiAgKiBNaW5pIGNv
cHlfZmlsZSBpbXBsZW1lbnRhdGlvbiBmb3IgYnVzeWJveAogICoKICAqIENvcHlyaWdodCAoQykg
MjAwMSBieSBNYXR0IEtyYWFpIDxrcmFhaUBhbHVtbmkuY2FybmVnaWVtZWxsb24uZWR1PgorICog
U0VMaW51eCBzdXBwb3J0IGJ5IFl1aWNoaSBOYWthbXVyYSA8eW5ha2FtQGhpdGFjaGlzb2Z0Lmpw
PgogICoKICAqIExpY2Vuc2VkIHVuZGVyIEdQTHYyIG9yIGxhdGVyLCBzZWUgZmlsZSBMSUNFTlNF
IGluIHRoaXMgdGFyYmFsbCBmb3IgZGV0YWlscy4KICAqCkBAIC02Miw2ICs2MywyNiBAQAogCQlk
ZXN0X2V4aXN0cyA9IDE7CiAJfQogCisjaWYgRU5BQkxFX1NFTElOVVgKKwlpZiAoKGZsYWdzICYg
RklMRVVUSUxTX1BSRVNFUlZFX1NFQ1VSSVRZX0NPTlRFWFQpICYmIGlzX3NlbGludXhfZW5hYmxl
ZCgpID4gMCkgeworCQlzZWN1cml0eV9jb250ZXh0X3QgY29uOworCQlpZiAobGdldGZpbGVjb24g
KHNvdXJjZSwgJmNvbikgPj0gMCkgeworCQkJaWYgKHNldGZzY3JlYXRlY29uKGNvbikgPCAwKSB7
CisJCQkJYmJfcGVycm9yX21zZyAoImNhbm5vdCBzZXQgc2V0ZnNjcmVhdGVjb24gJXMiLCBjb24p
OworCQkJCWZyZWVjb24oY29uKTsKKwkJCQlyZXR1cm4gLTE7CisJCQl9CisJCX0gZWxzZSB7CisJ
CQlpZihlcnJubyA9PSBFTk9UU1VQIHx8IGVycm5vID09IEVOT0RBVEEpIHsKKwkJCQlzZXRmc2Ny
ZWF0ZWNvbihOVUxMKTsKKwkJCX0gZWxzZSB7CisJCQkJYmJfcGVycm9yX21zZyAoImNhbm5vdCAg
bGdldGZpbGVjb24gJXMiLCBzb3VyY2UpOworCQkJCXJldHVybiAtMTsKKwkJCX0KKwkJfQorCX0K
KyNlbmRpZgorCiAJaWYgKFNfSVNESVIoc291cmNlX3N0YXQuc3RfbW9kZSkpIHsKIAkJRElSICpk
cDsKIAkJc3RydWN0IGRpcmVudCAqZDsKQEAgLTIwMiw4ICsyMjMsMjcgQEAKIAkJCQljbG9zZShz
cmNfZmQpOwogCQkJCXJldHVybiAtMTsKIAkJCX0KKwkJfQkJCQkKKworI2lmIEVOQUJMRV9TRUxJ
TlVYCisJCWlmICgoKGZsYWdzICYgRklMRVVUSUxTX1BSRVNFUlZFX1NFQ1VSSVRZX0NPTlRFWFQp
CisJCSB8fCAoZmxhZ3MgJiBGSUxFVVRJTFNfU0VUX1NFQ1VSSVRZX0NPTlRFWFQpKQorCQkgJiYg
aXNfc2VsaW51eF9lbmFibGVkKCkgPiAwKSB7CisJCQlzZWN1cml0eV9jb250ZXh0X3QgY29uOyAg
CisJCQlpZihnZXRmc2NyZWF0ZWNvbigmY29uKSA9PSAtMSkgeworCQkJCWJiX3BlcnJvcl9tc2cg
KCJjYW5ub3QgZ2V0ZnNjcmVhdGVjb24iKTsKKwkJCQlyZXR1cm4gLTE7CisJCQl9CQkJCQorCQkJ
aWYgKGNvbikgeworCQkJCWlmKHNldGZpbGVjb24oZGVzdCwgY29uKSA9PSAtMSkgeworCQkJCQli
Yl9wZXJyb3JfbXNnICgiY2Fubm90IHNldGZpbGVjb246JXMsJXMiLGRlc3QsY29uKTsKKwkJCQkJ
ZnJlZWNvbihjb24pOworCQkJCQlyZXR1cm4gLTE7CisJCQkJfQorCQkJCWZyZWVjb24oY29uKTsK
KwkJCX0KIAkJfQotCisjZW5kaWYKIAkJaWYgKGJiX2NvcHlmZF9lb2Yoc3JjX2ZkLCBkc3RfZmQp
ID09IC0xKQogCQkJc3RhdHVzID0gLTE7CiAJCWlmIChjbG9zZShkc3RfZmQpIDwgMCkgewo=

--Multipart=_Mon__26_Feb_2007_10_52_49_+0900_x=rkSGZQ+uSFYXUD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
