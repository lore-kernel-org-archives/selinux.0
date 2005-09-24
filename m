Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8QCcSNs010992
	for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2005 08:38:28 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8QCXIqv018323
	for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2005 12:33:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com,
   Joshua Brindle <jbrindle@tresys.com>
Subject: kickstart install of rawhide with SE Linux MCS policy
Date: Sat, 24 Sep 2005 17:06:33 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CsPNDltJ7txpTpx"
Message-Id: <200509241706.42713.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_CsPNDltJ7txpTpx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As you have probably noticed there are kudzu dependencies that make upgrading 
a machine to rawhide a PITA.

As an easy method of installing a MCS machine I've created a kick-start config 
for it.  Firstly you have to have a kickstart server (have copied all FC4 
files to the server and made suitable configuration to the DHCP server or 
whatever - neither of these lists is appropriate for the details of 
kick-start configuration so I won't try to explain).

The file ks.cfg refers to "SERV" which should be replaced by the IP address of 
the NFS and web server used.  The file archive.tgz (attached) needs to be on 
the web server (modifying ks.cfg to have it use an NFS server instead is easy 
enough).  The file rpms.tar referenced in the ks.cfg file needs to contain 
the following packages from rawhide (or newer versions if available).

checkpolicy-1.27.1-1.i386.rpm
glibc-2.3.90-12.i686.rpm
glibc-common-2.3.90-12.i386.rpm
glibc-devel-2.3.90-12.i386.rpm
glibc-headers-2.3.90-12.i386.rpm
hwdata-0.169-1.noarch.rpm
iptables-1.3.2-1.i386.rpm
kernel-2.6.13-1.1567_FC5.i686.rpm
kudzu-1.2.7-1.i386.rpm
libselinux-1.26-6.i386.rpm
libselinux-devel-1.26-6.i386.rpm
libsemanage-1.3.2-1.i386.rpm
libsepol-1.9.4-1.i386.rpm
libsetrans-0.1.7-1.i386.rpm
mkinitrd-4.2.21-1.i386.rpm
module-init-tools-3.2-0.pre7.3.i386.rpm
policycoreutils-1.27.1-1.i386.rpm
procps-3.2.5-7.i386.rpm
selinux-policy-strict-1.27.1-5.noarch.rpm
selinux-policy-strict-sources-1.27.1-5.noarch.rpm
selinux-policy-targeted-1.27.1-4.noarch.rpm
selinux-policy-targeted-sources-1.27.1-4.noarch.rpm
udev-069-3.i386.rpm

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_CsPNDltJ7txpTpx
Content-Type: application/x-gzip;
  name="ks.cfg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="ks.cfg.gz"

H4sICIj5NEMCA2tzLmNmZwB1VVlv3DYQfuevGGTbPhjRap3YRlF0g6S2YwSJk8BbN30rKGokEeJV
ktoL/fEd6lh77eRhuZyZb4Zza3aDBj2PWEKxg49StCFyH+HSmkrWHUmsZzOneKys18vtrxcv4d3t
1cXZS7AePpiICq5vL87+ZGy22oWIGkBxU3e8RpYugOaf+xWbfRqZoG3ZKQwQLUhDjynV40LnnKWH
R/hoq8VdYbkv2XSBLhyE2nYB2XASL7Gi1Li3Btl0gSzrooB3XYieK8nzW1SF7TxBZnfWRnA8hI2l
FzxRbgOnr16fnV+QEIsk5lVEPznKo7SGzXwvYrMPAxe+rHoA8hJsBZ2rPS+RTcHN7gPC5dXdl9sj
M6CxlJzNROmtHkDfsHjyUudVCoDOJkb3W56vru/+yitxNih8fr86tnnb2zRVIK2Afo1+mTSAyFL6
ZY7blOMwWBizmGJRljz2IA5FT68/EmSZsqLnLnXhgc0uFXIPsUG45SFl6I+UrDsUKZN7pJAItkOq
1VfqJtk7J5KOpI6QJvXS8EjPdKnjsizlMsukkVHxgvqKza5kaMFNFp7q9mp5X6Ysq0LcOQTcxtcp
eLlHOF0sktXgvNTc72BQcOv56WKELE/pUnu7eYxja6uI1zlY14sBzpStiQv5s4cM17j0gwvruqeS
1mj+fLE46IYNdw/qI9UrjPfvqh/KxLvYWC/3Q6FTGsYsJEEqME1BaHhJsRCBhhcKdXlOSfyMkRq8
PUqdGXlZltLnvI12WTYiuVHiWgpcYmySH40NcYiRbxpJbT17Lz1uUqmOu6Wa2NPjZYoiNOTA6vqT
NN32iUJA1XMTnhwTVF0quAVDuZyQCH9/k4ZiCiy00m1TO4k2bZGx7Y+C+tkNQuq6t1DwgNk23Wpj
NVJYoY3WJQYNCW21HkWj6hopuKK2ozamtLC3EKm2D7Tamd7MBotxphKluVSPSEoaKus0mphFa1Ug
ZyhzTLc0d5A5yDGKfNfpuUcSzMu8M1Swkun1c9HJD9GihDxqxzY1xqOVwL1o5Brnsd4/F3qnw5y2
OqMfbNcVHBheP9yT7RGxr/pnjqwS9BmPkTJkCJYaqJIKJ5oLJ0vgTpfghBaSZyJMskJ1uKedLNWB
5bFseMxUKEB07sCmNXaMo0631YGqhchqKj7tdQNKFtN9kstQmrP22IJzjgLO6M8ibNa0LNUkioJ6
VawPUE1ZjDvQtI6EpW9NFyOjno1DsyIsBuD9kJWTeaJevfnlFP6jpkIapDUEU867UBxS14PGpGVS
95+7vAs+p7n1mPvG5Cc3X29OaGO0raSN8i9kpt/k/aSkvbGkz5gU5AmNar/58tp3RX/M09B8lzkv
eEuulymsFyFP2+qn/oTD5C0X+Qv4/Yfa8Oa7IvY/xcpVKj4IAAA=

--Boundary-00=_CsPNDltJ7txpTpx
Content-Type: application/x-tgz;
  name="archive.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="archive.tgz"

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

--Boundary-00=_CsPNDltJ7txpTpx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
