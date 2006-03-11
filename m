Message-ID: <4412C1CD.6080808@redhat.com>
Date: Sat, 11 Mar 2006 07:25:49 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: =?UTF-8?B?VmlsbGUgU2t5dHTDpA==?= <ville.skytta@iki.fi>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: w3c.te module policy
References: <1140879631.15616.46.camel@bobcat.mine.nu>	 <4411F026.4070508@redhat.com> <1142072726.19009.30.camel@bobcat.mine.nu>
In-Reply-To: <1142072726.19009.30.camel@bobcat.mine.nu>
Content-Type: multipart/mixed;
 boundary="------------040005090305020506010407"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040005090305020506010407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ville has been trying to build a modular policy package for w3c.  He 
created te,fc,if files similar to the ones I have attached.  The problem 
is that when he compiles them he ends up with avc messages suggesting he 
needs these additional rules:

allow httpd_t httpd_w3c_script_exec_t:file { execute execute_no_trans 
getattr ioctl read };

I have duplicated this on my machine.

 From my reading of the generated policy these should already exist.  
Examining the tmp/w3c.tmp file it looks like they are there (except for 
the execute_no_trans).  They are wrapped in a boolean though.  Is there 
something wrong in policy modules handling of booleans?



--------------040005090305020506010407
Content-Type: text/plain;
 name="w3c.te"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="w3c.te"

cG9saWN5X21vZHVsZSh3M2MsMS4yLjEpCgphcGFjaGVfY29udGVudF90ZW1wbGF0ZSh3M2Mp
CgpzeXNuZXRfZG5zX25hbWVfcmVzb2x2ZShodHRwZF93M2Nfc2NyaXB0X3QpCgojIGFsbG93
IGh0dHBkX3czY19zY3JpcHRfdCB0byBjb25uZWN0IHRvIGEgcmVsYXkKY29yZW5ldF90Y3Bf
Y29ubmVjdF9nb3BoZXJfcG9ydChodHRwZF93M2Nfc2NyaXB0X3QpCmNvcmVuZXRfdGNwX2Nv
bm5lY3RfZnRwX3BvcnQoaHR0cGRfdzNjX3NjcmlwdF90KQpjb3JlbmV0X3RjcF9jb25uZWN0
X2h0dHBfcG9ydChodHRwZF93M2Nfc2NyaXB0X3QpCmNvcmVuZXRfdGNwX2Nvbm5lY3RfaHR0
cF9jYWNoZV9wb3J0KGh0dHBkX3czY19zY3JpcHRfdCkKCnR1bmFibGVfcG9saWN5KGBodHRw
ZF9jYW5fbmV0d29ya19jb25uZWN0JyxgCgljb3JlbmV0X3RjcF9jb25uZWN0X2FsbF9wb3J0
cyhodHRwZF93M2Nfc2NyaXB0X3QpCicpCgo=
--------------040005090305020506010407
Content-Type: text/plain;
 name="w3c.fc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="w3c.fc"

L3Vzci9zaGFyZS93M2MtbWFya3VwLXZhbGlkYXRvcigvLiopPwkJZ2VuX2NvbnRleHQoc3lz
dGVtX3U6b2JqZWN0X3I6aHR0cGRfY29uZmlnX3QsczApCi91c3Ivc2hhcmUvdzNjLW1hcmt1
cC12YWxpZGF0b3IvY2hlY2sJCWdlbl9jb250ZXh0KHN5c3RlbV91Om9iamVjdF9yOmh0dHBk
X3czY19zY3JpcHRfZXhlY190LHMwKQo=
--------------040005090305020506010407
Content-Type: text/plain;
 name="w3c.if"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="w3c.if"


--------------040005090305020506010407--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
