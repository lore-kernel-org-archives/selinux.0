Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l199kPAj013082
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 04:46:25 -0500
Received: from msp1.hitachi-sk.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l199lXvH016660
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 09:47:33 GMT
Received: from vs2.hitachi-sk.co.jp ([133.108.252.215])
	by msp1.hitachi-sk.co.jp (unknown) with ESMTP id l199lWk3005967
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 18:47:32 +0900
Date: Fri, 9 Feb 2007 18:47:41 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: busybox@busybox.net, busybox@kaigai.gr.jp
Cc: ynakam@hitachisoft.jp, Denis Vlasenko <vda.linux@googlemail.com>,
        selinux@tycho.nsa.gov, russell@coker.com.au, rob@landley.net
Subject: Re: [busybox:00365] Re: [PATCH 1/6] busybox -- SELinux option
 support for coreutils
Message-Id: <20070209184741.dcbef9a9.ynakam@hitachisoft.jp>
In-Reply-To: <200702082332.43175.vda.linux@googlemail.com>
References: <20070208155426.7e9ca113.ynakam@hitachisoft.jp>
	<200702082332.43175.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__9_Feb_2007_18_47_41_+0900_Ia8T7ru=IvOx7X5Y"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Fri__9_Feb_2007_18_47_41_+0900_Ia8T7ru=IvOx7X5Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thank you for comments.

On Thu, 8 Feb 2007 23:32:43 +0100
Denis Vlasenko  wrote:
> On Thursday 08 February 2007 07:54, Yuichi Nakamura wrote:
> > 
> > [1/6] busybox-coreutils-common-01.patch
> >  - usage.h for SELinux options
> > 
> > Signed-off-by: Yuichi Nakamura <ynakam@hitachisoft.jp>
> 
> 
> @@ -1299,9 +1301,8 @@
>  #define id_full_usage \
>         "Print information for USERNAME or the current user" \
>         "\n\nOptions:\n" \
> -	USE_SELINUX( \
> -       "	-c	Prints only the security context\n") \
> -       "	-g	Prints only the group ID\n" \
> +	   USAGE_SELINUX("	-Z	prints only the security context\n")	\
> +	   "	-g	Prints only the group ID\n"						\
> 
> Well I can fix occasional problems but this is a bitt too much.
> I would prefer more careful formatting, like
> 
> 	USAGE_SELINUX( \
>        "	-Z	prints only the security context\n" \
> 	) \
>        "	-g	Prints only the group ID\n" \
> 
> This helps to avoid misformatting in help texts.
> 
> The rest of this patch needs similar reformatting.
Fixed.

> --
> vda
> 

We were porting SELinux option based on coreutils in Fedora Core6, 
but Stephen recommended to check upstream coreutils.
So I have checked upstream coreutils and found some SELinux option has been changed.
I have changed following:
* Removed -Z option from cp
* Added -Z and --preserve-context option to install

About cp,  -c option is dropped in upstream and "--preserve=context" is used instead.
However, cp in BusyBox does not have long options, so our patch still has -c option.

Yuichi Nakamura



--Multipart=_Fri__9_Feb_2007_18_47_41_+0900_Ia8T7ru=IvOx7X5Y
Content-Type: application/octet-stream;
 name="busybox-coreutils-common-01.v2.patch"
Content-Disposition: attachment;
 filename="busybox-coreutils-common-01.v2.patch"
Content-Transfer-Encoding: base64

