Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8O6iarT015436
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 02:44:37 -0400 (EDT)
Received: from mail-router02.qut.edu.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8O6iXrq014839
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 06:44:35 GMT
Date: Fri, 24 Sep 2004 16:44:26 +1000
From: Mark Huth <mc.huth@qut.edu.au>
Subject: file context patches
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <4ed82715.84b7e17d.81fae00@mail-msgstore01.qut.edu.au>
Content-Type: multipart/mixed;
	boundary="-----d87fb3e36c0fbab622756044dd8f81c2"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


-------d87fb3e36c0fbab622756044dd8f81c2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi 

I'm currently experimenting with running User Mode Linux under
SELinux (on Fedora) and found a small change that needs to be
made to the uml.fc file.  See the included patch.  Also found
some updates that need to be made to the zebra.fc and
nagios.fc files.

Now for some other stuff:

I was wondering what are the differences between policy 17 and
policy 18?  I found some info on the hardened gentoo site
about the policies up to 17 but see we are now up to 18.

Also, I've just done a yum update against the development
tree, relabelled and tried booting into SELinux enforcing mode
but it failed with heaps of denied messages regarding tmpfs_t.
 A couple of other errors of note were:

/sbin/restorecon get context on /dev failed: 'Operation not
supported'
/sbin/restorecon get context on /dev/null failed: 'Operation
not supported'

Soon after that the boot process stops with a 'Give root
password for maintainence' message.  Any ideas on what might
be wrong?

Thanks

-------d87fb3e36c0fbab622756044dd8f81c2
Content-Type: text/plain;
	name="diff.txt"
Content-Disposition: inline;
	filename="diff.txt"
Content-Transfer-Encoding: base64

