Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBN05ORb024828
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 19:05:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBN05Npn000130
	for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 00:05:24 GMT
Received: from ybbsmtp04.mail.yahoo.co.jp (ybbsmtp04.mail.yahoo.co.jp [210.81.151.172])
        by jazzband.ncsc.mil  with SMTP id hBN05Mab000127 for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 00:05:22 GMT
Message-Id: <200312230005.hBN05Mab000127@jazzband.ncsc.mil>
Date: Tue, 23 Dec 2003 09:01:44 +0900
From: Yuichi Nakamura <himainu_ynakam@yahoo.co.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Apache on FedoraCore1(Was Re: log_domain macro)
Content-Type: multipart/mixed; boundary="------------Boundary_:G':XY8OVJ0ISu'"
In-Reply-To: <3FE6EA56.7010708@redhat.com>
References: <3FE6EA56.7010708@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary_:G':XY8OVJ0ISu'
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Daniel J Walsh <dwalsh@redhat.com> wrote:
> >On Mon, Dec 22, 2003 at 10:54:07AM +1300, Kerry Thompson wrote:
> >>PAM ( and others ) make calls to the kerberos library which will always
> >>open /etc/krb5.conf in r/w mode, even though no apps should be writing to
> >>it. I suggest allowing read from all, and dontaudit for write.
> Kerberos has a sort of getstatusinfo call that it uses for all its 
> configuration files.  It basically loads up a information structure that 
> allows it to make decistions on a file.  Included in this information is 
> whether the file is writable.  So the Kerberos library does an 
> access(filename,W_OK) on the file it is investigating. 

I didn't know such behavior of kerberos.
I added "dontaudit httpd_t krb5_conf_t:file { write };" in apache.te.

To add "neverallow ~{ admin } krb5_conf_t:file { write }" might be better.

---
Yuichi Nakamura

--------------Boundary_:G':XY8OVJ0ISu'
Content-Type: application/octet-stream; name="apache.te.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="apache.te.patch"

