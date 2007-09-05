Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l85JYwa3024073
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 15:34:58 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l85JYuMO021500
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 19:34:57 GMT
Subject: [PATCH] libselinux: fix rpm_execcon in SWIG bindings
From: James Athey <jathey@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46DD6A6C.2040305@redhat.com>
References: <1181744873.18728.10.camel@exodus.columbia.tresys.com>
	 <46DD6A6C.2040305@redhat.com>
Content-Type: multipart/mixed; boundary="=-iaUZeJsuIldCAJhncUH1"
Date: Wed, 05 Sep 2007 15:35:22 -0400
Message-Id: <1189020922.8528.10.camel@exodus.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-iaUZeJsuIldCAJhncUH1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-09-04 at 10:23 -0400, Daniel J Walsh wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=276121
> 
> Bug in refactored SWIG Bindings.
> 
> 
> #!/usr/bin/python
> 
> import selinux
> args = [ "/bin/bash", "--version" ]
> selinux.rpm_execcon(0, args[0], args, [ ])
> 
> Produces:
> 
> Traceback (most recent call last):
>   File "test.py", line 5, in <module>
>     selinux.rpm_execcon(0, args[0], args, [ ])
> TypeError: in method 'rpm_execcon', argument 3 of type 'char *const []'
> 
> Version-Release number of selected component (if applicable):
> libselinux-2.0.31-3.fc8
> 
> James do  you have a nice quick fix for this?

It's nice, it's quick, and I think it's a fix, but I'll let you be the
judge of that.


--=-iaUZeJsuIldCAJhncUH1
Content-Disposition: attachment; filename=libselinux_swig_rpm_execcon.patch
Content-Type: text/x-patch; name=libselinux_swig_rpm_execcon.patch; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IGxpYnNlbGludXgvc3JjL3NlbGludXhzd2lnX3B5dGhvbi5pDQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQot
LS0gbGlic2VsaW51eC9zcmMvc2VsaW51eHN3aWdfcHl0aG9uLmkJKHJldmlzaW9uIDI1NDkpDQor
KysgbGlic2VsaW51eC9zcmMvc2VsaW51eHN3aWdfcHl0aG9uLmkJKHdvcmtpbmcgY29weSkNCkBA
IC05OCw0ICs5OCw0MSBAQA0KIAl9DQogfQ0KIA0KKyV0eXBlbWFwKGluKSBjaGFyICogY29uc3Qg
W10gew0KKwlpbnQgaSwgc2l6ZTsNCisJUHlPYmplY3QgKiBzOw0KKw0KKwlpZiAoIVB5U2VxdWVu
Y2VfQ2hlY2soJGlucHV0KSkgew0KKwkJUHlFcnJfU2V0U3RyaW5nKFB5RXhjX1ZhbHVlRXJyb3Is
ICJFeHBlY3RlZCBhIHNlcXVlbmNlIik7DQorCQlyZXR1cm4gTlVMTDsNCisJfQ0KKw0KKwlzaXpl
ID0gUHlTZXF1ZW5jZV9TaXplKCRpbnB1dCk7DQorCQ0KKwkkMSA9IChjaGFyKiopIG1hbGxvYyhz
aXplICsgMSk7DQorDQorCWZvcihpID0gMDsgaSA8IHNpemU7IGkrKykgew0KKwkJaWYgKCFQeVN0
cmluZ19DaGVjayhQeVNlcXVlbmNlX0dldEl0ZW0oJGlucHV0LCBpKSkpIHsNCisJCQlQeUVycl9T
ZXRTdHJpbmcoUHlFeGNfVmFsdWVFcnJvciwgIlNlcXVlbmNlIG11c3QgY29udGFpbiBvbmx5IHN0
cmluZ3MiKTsNCisJCQlyZXR1cm4gTlVMTDsNCisJCX0NCisJfQ0KKwkJDQorCWZvcihpID0gMDsg
aSA8IHNpemU7IGkrKykgew0KKwkJcyA9IFB5U2VxdWVuY2VfR2V0SXRlbSgkaW5wdXQsIGkpOw0K
KwkJJDFbaV0gPSAoY2hhciopIG1hbGxvYyhQeVN0cmluZ19TaXplKHMpICsgMSk7DQorCQlzdHJj
cHkoJDFbaV0sIFB5U3RyaW5nX0FzU3RyaW5nKHMpKTsNCisJfQ0KKwkkMVtzaXplXSA9IE5VTEw7
DQorfQ0KKw0KKyV0eXBlbWFwKGZyZWVhcmcsbWF0Y2g9ImluIikgY2hhciAqIGNvbnN0IFtdIHsN
CisJaW50IGkgPSAwOw0KKwl3aGlsZSgkMVtpXSkgew0KKwkJZnJlZSgkMVtpXSk7DQorCQlpKys7
DQorCX0NCisJZnJlZSgkMSk7DQorfQ0KKw0KICVpbmNsdWRlICJzZWxpbnV4c3dpZy5pIg0K


--=-iaUZeJsuIldCAJhncUH1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
