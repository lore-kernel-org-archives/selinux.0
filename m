Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA10350
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 10:45:36 -0500 (EST)
From: j.logsdon@lancaster.ac.uk
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA08881
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 15:42:43 GMT
Received: from parmenides.zen.co.uk (parmenides.zen.co.uk [212.23.8.69])
	by jazzswing.ncsc.mil  with SMTP id PAA08877
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 15:42:42 GMT
Received: from localhost (j.logsdon@localhost)
	by quantex-research.com (8.8.7/8.8.7) with ESMTP id PAA23838
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 15:50:31 GMT
Date: Sun, 26 Jan 2003 15:50:31 +0000 (GMT)
To: selinux@tycho.nsa.gov
Subject: Getting closer all the time ...
Message-ID: <Pine.LNX.4.10.10301261453530.8521-300000@mercury.quantex>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811574-2116922502-1043596231=:8521"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811574-2116922502-1043596231=:8521
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi

I now have a compiled kernel that boots OK but the system is still not
usable.  The kernel is based on the NSA version compiled with gcc-3.2-7 on
RH8 with updates to 20th Jan.  I am using reiserfs and ext3 filesystems if
that matters.

The symptoms are that on boot up and at various times during a shell,
there are messages from the kernel thus:

Jan 26 12:51:26 venus kernel: SELinux: initialized (dev 03:42, type
reiserfs), uses PSIDs
Jan 26 12:51:27 venus kernel: SELinux: initialized (dev 00:08, type
tmpfs), uses transition SIDs
Jan 26 12:51:27 venus kernel:
Jan 26 12:51:27 venus kernel: avc:  denied  { getattr } for  pid=136
exe=/sbin/quotaon dev=16:41 ino=2 scontext=system_u:system_r:quota_t
tcontext=system_u:object_r:file_t tclass=dir
Jan 26 12:51:27 venus kernel:
Jan 26 12:51:27 venus kernel: avc:  denied  { write } for  pid=138
exe=/bin/rm path=/.autofsck dev=03:03 ino=3419
scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:file_t
tclass=file

with the entry within {} changing as appropriate I guess.

I can log in (and still get such messages) to a console shell:

Jan 26 12:52:07 venus  -- root[841]: ROOT LOGIN ON tty1 USING
root:user_r:user_t
Jan 26 12:52:08 venus kernel:
Jan 26 12:52:08 venus kernel: avc:  denied  { read } for  pid=849
exe=/bin/bash path=/root dev=03:03 ino=21 scontext=root:user_r:user_t
context=system_u:object_r:sysadm_home_dir_t tclass=dir
Jan 26 12:52:26 venus kernel:
Jan 26 12:52:26 venus kernel: avc:  denied  { search } for  pid=897
exe=/usr/X11R6/bin/xauth path=/root dev=03:03 ino=21
scontext=root:user_r:user_xauth_t
tcontext=system_u:object_r:sysadm_home_dir_t tclass=dir
Jan 26 12:52:26 venus kernel:
Jan 26 12:52:26 venus kernel: avc:  denied  { write } for  pid=897
exe=/usr/X11R6/bin/xauth path=/root dev=03:03 ino=21
scontext=root:user_r:user_xauth_t
tcontext=system_u:object_r:sysadm_home_dir_t tclass=dir
Jan 26 12:52:26 venus kernel:
Jan 26 12:52:26 venus kernel: avc:  denied  { add_name } for  pid=897
exe=/usr/X11R6/bin/xauth path=/root/.Xauthority-c
scontext=root:user_r:user_xauth_t
tcontext=system_u:object_r:sysadm_home_dir_t tclass=dir
Jan 26 12:52:26 venus kernel:

but when I try and start X the system hangs after giving the last few
messages above and I have to resort to the hard reboot - blessing reiserfs
at the same time!

I seem to be close but not yet there.  I expect that there is something
silly that I haven't done (like reading the appropriate instruction) but
maybe the problem is more complex.

/proc/cpuinfo and .config are attached - I can send the /var/log/messages
if necessary!

Can anyone give me some guidance?

TIA

John

---1463811574-2116922502-1043596231=:8521
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="selinux.config"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10301261550310.8521@mercury.quantex>
Content-Description: .config file
Content-Disposition: attachment; filename="selinux.config"

