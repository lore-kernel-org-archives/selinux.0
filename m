Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA15787
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 11:06:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA22407
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 15:04:48 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA22403 for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 15:04:48 GMT
Date: Fri, 26 Jul 2002 11:05:55 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Brian May <bam@snoopy.apana.org.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: [patch] Re: Policy questions
In-Reply-To: <20020726030213.GB27354@snoopy.apana.org.au>
Message-ID: <Pine.GSO.4.33.0207261050430.20783-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1903590565-1027695852=:20783"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1903590565-1027695852=:20783
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.33.0207261105381.20783@raven>


On Fri, 26 Jul 2002, Brian May wrote:

> The writeable_t type is also a source of puzzlement to me, those files
> need to be read by most/all processes, not written!

After removing the locale -> writeable_t entries from types.fc and
relabeling, I don't seem to be encountering any denials.  Without specific
entries, /usr/lib/locale/.*/LC_.* is left in lib_t and
/usr/share/locale/.*/LC_.8 is left in usr_t.  I'd suggest simply removing
these entries from types.fc.  You can then remove the corresponding 'allow
... writeable_t' rules from several domains or replace them with rules
granting read access to usr_t and lib_t if they don't already have such
access.

The attached patch removes these entries from types.fc.  I've committed
this patch plus corresponding changes to several domains to the
sourceforge CVS.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1903590565-1027695852=:20783
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="writeable.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0207261104120.20783@raven>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="writeable.patch"

SW5kZXg6IHNlbGludXgvcG9saWN5L2ZpbGVfY29udGV4dHMvdHlwZXMuZmMN
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3Zzcm9vdC9z
ZWxpbnV4L25zYS9zZWxpbnV4L3BvbGljeS9maWxlX2NvbnRleHRzL3R5cGVz
LmZjLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4zDQpkaWZmIC11IC1yMS4z
IHR5cGVzLmZjDQotLS0gc2VsaW51eC9wb2xpY3kvZmlsZV9jb250ZXh0cy90
eXBlcy5mYwkxMiBKdWwgMjAwMiAxNToxOTo0NCAtMDAwMAkxLjMNCisrKyBz
ZWxpbnV4L3BvbGljeS9maWxlX2NvbnRleHRzL3R5cGVzLmZjCTI2IEp1bCAy
MDAyIDE0OjMzOjEzIC0wMDAwDQpAQCAtMTk2LDEwICsxOTQsOCBAQA0KIC91
c3IvbGliL2F1dG9mcy8uKlwuc28JCXN5c3RlbV91Om9iamVjdF9yOnNobGli
X3QNCiAvdXNyL2xpYi9wZXJsNS9tYW4oLy4qKT8Jc3lzdGVtX3U6b2JqZWN0
X3I6bWFuX3QNCiAvdXNyL2xpYi9wZXJsLipcLnNvCQlzeXN0ZW1fdTpvYmpl
Y3RfcjpzaGxpYl90DQotL3Vzci9saWIvbG9jYWxlLy4qL0xDXy4qIAlzeXN0
ZW1fdTpvYmplY3Rfcjp3cml0ZWFibGVfdA0KIC91c3IvbGliL3NlbGludXgo
Ly4qKT8JCXN5c3RlbV91Om9iamVjdF9yOnBvbGljeV9zcmNfdA0KIC91c3Iv
bGliL2VtYWNzZW4tY29tbW9uLy4qCXN5c3RlbV91Om9iamVjdF9yOmJpbl90
DQotL3Vzci9zaGFyZS9sb2NhbGUvLiovTENfLiogCXN5c3RlbV91Om9iamVj
dF9yOndyaXRlYWJsZV90DQogL3Vzci9zaGFyZS9zZWxpbnV4KC8uKik/CXN5
c3RlbV91Om9iamVjdF9yOnBvbGljeV9zcmNfdA0KIC91c3IvZ2FtZXMoLy4q
KT8JCXN5c3RlbV91Om9iamVjdF9yOmJpbl90DQogDQo=
---559023410-1903590565-1027695852=:20783--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