SW5kZXg6IGluY2x1ZGUvdXNhZ2UuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBpbmNsdWRlL3VzYWdlLmgJKHJl
dmlzaW9uIDE3ODAzKQorKysgaW5jbHVkZS91c2FnZS5oCSh3b3JraW5nIGNvcHkpCkBAIC0zODgs
MTMgKzM4OCwxNiBAQAogICAgICAgICJDb3B5IFNPVVJDRSB0byBERVNULCBvciBtdWx0aXBsZSBT
T1VSQ0UocykgdG8gRElSRUNUT1JZIiBcCiAgICAgICAgIlxuXG5PcHRpb25zOlxuIiBcCiAgICAg
ICAgIgktYQlTYW1lIGFzIC1kcFJcbiIgXAorCVVTQUdFX1NFTElOVVgoIFwKKyAgICAgICAiCS1j
CVByZXNlcnZlcyBzZWN1cml0eSBjb250ZXh0XG4iIFwKKwkpIFwKICAgICAgICAiCS1kLC1QCVBy
ZXNlcnZlIGxpbmtzXG4iIFwKICAgICAgICAiCS1ILC1MCURlcmVmZXJlbmNlIGFsbCBzeW1saW5r
cyAoaW1wbGllZCBieSBkZWZhdWx0KVxuIiBcCiAgICAgICAgIgktcAlQcmVzZXJ2ZSBmaWxlIGF0
dHJpYnV0ZXMgaWYgcG9zc2libGVcbiIgXAogICAgICAgICIJLWYJRm9yY2UsIG92ZXJ3cml0ZVxu
IiBcCiAgICAgICAgIgktaQlJbnRlcmFjdGl2ZSwgcHJvbXB0IGJlZm9yZSBvdmVyd3JpdGVcbiIg
XAogICAgICAgICIJLVIsLXIJQ29weSBkaXJlY3RvcmllcyByZWN1cnNpdmVseVxuIiBcCi0gICAg
ICAgIgktbCwtcwlDcmVhdGUgKHN5bSlsaW5rcyIKKyAgICAgICAiCS1sLC1zCUNyZWF0ZSAoc3lt
KWxpbmtzXG4iCiAKICNkZWZpbmUgY3Bpb190cml2aWFsX3VzYWdlIFwKICAgICAgICAiLVtkaW10
dXZdW0YgY3Bpb2ZpbGVdIgpAQCAtMTI5OSw5ICsxMzAyLDEwIEBACiAjZGVmaW5lIGlkX2Z1bGxf
dXNhZ2UgXAogICAgICAgICJQcmludCBpbmZvcm1hdGlvbiBmb3IgVVNFUk5BTUUgb3IgdGhlIGN1
cnJlbnQgdXNlciIgXAogICAgICAgICJcblxuT3B0aW9uczpcbiIgXAotCVVTRV9TRUxJTlVYKCBc
Ci0gICAgICAgIgktYwlQcmludHMgb25seSB0aGUgc2VjdXJpdHkgY29udGV4dFxuIikgXAotICAg
ICAgICIJLWcJUHJpbnRzIG9ubHkgdGhlIGdyb3VwIElEXG4iIFwKKwlVU0FHRV9TRUxJTlVYKCBc
CisgICAgICAgIgktWglwcmludHMgb25seSB0aGUgc2VjdXJpdHkgY29udGV4dFxuIiBcCisJKSBc
CisJICAgIgktZwlQcmludHMgb25seSB0aGUgZ3JvdXAgSURcbiIJCQkJCQlcCiAgICAgICAgIgkt
dQlQcmludHMgb25seSB0aGUgdXNlciBJRFxuIiBcCiAgICAgICAgIgktbglQcmludCBhIG5hbWUg
aW5zdGVhZCBvZiBhIG51bWJlclxuIiBcCiAgICAgICAgIgktcglQcmludHMgdGhlIHJlYWwgdXNl
ciBJRCBpbnN0ZWFkIG9mIHRoZSBlZmZlY3RpdmUgSUQiCkBAIC0xNTE5LDcgKzE1MjMsMTAgQEAK
ICAgICAgICAiCS1tCVNldCBwZXJtaXNzaW9uIG1vZGVzXG4iIFwKICAgICAgICAiCS1vCVNldCBv
d25lcnNoaXBcbiIgXAogICAgICAgICIJLXAJUHJlc2VydmUgZGF0ZVxuIiBcCi0gICAgICAgIgkt
cwlTdHJpcCBzeW1ib2wgdGFibGVzIgorICAgICAgICIgICAgLXMgIFN0cmlwIHN5bWJvbCB0YWJs
ZXNcbiIgXAorCVVTQUdFX1NFTElOVVgoIFwKKyAgICAgICAiCVoJU2V0IHNlY3VyaXR5IGNvbnRl
eHQgb2YgY29weSIgXAorCSkKIAogI2RlZmluZSBpcF90cml2aWFsX3VzYWdlIFwKICAgICAgICAi
W09QVElPTlNdIHthZGRyZXNzIHwgbGluayB8IHJvdXRlIHwgdHVubmVsIHwgcnVsZX0ge0NPTU1B
TkR9IgpAQCAtMTgyOSw3ICsxODM2LDkgQEAKIAlVU0VfU0VMSU5VWCggXAogICAgICAgICJcbgkt
awlQcmludCBzZWN1cml0eSBjb250ZXh0IikgXAogCVVTRV9TRUxJTlVYKCBcCi0gICAgICAgIlxu
CS1LCVByaW50IHNlY3VyaXR5IGNvbnRleHQgaW4gbG9uZyBmb3JtYXQiKQorICAgICAgICJcbgkt
SwlQcmludCBzZWN1cml0eSBjb250ZXh0IGluIGxvbmcgZm9ybWF0IikgXAorCVVTRV9TRUxJTlVY
KCBcCisJIlxuCS1aCVByaW50IHNlY3VyaXR5IGNvbnRleHQgYW5kIHBlcm1pc3Npb24iKQogCiAj
ZGVmaW5lIGxzYXR0cl90cml2aWFsX3VzYWdlIFwKICAgICAgICAiWy1SYWRsdl0gW2ZpbGVzLi4u
XSIKQEAgLTE5NzQsNyArMTk4MywxMSBAQAogICAgICAgICJDcmVhdGUgdGhlIERJUkVDVE9SWShp
ZXMpIGlmIHRoZXkgZG8gbm90IGFscmVhZHkgZXhpc3QiIFwKICAgICAgICAiXG5cbk9wdGlvbnM6
XG4iIFwKICAgICAgICAiCS1tCVNldCBwZXJtaXNzaW9uIG1vZGUgKGFzIGluIGNobW9kKSwgbm90
IHJ3eHJ3eHJ3eCAtIHVtYXNrXG4iIFwKLSAgICAgICAiCS1wCU5vIGVycm9yIGlmIGV4aXN0aW5n
LCBtYWtlIHBhcmVudCBkaXJlY3RvcmllcyBhcyBuZWVkZWQiCisgICAgICAgIgktcAlObyBlcnJv
ciBpZiBleGlzdGluZywgbWFrZSBwYXJlbnQgZGlyZWN0b3JpZXMgYXMgbmVlZGVkXG4iCVwKKwlV
U0FHRV9TRUxJTlVYKCBcCisgICAgICAgIgktWglzZXQgc2VjdXJpdHkgY29udGV4dCIgXAorCSkK
KwogI2RlZmluZSBta2Rpcl9leGFtcGxlX3VzYWdlIFwKICAgICAgICAiJCBta2RpciAvdG1wL2Zv
b1xuIiBcCiAgICAgICAgIiQgbWtkaXIgL3RtcC9mb29cbiIgXApAQCAtMjAxOSw3ICsyMDMyLDEw
IEBACiAjZGVmaW5lIG1rZmlmb19mdWxsX3VzYWdlIFwKICAgICAgICAiQ3JlYXRlIGEgbmFtZWQg
cGlwZSAoaWRlbnRpY2FsIHRvICdta25vZCBuYW1lIHAnKSIgXAogICAgICAgICJcblxuT3B0aW9u
czpcbiIgXAotICAgICAgICIJLW0JQ3JlYXRlIHRoZSBwaXBlIHVzaW5nIHRoZSBzcGVjaWZpZWQg
bW9kZSAoZGVmYXVsdCBhPXJ3KSIKKyAgICAgICAiCS1tCUNyZWF0ZSB0aGUgcGlwZSB1c2luZyB0
aGUgc3BlY2lmaWVkIG1vZGUgKGRlZmF1bHQgYT1ydylcbiIgXAorCVVTQUdFX1NFTElOVVgoIFwK
KyAgICAgICAiCS1aCXNldCBzZWN1cml0eSBjb250ZXh0IiBcCisJKQogCiAjZGVmaW5lIG1rZnNf
bWluaXhfdHJpdmlhbF91c2FnZSBcCiAgICAgICAgIlstYyB8IC1sIGZpbGVuYW1lXSBbLW5YWF0g
Wy1pWFhdIC9kZXYvbmFtZSBbYmxvY2tzXSIKQEAgLTIwNDEsNyArMjA1NywxMSBAQAogICAgICAg
ICJcblxuVFlQRXMgaW5jbHVkZTpcbiIgXAogICAgICAgICIJYjoJTWFrZSBhIGJsb2NrIChidWZm
ZXJlZCkgZGV2aWNlXG4iIFwKICAgICAgICAiCWMgb3IgdToJTWFrZSBhIGNoYXJhY3RlciAodW4t
YnVmZmVyZWQpIGRldmljZVxuIiBcCi0gICAgICAgIglwOglNYWtlIGEgbmFtZWQgcGlwZS4gTUFK
T1IgYW5kIE1JTk9SIGFyZSBpZ25vcmVkIGZvciBuYW1lZCBwaXBlcyIKKyAgICAgICAiCXA6CU1h
a2UgYSBuYW1lZCBwaXBlLiBNQUpPUiBhbmQgTUlOT1IgYXJlIGlnbm9yZWQgZm9yIG5hbWVkIHBp
cGVzXG4iIFwKKwlVU0FHRV9TRUxJTlVYKCBcCisgICAgICAgIgktWglzZXQgc2VjdXJpdHkgY29u
dGV4dCIgXAorCSkKKwogI2RlZmluZSBta25vZF9leGFtcGxlX3VzYWdlIFwKICAgICAgICAiJCBt
a25vZCAvZGV2L2ZkMCBiIDIgMFxuIiBcCiAgICAgICAgIiQgbWtub2QgLW0gNjQ0IC90bXAvcGlw
ZSBwXG4iCkBAIC0yOTAxLDYgKzI5MjEsOSBAQAogICAgICAgICIJLWYJRGlzcGxheSBmaWxlc3lz
dGVtIHN0YXR1c1xuIiBcCiAgICAgICAgIgktTCwtbAlEZXJlZmVyZW5jZSBsaW5rc1xuIiBcCiAg
ICAgICAgIgktdAlEaXNwbGF5IGluZm8gaW4gdGVyc2UgZm9ybSIgXAorCVVTQUdFX1NFTElOVVgo
IFwKKyAgICAgICAiCS1aCXByaW50IHNlY3VyaXR5IGNvbnRleHRcbiIgXAorCSkgXAogCVVTRV9G
RUFUVVJFX1NUQVRfRk9STUFUKCBcCiAgICAgICAgIlxuXG5WYWxpZCBmb3JtYXQgc2VxdWVuY2Vz
IGZvciBmaWxlczpcbiIgXAogICAgICAgICIgJWEJQWNjZXNzIHJpZ2h0cyBpbiBvY3RhbFxuIiBc
CkBAIC0yOTM1LDYgKzI5NTgsOSBAQAogICAgICAgICIgJWMJVG90YWwgZmlsZSBub2RlcyBpbiBm
aWxlIHN5c3RlbVxuIiBcCiAgICAgICAgIiAlZAlGcmVlIGZpbGUgbm9kZXMgaW4gZmlsZSBzeXN0
ZW1cbiIgXAogICAgICAgICIgJWYJRnJlZSBibG9ja3MgaW4gZmlsZSBzeXN0ZW1cbiIgXAorCVVT
QUdFX1NFTElOVVgoIFwKKyAgICAgICAiCSVDCVNlY3VyaXR5IGNvbnRleHQgaW4gU0VMaW51eFxu
IiBcCisJKSBcCiAgICAgICAgIiAlaQlGaWxlIFN5c3RlbSBJRCBpbiBoZXhcbiIgXAogICAgICAg
ICIgJWwJTWF4aW11bSBsZW5ndGggb2YgZmlsZW5hbWVzXG4iIFwKICAgICAgICAiICVuCUZpbGUg
bmFtZVxuIiBcCg==

--Multipart=_Fri__9_Feb_2007_18_47_41_+0900_Ia8T7ru=IvOx7X5Y--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
