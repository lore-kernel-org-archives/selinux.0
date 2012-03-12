Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2CAHFvr017174
	for <selinux@tycho.nsa.gov>; Mon, 12 Mar 2012 06:17:15 -0400
Received: by werm13 with SMTP id m13so3334339wer.12
        for <selinux@tycho.nsa.gov>; Mon, 12 Mar 2012 03:17:13 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 12 Mar 2012 18:17:13 +0800
Message-ID: <CANvtKVZJ7EU3N8M=NMROtmyTKs+VUCZyMT9uJtNmraK7rz-fAA@mail.gmail.com>
Subject: [PATCH] libselinux init functions
From: Xin Ouyang <xinpascal@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=f46d04428624c80c9404bb090b86
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04428624c80c9404bb090b86
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I am working on the newest release of SELinux userspace packages and
sysvinit, and find there are a defect for init function of libselinux.
  * libselinux-2.1.9
  * sysvinit-2.88dsf

AFAIK, while sysvinit is configured with SELinux, /sbin/init would be
linked to libselinux. So before /sbin/init running, init_selinuxmnt()
would be called.

// libselinux-2.1.9/src/init.c

static void init_lib(void) __attribute__ ((constructor));
static void init_lib(void)
{
        selinux_page_size = sysconf(_SC_PAGE_SIZE);
        init_selinuxmnt();
}

As called before /sbin/init, init_selinuxmnt() is called before any
other userspace process.
At this time, procfs(/proc) and selinuxfs(/sys/fs/selinux or /selinux)
have not been mounted, because kernel do not mount them.

So, after init_lib() -> init_selinuxmnt(), global variable
"selinux_mnt" is still null.

/sbin/init would call is_selinux_enabled() to check whether selinux
enabled. Because "selinux_mnt" is null, is_selinux_enabled() always
return 0.

// libselinux-2.1.9/src/enabled.c

int is_selinux_enabled(void)
{
        int enabled = 0;

        if (selinux_mnt) {
                enabled = 1;
                if (getcon_raw(&con) == 0) {
                        if (!strcmp(con, "kernel"))
                                enabled = 0;
                        freecon(con);
                }
        }

        return enabled;
}

