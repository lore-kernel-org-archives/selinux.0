Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t89C4Wnk025828
 for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2015 08:05:19 -0400
Received: by ykdu9 with SMTP id u9so10934827ykd.2
 for <selinux@tycho.nsa.gov>; Wed, 09 Sep 2015 05:04:11 -0700 (PDT)
MIME-Version: 1.0
From: Divya Vyas <dvyas@mvista.com>
Date: Wed, 9 Sep 2015 17:33:51 +0530
Message-ID: <CA+=dQ-_UrusjCYEvonfGxs3czxRWiV6iEm6Mk929iOL24UMzTg@mail.gmail.com>
Subject: No http boolean
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11399376cf3ce0051f4f4728
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11399376cf3ce0051f4f4728
Content-Type: text/plain; charset=UTF-8

Hi,

I am running selinux on my ubuntu machine and wants apache server
restriction to /etc/passwd.

I am just trying to play with http booleans to allow rules:

setsebool -P httpd_enable_homedirs on
libsemanage.dbase_llist_set: record not found in the database (No such file
or directory).
libsemanage.dbase_llist_set: could not set record value (No such file or
directory).
Could not change boolean httpd_enable_homedirs
Could not change policy booleans

getsebool -a | grep http
no result


dpkg -l | grep selinux
ii  libselinux1
2.1.0-4.1ubuntu1                    SELinux runtime shared libraries
ii  python-selinux
2.1.0-4.1ubuntu1                    Python bindings to SELinux shared
libraries
ii  selinux
1:0.11                              Security-Enhanced Linux runtime support
ii  selinux-policy-dev
2:2.20110726-3                      Headers from the SELinux reference
policy for building modules
ii  selinux-policy-ubuntu
0.2.20091117-0ubuntu2               Security-Enhanced Linux Reference Policy
ii  selinux-utils
2.1.0-4.1ubuntu1                    SELinux utility programs


semoule -l | grep apache
no result

 From where I can get  http booleans?

--001a11399376cf3ce0051f4f4728
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj5IaSw8YnI+PGJyPjwvZGl2PkkgYW0g
cnVubmluZyBzZWxpbnV4IG9uIG15IHVidW50dSBtYWNoaW5lIGFuZCB3YW50cyBhcGFjaGUgc2Vy
dmVyIHJlc3RyaWN0aW9uIHRvIC9ldGMvcGFzc3dkLjxicj48YnI+SSBhbSBqdXN0IHRyeWluZyB0
byBwbGF5IHdpdGggaHR0cCBib29sZWFucyB0byBhbGxvdyBydWxlczo8YnI+PGJyPnNldHNlYm9v
bCAtUCBodHRwZF9lbmFibGVfaG9tZWRpcnMgb248YnI+bGlic2VtYW5hZ2UuZGJhc2VfbGxpc3Rf
c2V0OiByZWNvcmQgbm90IGZvdW5kIGluIHRoZSBkYXRhYmFzZSAoTm8gc3VjaCBmaWxlIG9yIGRp
cmVjdG9yeSkuPGJyPmxpYnNlbWFuYWdlLmRiYXNlX2xsaXN0X3NldDogY291bGQgbm90IHNldCBy
ZWNvcmQgdmFsdWUgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpLjxicj5Db3VsZCBub3QgY2hh
bmdlIGJvb2xlYW4gaHR0cGRfZW5hYmxlX2hvbWVkaXJzPGJyPkNvdWxkIG5vdCBjaGFuZ2UgcG9s
aWN5IGJvb2xlYW5zPGJyPjxicj48L2Rpdj5nZXRzZWJvb2wgLWEgfCBncmVwIGh0dHAgPGJyPjwv
ZGl2Pm5vIHJlc3VsdDxicj48YnI+PGJyPmRwa2cgLWwgfCBncmVwIHNlbGludXg8YnI+aWnCoCBs
aWJzZWxpbnV4McKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMi4xLjAtNC4xdWJ1bnR1McKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFNFTGludXggcnVudGltZSBzaGFyZWQgbGlicmFyaWVzPGJyPmlpwqAg
cHl0aG9uLXNlbGludXjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDIuMS4wLTQuMXVidW50dTHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBQeXRob24gYmluZGluZ3MgdG8gU0VMaW51eCBzaGFyZWQgbGlicmFyaWVz
PGJyPmlpwqAgc2VsaW51eMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxOjAuMTHCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNlY3VyaXR5LUVuaGFuY2Vk
IExpbnV4IHJ1bnRpbWUgc3VwcG9ydDxicj5pacKgIHNlbGludXgtcG9saWN5LWRldsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI6Mi4yMDExMDcyNi0z
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhlYWRlcnMgZnJvbSB0
aGUgU0VMaW51eCByZWZlcmVuY2UgcG9saWN5IGZvciBidWlsZGluZyBtb2R1bGVzPGJyPmlpwqAg
c2VsaW51eC1wb2xpY3ktdWJ1bnR1wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgMC4yLjIwMDkxMTE3LTB1YnVudHUywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBTZWN1cml0eS1FbmhhbmNlZCBMaW51eCBSZWZlcmVuY2UgUG9saWN5PGJyPmlpwqAgc2VsaW51
eC11dGlsc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAyLjEuMC00LjF1YnVudHUxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgU0VMaW51eCB1dGlsaXR5IHByb2dyYW1zPGJyPjxicj48YnI+PC9kaXY+PGRpdj5z
ZW1vdWxlIC1sIHwgZ3JlcCBhcGFjaGU8YnI+PC9kaXY+PGRpdj5ubyByZXN1bHQ8YnI+PGJyPjwv
ZGl2PjxkaXY+wqBGcm9tIHdoZXJlIEkgY2FuIGdldMKgIGh0dHAgYm9vbGVhbnM/IDxicj48YnI+
PGJyPjwvZGl2PjwvZGl2Pg0K
--001a11399376cf3ce0051f4f4728--
