Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5G9XGI4013630
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2003 05:33:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5G9WYss008075
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2003 09:32:34 GMT
Received: from nsa.hitachi-sk.co.jp (nsa.hitachi-sk.co.jp [202.232.217.2])
	by jazzswing.ncsc.mil  with ESMTP id h5G9WWhY008071
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2003 09:32:33 GMT
Received: from vsa.hitachi-sk.co.jp ([133.108.250.41])
	by nsa.hitachi-sk.co.jp (8.11.6/3.7W) with ESMTP id h5G9X1k13809
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2003 18:33:01 +0900
Received: from gwa.hitachi-sk.co.jp (localhost [127.0.0.1])
	by vsa.hitachi-sk.co.jp (8.9.3+3.2W/3.7W) with ESMTP id SAA17349
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2003 18:33:01 +0900 (JST)
Received: (from root@localhost)
	by gwa.hitachi-sk.co.jp (8.11.6+Sun/3.7W) id h5G9X0o01650
	for selinux@tycho.nsa.gov; Mon, 16 Jun 2003 18:33:00 +0900 (JST)
Received: from ori.hitachi-sk.co.jp (ori.ori.hitachi-sk.co.jp [133.108.2.2])
	by dns1.hitachi-sk.co.jp (8.11.6/3.7W) with ESMTP id h5G9X0925061
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2003 18:33:00 +0900
Message-Id: <200306160932.AA00821@ilios104.ori.hitachi-sk.co.jp>
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
Date: Mon, 16 Jun 2003 18:32:59 +0900
To: selinux@tycho.nsa.gov
Subject: Re: GUI Policy Editors (other than Tresys's setools)
In-Reply-To: <0D2F5426C26FD511A1C400B0D0D0596867264E@deliverance.tycho.ncsc.mil>
References: <0D2F5426C26FD511A1C400B0D0D0596867264E@deliverance.tycho.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--------------------2476696889550883"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is multipart message.

----------------------2476696889550883
Content-Type: text/plain; charset=us-ascii

Thank you for introducing our GUI tool.

We(Hitachi Software Engineering) developed "SELinux Policy Editor".
SELinux Policy Editor is Web-based GUI tool for SELinux policy configuration,
and distributed under GPL.

Release note(README) for SELinux Policy Editor is attached to this mail.
You can find the tool "http://www.selinux.hitachi-sk.co.jp/en/index.html" -> tools.

However,the download page is described only in Japanese.
If you want English download page, please wait.

Gwyer, Megan Wrote:
>Hi.  I'm looking into GUI's to edit policy for SELinux.  I'm familiar with
>Tresys's tools and I'm wondering if anyone has experience with any other
>tools.  It appears that Hitachi Software Engineering Company in Japan has
>developed some tools based on Webmin
>(http://www.selinux.hitachi-sk.co.jp/en/tool/selpe/selpe-top.html).  Does
>anyone have any opinions on this and is familiar with it?  I find it strange
>because I can't find it mentioned anywhere on the list.  Also, the Computer
>Privacy and Security Lab at the University of North Texas seems to have a
>project to design tools for editing and analyzing policy, but all they
>currently have listed is an GUI analyzer.
>(http://cops.csci.unt.edu/projects/selinux/main.html).  Is anyone familiar
>with this project and have any opinions?  Thank you very much!
>-Meghan Gwyer
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>

--------------------
Yuichi Nakamura
Research&Development Department
Hitachi Software Engineering Co.,Ltd.
ynakam@ori.hitachi-sk.co.jp
http://www.selinux.hitachi-sk.co.jp/en/(SELinux Policy Editor)

----------------------2476696889550883
Content-Type: application/octet-stream;
	name="README"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="README"

KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKU0VMaW51eCBQb2xpY3kgRWRpdG9y
IGZvciBXZWJtaW4KKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKClRoaXMgZG9j
dW1lbnQgaXMgYSByZWxlYXNlIG5vdGUgZm9yIFNFTGludXggUG9saWN5IEVkaXRvciB0aGF0
IGlzIGFuCmFkZC1vbiBtb2R1bGUgZm9yIFdlYm1pbigqMSkuIFRoaXMgZG9jdW1lbnQgZGVz
Y3JpYmVzIHRoZSBtaW5pbXVtCnN5c3RlbSByZXF1aXJlbWVudHMgYW5kIHRoZSBtYXR0ZXJz
IHRvIGJlIGF0dGVuZGVkIHRvLgoKSWYgeW91IHdhbnQgbW9yZSBpbmZvcm1hdGlvbnMsIHBs
ZWFzZSByZWZlciBmb2xsb3dpbmcgZG9jdW1lbnRzLgoKICAgIC0gaW5zdGFsbC50eHQgICAg
ICAgOiB0aGUgaW5zdGFsbCBtZXRob2QKICAgIC0gaW50ZXJsYW5ndWFnZS50eHQgOiBzcGVj
aWZpY2F0aW9ucyBmb3IgaW50ZXItbGFuZ3VhZ2UgKG5vIEVuZ2xpc2gpCiAgICAtIHJlYWRt
ZV9wb2xpY3kudHh0IDogTm90ZXMgZm9yIGRlZmF1bHQgc2VjdXJpdHkgcG9saWN5CgoKV2hh
dCBpcyBTRUxpbnV4IFBvbGljeSBFZGl0b3IgPwoKICAgIFNFTGludXggUG9saWN5IEVkaXRv
ciBpcyBhbiBhZGQtb24gbW9kdWxlIGZvciBXZWJtaW4uIElmIHlvdQogICAgaW5zdGFsbHMg
dGhpcyBtb2R1bGUgaW4geW91ciBzeXN0ZW0gd2hvc2Ugb3BlcmF0aW5nIHN5c3RlbSBpcwog
ICAgU2VjdXJpdHktRW5oYW5jZWQgTGludXgoU0VMaW51eCkoKjIpLCB0aGlzIG1vZHVsZSBl
bmFibGVzCiAgICBXZWItYmFzZWQgZWRpdCBvZiB0aGUgc2VjdXJpdHkgcnVsZXMuCiAgICAK
ICAgIFNFTGludXggYnJpbmdzIHZlcnkgc3Ryb25nIHNlY3VyaXR5LCBidXQgdGhlIGRlZmlu
aXRpb24gb2YKICAgIHNlY3VyaXR5IHJ1bGVzIGlzIHZlcnkgY29tcGxleCBhbmQgZGlmZmlj
dWx0IHRvIGRlYWwgd2l0aC4gV2l0aG91dAogICAgU0VMaW51eCBQb2xpY3kgRWRpdG9yLCB5
b3UgbXVzdCBlZGl0IG1hbnkgY29uZmlndXJhdGlvbiBmaWxlcyB0bwogICAgZGVmaW5lIHRo
ZSBzZWN1cml0eSBwb2xpY3kgZm9yIHlvdXIgc3lzdGVtLiBUaGlzIGlzIGhhcmQKICAgIHRh
c2suIFNFTGludXggUG9saWN5IEVkaXRvciBwcmV2ZW50cyBtaXMtZGVmaW5pbmcgb3IgbGFj
ayBvZgogICAgc2VjdXJpdHkgcnVsZXMsIGJlY2F1c2UgdGhpcyBtb2R1bGUgcHJvdmlkZXMg
bW9yZSBlYXNpbHkKICAgIHVuZGVyc3RhbmRhYmxlIGV4cHJlc3Npb25zIG9mIHNlY3VyaXR5
IHBvbGljeSBvbiBXZWIgYnJvd3Nlci4KCgpXaGF0IGlzIHRoZSBmZWF0dXJlIG9mIFNFTGlu
dXggUG9saWN5IEVkaXRvciA/CgogICAgIFNFTGludXggUG9saWN5IEVkaXRvciBoYXMgZm9s
bG93aW5nIGZlYXR1cmVzLgogICAgCiAgICAtIFdlYi1iYXNlZCBpbnRlcmZhY2UgZm9yIGVk
aXRpbmcgc2VjdXJpdHkgcnVsZXMgZm9yIFNFTGludXgKICAgIC0gR1VJIFZpZXcgdG8gcmV2
aWV3IHNlY3VyaXR5IHJ1bGUgY29uZmlndXJhdGlvbgogICAgLSBTdXBwb3J0cyBhbiBpbnRl
ci1sYW5ndWFnZQogICAgLSBBdXRvbWF0aWMgbGFiZWwgZ2VuZXJhdGlvbgogICAgLSBBIGxh
c3RpbmcgY29uZmlndXJhdGlvbiBzdHlsZQogICAgCiAgICAKICAgID0gV2ViLWJhc2VkIGlu
dGVyZmFjZSBmb3IgZWRpdGluZyBzZWN1cml0eSBydWxlcyBmb3IgU0VMaW51eCA9CiAgICAK
CVNFTGludXggUG9saWN5IEVkaXRvciBpcyBpbXBsZW1lbnRlZCBhcyBhbiBhZGQtb24gbW9k
dWxlIGZvcgoJV2VibWluLiBXZWJtaW4gaXMgYSB3ZWItYmFzZWQgaW50ZXJmYWNlIGZvciBz
eXN0ZW0KCWFkbWluaXN0cmF0aW9uIGZvciB1bml4LiBTbyB0aGUgc2VjdXJpdHkgcG9saWN5
IGZvciBTRUxpbnV4IGlzCglkaXNwbGF5ZWQgdmlzdWFsbHkgYW5kIG1vcmUgdW5kZXJzdGFu
ZGFibHkuIE9mIGNvdXJzZSwgeW91IGNhbgoJZWRpdCB0aGUgc2VjdXJpdHkgcnVsZXMgZnJv
bSByZW1vdGUgaG9zdCB3aXRoIGJyb3dzZXIsCglyZWdhcmRsZXNzIG9mIHlvdXIgcGxhdGZv
cm0uCiAgICAgICAgCgk9IFNob3dzIHNlY3VyaXR5IHJ1bGUgY29uZmlndXJhdGlvbnMgPQog
ICAgCglTRUxpbnV4IFBvbGljeSBFZGl0b3IgaGFzIGEgZnVuY3Rpb24gdG8gc2hvdyB0aGUg
c2VjdXJpdHkgcnVsZSAKCWNvbmZpZ3VyYXRpb25zIHVuaXRhcnkuIFRoaXMgZnVuY3Rpb24g
d2lsbCBwcmV2ZW50IG1pcy1kZWZpbml0aW9uIAoJb2YgdGhlIHNlY3VyaXR5IHJ1bGVzLgog
ICAgICAgIAoJPSBTdXBwb3J0cyBhbiBpbnRlci1sYW5ndWFnZSA9CiAgICAKCVRoZSBzZWN1
cml0eSBydWxlcyBlZGl0ZWQgd2l0aCBTRUxpbnV4IFBvbGljeSBFZGl0b3IgaXMKCW91dHB1
dCB0byBpbnRlci1jb25maWd1cmF0aW9uIGZpbGVzLiBUaGUgc2VjdXJpdHkgcnVsZXMgaW4K
CXRob3NlIGludGVyLWNvbmZpZ3VyYXRpb24gZmlsZXMgYXJlIGRlc2NyaWJlZCBieSBhbgoJ
aW50ZXItbGFuZ3VhZ2UuICBUaGlzIGludGVyLWxhbmd1YWdlIGlzIG1vcmUgdW5kZXJzdGFu
ZGFibGUKCXRoYW4gdGhlIG9yaWdpbmFsIHBvbGljeSBsYW5ndWFnZSBpbiBTRUxpbnV4LiBZ
b3UgbWF5IGVkaXQKCXRob3NlIGludGVyLWNvbmZpZ3VyYXRpb24gZmlsZXMgZGlyZWN0bHku
IFRob3NlCglpbnRlci1jb25maWd1cmF0aW9uIGZpbGVzIGFyZSBjb252ZXJ0ZWQgaW50byB0
aGUgb3JpZ2luYWwKCWNvbmZpZ3VyYXRpb24gZmlsZSBpbiBTRUxpbnV4IGJ5IGEgY29udmVy
dGVyIHdoaWNoIFNFTGludXgKCVBvbGljeSBFZGl0b3IgcHJvdmlkZXMuCiAgICAJCiAgICA9
IEF1dG9tYXRpYyBsYWJlbCBnZW5lcmF0aW9uID0KICAgIAoJVGhlIGFjY2VzcyBjb250cm9s
IGluIFNFTGludXggaXMgbm90IGRlZmluZWQgZm9yIHRoZSByZWxhdGlvbgoJYmV0d2VlbiB0
aGUgc3ViamVjdCBhbmQgdGhlIG9iamVjdCBidXQgZm9yIHRoZSBsYWJlbCBhdHRhY2hlZAoJ
dG8gdGhlIHN1YmplY3QgYW5kIHRoZSBsYWJlbCBhdHRhY2hlZCB0byB0aGUgb2JqZWN0LiBU
aGVyZWZvcmUKCXRoZSByZWxhdGlvbiBiZXR3ZWVuIHRoZSBvYmplY3QgYW5kIHRoZSBsYWJl
bCBhdHRhY2hlZCB0byBpcwoJdmVyeSBpbXBvcnRhbnQsIGFuZCBjb21wbGljYXRlcyB0aGUg
c2VjdXJpdHkgcnVsZQoJY29uZmlndXJhdGlvbi4KICAgICAgICAKCVRoZSBjb252ZXJ0ZXIg
aW4gU0VMaW51eCBQb2xpY3kgRWRpdG9yIGdlbmVyYXRlcyB0aGUgbmFtZSBvZgoJbGFiZWwg
YXV0b21hdGljYWxseSBiYXNlZCBvbiB0aGUgbmFtZSBvZiBkb21haW4gYW5kIHRoZSBuYW1l
CglvZiBzdWJqZWN0IGFjY2Vzc2VkIGJ5IGl0LiBUaGFua3MgdG8gdGhpcyBmdW5jdGlvbiwg
eW91IGNhbgoJY29uZmlndXJlIHRoZSBzZWN1cml0eSBwb2xpY3kgYnkgaW50dWl0aW9uIHdp
dGhvdXQgYmVpbmcKCWNvbnNjaW91cyBvZiB0aGUgbmFtZSBvZiBsYWJlbC4KICAgICAgICAK
ICAgID0gQSBsYXN0aW5nIGNvbmZpZ3VyYXRpb24gc3R5bGUgPQogICAgCglTRUxpbnV4IGlz
IHZlcnNpb24gdXBwZWQgZnJlcXVlbnRseS4gVGhlIHZlcnNpb24tdXAgYnJpbmdzIHRoZQoJ
Y2hhbmdlIG9mIHRoZSBzZWN1cml0eSBwb2xpY3kgY29uZmlndXJhdGlvbiBzdHlsZS4gVGhl
cmVmb3JlCgl0aGUgYWRtaW5pc3RyYXRvciBtdXN0IGdyYXNwIHRoZSBuZXcgc3R5bGUgb2Yg
dGhlIHNlY3VyaXR5Cglwb2xpY3kgY29uZmlndXJhdGlvbiBldmVyeSB0aW1lIHdoZW5ldmVy
IFNFTGludXggYXJlIHZlcnNpb24KCXVwcGVkLgogICAgICAgIAoJSW4gU0VMaW51eCBQb2xp
Y3kgRWRpdG9yLCB0aGUgaW50ZXItY29uZmlndXJhdGlvbiBhbmQgdGhlCgljb252ZXJ0ZXIg
YWJzb3JiIHRoZSBjaGFuZ2Ugb2YgdGhlIHNlY3VyaXR5IHBvbGljeQoJY29uZmlndXJhdGlv
biBzdHlsZS4gQ29uc2VxdWVudGx5LCBTRUxpbnV4IFBvbGljeSBFZGl0b3IgY2FuCglwcm92
aWRlcyBhIGxhc3Rpbmcgd2ViLWJhc2VkIHN0eWxlIG9mIHRoZSBzZWN1cml0eSBwb2xpY3kK
CWNvbmZpZ3VyYXRpb24uCgoKV2hhdCBpcyB0aGUgbWluaW11bSBzeXN0ZW0gcmVxdWlyZW1l
bnRzID8KCiAgICA8IFNlcnZlciBzaWRlID4KICAgIAoJLSBPUyAgICAgOiBTRUxpbnV4IHZl
cnNpb24gMjAwMjEyMTIxMCwgMjAwMzAxMTUxMAoJLSBXZWJtaW4gOiBXZWJtaW4gIHZlcnNp
b24gMS4wMywgMS4wNQogICAgCiAgICA8IENsaWVudCBzaWRlID4KICAgIAoJV2UgaGF2ZSB0
ZXN0ZWQgd2l0aCBmb2xsb3dpbmcgZW52aXJvbm1lbnRzLiAKCUhvd2V2ZXIsIGV2ZW4gaWYg
eW91IHVzZSB0aGlzIG1vZHVsZSB3aXRoIGxpc3RlZCBlbnZpcm9ubWVudHMgLCAKCXRoaXMg
bW9kdWxlIG1heSBiZWhhdmUgYWJub3JtYWxseSBkZXBlbmRpbmcgb24geW91ciBlbnZpcm9u
bWVudC4gCglXZSBkb2VzIG5vdCBuZWNlc3NhcmlseSB3YXJyYW50IHRoZSBub3JtYWwgb3Bl
cmF0aW9uIGluIHRoZSAKCWZvbGxvd2luZyBlbnZpcm9ubWVudHMuCiAgICAgICAgCgktIE9T
ICAgICAgOiBSZWRIYXQ3LjIsIFJlZEhhdDcuMywgUmVkSGF0IDguMAoJLSBCcm93c2VyIDog
TW96aWxsYSB2ZXJzaW9uIDEuMC4xLCAKICAgICAgICAKCS0gT1MgICAgICA6IFdpbmRvd3NO
VDQuMCwgV2luZG93cyBYUCBQcm8KCS0gQnJvd3NlciA6IElFIHZlcnNpb24gNi4wIAoJCSAg
ICBOZXRzY2FwZSB2ZXJzaW9uIDQuN3gsIDcueAoKTm90ZXMKCglUaGlzIHNvZnR3YXJlIGlz
IE5PVCBhIGNvbW1lcmNpYWwgcHJvZHVjdCBvZiBIaXRhY2hpIFNvZnR3YXJlLgoJVGhlcmVm
b3JlLCB0aGVyZSBpcyBubyB3YXJyYW50eSBhbmQgc3VwcG9ydCBmb3IgdGhpcyBzb2Z0d2Fy
ZS4KCVRoZSBpbnRlbnQgaXMgdG8gYWxsb3cgZnJlZSB1c2Ugb2YgdGhpcyBzb3VyY2UgY29k
ZSB1bmRlcgoJdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIChTZWUgQ09QWUlORyku
CglBYnNvbHV0ZWx5IG5vIHdhcnJhbnR5IGlzIHByb3ZpZGVkIG9yIGltcGxpZWQgKHNlZSBD
T1BZSU5HKS4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCioxIFdlYi1iYXNlZCBzeXN0ZW0gYWRtaW5pc3RyYXRpb24gdG9vbCBmb3IgdW5p
eAogICAgLSBodHRwOi8vd3d3LndlYm1pbi5jb20vCiAgICAKKjIgU2VjdXJpdHktRW5oYW5j
ZWQgTGludXgKICAgIC0gaHR0cDovL3d3dy5uc2EuZ292Lwo=

----------------------2476696889550883--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
