Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l199lbGk013124
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 04:47:37 -0500
Received: from msp1.hitachi-sk.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l199mjRX004317
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 09:48:45 GMT
Received: from vs1.hitachi-sk.co.jp ([133.108.252.215])
	by msp1.hitachi-sk.co.jp (unknown) with ESMTP id l199minV006172
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 18:48:44 +0900
Date: Fri, 9 Feb 2007 18:48:53 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: busybox@kaigai.gr.jp
Cc: ynakam@hitachisoft.jp, Denis Vlasenko <vda.linux@googlemail.com>,
        busybox@busybox.net, selinux@tycho.nsa.gov, russell@coker.com.au,
        rob@landley.net
Subject: Re: [busybox:00367] Re: [PATCH 3/6] busybox -- SELinux option
 support for coreutils
Message-Id: <20070209184853.0671d4c9.ynakam@hitachisoft.jp>
In-Reply-To: <200702082353.43667.vda.linux@googlemail.com>
References: <20070208155438.6cf3ebf3.ynakam@hitachisoft.jp>
	<200702082353.43667.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__9_Feb_2007_18_48_53_+0900_/R7dnoM=3SRFm7UM"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Fri__9_Feb_2007_18_48_53_+0900_/R7dnoM=3SRFm7UM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2007 23:53:43 +0100
