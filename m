Message-ID: <4B07F64B.1070407@kaigai.gr.jp>
Date: Sat, 21 Nov 2009 23:16:43 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: selabel_*() support for database objects
References: <4B050008.3010201@ak.jp.nec.com> <4B0757F5.5080902@tycho.nsa.gov>
In-Reply-To: <4B0757F5.5080902@tycho.nsa.gov>
Content-Type: multipart/mixed;
 boundary="------------020006060906080906070909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020006060906080906070909
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Eamon Walsh wrote:
> On 11/19/2009 03:21 AM, KaiGai Kohei wrote:
>> This patch allows selabel_*() interfaces to provide an expected security context
>> for the given database object identified by its name and object class.
>> It is necessary to implement a feature something like the restorecon on databases.
> 
> The patch is whitespace damaged, can you re-send it as a text attachment.
> 

Does the attached one still damaged?

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------020006060906080906070909
Content-Type: application/octect-stream;
 name="selabel-db-support.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="selabel-db-support.patch"

IGluY2x1ZGUvc2VsaW51eC9sYWJlbC5oICAgICAgICAgICAgICAgfCAgIDExICsKIGluY2x1
ZGUvc2VsaW51eC9zZWxpbnV4LmggICAgICAgICAgICAgfCAgICAxIAogbWFuL21hbjMvc2Vs
YWJlbF9vcGVuLjMgICAgICAgICAgICAgICB8ICAgMTAgLQogbWFuL21hbjMvc2VsaW51eF9i
aW5hcnlfcG9saWN5X3BhdGguMyB8ICAgIDYgCiBtYW4vbWFuNS9zZWxhYmVsX2RiLjUgICAg
ICAgICAgICAgICAgIHwgICA5MyArKysrKysrKysKIHNyYy9maWxlX3BhdGhfc3VmZml4ZXMu
aCAgICAgICAgICAgICAgfCAgICAxIAogc3JjL2xhYmVsLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgIDMgCiBzcmMvbGFiZWxfZGIuYyAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDMzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBzcmMvbGFiZWxf
aW50ZXJuYWwuaCAgICAgICAgICAgICAgICAgIHwgICAgMiAKIHNyYy9zZWxpbnV4X2NvbmZp
Zy5jICAgICAgICAgICAgICAgICAgfCAgICA5IAogc3JjL3NlbGludXhfaW50ZXJuYWwuaCAg
ICAgICAgICAgICAgICB8ICAgIDEgCiAxMSBmaWxlcyBjaGFuZ2VkLCA0NjYgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkK
--------------020006060906080906070909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
