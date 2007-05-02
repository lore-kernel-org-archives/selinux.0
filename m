Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l42FnkG5001828
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 11:49:46 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l42FnjqC012007
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 15:49:45 GMT
Received: by wx-out-0506.google.com with SMTP id s17so163279wxc
        for <selinux@tycho.nsa.gov>; Wed, 02 May 2007 08:49:45 -0700 (PDT)
Message-ID: <cadfc0e40705020849o3f1b90c4l6f7bb5d9dcbc3c23@mail.gmail.com>
Date: Wed, 2 May 2007 10:49:44 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: launching apps at level (MLS) and polyinstantiation
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1177944754.16232.28.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3532_23279487.1178120984452"
References: <463243E3.2060602@gmail.com>
	 <1177700491.3357.113.camel@moss-spartans.epoch.ncsc.mil>
	 <1177700749.3357.116.camel@moss-spartans.epoch.ncsc.mil>
	 <463360B0.7020106@gmail.com>
	 <1177934887.16232.7.camel@moss-spartans.epoch.ncsc.mil>
	 <4636002F.5000100@gmail.com>
	 <1177944754.16232.28.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_3532_23279487.1178120984452
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Stephen.
I'd appreciate you reviewing this proposed patch.

Ted

On 4/30/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2007-04-30 at 09:41 -0500, Ted X Toth wrote:
> > Stephen Smalley wrote:
> > > On Sat, 2007-04-28 at 09:56 -0500, Ted X Toth wrote:
> > >
> > >> Stephen Smalley wrote:
> > >>
> > >>> On Fri, 2007-04-27 at 15:01 -0400, Stephen Smalley wrote:
> > >>>
> > >>>
> > >>>> On Fri, 2007-04-27 at 13:41 -0500, Ted X Toth wrote:
> > >>>>
> > >>>>
> > >>>>> I'm working on an application that launches other applications at a
> > >>>>> specified level. I have also configured polyinstantiation for a some
> > >>>>> directories. What I have found is that I had to make this application
> > >>>>> pam aware in order for the child process to get polyinstantiated
> > >>>>> directories. One issue is the reauthentication I've already
> > >>>>> authenticated why should I have to reauthenticate so that a child
> > >>>>> process can use polyinstantiated directories? Currently this app works
> > >>>>> when run as root but not as other users because the unshare call in
> > >>>>> pam_namespace fails for lack of permissions (CAP_SYS_ADMIN?). What do I
> > >>>>> need to do so that the application has this capability? I tried making
> > >>>>> the app setuid but that didn't help.
> > >>>>>
> > >>>>>
> > >>>> First, your application sounds similar to newrole -l, so hopefully you
> > >>>> can draw from it.
> > >>>>
> > >>>>
> > >>> In fact, newrole -l <level> -- -c <app> will run an application in a
> > >>> given level.
> > >>>
> > >>>
> > >>>
> > >>>> What precisely requires your app to perform authentication?  You control
> > >>>> your app's pam config, so you can define those modules as you see fit,
> > >>>> including using trivial ones like pam_permit.so.  And you control
> > >>>> whether your app calls pam_authenticate().  Possibly you may need to set
> > >>>> up state to make pam_open_session() happy.
> > >>>>
> > >>>> newrole has the same issue wrt needing capabilities, so look to it as an
> > >>>> example - look at the NAMESPACE_PRIV code.  It needs to be suid but also
> > >>>> needs to run in a domain that is allowed those capabilities.
> > >>>>
> > >>>>
> > >>>>
> > >> Would it be reasonable to extend newrole by adding a parameter for the
> > >> pam service name so that different authentication strategies could be
> > >> employed?
> > >>
> > >
> > > That would be dangerous - a user could then pick any pam service name he
> > > wants and run newrole with that, e.g. to bypass some aspect of the
> > > newrole pam stack.
> > >
> > > But you are certainly free to customize /etc/pam.d/newrole on your
> > > systems as you like.
> > >
> > We wouldn't want to change newroles pam configuration across the board
> > like that we're looking to be able to reuse its capability in more
> > flexible ways. You could limit which pam configurations that could be
> > used by defining a policy attribute and only allowing newrole access
> > to files with that attribute, right? Another idea is to have a
> > configuration file that would map service names to applications being
> > run under newrole.
>
> I wouldn't want to base it on what types newrole can read, as that will
> be too coarse-grained and too prone to misconfiguration.  Having an
> explicit configuration for newrole'able apps would make more sense, more
> like consolehelper aka usermode.
>
> --
> Stephen Smalley
> National Security Agency
>
>

