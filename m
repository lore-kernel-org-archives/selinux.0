Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3IGxrh5022537
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 12:59:53 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3IGxqGn002712
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 16:59:53 GMT
Received: by wx-out-0506.google.com with SMTP id s17so236304wxc
        for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 09:59:51 -0700 (PDT)
Message-ID: <cadfc0e40704180959i4aad6211r6b66d1433c69a1ee@mail.gmail.com>
Date: Wed, 18 Apr 2007 11:59:51 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Michael C Thompson" <thompsmc@us.ibm.com>
Subject: Re: directory polyinstantiation failure
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46252BB5.1070407@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_55313_23908674.1176915591211"
References: <cadfc0e40704171107l770c48cak16f504b6b0a0dcc0@mail.gmail.com>
	 <46251650.7000509@us.ibm.com>
	 <cadfc0e40704171223r5b566441p276426561ec21290@mail.gmail.com>
	 <46252BB5.1070407@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_55313_23908674.1176915591211
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is the patch for to expand $HOME. However as I looked at the code
I see the reason for behavior that had confused me partly because it
isn't documented and partly because I don't think it is desired. I'd
specified some directories to be polyinstantiated by level but then
I'd see that they might also get polyinstantiated by user. The code as
described in the following comment is overriding my specified method
if getexeccon fails.
/*
 * This function checks if the calling program has requested context
 * change by calling setexeccon(). If context change is not requested
 * then it does not make sense to polyinstantiate based on context.
 * The return value from this function is used when selecting the
 * polyinstantiation method. If context change is not requested then
 * the polyinstantiation method is set to USER, even if the configuration
 * file lists the method as "context" or "both".
 */
static int ctxt_based_inst_needed(void)

Why if getexeccon fails doesn't it make sense to polyinstantiate based
on context/level? Why not call getcon lf getexeccon fails and use that
context instead of switching the method?

Oh yeah I also patch the debug output of an error that pam_namespace
doesn't care about so why should I.

On 4/17/07, Michael C Thompson <thompsmc@us.ibm.com> wrote:
> Xavier Toth wrote:
> > If you try and use $HOME in the directory name for instance
> > $HOME/.mozilla the $HOME is not expanded. I'll submit a patch.
>
> Nice find, thank you for the patch. :)
>
> Mike
>

------=_Part_55313_23908674.1176915591211
Content-Type: text/x-patch; name=pam-0.99.7.1-namespace-expand-home.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0nzwzb0
Content-Disposition: attachment; filename="pam-0.99.7.1-namespace-expand-home.patch"

LS0tIExpbnV4LVBBTS0wLjk5LjcuMC9tb2R1bGVzL3BhbV9uYW1lc3BhY2UvcGFtX25hbWVzcGFj
ZS5jCTIwMDctMDQtMTggMDk6MzI6MDUuMDAwMDAwMDAwIC0wNTAwCisrKyBMaW51eC1QQU0tMC45
OS43LjAubmV3L21vZHVsZXMvcGFtX25hbWVzcGFjZS9wYW1fbmFtZXNwYWNlLmMJMjAwNy0wNC0x
OCAwOTozMToyMy4wMDAwMDAwMDAgLTA1MDAKQEAgLTE5NiwxNCArMTk2LDE4IEBACiAgICAgdWlk
cyA9IHN0cnRva19yKE5VTEwsICIgXHQiLCAmdHB0cik7CiAKICAgICAvKgotICAgICAqIElmIHRo
ZSBkaXJlY3RvcnkgYmVpbmcgcG9seWluc3RhbnRpYXRlZCBpcyB0aGUgaG9tZSBkaXJlY3RvcnkK
LSAgICAgKiBvZiB0aGUgdXNlciB3aG8gaXMgZXN0YWJsaXNoaW5nIGEgc2Vzc2lvbiwgd2UgaGF2
ZSB0byBzd2FwCi0gICAgICogdGhlICIkSE9NRSIgc3RyaW5nIHdpdGggdGhlIHVzZXIncyBob21l
IGRpcmVjdG9yeSB0aGF0IGlzCi0gICAgICogcGFzc2VkIGluIGFzIGFuIGFyZ3VtZW50LgorICAg
ICAqIEV4cGFuZCAkSE9NRSBpbiBkaXIKICAgICAgKi8KLSAgICBpZiAoc3RyY21wKGRpciwgIiRI
T01FIikgPT0gMCkgewotCWRpciA9IGhvbWU7CisgICAgaWYgKCh0cHRyID0gc3Ryc3RyKGRpciwg
IiRIT01FIikpICE9IDApIHsKKyAgICAgICAgaWYgKHN0cmxlbihkaXIpID4gNSkgeworICAgICAg
ICAgICAgY2hhciAqZXhwYW5kZWQgPSBhbGxvY2Eoc3RybGVuKGhvbWUpK3N0cmxlbihkaXIpLTUr
MSk7CisgICAgICAgICAgICAqdHB0ciA9IDA7CisgICAgICAgICAgICBzcHJpbnRmKGV4cGFuZGVk
LCAiJXMlcyIsIGhvbWUsIHRwdHIrNSk7CisgICAgICAgICAgICBkaXIgPSBleHBhbmRlZDsKKwl9
CisJZWxzZQorICAgICAgICAgICAgZGlyID0gaG9tZTsKICAgICB9CiAKICAgICAvKgogICAgICAq
IEV4cGFuZCAkSE9NRSBhbmQgJFVTRVIgaW4gaW5zdGFuY2UgZGlyIHByZWZpeApAQCAtMTExNywx
MCArMTE0MSwxMSBAQAogCiAgICAgICAgICAgICAgICAgaWYgKHVtb3VudChwcHRyLT5kaXIpIDwg
MCkgewogICAgICAgICAgICAgCSAgICBpbnQgc2F2ZWRfZXJybm8gPSBlcnJubzsKLSAgICAgICAg
ICAgIAkgICAgcGFtX3N5c2xvZyhpZGF0YS0+cGFtaCwgTE9HX0VSUiwgIlVubW91bnQgb2YgJXMg
ZmFpbGVkLCAlbSIsCisgICAgICAgICAgICAJICAgIGlmIChzYXZlZF9lcnJubyAhPSBFSU5WQUwp
IHsKKyAgICAgICAgICAgIAkgICAgICAgIHBhbV9zeXNsb2coaWRhdGEtPnBhbWgsIExPR19FUlIs
ICJVbm1vdW50IG9mICVzIGZhaWxlZCwgJW0iLAogICAgICAgICAgICAgICAgICAgICAJcHB0ci0+
ZGlyKTsKLSAgICAgICAgICAgIAkgICAgaWYgKHNhdmVkX2Vycm5vICE9IEVJTlZBTCkKICAgICAg
ICAgICAgICAgICAJcmV0dXJuIFBBTV9TRVNTSU9OX0VSUjsKKwkJICAgIH0KICAgICAgICAgICAg
ICAgICB9IGVsc2UgaWYgKGlkYXRhLT5mbGFncyAmIFBBTU5TX0RFQlVHKQogICAgICAgICAgICAg
ICAgICAgICBwYW1fc3lzbG9nKGlkYXRhLT5wYW1oLCBMT0dfREVCVUcsICJVbW91bnQgc3VjY2Vl
ZGVkICVzIiwKIAkJCQlwcHRyLT5kaXIpOwo=
------=_Part_55313_23908674.1176915591211--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
