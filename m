Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA26882
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 16:40:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA07452
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 20:38:50 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA07446
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 20:38:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Fwd: Re: addition for xdm.te
Date: Tue, 16 Apr 2002 22:40:15 +0200
References: <Pine.GSO.4.33.0204161535180.5820-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204161535180.5820-100000@raven>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_3FHO95NH7OU9VEVU9A3E"
Message-Id: <20020416204015.C51F727891@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_3FHO95NH7OU9VEVU9A3E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Tue, 16 Apr 2002 21:36, you wrote:
> On Tue, 16 Apr 2002, Russell Coker wrote:
> > I use the tmp directory to keep all generated files in one place, and to
> > allow a "rm tmp/*" in the clean rule to clean it all up.
> >
> > My Makefile is designed to work correctly, if you run "make" twice the
> > second time no work should be done, if you change a source file and then
> > run "make" then it should only re-build the necessary files.  My Makefile
> > does this.
>
> Not quite, but close.  Try removing domains/user.te and running make with
> your Makefile.

OK.  I've fixed that.

What do you think about the attached Makefile?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_3FHO95NH7OU9VEVU9A3E
Content-Type: text/plain;
  charset="iso-8859-1";
  name="Makefile"
Content-Transfer-Encoding: base64
Content-Description: Makefile
Content-Disposition: attachment; filename="Makefile"

