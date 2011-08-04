Message-ID: <4E3B1416.5020504@redhat.com>
Date: Thu, 04 Aug 2011 17:50:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 029/155] policycoreutils: fixfiles clean up /var/run and
References: <4E39B5E6.8000100@redhat.com>  <1312469767.20973.53.camel@moss-pluto>  <CACLa4ptckXGt6XEqDMnmeZhV3AzVwnL=ktSTtVTFGg+A=Ajcug@mail.gmail.com>  <CACLa4puk2gO=aV=oNj-Kmj=eSmYmquX0skKoCxso6o9tWcf_Ng@mail.gmail.com> <1312486409.20973.66.camel@moss-pluto> <4E3B007B.1020502@redhat.com> <4E3B085D.1050400@redhat.com> <4E3B09CA.30604@redhat.com> <4E3B0AB1.2050707@redhat.com>
In-Reply-To: <4E3B0AB1.2050707@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------080409080508020603020508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080409080508020603020508
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2011 05:10 PM, Eric Paris wrote:
> On 08/04/2011 05:06 PM, Daniel J Walsh wrote:
>> On 08/04/2011 05:00 PM, Eric Paris wrote:
> 
>>> I also question the use of /sys/fs/selinux/ but I'm not sure we
>>> have a good way to find that in a script.....  Do we have one?
>>> 
>> 
>> grep selinuxfs /proc/self/mountinfo | awk '{ print $5 }'
> 
> $ grep selinuxfs /proc/self/mountinfo | awk '{ print $5 }' /selinux 
> /chroot/selinux
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
> quotes as the message.
> 
> 

Second attempt.

--------------080409080508020603020508
Content-Type: text/plain;
 name="unlabeled_file.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="unlabeled_file.patch"

