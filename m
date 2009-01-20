Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0KFBcNU001290
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2009 10:11:38 -0500
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0KF8hQd019238
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2009 15:08:43 GMT
Message-ID: <4975E9A3.8060003@kaigai.gr.jp>
Date: Wed, 21 Jan 2009 00:11:31 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, refpolicy@oss.tresys.com,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] [PATCH] Add a new permission to db_procedure
References: <4973468F.1010706@kaigai.gr.jp> <49758904.2070303@ak.jp.nec.com> <1232461874.10460.1.camel@gorn>
In-Reply-To: <1232461874.10460.1.camel@gorn>
Content-Type: multipart/mixed;
 boundary="------------060505050408020106020500"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060505050408020106020500
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

> Changes to object classes need to be discussed on the SELinux list.

OK, I send the patch again for folks in selinux-list only.

>>> The attached patch add a new permission named as "install" to db_procedure.
>>>
>>> The purpose of this permission is to prevent malicious functions are invoked
>>> as a part of server's internal tasks.
>>>
>>> PostgreSQL allows user-defined functions to use its internal tasks.
>>> For example, it can be used to implement an output/input handler of new data
>>> types, an index access method, implementation of operator classes and so on.
>>>
>>> When we defines a new type, it requires to specify its output/input handler
>>> at least. No need to say, these functions should not be malicious ones,
>>> because user implicitly invokes these function when he uses the type.
>>> This permission is checked when we defines a new system catalog entry which
>>> has a possibility to invoke user defined functions.

A supplement:
PostgreSQL allows user to define his own data type, like "struct xxx" in C
language, and he can also define its input/output handler. The input/output
handler is invoked when user send a text representation, to translate it
into internal data structure, implicitly. For example, a function similar
to atoi() is configured for INTEGER type in default.

I'm worrying about a malicious one secretly installs a malicious function
which leaks given information to somewhere as a implementation of type
input/output handler, in typical scenario.

In addition, it allows to install user-defined functions to implement
database index access methods, multibyte encoding conversions, operator
classes and so on.

>>> In the attached patch, only sepgsql_proc_t is allowed to { install }, because
>>> any other user defined functions are not checked by DBA, so it is not safe to
>>> use it as a part of internal/common processes.
>>> If DBA want to apply user defined functions as a part of internal task, he has
>>> to confirm its safeness and relabel to sepgsql_proc_t at first.
>>>
>>> Please apply it, if no matter.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------060505050408020106020500
Content-Type: application/octect-stream;
 name="refpolicy-db_procedure.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="refpolicy-db_procedure.patch"