------=_Part_3532_23279487.1178120984452
Content-Type: text/x-patch; name=policycoreutils-service-name.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f17yq6h2
Content-Disposition: attachment; filename="policycoreutils-service-name.patch"

LS0tIHBvbGljeWNvcmV1dGlscy0xLjMzLjEyL25ld3JvbGUvbmV3cm9sZS5jCTIwMDctMDUtMDIg
MTA6NDU6MTQuMDAwMDAwMDAwIC0wNTAwCisrKyBwb2xpY3ljb3JldXRpbHMtMS4zMy4xMi5uZXcv
bmV3cm9sZS9uZXdyb2xlLmMJMjAwNy0wNS0wMiAxMDo0NTowNS4wMDAwMDAwMDAgLTA1MDAKQEAg
LTU0LDYgKzU0LDcgQEAKICNpbmNsdWRlIDxzdGRpby5oPgogI2luY2x1ZGUgPHN0ZGxpYi5oPgkJ
LyogZm9yIG1hbGxvYygpLCByZWFsbG9jKCksIGZyZWUoKSAqLwogI2luY2x1ZGUgPHB3ZC5oPgkJ
LyogZm9yIGdldHB3dWlkKCkgKi8KKyNpbmNsdWRlIDxjdHlwZS5oPgogI2luY2x1ZGUgPHN5cy90
eXBlcy5oPgkJLyogdG8gbWFrZSBnZXR1aWQoKSBhbmQgZ2V0cHd1aWQoKSBoYXBweSAqLwogI2lu
Y2x1ZGUgPHN5cy93YWl0Lmg+CQkvKiBmb3Igd2FpdCgpICovCiAjaW5jbHVkZSA8Z2V0b3B0Lmg+
CQkvKiBmb3IgZ2V0b3B0X2xvbmcoKSBmb3JtIG9mIGdldG9wdCgpICovCkBAIC04NSw2ICs4Niw4
IEBACiAjZGVmaW5lIFBBQ0tBR0UgInBvbGljeWNvcmV1dGlscyIJLyogdGhlIG5hbWUgb2YgdGhp
cyBwYWNrYWdlIGxhbmcgdHJhbnNsYXRpb24gKi8KICNlbmRpZgogCisjaW5jbHVkZSA8c2Vwb2wv
cG9saWN5ZGIvaGFzaHRhYi5oPgorCiAvKiBVU0FHRV9TVFJJTkcgZGVzY3JpYmVzIHRoZSBjb21t
YW5kLWxpbmUgYXJncyBvZiB0aGlzIHByb2dyYW0uICovCiAjZGVmaW5lIFVTQUdFX1NUUklORyAi
VVNBR0U6IG5ld3JvbGUgWyAtciByb2xlIF0gWyAtdCB0eXBlIF0gWyAtbCBsZXZlbCBdIFsgLXAg
XSBbIC1WIF0gWyAtLSBhcmdzIF0iCiAKQEAgLTE1Niw2ICsxNTksNyBAQAogI2luY2x1ZGUgPHNl
Y3VyaXR5L3BhbV9taXNjLmg+CS8qIGZvciBtaXNjX2NvbnYgUEFNIHV0aWxpdHkgZnVuY3Rpb24g
Ki8KIAogI2RlZmluZSBTRVJWSUNFX05BTUUgIm5ld3JvbGUiCS8qIHRoZSBuYW1lIG9mIHRoaXMg
cHJvZ3JhbSBmb3IgUEFNICovCitjaGFyICpzZXJ2aWNlX25hbWUgPSAibmV3cm9sZSI7CiAKIC8q
IGF1dGhlbnRpY2F0ZV92aWFfcGFtKCkKICAqCkBAIC05MjEsNiArOTI1LDE0MSBAQAogCXJldHVy
biAwOwogfQogCitzdGF0aWMgdW5zaWduZWQgaW50IHJlcXN5bWhhc2goaGFzaHRhYl90IGgsIGhh
c2h0YWJfa2V5X3Qga2V5KQoreworCWNoYXIgKnAsICprZXlwOworCXNpemVfdCBzaXplOworCXVu
c2lnbmVkIGludCB2YWw7CisKKwl2YWwgPSAwOworCWtleXAgPSAoY2hhciAqKWtleTsKKwlzaXpl
ID0gc3RybGVuKGtleXApOworCWZvciAocCA9IGtleXA7ICgoc2l6ZV90KSAocCAtIGtleXApKSA8
IHNpemU7IHArKykKKwkJdmFsID0KKwkJICAgICh2YWwgPDwgNCB8ICh2YWwgPj4gKDggKiBzaXpl
b2YodW5zaWduZWQgaW50KSAtIDQpKSkgXiAoKnApOworCXJldHVybiB2YWwgJiAoaC0+c2l6ZSAt
IDEpOworfQorCitzdGF0aWMgaW50IHJlcXN5bWNtcChoYXNodGFiX3QgaAorCQkgICAgIF9fYXR0
cmlidXRlX18gKCh1bnVzZWQpKSwgaGFzaHRhYl9rZXlfdCBrZXkxLAorCQkgICAgIGhhc2h0YWJf
a2V5X3Qga2V5MikKK3sKKwljaGFyICprZXlwMSwgKmtleXAyOworCisJa2V5cDEgPSAoY2hhciAq
KWtleTE7CisJa2V5cDIgPSAoY2hhciAqKWtleTI7CisJcmV0dXJuIHN0cmNtcChrZXlwMSwga2V5
cDIpOworfQorCitzdGF0aWMgaGFzaHRhYl90IGFwcF9zZXJ2aWNlX25hbWVzID0gTlVMTDsKKwor
c3RhdGljIHZvaWQgcHJvY2Vzc19jb25maWcoRklMRSAqIGNmZykKK3sKKwljaGFyICpsaW5lX2J1
ZiA9IE5VTEw7CisJc2l6ZV90IGxlbiA9IDA7CisJc2l6ZV90IGN1cnJlbnRfc2l6ZSA9IDA7CisJ
Y2hhciAqYXBwID0gTlVMTDsKKwljaGFyICpzZXJ2aWNlID0gTlVMTDsKKwlpbnQgcmV0OworCWNo
YXIgKmxvY2FsX2FwcCA9IE5VTEw7CisJY2hhciAqbG9jYWxfc2VydmljZV9uYW1lID0gTlVMTDsK
KworCXdoaWxlIChnZXRsaW5lKCZsaW5lX2J1ZiwgJmxlbiwgY2ZnKSA+IDApIHsKKwkgIGNoYXIg
KmJ1ZmZlciA9IGxpbmVfYnVmOworCSAgd2hpbGUgKGlzc3BhY2UoKmJ1ZmZlcikpCisJICAgIGJ1
ZmZlcisrOworCSAgaWYgKGJ1ZmZlclswXSA9PSAnIycpCisJICAgIGNvbnRpbnVlOworCSAgaW50
IGwgPSBzdHJsZW4oYnVmZmVyKSAtIDE7CisJICBpZiAobCA8PSAwKQorCSAgICBjb250aW51ZTsK
KwkgIGJ1ZmZlcltsXSA9IDA7CisJICBpZiAobG9jYWxfYXBwID09IE5VTEwpIHsKKwkgICAgY3Vy
cmVudF9zaXplID0gbGVuOworCSAgICBsb2NhbF9hcHAgPSBtYWxsb2MoY3VycmVudF9zaXplKTsK
KwkgICAgbG9jYWxfc2VydmljZV9uYW1lID0gbWFsbG9jKGN1cnJlbnRfc2l6ZSk7CisJICB9CisJ
ICBlbHNlIHsKKwkgICAgaWYgKGN1cnJlbnRfc2l6ZSA8IGxlbikgeworCSAgICAgIGN1cnJlbnRf
c2l6ZSA9IGxlbjsKKwkgICAgICBsb2NhbF9hcHAgPSAoY2hhciAqKXJlYWxsb2MobG9jYWxfYXBw
LCBjdXJyZW50X3NpemUpOworCSAgICAgIGxvY2FsX3NlcnZpY2VfbmFtZSA9IChjaGFyICopcmVh
bGxvYyhsb2NhbF9zZXJ2aWNlX25hbWUsIGN1cnJlbnRfc2l6ZSk7CisJICAgIH0KKwkgIH0KKwkg
ICAgCisJICBsb2NhbF9hcHBbMF0gPSAwOworCSAgbG9jYWxfc2VydmljZV9uYW1lWzBdID0gMDsK
KwkgIC8qIAorCSAgICAgU3BsaXQgdGhlIGJ1ZmZlciBpbnRvIHRoZSBhcHBsaWNhdGlvbiBhbmQg
c2VydmljZSBuYW1lcyAKKwkgICovCisJICBzc2NhbmYoYnVmZmVyLCAiJXMgJXMiLCBsb2NhbF9h
cHAsIGxvY2FsX3NlcnZpY2VfbmFtZSk7CisJICBpZiAoc3RybGVuKGxvY2FsX2FwcCkgPiAwKSB7
CisJICAgIGFwcCA9IChjaGFyKikgbWFsbG9jKCBzdHJsZW4obG9jYWxfYXBwKSsxICk7CisJICAg
IHN0cmNweShhcHAsIGxvY2FsX2FwcCk7CisJICAgIC8qCisJICAgICAgQ2hlY2sgZm9yIGEgc2Vy
dmljZSBuYW1lCisJICAgICovCisJICAgIGlmIChzdHJsZW4obG9jYWxfc2VydmljZV9uYW1lKSA+
IDApIHsKKwkgICAgICBzZXJ2aWNlID0gKGNoYXIqKSBtYWxsb2MoIHN0cmxlbihsb2NhbF9zZXJ2
aWNlX25hbWUpKzEgKTsKKwkgICAgICBzdHJjcHkoc2VydmljZSwgbG9jYWxfc2VydmljZV9uYW1l
KTsKKwkgICAgICAvKgorCQlTYXZlIHRoZSBtYXBwaW5nIHRvIHRoZSBoYXNodGFibGUuCisJICAg
ICAgKi8KKwkgICAgICByZXQgPSBoYXNodGFiX2luc2VydChhcHBfc2VydmljZV9uYW1lcywKKwkJ
CQkgICBhcHAsCisJCQkJICAgc2VydmljZSk7CisJICAgIH0KKwkgICAgZWxzZSB7CisJICAgICAg
LyoKKwkJTm8gc2VydmljZSBuYW1lIHNwZWNpZmllZCBmb3IgYXBwLgorCSAgICAgICovCisJICAg
ICAgZnJlZShhcHApOworCSAgICB9CisJICB9CisJfQorCWZyZWUobGluZV9idWYpOworCWlmIChs
b2NhbF9hcHAgPT0gTlVMTCkgeworCSAgZnJlZShsb2NhbF9hcHApOworCX0KKwlpZiAobG9jYWxf
c2VydmljZV9uYW1lID09IE5VTEwpIHsKKwkgIGZyZWUobG9jYWxfc2VydmljZV9uYW1lKTsKKwl9
Cit9CisKKy8qIAorICAgUmVhZCBjb25maWcgZmlsZSBpZ25vcmluZyBjb21tZW50IGxpbmVzLgor
ICAgRmlsZXMgc3BlY2lmaWVkIG9uZSBwZXIgbGluZSBleGVjdXRhYmxlIHdpdGggYSBjb3JyZXNw
b25kaW5nCisgICBwYW0gc2VydmljZSBuYW1lLgorKi8KKworc3RhdGljIHZvaWQgcmVhZF9jb25m
aWcoKQoreworCWNoYXIgKmNvbmZpZ19maWxlX3BhdGggPSAiL2V0Yy9zZWxpbnV4L25ld3JvbGUu
Y29uZiI7CisJYXBwX3NlcnZpY2VfbmFtZXMgPSBoYXNodGFiX2NyZWF0ZShyZXFzeW1oYXNoLCBy
ZXFzeW1jbXAsIDY0KTsKKwlGSUxFICpjZmcgPSBOVUxMOworCWNmZyA9IGZvcGVuKGNvbmZpZ19m
aWxlX3BhdGgsICJyIik7CisJaWYgKCFjZmcpCisJICByZXR1cm47CisJcHJvY2Vzc19jb25maWco
Y2ZnKTsKKwlmY2xvc2UoY2ZnKTsKK30KKworc3RhdGljIHZvaWQgZnJlZV9oYXNodGFiKGhhc2h0
YWJfdCByZXEpCit7CisJdW5zaWduZWQgaW50IGk7CisJaGFzaHRhYl9wdHJfdCBjdXI7CisKKwlm
b3IgKGkgPSAwOyBpIDwgcmVxLT5zaXplOyBpKyspIHsKKwkJY3VyID0gcmVxLT5odGFibGVbaV07
CisJCXdoaWxlIChjdXIgIT0gTlVMTCkgeworCQkgIGZyZWUoY3VyLT5kYXR1bSk7CisJCSAgZnJl
ZShjdXItPmtleSk7CisJCSAgY3VyID0gY3VyLT5uZXh0OworCQl9CisJfQorCWhhc2h0YWJfZGVz
dHJveShyZXEpOworfQorCiAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAgKgogICogQWxsIGNvZGUgdXNlZCBm
b3IgYm90aCBQQU0gYW5kIHNoYWRvdyBwYXNzd2QgZ29lcyBpbiB0aGlzIHNlY3Rpb24uCkBAIC0x
MDAxLDYgKzExNDAsOCBAQAogCQlyZXR1cm4gLTE7CiAJfQogCisJcmVhZF9jb25maWcoKTsKKwog
CXR0eW4gPSB0dHluYW1lKDApOwogCWlmICghdHR5biB8fCAqdHR5biA9PSAnXDAnKSB7CiAJCWZw
cmludGYoc3RkZXJyLApAQCAtMTAyNSw3ICsxMTY2LDI3IEBACiAKIAlwcmludGYoXygiQXV0aGVu
dGljYXRpbmcgJXMuXG4iKSwgcHcucHdfbmFtZSk7CiAjaWZkZWYgVVNFX1BBTQotCXBhbV9zdGF0
dXMgPSBwYW1fc3RhcnQoU0VSVklDRV9OQU1FLCBwdy5wd19uYW1lLCAmcGFtX2NvbnZlcnNhdGlv
biwKKwkvKgorCSAgQXJlIHdlIGJlaW5nIGFza2VkIHRvIGV4ZWN1dGUgYSBwcm9jZXNzIGluIGEg
bmV3IGNvbnRleHQ/CisJKi8KKwlpZiAob3B0aW5kIDwgYXJnYykgeworCSAgLyoKKwkgICAgR2V0
IHRoZSBleGVjdXRhYmxlIGZyb20gdGhlIGNvbW1hbmQgbGluZS4KKwkgICovCisJICBjaGFyICpj
bWQgPSAoY2hhciAqKW1hbGxvYyhzdHJsZW4oYXJndltvcHRpbmQrMV0pKTsKKwkgIHNzY2FuZihh
cmd2W29wdGluZCsxXSwgIiVzIiwgY21kKTsKKwkgIC8qCisJICAgIFNlZSBpZiB0aGVyZSBpcyBh
IHBhbSBjb25maWd1cmF0aW9uIHNwZWNpZmljIHRvIHRoZSBleGVjdXRhYmxlLgorCSAgKi8KKwkg
IGNoYXIqIGFwcF9zZXJ2aWNlX25hbWUgPSAKKwkgICAgKGNoYXIgKikgaGFzaHRhYl9zZWFyY2go
YXBwX3NlcnZpY2VfbmFtZXMsIGNtZCk7CisJICBpZiAoYXBwX3NlcnZpY2VfbmFtZSAhPSBOVUxM
KSB7CisJICAgIHNlcnZpY2VfbmFtZSA9IGFwcF9zZXJ2aWNlX25hbWU7CisJICB9CisJICBmcmVl
KGNtZCk7CisJfQorCisJcGFtX3N0YXR1cyA9IHBhbV9zdGFydChzZXJ2aWNlX25hbWUsIHB3LnB3
X25hbWUsICZwYW1fY29udmVyc2F0aW9uLAogCQkJICAgICAgICZwYW1faGFuZGxlKTsKIAlpZiAo
cGFtX3N0YXR1cyAhPSBQQU1fU1VDQ0VTUykgewogCQlmcHJpbnRmKHN0ZGVyciwgXygiZmFpbGVk
IHRvIGluaXRpYWxpemUgUEFNXG4iKSk7CkBAIC0xMTE0LDYgKzEyNzUsNyBAQAogCQkJCXBhbV9z
dHJlcnJvcihwYW1faGFuZGxlLCByYykpOwogCQkJZXhpdF9jb2RlID0gLTE7CiAJCX0KKwkJZnJl
ZV9oYXNodGFiKGFwcF9zZXJ2aWNlX25hbWVzKTsKICNlbmRpZgogCQlmcmVlKHB3LnB3X25hbWUp
OwogCQlmcmVlKHB3LnB3X2Rpcik7Ci0tLSBwb2xpY3ljb3JldXRpbHMtMS4zMy4xMi9uZXdyb2xl
L01ha2VmaWxlCTIwMDctMDEtMTEgMTM6MDE6MzkuMDAwMDAwMDAwIC0wNjAwCisrKyBwb2xpY3lj
b3JldXRpbHMtMS4zMy4xMi5uZXcvbmV3cm9sZS9NYWtlZmlsZQkyMDA3LTA0LTMwIDE0OjU5OjAw
LjAwMDAwMDAwMCAtMDUwMApAQCAtMjIsNyArMjIsNyBAQAogCiBDRkxBR1MgPz0gLVdlcnJvciAt
V2FsbCAtVwogb3ZlcnJpZGUgQ0ZMQUdTICs9IC1EVkVSU0lPTj1cIiQoVkVSU0lPTilcIiAkKExE
RkxBR1MpIC1JJChQUkVGSVgpL2luY2x1ZGUgLURVU0VfTkxTIC1ETE9DQUxFRElSPSJcIiQoTE9D
QUxFRElSKVwiIiAtRFBBQ0tBR0U9IlwicG9saWN5Y29yZXV0aWxzXCIiCi1MRExJQlMgKz0gLWxz
ZWxpbnV4IC1sc2Vwb2wgLUwkKFBSRUZJWCkvbGliCitMRExJQlMgKz0gJChMSUJESVIpL2xpYnNl
cG9sLmEgLWxzZWxpbnV4IC1sc2Vwb2wgLUwkKFBSRUZJWCkvbGliCiBpZmVxICgke1BBTUh9LCAv
dXNyL2luY2x1ZGUvc2VjdXJpdHkvcGFtX2FwcGwuaCkKIAlvdmVycmlkZSBDRkxBR1MgKz0gLURV
U0VfUEFNCiAJTERMSUJTICs9IC1scGFtIC1scGFtX21pc2MK
------=_Part_3532_23279487.1178120984452--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
