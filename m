Date: Wed, 24 Apr 2002 09:00:05 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: Reino Wallin <reino@oribium.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: RE: SELinux RPM Version
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152435F@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0204240844360.17117-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1019653205=:17117"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1019653205=:17117
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 24 Apr 2002, Westerman, Mark wrote:

> I have been palnning to ask this, since the file_contexts have been
> move back to the policy directory, did you create a setfiles directory
> or just move the file_contexts to the policy directory ?
>
> I move the file_contexts to the policy directory and created an
> entry into the Makefile call relabelfs  'make relabelfs' to
> relabel the file system.

Last month, shortly after the last public release, we partitioned file
contexts into a collection of *.fc files with a similar organization to
the policy program domains to make it easy to manage the file contexts
for individual program domains
(http://marc.theaimsgroup.com/?l=selinux&m=101655275415635&w=2).  These
files were originally located in setfiles/{types.fc,program/*.fc}, and the
setfiles Makefile generated a setfiles/file_contexts file from these
files.  Recently, we relocated the types.fc and program/*.fc files under a
new policy/file_contexts directory and revised the policy Makefile to
generate a policy/file_contexts/file_contexts file from the right set of
.fc files based on the set of .te files present in policy/domains/program
(http://marc.theaimsgroup.com/?l=selinux&m=101924792620498&w=2).  These
changes were all based on public discussions on the selinux list.
Our current policy Makefile is attached.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





---559023410-1804928587-1019653205=:17117
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=Makefile
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0204240900050.17117@raven>
Content-Description: 
Content-Disposition: attachment; filename=Makefile

Iw0KIyBNYWtlZmlsZSBmb3IgdGhlIHNlY3VyaXR5IHBvbGljeS4NCiMNCiMg
VGFyZ2V0czoNCiMgDQojIHBvbGljeSAtIGNvbXBpbGUgdGhlIHBvbGljeSBj
b25maWd1cmF0aW9uLg0KIyBpbnN0YWxsIC0gY29tcGlsZSBhbmQgaW5zdGFs
bCB0aGUgcG9saWN5IGNvbmZpZ3VyYXRpb24uDQojIGxvYWQgICAgLSBjb21w
aWxlLCBpbnN0YWxsLCBhbmQgbG9hZCB0aGUgcG9saWN5IGNvbmZpZ3VyYXRp
b24uDQojIHJlbGFiZWwgLSByZWxhYmVsIGZpbGVzeXN0ZW1zIGJhc2VkIG9u
IHRoZSBmaWxlIGNvbnRleHRzIGNvbmZpZ3VyYXRpb24uDQojDQojIFRoZSBk
ZWZhdWx0IHRhcmdldCBpcyAncG9saWN5Jy4NCiMNCg0KIyBTZXQgdG8geSBp
ZiBNTFMgaXMgZW5hYmxlZCBpbiB0aGUgbW9kdWxlLg0KTUxTPW4NCg0KQklO
RElSID0gL3Vzci9sb2NhbC9zZWxpbnV4L2Jpbg0KTE9BRFBPTElDWSAgPSAk
KEJJTkRJUikvbG9hZF9wb2xpY3kNCkNIRUNLUE9MSUNZID0gJChCSU5ESVIp
L2NoZWNrcG9saWN5DQpTRVRGSUxFUyA9ICQoQklORElSKS9zZXRmaWxlcw0K
DQpQT0xJQ1lWRVIgOj0gcG9saWN5LiQoc2hlbGwgJChDSEVDS1BPTElDWSkg
LVYpDQpJTlNUQUxMRElSID0gL2V0Yy9zZWN1cml0eS9zZWxpbnV4DQpMT0FE
UEFUSCA9ICQoSU5TVEFMTERJUikvJChQT0xJQ1lWRVIpDQoNClBPTElDWUZJ
TEVTID0gJChhZGRwcmVmaXggL3Vzci9sb2NhbC9zZWxpbnV4L2ZsYXNrLyxz
ZWN1cml0eV9jbGFzc2VzIGluaXRpYWxfc2lkcyBhY2Nlc3NfdmVjdG9ycykN
CmlmZXEgKCQoTUxTKSx5KQ0KUE9MSUNZRklMRVMgKz0gbWxzDQplbmRpZg0K
UE9MSUNZRklMRVMgKz0gbWFjcm9fdXNlZF9mbGFncy50ZSBwcm9ncmFtX3Vz
ZWRfZmxhZ3MudGUgYWxsLnRlIHJiYWMNClBPTElDWUZJTEVTICs9IHVzZXJz
DQpQT0xJQ1lGSUxFUyArPSBjb25zdHJhaW50cyANClBPTElDWUZJTEVTICs9
IGluaXRpYWxfc2lkX2NvbnRleHRzIGZzX2NvbnRleHRzIGRldmZzX2NvbnRl
eHRzIG5ldF9jb250ZXh0cw0KDQpGQyA9IGZpbGVfY29udGV4dHMvZmlsZV9j
b250ZXh0cw0KRkNGSUxFUz1maWxlX2NvbnRleHRzL3R5cGVzLmZjICQocGF0
c3Vic3QgZG9tYWlucy9wcm9ncmFtLyUudGUsZmlsZV9jb250ZXh0cy9wcm9n
cmFtLyUuZmMsICQod2lsZGNhcmQgZG9tYWlucy9wcm9ncmFtLyoudGUpKQ0K
DQoNCnBvbGljeTogJChQT0xJQ1lWRVIpDQoNCiQoUE9MSUNZVkVSKTogIHBv
bGljeS5jb25mICQoQ0hFQ0tQT0xJQ1kpDQoJJChDSEVDS1BPTElDWSkgLW8g
JEAgcG9saWN5LmNvbmYNCg0KaW5zdGFsbDogJChQT0xJQ1lWRVIpDQoJbWtk
aXIgLXAgJChJTlNUQUxMRElSKQ0KCWluc3RhbGwgLW0gNjQ0IC1vIHJvb3Qg
LWcgcm9vdCAkKFBPTElDWVZFUikgJChMT0FEUEFUSCkNCg0KbG9hZDogaW5z
dGFsbA0KCSQoQklORElSKS9sb2FkX3BvbGljeSAkKExPQURQQVRIKQ0KDQpw
b2xpY3kuY29uZjogJChQT0xJQ1lGSUxFUykgJCh3aWxkY2FyZCBtYWNyb3Mv
Ki50ZSkgbWFjcm9zIA0KCW00IC1JbWFjcm9zIC1zICQoUE9MSUNZRklMRVMp
ID4gcG9saWN5LmNvbmYNCg0KcHJvZ3JhbV91c2VkX2ZsYWdzLnRlOiAkKHdp
bGRjYXJkIGRvbWFpbnMvcHJvZ3JhbS8qLnRlKSBkb21haW5zL3Byb2dyYW0N
CgkoIGNkIGRvbWFpbnMvcHJvZ3JhbS8gOyBmb3IgbiBpbiAqLnRlIDsgZG8g
ZWNobyAiZGVmaW5lKFxgJCRuJykiOyBkb25lICkgPiAkQA0KDQptYWNyb191
c2VkX2ZsYWdzLnRlOiAkKHdpbGRjYXJkIG1hY3Jvcy9wcm9ncmFtLyoudGUp
IG1hY3Jvcy9wcm9ncmFtDQoJKCBjZCBtYWNyb3MvcHJvZ3JhbS8gOyBmb3Ig
biBpbiAqLnRlIDsgZG8gZWNobyAiZGVmaW5lKFxgJCRuJykiOyBkb25lICkg
PiAkQA0KDQphbGwudGU6IG1hY3Jvcy9nbG9iYWxfbWFjcm9zLnRlIGFsbF90
eXBlcy50ZSBhbGxfZG9tYWlucy50ZSBhc3NlcnQudGUNCgljYXQgJF4gPiAk
QA0KDQphbGxfdHlwZXMudGU6ICQod2lsZGNhcmQgdHlwZXMvKi50ZSkgdHlw
ZXMNCgljYXQgdHlwZXMvKi50ZSA+ICRADQoNCmFsbF9kb21haW5zLnRlOiAk
KHdpbGRjYXJkIGRvbWFpbnMvKi50ZSBkb21haW5zL3Byb2dyYW0vKi50ZSkg
ZG9tYWlucyBkb21haW5zL3Byb2dyYW0NCgljYXQgZG9tYWlucy8qLnRlIGRv
bWFpbnMvcHJvZ3JhbS8qLnRlID4gJEANCg0KcmVsYWJlbDogICQoRkMpICQo
U0VURklMRVMpDQoJJChTRVRGSUxFUykgJChGQykgYG1vdW50IHwgYXdrICcv
KGV4dFsyM118cmVpc2VyZnMpL3twcmludCAkJDN9J2ANCgl0b3VjaCByZWxh
YmVsDQoNCnJlc2V0OiAgJChGQykgJChTRVRGSUxFUykNCgkkKFNFVEZJTEVT
KSAtUiAkKEZDKSBgbW91bnQgfCBhd2sgJy8oZXh0WzIzXXxyZWlzZXJmcykv
e3ByaW50ICQkM30nYA0KDQokKEZDKTogJChGQ0ZJTEVTKSBmaWxlX2NvbnRl
eHRzL3Byb2dyYW0NCgljYXQgJChGQ0ZJTEVTKSA+ICRADQoNCmNsZWFuOg0K
CXJtIC1mICQoUE9MSUNZVkVSKSBwb2xpY3kuY29uZiANCglybSAtZiBwcm9n
cmFtX3VzZWRfZmxhZ3MudGUgbWFjcm9fdXNlZF9mbGFncy50ZQ0KCXJtIC1m
IGFsbC50ZSBhbGxfdHlwZXMudGUgYWxsX2RvbWFpbnMudGUgDQoJcm0gLWYg
JChGQykgcmVsYWJlbA0KIA0KLWluY2x1ZGUgdGVzdC5taw0KDQo=
---559023410-1804928587-1019653205=:17117--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