Then, selinux_init_load_policy(&enforce) is never called, so SELinux
init failed. :(

// sysvinit-2.88dsf/src/init.c

#ifdef WITH_SELINUX
	if (getenv("SELINUX_INIT") == NULL) {
		const int rc = mount("proc", "/proc", "proc", 0, 0);
		if (is_selinux_enabled() > 0) {
			putenv("SELINUX_INIT=YES");
			...
			if (selinux_init_load_policy(&enforce) == 0) {
				execv(myname, argv);
			} else {
				if (enforce > 0) {
					....
					exit(1);
				}
			}
		}
		....
	}
#endif


My patch is mounting procfs before selinuxfs_exists(), which would
check whether selinux exist in /proc/filesystem.
And mounting selinuxfs mountpoint after selinuxfs_exists().

Then, the init_lib() flow should be:
init_lib()
 `-- if (selinux_mnt) return
 `-- mount proc fs
 `-- if (!selinuxfs_exists()) goto out
 `-- mount selinuxfs (/sys/fs/selinux or /selinux)
 `-- check selinuxfs mountpoint in /proc/mounts
 `-- verify_selinuxmnt()
       `-- set selinux_mnt

Any suggestion would be welcome. Thanks. :)

-- 
- Pascal

--f46d04428624c80c9404bb090b86
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-libselinux-Mount-proc-and-SELINUXFS.patch"
Content-Disposition: attachment;
	filename="0001-libselinux-Mount-proc-and-SELINUXFS.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gzpcwf6b0

RnJvbSA0YTM2YjM0ZWEyM2U1NjgxNGI1NmMwNDNkZjYwODhjYWFkNjAyMmQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaW4gT3V5YW5nIDxYaW4uT3V5YW5nQHdpbmRyaXZlci5jb20+
CkRhdGU6IE1vbiwgMTIgTWFyIDIwMTIgMTg6MDU6MTYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBs
aWJzZWxpbnV4OiBNb3VudCAvcHJvYyBhbmQgU0VMSU5VWEZTLgoKU2luY2UgL3Byb2MgYW5kIFNF
TElOVVhGUyBhcmUgbm90IG1vdW50ZWQgYmVmb3JlIGluaXQgcHJvY2VzcydzCmZpcnN0IHJ1bm5p
bmcsIGNoZWNraW5nIGZvciBmaWxlc3lzdGVtIHR5cGUgYW5kIG1vdW50IHBvaW50IG9mCnNlbGlu
dXhmcyB3b3VsZCBhbHdheXMgZmFpbC4KU28gbW91bnQgdGhlbSBiZWZvcmUgY2hlY2tpbmcgdG8g
Zml4IHRoaXMuCi0tLQogc3JjL2luaXQuYyB8ICAgMjIgKysrKysrKysrKysrKysrKysrKysrKwog
MSBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3NyYy9pbml0LmMgYi9zcmMvaW5pdC5jCmluZGV4IDAwYWZkZTcuLmE0Y2U3MjYgMTAw
NjQ0Ci0tLSBhL3NyYy9pbml0LmMKKysrIGIvc3JjL2luaXQuYwpAQCAtMTEsMTIgKzExLDE3IEBA
CiAjaW5jbHVkZSA8c3lzL3Zmcy5oPgogI2luY2x1ZGUgPHN0ZGludC5oPgogI2luY2x1ZGUgPGxp
bWl0cy5oPgorI2luY2x1ZGUgPHN5cy9tb3VudC5oPgogCiAjaW5jbHVkZSAiZHNvLmgiCiAjaW5j
bHVkZSAicG9saWN5LmgiCiAjaW5jbHVkZSAic2VsaW51eF9pbnRlcm5hbC5oIgogI2luY2x1ZGUg
InNldHJhbnNfaW50ZXJuYWwuaCIKIAorI2lmbmRlZiBNTlRfREVUQUNIIC8qIE1pc3NpbmcgaW4g
Z2xpYmMyLjcgKi8KKyMgIGRlZmluZSBNTlRfREVUQUNIIDIKKyNlbmRpZgorCiBjaGFyICpzZWxp
bnV4X21udCA9IE5VTEw7CiBpbnQgc2VsaW51eF9wYWdlX3NpemUgPSAwOwogaW50IG9ial9jbGFz
c19jb21wYXQgPSAxOwpAQCAtODYsNiArOTEsNyBAQCBzdGF0aWMgdm9pZCBpbml0X3NlbGludXht
bnQodm9pZCkKIAlGSUxFICpmcD1OVUxMOwogCXNpemVfdCBsZW47CiAJc3NpemVfdCBudW07CisJ
aW50IHJjID0gLTE7CiAKIAlpZiAoc2VsaW51eF9tbnQpCiAJCXJldHVybjsKQEAgLTk0LDEwICsx
MDAsMjIgQEAgc3RhdGljIHZvaWQgaW5pdF9zZWxpbnV4bW50KHZvaWQpCiAKIAlpZiAodmVyaWZ5
X3NlbGludXhtbnQoT0xEU0VMSU5VWE1OVCkgPT0gMCkgcmV0dXJuOwogCisJcmMgPSBtb3VudCgi
bm9uZSIsICIvcHJvYyIsICJwcm9jIiwgMCwgMCk7CisKIAkvKiBEcm9wIGJhY2sgdG8gZGV0ZWN0
aW5nIGl0IHRoZSBsb25nIHdheS4gKi8KIAlpZiAoIXNlbGludXhmc19leGlzdHMoKSkKIAkJZ290
byBvdXQ7CiAKKwkvKiBTaW5jZSBTRUxJTlVYRlMgaXMgbm90IG1vdW50ZWQgYmVmb3JlIGluaXQg
cHJvY2VzcydzIGZpcnN0IHJ1bm5pbmcsIAorCSAqIHRoZXJlIHdvdWxkIGJlIG5vIFNFTElOVVhG
UyBpdGVtIGluIC9wcm9jL21vdW50cy4KKwkgKiBTbyBtb3VudCBpdCBiZWZvcmUgY2hlY2tpbmcg
L3Byb2MvbW91bnRzIHRvIGZpeCB0aGlzLiAqLworICAgICAgICBpZiAobW91bnQoU0VMSU5VWEZT
LCBTRUxJTlVYTU5ULCBTRUxJTlVYRlMsIDAsIDApICE9IDAgCisJCQkJJiYgZXJybm8gIT0gRUJV
U1kpCisJCWdvdG8gb3V0OworICAgICAgICBlbHNlIGlmIChtb3VudChTRUxJTlVYRlMsIE9MRFNF
TElOVVhNTlQsIFNFTElOVVhGUywgMCwgMCkgIT0gMCAKKwkJCQkmJiBlcnJubyAhPSBFQlVTWSkK
KwkJZ290byBvdXQ7CisKIAkvKiBBdCB0aGlzIHBvaW50LCB0aGUgdXN1YWwgc3BvdCBkb2Vzbid0
IGhhdmUgYW4gc2VsaW51eGZzIHNvCiAJICogd2UgbG9vayBhcm91bmQgZm9yIGl0ICovCiAJZnAg
PSBmb3BlbigiL3Byb2MvbW91bnRzIiwgInIiKTsKQEAgLTEyNiw2ICsxNDQsMTAgQEAgc3RhdGlj
IHZvaWQgaW5pdF9zZWxpbnV4bW50KHZvaWQpCiAKICAgICAgIG91dDoKIAlmcmVlKGJ1Zik7CisK
KwlpZiAocmMgPT0gMCkKKwkJdW1vdW50MigiL3Byb2MiLCBNTlRfREVUQUNIKTsKKwogCWlmIChm
cCkKIAkJZmNsb3NlKGZwKTsKIAlyZXR1cm47Ci0tIAoxLjcuNS40Cgo=
--f46d04428624c80c9404bb090b86--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
