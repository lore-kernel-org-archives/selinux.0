Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4MGCYSV013194
 for <selinux@tycho.nsa.gov>; Fri, 22 May 2015 12:12:34 -0400
Received: by wicmc15 with SMTP id mc15so44616165wic.1
 for <selinux@tycho.nsa.gov>; Fri, 22 May 2015 09:12:13 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 22 May 2015 11:12:13 -0500
Message-ID: <CAFPpqQHQ5n=4chF3hCbQMQfU6yZ9KgjoVyotGCg6FA1RDdtxiw@mail.gmail.com>
Subject: string_to_av_perm behavior
From: Ted Toth <txtoth@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=089e013c6b344f05cc0516adec05
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e013c6b344f05cc0516adec05
Content-Type: text/plain; charset=UTF-8

./avperm
1 - av_perm 0
security class: 66
class db_tuple av select
2 - av_perm 8
3 - av_perm 8

why does the first call to string_to_av_perm return 0 something seem wrong here.

Ted

--089e013c6b344f05cc0516adec05
Content-Type: text/x-csrc; charset=US-ASCII; name="avperm.c"
Content-Disposition: attachment; filename="avperm.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i9zsxuoh0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzZWxpbnV4L3NlbGludXguaD4KI2luY2x1ZGUg
PHNlbGludXgvZmxhc2suaD4KI2luY2x1ZGUgPHNlbGludXgvYXZfcGVybWlzc2lvbnMuaD4KCmlu
dCBtYWluKGludCBhcmdjLCBjaGFyKiphcmd2KSB7CiAgY29uc3QgY2hhciAqcGVybV9uYW1lID0g
InNlbGVjdCI7CiAgY29uc3QgY2hhciAqY2xhc3NfbmFtZSA9ICJkYl90dXBsZSI7CiAgYWNjZXNz
X3ZlY3Rvcl90IGF2X3Blcm07CiAgc2VjdXJpdHlfY2xhc3NfdCBzZWNfY2xhc3M7CgogIGF2X3Bl
cm0gPSAwOwogIHNlY19jbGFzcyA9IFNFQ0NMQVNTX0RCX1RVUExFOwoKICBhdl9wZXJtID0gc3Ry
aW5nX3RvX2F2X3Blcm0oc2VjX2NsYXNzLCBwZXJtX25hbWUpOwogIHByaW50ZigiMSAtIGF2X3Bl
cm0gJWRcbiIsIGF2X3Blcm0pOwoKICBzZWNfY2xhc3MgPSBzdHJpbmdfdG9fc2VjdXJpdHlfY2xh
c3MoY2xhc3NfbmFtZSk7CiAgcHJpbnRmKCJzZWN1cml0eSBjbGFzczogJWRcbiIsIHNlY19jbGFz
cyk7CiAgYXZfcGVybSA9IDA7CiAgYXZfcGVybSA9IHN0cmluZ190b19hdl9wZXJtKHNlY19jbGFz
cywgcGVybV9uYW1lKTsKICBwcmludGYoImNsYXNzICVzIGF2ICVzXG4iLCBzZWN1cml0eV9jbGFz
c190b19zdHJpbmcoU0VDQ0xBU1NfREJfVFVQTEUpLCBzZWN1cml0eV9hdl9wZXJtX3RvX3N0cmlu
ZyhTRUNDTEFTU19EQl9UVVBMRSwgREJfVFVQTEVfX1NFTEVDVCkpOwogIHByaW50ZigiMiAtIGF2
X3Blcm0gJWRcbiIsIGF2X3Blcm0pOwogIGF2X3Blcm0gPSAwOwogIGF2X3Blcm0gPSBzdHJpbmdf
dG9fYXZfcGVybShTRUNDTEFTU19EQl9UVVBMRSwgcGVybV9uYW1lKTsKICBwcmludGYoIjMgLSBh
dl9wZXJtICVkXG4iLCBhdl9wZXJtKTsKCn0K
--089e013c6b344f05cc0516adec05--