SW5kZXg6IHJlZnBvbGljeS9wb2xpY3kvZmxhc2svYWNjZXNzX3ZlY3RvcnMKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQotLS0gcmVmcG9saWN5L3BvbGljeS9mbGFzay9hY2Nlc3NfdmVjdG9ycwkocmV2aXNp
b24gMjkwNCkKKysrIHJlZnBvbGljeS9wb2xpY3kvZmxhc2svYWNjZXNzX3ZlY3RvcnMJKHdv
cmtpbmcgY29weSkKQEAgLTczOSw2ICs3MzksNyBAQAogewogCWV4ZWN1dGUKIAllbnRyeXBv
aW50CisJaW5zdGFsbAogfQogCiBjbGFzcyBkYl9jb2x1bW4KSW5kZXg6IHJlZnBvbGljeS9w
b2xpY3kvbWNzCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHJlZnBvbGljeS9wb2xpY3kvbWNzCShyZXZp
c2lvbiAyOTA0KQorKysgcmVmcG9saWN5L3BvbGljeS9tY3MJKHdvcmtpbmcgY29weSkKQEAg
LTEyMyw3ICsxMjMsNyBAQAogbWxzY29uc3RyYWluIGRiX3R1cGxlIHsgcmVsYWJlbGZyb20g
c2VsZWN0IHVwZGF0ZSBkZWxldGUgdXNlIH0KIAkoIGgxIGRvbSBoMiApOwogCi1tbHNjb25z
dHJhaW4gZGJfcHJvY2VkdXJlIHsgZXhlY3V0ZSB9CittbHNjb25zdHJhaW4gZGJfcHJvY2Vk
dXJlIHsgZXhlY3V0ZSBpbnN0YWxsIH0KIAkoIGgxIGRvbSBoMiApOwogCiBtbHNjb25zdHJh
aW4gZGJfYmxvYiB7IGRyb3Agc2V0YXR0ciByZWxhYmVsZnJvbSByZWFkIHdyaXRlIH0KSW5k
ZXg6IHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0Z3Jlc3FsLnRlCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KLS0tIHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9wb3N0
Z3Jlc3FsLnRlCShyZXZpc2lvbiAyOTA0KQorKysgcmVmcG9saWN5L3BvbGljeS9tb2R1bGVz
L3NlcnZpY2VzL3Bvc3RncmVzcWwudGUJKHdvcmtpbmcgY29weSkKQEAgLTMwMyw3ICszMDMs
NyBAQAogYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX3N5c29ial90OmRiX2Nv
bHVtbiB7IGdldGF0dHIgdXNlIHNlbGVjdCB9OwogYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlw
ZSBzZXBnc3FsX3N5c29ial90OmRiX3R1cGxlIHsgdXNlIHNlbGVjdCB9OwogCi1hbGxvdyBz
ZXBnc3FsX2NsaWVudF90eXBlIHNlcGdzcWxfcHJvY190OmRiX3Byb2NlZHVyZSB7IGdldGF0
dHIgZXhlY3V0ZSB9OworYWxsb3cgc2VwZ3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX3Byb2Nf
dDpkYl9wcm9jZWR1cmUgeyBnZXRhdHRyIGV4ZWN1dGUgaW5zdGFsbCB9OwogYWxsb3cgc2Vw
Z3NxbF9jbGllbnRfdHlwZSBzZXBnc3FsX3RydXN0ZWRfcHJvY190OmRiX3Byb2NlZHVyZSB7
IGdldGF0dHIgZXhlY3V0ZSBlbnRyeXBvaW50IH07CiAKIGFsbG93IHNlcGdzcWxfY2xpZW50
X3R5cGUgc2VwZ3NxbF9ibG9iX3Q6ZGJfYmxvYiB7IGNyZWF0ZSBkcm9wIGdldGF0dHIgc2V0
YXR0ciByZWFkIHdyaXRlIH07CkluZGV4OiByZWZwb2xpY3kvcG9saWN5L21scwo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSByZWZwb2xpY3kvcG9saWN5L21scwkocmV2aXNpb24gMjkwNCkKKysrIHJl
ZnBvbGljeS9wb2xpY3kvbWxzCSh3b3JraW5nIGNvcHkpCkBAIC02NjQsNyArNjY0LDcgQEAK
IAkgKCB0MSA9PSBtbHNkYnJlYWQgKSBvcgogCSAoIHQyID09IG1sc3RydXN0ZWRvYmplY3Qg
KSk7CiAKLW1sc2NvbnN0cmFpbiB7IGRiX3Byb2NlZHVyZSB9IHsgZ2V0YXR0ciBleGVjdXRl
IH0KK21sc2NvbnN0cmFpbiB7IGRiX3Byb2NlZHVyZSB9IHsgZ2V0YXR0ciBleGVjdXRlIGlu
c3RhbGwgfQogCSgoIGwxIGRvbSBsMiApIG9yCiAJICgoIHQxID09IG1sc2RicmVhZHRvY2xy
ICkgYW5kICggaDEgZG9tIGwyICkpIG9yCiAJICggdDEgPT0gbWxzZGJyZWFkICkgb3IK
--------------060505050408020106020500--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