ZGlmZiAtLWdpdCBhL3BvbGljeWNvcmV1dGlscy9zY3JpcHRzL2ZpeGZpbGVzIGIvcG9saWN5
Y29yZXV0aWxzL3NjcmlwdHMvZml4ZmlsZXMKaW5kZXggNmRlNzEwYS4uODk5ZGNlMiAxMDA3
NTUKLS0tIGEvcG9saWN5Y29yZXV0aWxzL3NjcmlwdHMvZml4ZmlsZXMKKysrIGIvcG9saWN5
Y29yZXV0aWxzL3NjcmlwdHMvZml4ZmlsZXMKQEAgLTIxLDYgKzIxLDIzIEBACiAjIEZvdW5k
YXRpb24sIEluYy4sIDU5IFRlbXBsZSBQbGFjZSwgU3VpdGUgMzMwLCBCb3N0b24sIE1BICAw
MjExMS0xMzA3ICBVU0EKIAogIworIyBHZXQgdGhlIGRlZmF1bHQgbGFiZWwgcmV0dXJuZWQg
ZnJvbSB0aGUga2VybmVsIGZvciBhIGZpbGUgd2l0aCBhIGxhYmxlIHRoZSAKKyMga2VybmVs
IGRvZXMgbm90IHVuZGVyc3RhbmQKKyMKK2dldF91bmRlZmluZWRfdHlwZSgpIHsKKyAgICBT
RUxJTlVYTU5UPWBncmVwIHNlbGludXhmcyAvcHJvYy9zZWxmL21vdW50aW5mbyB8IGhlYWQg
LTEgfCBhd2sgJ3sgcHJpbnQgJDUgfSdgCisgICAgY2F0ICR7U0VMSU5VWE1OVH0vaW5pdGlh
bF9jb250ZXh0cy91bmxhYmVsZWQgfCBzZWNvbiAtdAorfQorCisjCisjIEdldCB0aGUgZGVm
YXVsdCBsYWJlbCBmb3IgYSBmaWxlIHdpdGhvdXQgYSBsYWJlbAorIworZ2V0X3VubGFiZWxl
ZF90eXBlKCkgeworICAgIFNFTElOVVhNTlQ9YGdyZXAgc2VsaW51eGZzIC9wcm9jL3NlbGYv
bW91bnRpbmZvIHwgaGVhZCAtMSB8IGF3ayAneyBwcmludCAkNSB9J2AKKyAgICBjYXQgJFNF
TElOVVhNTlQvaW5pdGlhbF9jb250ZXh0cy9maWxlIHwgc2Vjb24gLXQgCit9CisKKyMKICMg
R2V0IGFsbCBtb3VudCBwb2ludHMgdGhhdCBzdXBwb3J0IHNlY2xhYmVsCiAjCiBnZXRfYWxs
X2xhYmVsZWRfbW91bnRzKCkgewpAQCAtMjAwLDExICsyMTcsMTMgQEAgZmkKICR7U0VURklM
RVN9IC1xICR7U1lTTE9HRkxBR30gJHtGT1JDRUZMQUd9ICQqICR7RkN9ICR7RklMRVNZU1RF
TVNSV30gMj4mMSB8IGNhdCA+PiAkTE9HRklMRQogcm0gLXJmIC90bXAvZ2NvbmZkLSogL3Rt
cC9wdWxzZS0qIC90bXAvb3JiaXQtKiAkVEVNUEZDRklMRQogCi1maW5kIC90bXAgXCggLWNv
bnRleHQgIio6ZmlsZV90KiIgLW8gLWNvbnRleHQgIio6dW5sYWJlbGVkX3QqIiBcKSBcKCAt
dHlwZSBzIC1vIC10eXBlIHAgXCkgLWRlbGV0ZQotZmluZCAvdG1wIFwoIC1jb250ZXh0ICIq
OmZpbGVfdCoiIC1vIC1jb250ZXh0ICIqOnVubGFiZWxlZF90KiIgXCkgLWV4ZWMgY2hjb24g
LXQgdG1wX3Qge30gXDsKLWZpbmQgL3Zhci90bXAgXCggLWNvbnRleHQgIio6ZmlsZV90KiIg
LW8gLWNvbnRleHQgIio6dW5sYWJlbGVkX3QqIiBcKSAtZXhlYyBjaGNvbiAtdCB0bXBfdCB7
fSBcOwotZmluZCAvdmFyL3J1biBcKCAtY29udGV4dCAiKjpmaWxlX3QqIiAtbyAtY29udGV4
dCAiKjp1bmxhYmVsZWRfdCoiIFwpIC1leGVjIGNoY29uIC10IHZhcl9ydW5fdCB7fSBcOwot
WyAtZSAvdmFyL2xpYi9kZWJ1ZyBdICYmIGZpbmQgL3Zhci9saWIvZGVidWcgXCggLWNvbnRl
eHQgIio6ZmlsZV90KiIgLW8gLWNvbnRleHQgIio6dW5sYWJlbGVkX3QqIiBcKSAtZXhlYyBj
aGNvbiAtdCBsaWJfdCB7fSBcOworVU5ERUZJTkVEPWBnZXRfdW5kZWZpbmVkX3R5cGVgIHx8
IGV4aXQgJD8KK1VOTEFCRUxFRD1gZ2V0X3VubGFiZWxlZF90eXBlYCB8fCBleGl0ICQ/Citm
aW5kIC90bXAgXCggLWNvbnRleHQgIio6JHtVTkxBQkVMRUR9KiIgLW8gLWNvbnRleHQgIio6
JHtVTkRFRklORUR9KiIgXCkgXCggLXR5cGUgcyAtbyAtdHlwZSBwIFwpIC1kZWxldGUKK2Zp
bmQgL3RtcCBcKCAtY29udGV4dCAiKjoke1VOTEFCRUxFRH0qIiAtbyAtY29udGV4dCAiKjok
e1VOREVGSU5FRH0qIiBcKSAtZXhlYyBjaGNvbiAtLXJlZmVyZW5jZSAvdG1wIHt9IFw7Citm
aW5kIC92YXIvdG1wIFwoIC1jb250ZXh0ICIqOiR7VU5MQUJFTEVEfSoiIC1vIC1jb250ZXh0
ICIqOiR7VU5ERUZJTkVEfSoiIFwpIC1leGVjIGNoY29uIC0tcmVmZXJlbmNlIC92YXIvdG1w
IHt9IFw7CitmaW5kIC92YXIvcnVuIFwoIC1jb250ZXh0ICIqOiR7VU5MQUJFTEVEfSoiIC1v
IC1jb250ZXh0ICIqOiR7VU5ERUZJTkVEfSoiIFwpIC1leGVjIGNoY29uIC0tcmVmZXJlbmNl
IC92YXIvcnVuIHt9IFw7CitbIC1lIC92YXIvbGliL2RlYnVnIF0gJiYgZmluZCAvdmFyL2xp
Yi9kZWJ1ZyBcKCAtY29udGV4dCAiKjoke1VOTEFCRUxFRH0qIiAtbyAtY29udGV4dCAiKjok
e1VOREVGSU5FRH0qIiBcKSAtZXhlYyBjaGNvbiAtLXJlZmVyZW5jZSAvbGliIHt9IFw7CiBl
eGl0ICQ/CiB9CiAK
--------------080409080508020603020508--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