IwojIE1ha2VmaWxlIGZvciB0aGUgc2VjdXJpdHkgcG9saWN5LgojCiMgVGFyZ2V0czoKIyAKIyBw
b2xpY3kgLSBjb21waWxlIHRoZSBwb2xpY3kgY29uZmlndXJhdGlvbi4KIyBpbnN0YWxsIC0gY29t
cGlsZSBhbmQgaW5zdGFsbCB0aGUgcG9saWN5IGNvbmZpZ3VyYXRpb24uCiMgbG9hZCAgICAtIGNv
bXBpbGUsIGluc3RhbGwsIGFuZCBsb2FkIHRoZSBwb2xpY3kgY29uZmlndXJhdGlvbi4KIwojIFRo
ZSBkZWZhdWx0IHRhcmdldCBpcyAncG9saWN5Jy4KIwoKIyBTZXQgdG8geSBpZiBNTFMgaXMgZW5h
YmxlZCBpbiB0aGUgbW9kdWxlLgpNTFM9bgoKQklORElSID0gL3Vzci9iaW4KTE9BRFBPTElDWSAg
PSAkKEJJTkRJUikvbG9hZF9wb2xpY3kKQ0hFQ0tQT0xJQ1kgPSAkKEJJTkRJUikvY2hlY2twb2xp
Y3kKClBPTElDWVZFUiA6PSBwb2xpY3kuJChzaGVsbCAkKENIRUNLUE9MSUNZKSAtVikKSU5TVEFM
TERJUiA9IC9ldGMvc2VjdXJpdHkvc2VsaW51eApMT0FEUEFUSCA9ICQoSU5TVEFMTERJUikvJChQ
T0xJQ1lWRVIpCgpQT0xJQ1lGSUxFUyA9IHNlY3VyaXR5X2NsYXNzZXMgaW5pdGlhbF9zaWRzIGFj
Y2Vzc192ZWN0b3JzCmlmZXEgKCQoTUxTKSx5KQpQT0xJQ1lGSUxFUyArPSBtbHMKZW5kaWYKUE9M
SUNZRklMRVMgKz0gdG1wL21hY3JvX3VzZWRfZmxhZ3MudGUgdG1wL3Byb2dyYW1fdXNlZF9mbGFn
cy50ZSB0bXAvYWxsLnRlIHJiYWMKUE9MSUNZRklMRVMgKz0gdXNlcnMKUE9MSUNZRklMRVMgKz0g
Y29uc3RyYWludHMgClBPTElDWUZJTEVTICs9IGluaXRpYWxfc2lkX2NvbnRleHRzIGZzX2NvbnRl
eHRzIGRldmZzX2NvbnRleHRzIG5ldF9jb250ZXh0cwoKJChQT0xJQ1lWRVIpOiAgcG9saWN5LmNv
bmYgJChDSEVDS1BPTElDWSkKCSQoQ0hFQ0tQT0xJQ1kpIC1vICRAIHBvbGljeS5jb25mCgpwb2xp
Y3k6ICQoUE9MSUNZVkVSKQoKaW5zdGFsbDogJChMT0FEUEFUSCkKCnBvbGljeS5jb25mOiAkKFBP
TElDWUZJTEVTKSBtYWNyb3MvKiBtYWNyb3MvcHJvZ3JhbS8qCgltNCAtSW1hY3JvcyAtcyAkXiA+
IHBvbGljeS5jb25mCgp0bXAvcHJvZ3JhbV91c2VkX2ZsYWdzLnRlOiAkKHdpbGRjYXJkIGRvbWFp
bnMvcHJvZ3JhbS8qLnRlKSBkb21haW5zL3Byb2dyYW0KCSggY2QgZG9tYWlucy9wcm9ncmFtLyA7
IGZvciBuIGluICoudGUgOyBkbyBlY2hvICJkZWZpbmUoXGAkJG4nKSI7IGRvbmUgKSA+ICRACgp0
bXAvbWFjcm9fdXNlZF9mbGFncy50ZTogJCh3aWxkY2FyZCBtYWNyb3MvcHJvZ3JhbS8qLnRlKSBt
YWNyb3MvcHJvZ3JhbQoJKCBjZCBtYWNyb3MvcHJvZ3JhbS8gOyBmb3IgbiBpbiAqLnRlIDsgZG8g
ZWNobyAiZGVmaW5lKFxgJCRuJykiOyBkb25lICkgPiAkQAoKJChMT0FEUEFUSCk6ICQoUE9MSUNZ
VkVSKQoJbWtkaXIgLXAgJChJTlNUQUxMRElSKQoJaW5zdGFsbCAtbSA2NDQgLW8gcm9vdCAtZyBy
b290ICQoUE9MSUNZVkVSKSAkKExPQURQQVRIKQoKbG9hZCB0bXAvbG9hZDogJChMT0FEUEFUSCkK
CSQoQklORElSKS9sb2FkX3BvbGljeSAkKExPQURQQVRIKQoJdG91Y2ggdG1wL2xvYWQKCnJlbGFi
ZWw6IGZpbGVfY29udGV4dHMgdG1wL2xvYWQKCXNldGZpbGVzIC1tIGZpbGVfY29udGV4dHMgYG1v
dW50IHwgYXdrICcvKGV4dFsyM118cmVpc2VyZnMpL3twcmludCAkJDN9J2AKCnRtcC9hbGwudGU6
IG1hY3Jvcy9nbG9iYWxfbWFjcm9zLnRlIHRtcC9hbGxfdHlwZXMudGUgdG1wL2FsbF9kb21haW5z
LnRlIGFzc2VydC50ZQoJY2F0ICReID4gJEAKCnRtcC9hbGxfdHlwZXMudGU6IHR5cGVzICQod2ls
ZGNhcmQgdHlwZXMvKi50ZSkKCWNhdCAkKHdpbGRjYXJkIHR5cGVzLyoudGUpID4gJEAKCnRtcC9h
bGxfZG9tYWlucy50ZTogZG9tYWlucyAkKHdpbGRjYXJkIGRvbWFpbnMvKi50ZSBkb21haW5zL3By
b2dyYW0vKi50ZSkgbWFjcm9zL2FkbWluX21hY3Jvcy50ZSBtYWNyb3MvdXNlcl9tYWNyb3MudGUK
CWNhdCAkKHdpbGRjYXJkIGRvbWFpbnMvKi50ZSBkb21haW5zL3Byb2dyYW0vKi50ZSkgPiAkQAoK
Y2xlYW46CglybSAtZiAkKFBPTElDWVZFUikgcG9saWN5LmNvbmYgCglybSAtZiB0bXAvKgoK

--------------Boundary-00=_3FHO95NH7OU9VEVU9A3E--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
