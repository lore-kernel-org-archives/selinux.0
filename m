Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1H6IikK007278
	for <selinux@tycho.nsa.gov>; Sat, 17 Feb 2007 01:18:44 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1H6Jx5x018528
	for <selinux@tycho.nsa.gov>; Sat, 17 Feb 2007 06:19:59 GMT
Received: by wx-out-0506.google.com with SMTP id s17so1121835wxc
        for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2007 22:19:57 -0800 (PST)
Message-ID: <e739902b0702162219o45a8ccc9v5e5092c9e310c4bb@mail.gmail.com>
Date: Fri, 16 Feb 2007 22:19:57 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Compile error with the SVN version of the refpolicy.
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_17099_26330625.1171693197024"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_17099_26330625.1171693197024
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

I am having a compile problem with the latest SVN check out of the
refpolicy.  Here is the error message:

/usr/bin/checkpolicy policy.conf -o
/etc/selinux/refpolicy/policy/policy.21
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
policy/modules/services/zebra.te:1136:ERROR 'syntax error' at token
'ntfs-3g' on line 1523915:
genfscon msdos / system_u:object_r:dosfs_t
genfscon ntfs-3g / system_u:object_r:dosfs_t
checkpolicy:  error(s) encountered while parsing configuration
make: *** [/etc/selinux/refpolicy/policy/policy.21] Error 1


The problem is that checkpolicy does not appear to like the '-'
character.  I changed the '-' to a '_' in the
policy/modules/kernel/filesystem.te file to fix the compile problem.


If this change is correct, I have provided a patch to someone can apply.

Thanks!

- Ryan

------=_Part_17099_26330625.1171693197024
Content-Type: text/x-patch; name=filesystem.te.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ey9n2l1i
Content-Disposition: attachment; filename="filesystem.te.patch"

SW5kZXg6IHBvbGljeS9tb2R1bGVzL2tlcm5lbC9maWxlc3lzdGVtLnRlCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0t
IHBvbGljeS9tb2R1bGVzL2tlcm5lbC9maWxlc3lzdGVtLnRlCShyZXZpc2lvbiAyMTgxKQorKysg
cG9saWN5L21vZHVsZXMva2VybmVsL2ZpbGVzeXN0ZW0udGUJKHdvcmtpbmcgY29weSkKQEAgLTE1
Myw3ICsxNTMsNyBAQAogYWxsb3cgZG9zZnNfdCBmc190OmZpbGVzeXN0ZW0gYXNzb2NpYXRlOwog
Z2VuZnNjb24gZmF0IC8gZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2JqZWN0X3I6ZG9zZnNfdCxzMCkK
IGdlbmZzY29uIG1zZG9zIC8gZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2JqZWN0X3I6ZG9zZnNfdCxz
MCkKLWdlbmZzY29uIG50ZnMtM2cgLyBnZW5fY29udGV4dChzeXN0ZW1fdTpvYmplY3Rfcjpkb3Nm
c190LHMwKQorZ2VuZnNjb24gbnRmc18zZyAvIGdlbl9jb250ZXh0KHN5c3RlbV91Om9iamVjdF9y
OmRvc2ZzX3QsczApCiBnZW5mc2NvbiBudGZzIC8gZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2JqZWN0
X3I6ZG9zZnNfdCxzMCkKIGdlbmZzY29uIHZmYXQgLyBnZW5fY29udGV4dChzeXN0ZW1fdTpvYmpl
Y3Rfcjpkb3Nmc190LHMwKQogCg==
------=_Part_17099_26330625.1171693197024--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