Denis Vlasenko wrote:
> On Thursday 08 February 2007 07:54, Yuichi Nakamura wrote:
> > [3/6] busybox-coreutils-03-mk.patch
> >  - -Z option support for mkdir, mkfifo, mknod. 
> >     By -Z, security context for created file can be set.
> > 
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> 
> +#if ENABLE_SELINUX
> +	security_context_t scontext = NULL;
> +#endif
>  
>  #if ENABLE_FEATURE_MKDIR_LONG_OPTIONS
>  	applet_long_options = mkdir_long_options;
>  #endif
> -	opt = getopt32(argc, argv, "m:p", &smode);
> +	opt = getopt32(argc, argv, "m:p" USE_SELINUX("Z:"), &smode USE_SELINUX(,&scontext));
>  	if (opt & 1) {
>  		mode = 0777;
>  		if (!bb_parse_mode(smode, &mode)) {
> @@ -50,6 +61,15 @@
>  	}
>  	if (opt & 2)
>  		flags |= FILEUTILS_RECUR;
> +#if ENABLE_SELINUX
> +	if(opt & 4) {
> +		selinux_or_die();
> +		if (setfscreatecon(scontext)) {
> +			bb_error_msg_and_die ("Sorry, cannot set default context "
> +					      "to %s.\n", scontext);
> 
> Initializing scontext to NULL is useless code. bb_error_msg_and_die
> has useless "Sorry" (with wrong capitalization: "mkdir: Sorry...")
> and useless ".\n" at the end.
Fixed.

> 
> Sorry guys, I would be really happy if these patches get
> a little bit prettier...
Thank you :-)

> --
> vda
> 


-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
SELinux Policy Editor: http://seedit.sourceforge.net/




--Multipart=_Fri__9_Feb_2007_18_48_53_+0900_/R7dnoM=3SRFm7UM
Content-Type: application/octet-stream;
 name="busybox-coreutils-mk-03.v2.patch"
Content-Disposition: attachment;
 filename="busybox-coreutils-mk-03.v2.patch"
Content-Transfer-Encoding: base64

SW5kZXg6IGNvcmV1dGlscy9ta2Rpci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGNvcmV1dGlscy9ta2Rpci5j
CShyZXZpc2lvbiAxNzgwMykKKysrIGNvcmV1dGlscy9ta2Rpci5jCSh3b3JraW5nIGNvcHkpCkBA
IC0xNiw2ICsxNiwxMSBAQAogICogY29uanVuY3Rpb24gd2l0aCAtbS4KICAqLwogCisvKiBOb3Yg
MjgsIDIwMDYgICAgICBZb3NoaW5vcmkgU2F0byA8eXNhdG9AdXNlcnMuc291cmNlZm9yZ2UuanA+
CisgKiAKKyAqIEFkZCAtWiAoU0VMaW51eCkgc3VwcG9ydC4KKyAqLworCiAjaW5jbHVkZSA8c3Rk
bGliLmg+CiAjaW5jbHVkZSA8dW5pc3RkLmg+CiAjaW5jbHVkZSA8Z2V0b3B0Lmg+IC8qIHN0cnVj
dCBvcHRpb24gKi8KQEAgLTI1LDYgKzMwLDkgQEAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb3B0aW9u
IG1rZGlyX2xvbmdfb3B0aW9uc1tdID0gewogCXsgIm1vZGUiLCAxLCBOVUxMLCAnbScgfSwKIAl7
ICJwYXJlbnRzIiwgMCwgTlVMTCwgJ3AnIH0sCisjaWYgRU5BQkxFX1NFTElOVVgKKwl7ICJjb250
ZXh0IiwgMSwgTlVMTCwgJ1onfSwKKyNlbmRpZgogCXsgMCwgMCwgMCwgMCB9CiB9OwogI2VuZGlm
CkBAIC0zNywxMSArNDUsMTQgQEAKIAlpbnQgZmxhZ3MgPSAwOwogCXVuc2lnbmVkIG9wdDsKIAlj
aGFyICpzbW9kZTsKKyNpZiBFTkFCTEVfU0VMSU5VWAorCXNlY3VyaXR5X2NvbnRleHRfdCBzY29u
dGV4dDsKKyNlbmRpZgogCiAjaWYgRU5BQkxFX0ZFQVRVUkVfTUtESVJfTE9OR19PUFRJT05TCiAJ
YXBwbGV0X2xvbmdfb3B0aW9ucyA9IG1rZGlyX2xvbmdfb3B0aW9uczsKICNlbmRpZgotCW9wdCA9
IGdldG9wdDMyKGFyZ2MsIGFyZ3YsICJtOnAiLCAmc21vZGUpOworCW9wdCA9IGdldG9wdDMyKGFy
Z2MsIGFyZ3YsICJtOnAiIFVTRV9TRUxJTlVYKCJaOiIpLCAmc21vZGUgVVNFX1NFTElOVVgoLCZz
Y29udGV4dCkpOwogCWlmIChvcHQgJiAxKSB7CiAJCW1vZGUgPSAwNzc3OwogCQlpZiAoIWJiX3Bh
cnNlX21vZGUoc21vZGUsICZtb2RlKSkgewpAQCAtNTAsNiArNjEsMTUgQEAKIAl9CiAJaWYgKG9w
dCAmIDIpCiAJCWZsYWdzIHw9IEZJTEVVVElMU19SRUNVUjsKKyNpZiBFTkFCTEVfU0VMSU5VWAor
CWlmKG9wdCAmIDQpIHsKKwkJc2VsaW51eF9vcl9kaWUoKTsKKwkJaWYgKHNldGZzY3JlYXRlY29u
KHNjb250ZXh0KSkgeworCQkJYmJfZXJyb3JfbXNnX2FuZF9kaWUgKCJmYWlsZWQgdG8gc2V0IGRl
ZmF1bHQgZmlsZSBjcmVhdGlvbiBjb250ZXh0ICIKKwkJCQkJICAgICAgInRvICVzIiwgc2NvbnRl
eHQpOworCQl9CisJfQorI2VuZGlmCiAKIAlpZiAob3B0aW5kID09IGFyZ2MpIHsKIAkJYmJfc2hv
d191c2FnZSgpOwpJbmRleDogY29yZXV0aWxzL2xpYmNvcmV1dGlscy9nZXRvcHRfbWtfZmlmb19u
b2QuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Ci0tLSBjb3JldXRpbHMvbGliY29yZXV0aWxzL2dldG9wdF9ta19maWZv
X25vZC5jCShyZXZpc2lvbiAxNzgwMykKKysrIGNvcmV1dGlscy9saWJjb3JldXRpbHMvZ2V0b3B0
X21rX2ZpZm9fbm9kLmMJKHdvcmtpbmcgY29weSkKQEAgLTMwLDExICszMCwyNSBAQAogewogCW1v
ZGVfdCBtb2RlID0gMDY2NjsKIAljaGFyICpzbW9kZSA9IE5VTEw7Ci0KLQlnZXRvcHQzMihhcmdj
LCBhcmd2LCAibToiLCAmc21vZGUpOwotCWlmKHNtb2RlKSB7CisjaWYgRU5BQkxFX1NFTElOVVgK
KwlzZWN1cml0eV9jb250ZXh0X3Qgc2NvbnRleHQ7CisjZW5kaWYKKwlpbnQgb3B0ID0gMDsKKwlv
cHQgPSBnZXRvcHQzMihhcmdjLCBhcmd2LCAibToiIFVTRV9TRUxJTlVYKCJaOiIpLCAmc21vZGUg
VVNFX1NFTElOVVgoLCZzY29udGV4dCkpOworCWlmKG9wdCAmIDEpIHsKIAkJaWYgKGJiX3BhcnNl
X21vZGUoc21vZGUsICZtb2RlKSkKIAkJCXVtYXNrKDApOwogCX0KKworI2lmIEVOQUJMRV9TRUxJ
TlVYCisJaWYob3B0ICYgMikgeworCQlzZWxpbnV4X29yX2RpZSgpOworCQlpZiAoc2V0ZnNjcmVh
dGVjb24oc2NvbnRleHQpKSB7CisJCQliYl9lcnJvcl9tc2dfYW5kX2RpZSAoImZhaWxlZCB0byBz
ZXQgZGVmYXVsdCBmaWxlIGNyZWF0aW9uIGNvbnRleHQgIgorCQkJCQkgICAgICAidG8gJXMiLCBz
Y29udGV4dCk7CisJCX0KKwl9CisjZW5kaWYKKwogCXJldHVybiBtb2RlOwogfQo=

--Multipart=_Fri__9_Feb_2007_18_48_53_+0900_/R7dnoM=3SRFm7UM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
