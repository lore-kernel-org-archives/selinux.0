Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA22709
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 15:59:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA19363
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 19:57:20 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA19359
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 19:57:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: boot loader
Date: Mon, 22 Apr 2002 21:58:46 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204220745090.24621-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204220745090.24621-100000@raven>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_YHJZP781RPWKA8N64B0R"
Message-Id: <20020422195846.432904545D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_YHJZP781RPWKA8N64B0R
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Mon, 22 Apr 2002 13:48, Stephen Smalley wrote:
> On Sat, 20 Apr 2002, Russell Coker wrote:
> > I am creating a policy for lilo.
> >
> > I have defined it's type as follows:
> > type lilo_t, domain, privlog, privmem, boot_loader;
> >
> > privmem is because lilo needs to read from /dev/mem to get BIOS data
> > about boot devices.  I have defined "boot_loader" as a type attribute for
> > anything that needs to write to raw hard drive devices to install a boot
> > loader (grub etc would need that too).  Then I added boot_loader in
> > assert.te as being allowed to write to fixed_disk_device_t.
> >
> > What do you think?
>
> This sounds fine.  Once lilo has been moved into its own domain, you might
> try removing direct access to fixed_disk_device_t from sysadm_t
> (the admin_domain macro).

Removing the direct access sounds like a good idea.

Also I like Mark's suggestion, which means there's no need for boot_loader.

I've attached my new te file, and following is the lilo file_contexts entries:
/etc/lilo.conf                  system_u:object_r:etc_bootloader_t
/sbin/lilo.*                    system_u:object_r:bootloader_exec_t

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_YHJZP781RPWKA8N64B0R
Content-Type: text/plain;
  charset="iso-8859-1";
  name="bootloader.te"
Content-Transfer-Encoding: base64
Content-Description: bootloader.te
Content-Disposition: attachment; filename="bootloader.te"

IwojIEF1dGhvcjogIFJ1c3NlbGwgQ29rZXIgPHJ1c3NlbGxAY29rZXIuY29tLmF1PgojCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgYm9vdGxvYWRl
cl90IGRvbWFpbi4KIwojIGJvb3Rsb2FkZXJfZXhlY190IGlzIHRoZSB0eXBlIG9mIHRoZSBib290
bG9hZGVyIGV4ZWN1dGFibGUuCiMKdHlwZSBib290bG9hZGVyX3QsIGRvbWFpbiwgcHJpdmxvZywg
cHJpdm1lbTsKdHlwZSBib290bG9hZGVyX2V4ZWNfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLCBl
eGVjX3R5cGU7CnR5cGUgYm9vdGxvYWRlcl90bXBfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLCB0
bXBmaWxlOwp0eXBlIGV0Y19ib290bG9hZGVyX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZTsKCnJv
bGUgc3lzYWRtX3IgdHlwZXMgYm9vdGxvYWRlcl90Owpyb2xlIHN5c3RlbV9yIHR5cGVzIGJvb3Rs
b2FkZXJfdDsKCmRvbWFpbl9hdXRvX3RyYW5zKHN5c2FkbV90LCBib290bG9hZGVyX2V4ZWNfdCwg
Ym9vdGxvYWRlcl90KQoKZmlsZV90eXBlX2F1dG9fdHJhbnMoYm9vdGxvYWRlcl90LCB0bXBfdCwg
Ym9vdGxvYWRlcl90bXBfdCkKCmFsbG93IGJvb3Rsb2FkZXJfdCB7IGV0Y190IH06ZGlyIHJfZGly
X3Blcm1zOwp1c2VzX3NobGliKGJvb3Rsb2FkZXJfdCkKCmFsbG93IGJvb3Rsb2FkZXJfdCB7IGZp
eGVkX2Rpc2tfZGV2aWNlX3QgcmVtb3ZhYmxlX2RldmljZV90IH06YmxrX2ZpbGUgcndfZmlsZV9w
ZXJtczsKYWxsb3cgYm9vdGxvYWRlcl90IGV0Y19ib290bG9hZGVyX3Q6ZmlsZSByX2ZpbGVfcGVy
bXM7CgpjYW5fZXhlYyhib290bG9hZGVyX3QsIHsgYm9vdGxvYWRlcl9leGVjX3QgYmluX3QgfSkK
YWxsb3cgYm9vdGxvYWRlcl90IHsgYmluX3Qgc2Jpbl90IH06ZGlyIHJfZGlyX3Blcm1zOwphdWRp
dGRlbnkgYm9vdGxvYWRlcl90IHN5c2FkbV9ob21lX3Q6ZGlyIH5yX2Rpcl9wZXJtczsKCmFsbG93
IGJvb3Rsb2FkZXJfdCBib290X3Q6ZGlyIHJ3X2Rpcl9wZXJtczsKYWxsb3cgYm9vdGxvYWRlcl90
IGJvb3RfdDp7IGZpbGUgbG5rX2ZpbGUgfSBjcmVhdGVfZmlsZV9wZXJtczsKCmFsbG93IGJvb3Rs
b2FkZXJfdCBzZWxmOmNhcGFiaWxpdHkgeyBzeXNfcmF3aW8gc3lzX2FkbWluIH07CiMgYWxsb3cg
Ym9vdGxvYWRlciB0byBnZXQgYXR0cmlidXRlcyBvZiBhbnkgZGV2aWNlIG5vZGUKYWxsb3cgYm9v
dGxvYWRlcl90IHsgZGV2ZnNfdCBmaWxlX3R5cGUgfTpkaXJfZmlsZV9jbGFzc19zZXQgZ2V0YXR0
cjsKYXVkaXRkZW55IGJvb3Rsb2FkZXJfdCBkZXZwdHNfdDpkaXIgfmNyZWF0ZV9kaXJfcGVybXM7
CgphbGxvdyBib290bG9hZGVyX3Qgc2VsZjpwcm9jZXNzIHsgZm9yayBzaWdjaGxkIH07CgphbGxv
dyBib290bG9hZGVyX3QgZnNfdDpmaWxlc3lzdGVtIGdldGF0dHI7CgphbGxvdyBib290bG9hZGVy
X3QgcHJvY190OmRpciByX2Rpcl9wZXJtczsKYWxsb3cgYm9vdGxvYWRlcl90IHByb2NfdDpmaWxl
IHJfZmlsZV9wZXJtczsKYWxsb3cgYm9vdGxvYWRlcl90IGV0Y19ydW50aW1lX3Q6ZmlsZSByX2Zp
bGVfcGVybXM7CgphbGxvdyBib290bG9hZGVyX3QgZGV2dHR5X3Q6Y2hyX2ZpbGUgcndfZmlsZV9w
ZXJtczsKCiMgZm9yIHJlYWRpbmcgQklPUyBkYXRhCmFsbG93IGJvb3Rsb2FkZXJfdCBtZW1vcnlf
ZGV2aWNlX3Q6Y2hyX2ZpbGUgcl9maWxlX3Blcm1zOwo=

--------------Boundary-00=_YHJZP781RPWKA8N64B0R--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