Q09ORklHX1g4Nj15DQpDT05GSUdfVUlEMTY9eQ0KQ09ORklHX01PRFVMRVM9
eQ0KQ09ORklHX01PRFZFUlNJT05TPXkNCkNPTkZJR19LTU9EPXkNCkNPTkZJ
R19NMzg2PXkNCkNPTkZJR19YODZfTDFfQ0FDSEVfU0hJRlQ9NA0KQ09ORklH
X1JXU0VNX0dFTkVSSUNfU1BJTkxPQ0s9eQ0KQ09ORklHX1g4Nl9QUFJPX0ZF
TkNFPXkNCkNPTkZJR19YODZfTUNFPXkNCkNPTkZJR19OT0hJR0hNRU09eQ0K
Q09ORklHX05FVD15DQpDT05GSUdfUENJPXkNCkNPTkZJR19QQ0lfR09BTlk9
eQ0KQ09ORklHX1BDSV9CSU9TPXkNCkNPTkZJR19QQ0lfRElSRUNUPXkNCkNP
TkZJR19JU0E9eQ0KQ09ORklHX1BDSV9OQU1FUz15DQpDT05GSUdfRUlTQT15
DQpDT05GSUdfU1lTVklQQz15DQpDT05GSUdfQlNEX1BST0NFU1NfQUNDVD15
DQpDT05GSUdfU1lTQ1RMPXkNCkNPTkZJR19LQ09SRV9FTEY9eQ0KQ09ORklH
X0JJTkZNVF9BT1VUPXkNCkNPTkZJR19CSU5GTVRfRUxGPXkNCkNPTkZJR19C
SU5GTVRfTUlTQz15DQpDT05GSUdfUE09eQ0KQ09ORklHX0FQTT1tDQpDT05G
SUdfUE5QPXkNCkNPTkZJR19JU0FQTlA9eQ0KQ09ORklHX0JMS19ERVZfRkQ9
eQ0KQ09ORklHX0JMS19ERVZfUkFNPW0NCkNPTkZJR19CTEtfREVWX1JBTV9T
SVpFPTQwOTYNCkNPTkZJR19QQUNLRVQ9eQ0KQ09ORklHX05FVEZJTFRFUj15
DQpDT05GSUdfVU5JWD15DQpDT05GSUdfSU5FVD15DQpDT05GSUdfSVBfTVVM
VElDQVNUPXkNCkNPTkZJR19JREU9eQ0KQ09ORklHX0JMS19ERVZfSURFPXkN
CkNPTkZJR19CTEtfREVWX0lERURJU0s9eQ0KQ09ORklHX0lERURJU0tfTVVM
VElfTU9ERT15DQpDT05GSUdfQkxLX0RFVl9JREVDRD15DQpDT05GSUdfQkxL
X0RFVl9DTUQ2NDA9eQ0KQ09ORklHX0JMS19ERVZfUloxMDAwPXkNCkNPTkZJ
R19CTEtfREVWX0lERVBDST15DQpDT05GSUdfSURFUENJX1NIQVJFX0lSUT15
DQpDT05GSUdfQkxLX0RFVl9JREVETUFfUENJPXkNCkNPTkZJR19JREVETUFf
UENJX0FVVE89eQ0KQ09ORklHX0JMS19ERVZfSURFRE1BPXkNCkNPTkZJR19C
TEtfREVWX0FETUE9eQ0KQ09ORklHX0JMS19ERVZfUElJWD15DQpDT05GSUdf
UElJWF9UVU5JTkc9eQ0KQ09ORklHX0lERURNQV9BVVRPPXkNCkNPTkZJR19C
TEtfREVWX0lERV9NT0RFUz15DQpDT05GSUdfU0NTST15DQpDT05GSUdfQkxL
X0RFVl9TRD15DQpDT05GSUdfU0RfRVhUUkFfREVWUz00MA0KQ09ORklHX1ND
U0lfREVCVUdfUVVFVUVTPXkNCkNPTkZJR19TQ1NJX01VTFRJX0xVTj15DQpD
T05GSUdfU0NTSV9DT05TVEFOVFM9eQ0KQ09ORklHX1NDU0lfU1lNNTNDOFhY
PXkNCkNPTkZJR19TQ1NJX05DUjUzQzhYWF9ERUZBVUxUX1RBR1M9NA0KQ09O
RklHX1NDU0lfTkNSNTNDOFhYX01BWF9UQUdTPTMyDQpDT05GSUdfU0NTSV9O
Q1I1M0M4WFhfU1lOQz0yMA0KQ09ORklHX05FVERFVklDRVM9eQ0KQ09ORklH
X0RVTU1ZPW0NCkNPTkZJR19ORVRfRVRIRVJORVQ9eQ0KQ09ORklHX05FVF9J
U0E9eQ0KQ09ORklHX05FMjAwMD1tDQpDT05GSUdfTkVUX1BDST15DQpDT05G
SUdfRUVQUk8xMDA9eQ0KQ09ORklHX05FMktfUENJPW0NCkNPTkZJR19JTlBV
VD1tDQpDT05GSUdfSU5QVVRfS0VZQkRFVj1tDQpDT05GSUdfSU5QVVRfTU9V
U0VERVY9bQ0KQ09ORklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9YPTEwMjQN
CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWT03NjgNCkNPTkZJR19W
VD15DQpDT05GSUdfVlRfQ09OU09MRT15DQpDT05GSUdfU0VSSUFMPXkNCkNP
TkZJR19VTklYOThfUFRZUz15DQpDT05GSUdfVU5JWDk4X1BUWV9DT1VOVD0y
NTYNCkNPTkZJR19CVVNNT1VTRT1tDQpDT05GSUdfQVRJWExfQlVTTU9VU0U9
bQ0KQ09ORklHX0xPR0lCVVNNT1VTRT1tDQpDT05GSUdfTVNfQlVTTU9VU0U9
bQ0KQ09ORklHX01PVVNFPXkNCkNPTkZJR19QU01PVVNFPXkNCkNPTkZJR19B
R1A9eQ0KQ09ORklHX0FHUF9JTlRFTD15DQpDT05GSUdfQUdQX0k4MTA9eQ0K
Q09ORklHX0FHUF9WSUE9eQ0KQ09ORklHX0FHUF9BTUQ9eQ0KQ09ORklHX0FH
UF9TSVM9eQ0KQ09ORklHX0FHUF9BTEk9eQ0KQ09ORklHX0RSTT15DQpDT05G
SUdfRFJNX05FVz15DQpDT05GSUdfRFJNX1RERlg9eQ0KQ09ORklHX0RSTV9S
QURFT049eQ0KQ09ORklHX0RSTV9JODEwPXkNCkNPTkZJR19EUk1fSTgxMF9Y
RlJFRV80MT15DQpDT05GSUdfQVVUT0ZTNF9GUz15DQpDT05GSUdfUkVJU0VS
RlNfRlM9eQ0KQ09ORklHX0VYVDNfRlM9eQ0KQ09ORklHX0pCRD15DQpDT05G
SUdfVE1QRlM9eQ0KQ09ORklHX1JBTUZTPXkNCkNPTkZJR19JU085NjYwX0ZT
PXkNCkNPTkZJR19KT0xJRVQ9eQ0KQ09ORklHX1BST0NfRlM9eQ0KQ09ORklH
X0RFVlBUU19GUz15DQpDT05GSUdfRVhUMl9GUz15DQpDT05GSUdfTkZTX0ZT
PXkNCkNPTkZJR19ORlNEPXkNCkNPTkZJR19TVU5SUEM9eQ0KQ09ORklHX0xP
Q0tEPXkNCkNPTkZJR19TTUJfRlM9eQ0KQ09ORklHX01TRE9TX1BBUlRJVElP
Tj15DQpDT05GSUdfU01CX05MUz15DQpDT05GSUdfTkxTPXkNCkNPTkZJR19O
TFNfREVGQVVMVD0iaXNvODg1OS0xIg0KQ09ORklHX1ZHQV9DT05TT0xFPXkN
CkNPTkZJR19WSURFT19TRUxFQ1Q9eQ0KQ09ORklHX1NPVU5EPXkNCkNPTkZJ
R19TT1VORF9FUzEzNzE9eQ0KQ09ORklHX1VTQj15DQpDT05GSUdfVVNCX1VI
Q0lfQUxUPXkNCkNPTkZJR19VU0JfU1RPUkFHRT15DQpDT05GSUdfU0VDVVJJ
VFlfQ0FQQUJJTElUSUVTPXkNCkNPTkZJR19TRUNVUklUWV9TRUxJTlVYPXkN
CkNPTkZJR19TRUNVUklUWV9TRUxJTlVYX0RFVkVMT1A9eQ0KQ09ORklHX1pM
SUJfSU5GTEFURT15DQpDT05GSUdfWkxJQl9ERUZMQVRFPXkNCg==
---1463811574-2116922502-1043596231=:8521
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="selinux.cpuinfo"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10301261550311.8521@mercury.quantex>
Content-Description: cpuinfo file
Content-Disposition: attachment; filename="selinux.cpuinfo"

cHJvY2Vzc29yCTogMA0KdmVuZG9yX2lkCTogQXV0aGVudGljQU1EDQpjcHUg
ZmFtaWx5CTogNQ0KbW9kZWwJCTogOA0KbW9kZWwgbmFtZQk6IEFNRC1LNih0
bSkgM0QgcHJvY2Vzc29yDQpzdGVwcGluZwk6IDANCmNwdSBNSHoJCTogMzUw
LjgwMQ0KY2FjaGUgc2l6ZQk6IDY0IEtCDQpmZGl2X2J1Zwk6IG5vDQpobHRf
YnVnCQk6IG5vDQpmMDBmX2J1Zwk6IG5vDQpjb21hX2J1Zwk6IG5vDQpmcHUJ
CTogeWVzDQpmcHVfZXhjZXB0aW9uCTogeWVzDQpjcHVpZCBsZXZlbAk6IDEN
CndwCQk6IHllcw0KZmxhZ3MJCTogZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBt
Y2UgY3g4IG1teCBzeXNjYWxsIDNkbm93DQpib2dvbWlwcwk6IDY5OS41OQ0K
DQo=
---1463811574-2116922502-1043596231=:8521--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