LS0tIHBvbGljeS5vcmlnL2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQvYXBhY2hlLnRlCTIwMDMt
MTItMDYgMTA6MDE6NTcuMDAwMDAwMDAwICswOTAwCisrKyBwb2xpY3kvZG9tYWlucy9wcm9n
cmFtL3VudXNlZC9hcGFjaGUudGUJMjAwMy0xMi0yMiAwOToyMzozOS4wMDAwMDAwMDAgKzA5
MDAKQEAgLTMwLDcgKzMwLDE4IEBACiAjCiB0eXBlIGh0dHBkX2NvbmZpZ190LCBmaWxlX3R5
cGUsIHN5c2FkbWZpbGU7CiAKLWxvZ2Rpcl9kb21haW4oaHR0cGQpCisjY2FuIGNyZWF0ZSBh
cHBlbmQtb25seSBsb2dzIHVuZGVyIC92YXIvbG9nCithcHBlbmRfbG9nZGlyX2RvbWFpbiho
dHRwZCkKKyNjYW4gcmVhZCAvZXRjL2h0dHBkL2xvZ3MKK2FsbG93IGh0dHBkX3QgaHR0cGRf
bG9nX3Q6bG5rX2ZpbGUgeyByZWFkIH07CisKKyNjYW4gd3JpdGUgc3NsbXV0ZXggZmlsZSB0
byAvdmFyL2xvZy9odHRwZAorIyEhTm90aWNlOkl0IGlzIGJldHRlciBub3QgdG8gZ3JhbnQg
d3JpdGUgYWNjZXNzcyB0byAvdmFyL2xvZy9odHRwZC4KKyNUbyBjb21tZW50IG91dCB0aGVz
ZSxtb2RpZnkgU1NMTXV0ZXggZW50cnkgaW4gL2V0Yy9odHRwZC9jb25mLmQvc3NsLmNvbmYs
bGlrZSBmb2xsb3dpbmcKKyNTU0xNdXRleCBmaWxlOi92YXIvY2FjaGUvbW9kX3NzbAorYWxs
b3cgaHR0cGRfdCBodHRwZF9sb2dfdDpkaXIgeyByZW1vdmVfbmFtZSB9OworYWxsb3cgaHR0
cGRfdCBodHRwZF9sb2dfdDpmaWxlIHsgc2V0YXR0ciB1bmxpbmsgfTsKKwogCiAjIEZvciAv
ZXRjL2luaXQuZC9hcGFjaGUyIHJlbG9hZAogY2FuX3RjcF9jb25uZWN0KGh0dHBkX3QsIGh0
dHBkX3QpCkBAIC05OSwxMSArMTEwLDE0IEBACiAnKQogCiB1c2VzX3NobGliKGh0dHBkX3Qp
CithbGxvdyBodHRwZF90IGxpYl90OmZpbGUgeyBnZXRhdHRyIHJlYWQgfTsKIAogIyBleGVj
dXRlIHBlcmwKLWNhbl9leGVjKGh0dHBkX3QsIGJpbl90KQorYWxsb3cgaHR0cGRfdCBiaW5f
dDpmaWxlIHJ4X2ZpbGVfcGVybXM7CithbGxvdyBodHRwZF90IGJpbl90OmRpciB7IHNlYXJj
aCB9OwogCiBjYW5fbmV0d29yayhodHRwZF90KQorYWxsb3cgaHR0cGRfdCBodHRwZF90Om5l
dGxpbmtfc29ja2V0IHsgYmluZCBjcmVhdGUgZ2V0YXR0ciByZWFkIHdyaXRlIH07CiAKICMj
IyMjIyMjIyMjIyMjIyMjIyMKICMgQWxsb3cgaHR0cGQgdG8gc2VhcmNoIHVzZXJzIGRpcmV0
b3JpZXMKQEAgLTExNCw3ICsxMjgsNyBAQAogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwogIyBB
bGxvdyB0aGUgaHR0cGRfdCB0aGUgY2FwYWJpbGl0eSB0byBiaW5kIHRvIGEgcG9ydCBhbmQg
dmFyaW91cyBvdGhlciBzdHVmZgogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwotYWxsb3cgaHR0
cGRfdCBodHRwZF90OmNhcGFiaWxpdHkge2Nob3duIG5ldF9iaW5kX3NlcnZpY2Ugc2V0Z2lk
IHNldHVpZCBraWxsIGRhY19vdmVycmlkZSBkYWNfcmVhZF9zZWFyY2ggfTsKK2FsbG93IGh0
dHBkX3QgaHR0cGRfdDpjYXBhYmlsaXR5IHtjaG93biBuZXRfYmluZF9zZXJ2aWNlIHNldGdp
ZCBzZXR1aWQga2lsbCBkYWNfb3ZlcnJpZGUgZGFjX3JlYWRfc2VhcmNoIG5ldF9hZG1pbiB9
OwogCiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
CiAjIEFsbG93IHRoZSBodHRwZF90IHRvIHJlYWQgdGhlIHdlYiBzZXJ2ZXJzIGNvbmZpZyBm
aWxlcwpAQCAtMjEyLDMgKzIyNiw4IEBACiBhbGxvdyBodHRwZF9waHBfdCBteXNxbGRfdmFy
X3J1bl90OnNvY2tfZmlsZSB7IHdyaXRlIH07CiAnKQogCisjIHJlYWQgL2V0Yy9rcmI1LmNv
bmYKK3R5cGUga3JiNV9jb25mX3QsZmlsZV90eXBlLHN5c2FkbWZpbGU7CithbGxvdyBodHRw
ZF90IGtyYjVfY29uZl90OmZpbGUgcl9maWxlX3Blcm1zOworIyBBcGFjaGUgb3BlbnMga3Ji
NS5jb25mIGluIHIvdyBtb2RlLCBidXQgaXQgZG9uJ3Qgd3JpdGUga3JiNS5jb25mCitkb250
YXVkaXQgaHR0cGRfdCBrcmI1X2NvbmZfdDpmaWxlIHsgd3JpdGUgfTsK

--------------Boundary_:G':XY8OVJ0ISu'--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
