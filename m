Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA26457
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 15:12:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA25132
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 19:11:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA25122 for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 19:11:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Fwd: Re: addition for xdm.te
Date: Tue, 16 Apr 2002 21:11:31 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204161417010.5820-200000@raven>
In-Reply-To: <Pine.GSO.4.33.0204161417010.5820-200000@raven>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_7BDOU11TMN1AFFR4FHHW"
Message-Id: <20020416191234.8484F27DDA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_7BDOU11TMN1AFFR4FHHW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Tue, 16 Apr 2002 20:20, Stephen Smalley wrote:
> Thanks.  I edited it slightly, so I'm using the attached patch relative to
> our policy Makefile.  I added $(wildcard), limited the lists to *.te to
> avoid picking up extraneous files, and dropped the macro_ prefix, since
> the macro files already have _macros in the name.  I'm also not using

I had also removed the macro_ prefix after sending the message.

> a separate tmp directory, although it doesn't especially matter to me.
> Is there a strong reason to use a separate tmp directory for the
> intermediate files?

I use the tmp directory to keep all generated files in one place, and to 
allow a "rm tmp/*" in the clean rule to clean it all up.

My Makefile is designed to work correctly, if you run "make" twice the second 
time no work should be done, if you change a source file and then run "make" 
then it should only re-build the necessary files.  My Makefile does this.

I've attached the complete Makefile I use.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_7BDOU11TMN1AFFR4FHHW
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
TElDWUZJTEVTKSBtYWNyb3MvKgoJbTQgLUltYWNyb3MgLXMgJF4gPiBwb2xpY3kuY29uZgoKdG1w
L3Byb2dyYW1fdXNlZF9mbGFncy50ZTogZG9tYWlucy9wcm9ncmFtLyogZG9tYWlucy9wcm9ncmFt
CgkoIGNkIGRvbWFpbnMvcHJvZ3JhbS8gOyBmb3IgbiBpbiAqIDsgZG8gZWNobyAiZGVmaW5lKFxg
JCRuJykiOyBkb25lICkgPiAkQAoKdG1wL21hY3JvX3VzZWRfZmxhZ3MudGU6IG1hY3Jvcy9wcm9n
cmFtLyogbWFjcm9zL3Byb2dyYW0KCSggY2QgbWFjcm9zL3Byb2dyYW0vIDsgZm9yIG4gaW4gKiA7
IGRvIGVjaG8gImRlZmluZShcYCQkbicpIjsgZG9uZSApID4gJEAKCiQoTE9BRFBBVEgpOiAkKFBP
TElDWVZFUikKCW1rZGlyIC1wICQoSU5TVEFMTERJUikKCWluc3RhbGwgLW0gNjQ0IC1vIHJvb3Qg
LWcgcm9vdCAkKFBPTElDWVZFUikgJChMT0FEUEFUSCkKCmxvYWQgdG1wL2xvYWQ6ICQoTE9BRFBB
VEgpCgkkKEJJTkRJUikvbG9hZF9wb2xpY3kgJChMT0FEUEFUSCkKCXRvdWNoIHRtcC9sb2FkCgpy
ZWxhYmVsOiBmaWxlX2NvbnRleHRzIHRtcC9sb2FkCglzZXRmaWxlcyAtbSBmaWxlX2NvbnRleHRz
IGBtb3VudCB8IGF3ayAnLyhleHRbMjNdfHJlaXNlcmZzKS97cHJpbnQgJCQzfSdgCgp0bXAvYWxs
LnRlOiBtYWNyb3MvZ2xvYmFsX21hY3Jvcy50ZSB0bXAvYWxsX3R5cGVzLnRlIHRtcC9hbGxfZG9t
YWlucy50ZSBhc3NlcnQudGUKCWNhdCAkXiA+ICRACgp0bXAvYWxsX3R5cGVzLnRlOiAkKHdpbGRj
YXJkIHR5cGVzLyoudGUpCgljYXQgJF4gPiAkQAoKdG1wL2FsbF9kb21haW5zLnRlOiAkKHdpbGRj
YXJkIGRvbWFpbnMvKi50ZSBkb21haW5zL3Byb2dyYW0vKi50ZSkKCWNhdCAkXiA+ICRACgpjbGVh
bjoKCXJtIC1mICQoUE9MSUNZVkVSKSBwb2xpY3kuY29uZiAKCXJtIC1mIHRtcC8qCgo=

--------------Boundary-00=_7BDOU11TMN1AFFR4FHHW--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