ZGlmZiAtdSAvZXRjL3NlbGludXgvc3RyaWN0L3NyYy9wb2xpY3kvZmlsZV9jb250ZXh0cy9w
cm9ncmFtL25hZ2lvcy5mYyBmaWxlX2NvbnRleHRzL3Byb2dyYW0vbmFnaW9zLmZjCi0tLSAv
ZXRjL3NlbGludXgvc3RyaWN0L3NyYy9wb2xpY3kvZmlsZV9jb250ZXh0cy9wcm9ncmFtL25h
Z2lvcy5mYwkyMDA0LTA5LTIyIDA2OjUwOjUzLjAwMDAwMDAwMCArMTAwMAorKysgZmlsZV9j
b250ZXh0cy9wcm9ncmFtL25hZ2lvcy5mYwkyMDA0LTA5LTI0IDE0OjE1OjQxLjAwMDAwMDAw
MCArMTAwMApAQCAtNSwzICs1LDkgQEAKIC92YXIvbG9nL25ldHNhaW50KC8uKik/CQkJc3lz
dGVtX3U6b2JqZWN0X3I6bmFnaW9zX2xvZ190CiAvdXNyL2xpYig2NCk/L25ldHNhaW50L3Bs
dWdpbnMoLy4qKT8JCXN5c3RlbV91Om9iamVjdF9yOmJpbl90CiAvdXNyL2xpYig2NCk/L2Nn
aS1iaW4vbmV0c2FpbnQvLisJLS0Jc3lzdGVtX3U6b2JqZWN0X3I6bmFnaW9zX2NnaV9leGVj
X3QKKyMgbmFnaW9zCisvdXNyL2Jpbi9uYWdpb3MJCQktLQlzeXN0ZW1fdTpvYmplY3Rfcjpu
YWdpb3NfZXhlY190CisvZXRjL25hZ2lvcygvLiopPwkJCXN5c3RlbV91Om9iamVjdF9yOm5h
Z2lvc19ldGNfdAorL3Zhci9sb2cvbmFnaW9zKC8uKik/CQkJc3lzdGVtX3U6b2JqZWN0X3I6
bmFnaW9zX2xvZ190CisvdXNyL2xpYig2NCk/L25hZ2lvcy9wbHVnaW5zKC8uKik/CXN5c3Rl
bV91Om9iamVjdF9yOmJpbl90CisvdXNyL2xpYig2NCk/L25hZ2lvcy9jZ2kvLisJLS0Jc3lz
dGVtX3U6b2JqZWN0X3I6bmFnaW9zX2NnaV9leGVjX3QKZGlmZiAtdSAvZXRjL3NlbGludXgv
c3RyaWN0L3NyYy9wb2xpY3kvZmlsZV9jb250ZXh0cy9wcm9ncmFtL3VtbC5mYyBmaWxlX2Nv
bnRleHRzL3Byb2dyYW0vdW1sLmZjCi0tLSAvZXRjL3NlbGludXgvc3RyaWN0L3NyYy9wb2xp
Y3kvZmlsZV9jb250ZXh0cy9wcm9ncmFtL3VtbC5mYwkyMDA0LTA5LTIyIDA2OjUwOjUzLjAw
MDAwMDAwMCArMTAwMAorKysgZmlsZV9jb250ZXh0cy9wcm9ncmFtL3VtbC5mYwkyMDA0LTA5
LTI0IDE0OjA3OjQ0LjAwMDAwMDAwMCArMTAwMApAQCAtMSw0ICsxLDQgQEAKICMgVXNlciBN
b2RlIExpbnV4CiAvdXNyL2Jpbi91bWxfc3dpdGNoCS0tCXN5c3RlbV91Om9iamVjdF9yOnVt
bF9zd2l0Y2hfZXhlY190CiAvdmFyL3J1bi91bWwtdXRpbGl0aWVzKC8uKik/CXN5c3RlbV91
Om9iamVjdF9yOnVtbF9zd2l0Y2hfdmFyX3J1bl90Ci0vaG9tZS9bXi9dKy8udW1sKC8uKik/
CQlzeXN0ZW1fdTpvYmplY3Rfcjp1c2VyX3VtbF9yd190CitIT01FX0RJUi9cLnVtbCgvLiop
PwkJc3lzdGVtX3U6b2JqZWN0X3I6Uk9MRV91bWxfcndfdApkaWZmIC11IC9ldGMvc2VsaW51
eC9zdHJpY3Qvc3JjL3BvbGljeS9maWxlX2NvbnRleHRzL3Byb2dyYW0vemVicmEuZmMgZmls
ZV9jb250ZXh0cy9wcm9ncmFtL3plYnJhLmZjCi0tLSAvZXRjL3NlbGludXgvc3RyaWN0L3Ny
Yy9wb2xpY3kvZmlsZV9jb250ZXh0cy9wcm9ncmFtL3plYnJhLmZjCTIwMDQtMDktMjIgMDY6
NTA6NTMuMDAwMDAwMDAwICsxMDAwCisrKyBmaWxlX2NvbnRleHRzL3Byb2dyYW0vemVicmEu
ZmMJMjAwNC0wOS0yNCAxNDoxMjowOC4wMDAwMDAwMDAgKzEwMDAKQEAgLTUsMyArNSw5IEBA
CiAvZXRjL3plYnJhKC8uKik/CQlzeXN0ZW1fdTpvYmplY3Rfcjp6ZWJyYV9jb25mX3QKIC92
YXIvcnVuLy56c2VydgkJLXMJc3lzdGVtX3U6b2JqZWN0X3I6emVicmFfdmFyX3J1bl90CiAv
dmFyL3J1bi8uemVicmEJCS1zCXN5c3RlbV91Om9iamVjdF9yOnplYnJhX3Zhcl9ydW5fdAor
IyBRdWFnZ2EKKy91c3Ivc2Jpbi9yaXAuKiAgCS0tCXN5c3RlbV91Om9iamVjdF9yOnplYnJh
X2V4ZWNfdAorL3Vzci9zYmluL29zcGYuKiAgCS0tCXN5c3RlbV91Om9iamVjdF9yOnplYnJh
X2V4ZWNfdAorL2V0Yy9xdWFnZ2EoLy4qKT8JCXN5c3RlbV91Om9iamVjdF9yOnplYnJhX2Nv
bmZfdAorL3Zhci9sb2cvcXVhZ2dhKC8uKik/CQlzeXN0ZW1fdTpvYmplY3Rfcjp6ZWJyYV9s
b2dfdAorL3Zhci9ydW4vcXVhZ2dhKC8uKik/CQlzeXN0ZW1fdTpvYmplY3Rfcjp6ZWJyYV92
YXJfcnVuX3QK

-------d87fb3e36c0fbab622756044dd8f81c2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
