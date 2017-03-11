MIME-Version: 1.0
In-Reply-To: <1489175376-27336-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1489175376-27336-1-git-send-email-jwcart2@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 11 Mar 2017 21:02:21 +0100
Message-ID: <CAJfZ7==2e9bN7Z94sLDO3boHDgVPx8Gr+=pXWsvNEbdqkjc8fg@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol and checkpolicy: Output CIL or policy.conf
 from kernel policy
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=94eb2c1cc2a4d82cb1054a79f43a
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c1cc2a4d82cb1054a79f43a
Content-Type: text/plain; charset=UTF-8

On Fri, Mar 10, 2017 at 8:49 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:
> It would sometimes be helpful for debugging or verification purposes to be able to convert
> a binary policy to a human-readable form.
>
> This patchset adds libsepol functions that take a kernel policydb in and outputs either
> a CIL or policy.conf text.
>
> Checkpolicy is modified to generate CIL text from a binary policy if using the "-C" option
> and to add the "-F" option to generate policy.conf text from a binary policy.
>
> Where possible rules are sorted in alphabetical or numerical order to aid in debugging.
>
> James Carter (3):
>   libsepol: Add ability to convert binary policy to CIL
>   libsepol: Add ability to convert binary policy to policy.conf file
>   checkpolicy: Add options to convert binary policy to CIL or a
>     policy.conf

Hello,
I agree such features are useful when analyzing policies. I have
tested the patches and compiled with some warnings flags (I have not
done a "real" code review). Here are some comments:

- First, the documentation (at least checkpolicy manpage) needs to be
updated with the new options. Also I spent some time trying to
understand what I was doing wrong with options -C and -F until I read
the third patch and understood that "-b" needs to be used as well.

- Then, when using "checkpolicy -bF" on my policy, I got blocks such as:

if ((git_cgi_enable_homedirs && use_samba_home_dirs)) {
            allow httpd_git_script_t cifs_t:dir { getattr search open };
        allow httpd_git_script_t cifs_t:dir { ioctl read getattr lock
search open };
        allow httpd_git_script_t cifs_t:dir { ioctl read getattr lock
search open };
        allow httpd_git_script_t cifs_t:file { ioctl read getattr lock open };
        allow httpd_git_script_t cifs_t:filesystem { getattr };
    } else {        dontaudit httpd_git_script_t cifs_t:file { ioctl
read getattr lock open };
}

The blocks have indentation issues (the first line of the if statement
has too much spaces and a "\n" is missing at the beginning of the else
block. Moreover the permissions are not sorted in alphabetical order
but this may be included in the "Where possible" part of your message.

- Third, the first patch introduces functions with printf-like
arguments and defines them with __attribute__((format(printf...))) in
the .c file. This is fine for the static functions but the other ones
need to have attributes in kernel_to_common.h instead (this enables
the compiler to check the format strings at build time when compiling
other files).

- Finally when compiling with -Wwrite-strings, gcc reports some issues
with literal strings assigned to non-const char* variables. I have
quickly written a short patch to make some variables const char* and
checkpolicy seems to work fine with it. The patch is attached to this
email if you want to consider it.

Cheers,
Nicolas

--94eb2c1cc2a4d82cb1054a79f43a
Content-Type: text/x-patch; charset=US-ASCII; name="0001-fix-Wwrite-string-warnings.patch"
Content-Disposition: attachment;
	filename="0001-fix-Wwrite-string-warnings.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j05obmai0

RnJvbSBjMjVhMDhlZmMzZjY1OTZjMGYzYmZkY2IyZTM2YWJjYTY4YjViM2U4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNvbGFzIElvb3NzIDxuaWNvbGFzLmlvb3NzQG00eC5vcmc+
CkRhdGU6IFNhdCwgMTEgTWFyIDIwMTcgMTA6MjY6NDUgKzAxMDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZml4IC1Xd3JpdGUtc3RyaW5nIHdhcm5pbmdzCgotLS0KIGxpYnNlcG9sL3NyYy9rZXJuZWxf
dG9fY2lsLmMgIHwgMTEgKysrKysrLS0tLS0KIGxpYnNlcG9sL3NyYy9rZXJuZWxfdG9fY29uZi5j
IHwgMTIgKysrKysrKy0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEw
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9rZXJuZWxfdG9fY2lsLmMg
Yi9saWJzZXBvbC9zcmMva2VybmVsX3RvX2NpbC5jCmluZGV4IDE0M2Y3ZmFhNGEwNy4uMDg1NDQy
NmZhZTMzIDEwMDY0NAotLS0gYS9saWJzZXBvbC9zcmMva2VybmVsX3RvX2NpbC5jCisrKyBiL2xp
YnNlcG9sL3NyYy9rZXJuZWxfdG9fY2lsLmMKQEAgLTI2Niw3ICsyNjYsNyBAQCBzdGF0aWMgaW50
IGNsYXNzX2NvbnN0cmFpbnRfcnVsZXNfdG9fc3RycyhzdHJ1Y3QgcG9saWN5ZGIgKnBkYiwgY2hh
ciAqY2xhc3NrZXksCiAJY2hhciAqZXhwciA9IE5VTEw7CiAJaW50IGlzX21sczsKIAljaGFyICpw
ZXJtczsKLQljaGFyICpmb3JtYXRfc3RyOworCWNvbnN0IGNoYXIgKmZvcm1hdF9zdHI7CiAJc3Ry
dWN0IHN0cnMgKnN0cnM7CiAKIAlmb3IgKGN1cnIgPSBjb25zdHJhaW50X3J1bGVzOyBjdXJyICE9
IE5VTEw7IGN1cnIgPSBjdXJyLT5uZXh0KSB7CkBAIC0zMDcsNyArMzA3LDcgQEAgc3RhdGljIGlu
dCBjbGFzc192YWxpZGF0ZXRyYW5zX3J1bGVzX3RvX3N0cnMoc3RydWN0IHBvbGljeWRiICpwZGIs
IGNoYXIgKmNsYXNza2UKIAlzdHJ1Y3QgY29uc3RyYWludF9ub2RlICpjdXJyOwogCWNoYXIgKmV4
cHIgPSBOVUxMOwogCWludCBpc19tbHM7Ci0JY2hhciAqZm9ybWF0X3N0cjsKKwljb25zdCBjaGFy
ICpmb3JtYXRfc3RyOwogCXN0cnVjdCBzdHJzICpzdHJzOwogCWludCByYyA9IDA7CiAKQEAgLTk5
NCw3ICs5OTQsOCBAQCBzdGF0aWMgY2hhciAqY2F0c19lYml0bWFwX3RvX3N0cihzdHJ1Y3QgZWJp
dG1hcCAqY2F0cywgY2hhciAqKnZhbF90b19uYW1lKQogewogCXN0cnVjdCBlYml0bWFwX25vZGUg
Km5vZGU7CiAJdWludDMyX3QgaSwgc3RhcnQsIHJhbmdlOwotCWNoYXIgKmNhdHNidWYsICpwLCAq
Zm10OworCWNoYXIgKmNhdHNidWYsICpwOworCWNvbnN0IGNoYXIgKmZtdDsKIAlpbnQgbGVuLCBy
ZW1haW5pbmc7CiAKIAlyZW1haW5pbmcgPSAoaW50KWNhdHNfZWJpdG1hcF9sZW4oY2F0cywgdmFs
X3RvX25hbWUpOwpAQCAtMTYwNSwxMCArMTYwNiwxMCBAQCBzdGF0aWMgY2hhciAqeHBlcm1zX3Rv
X3N0cihhdnRhYl9leHRlbmRlZF9wZXJtc190ICp4cGVybXMpCiAKIHN0YXRpYyBjaGFyICphdnRh
Yl9ub2RlX3RvX3N0cihzdHJ1Y3QgcG9saWN5ZGIgKnBkYiwgYXZ0YWJfa2V5X3QgKmtleSwgYXZ0
YWJfZGF0dW1fdCAqZGF0dW0pCiB7Ci0JY29uc3QgY2hhciAqZmxhdm9yOworCWNvbnN0IGNoYXIg
KmZsYXZvciwgKnRndDsKIAl1aW50MzJfdCBkYXRhID0gZGF0dW0tPmRhdGE7CiAJdHlwZV9kYXR1
bV90ICp0eXBlOwotCWNoYXIgKnNyYywgKnRndCwgKmNsYXNzLCAqcGVybXMsICpuZXc7CisJY2hh
ciAqc3JjLCAqY2xhc3MsICpwZXJtcywgKm5ldzsKIAljaGFyICpydWxlID0gTlVMTDsKIAogCXN3
aXRjaCAoMHhGRkYgJiBrZXktPnNwZWNpZmllZCkgewpkaWZmIC0tZ2l0IGEvbGlic2Vwb2wvc3Jj
L2tlcm5lbF90b19jb25mLmMgYi9saWJzZXBvbC9zcmMva2VybmVsX3RvX2NvbmYuYwppbmRleCA1
ZTVhODY0N2I0MjYuLjg5OGZkMWJhZjM4ZiAxMDA2NDQKLS0tIGEvbGlic2Vwb2wvc3JjL2tlcm5l
bF90b19jb25mLmMKKysrIGIvbGlic2Vwb2wvc3JjL2tlcm5lbF90b19jb25mLmMKQEAgLTI2MCw3
ICsyNjAsOCBAQCBzdGF0aWMgaW50IGNsYXNzX2NvbnN0cmFpbnRfcnVsZXNfdG9fc3RycyhzdHJ1
Y3QgcG9saWN5ZGIgKnBkYiwgY2hhciAqY2xhc3NrZXksCiAJaW50IHJjID0gMDsKIAlzdHJ1Y3Qg
Y29uc3RyYWludF9ub2RlICpjdXJyOwogCWludCBpc19tbHM7Ci0JY2hhciAqZm9ybWF0X3N0ciwg
KmZsYXZvciwgKnBlcm1zLCAqZXhwcjsKKwljb25zdCBjaGFyICpmb3JtYXRfc3RyLCAqZmxhdm9y
OworCWNoYXIgKnBlcm1zLCAqZXhwcjsKIAlzdHJ1Y3Qgc3RycyAqc3RyczsKIAogCWZvciAoY3Vy
ciA9IGNvbnN0cmFpbnRfcnVsZXM7IGN1cnIgIT0gTlVMTDsgY3VyciA9IGN1cnItPm5leHQpIHsK
QEAgLTMwNSw3ICszMDYsOCBAQCBzdGF0aWMgaW50IGNsYXNzX3ZhbGlkYXRldHJhbnNfcnVsZXNf
dG9fc3RycyhzdHJ1Y3QgcG9saWN5ZGIgKnBkYiwgY2hhciAqY2xhc3NrZQogewogCXN0cnVjdCBj
b25zdHJhaW50X25vZGUgKmN1cnI7CiAJaW50IGlzX21sczsKLQljaGFyICpmbGF2b3IsICpleHBy
OworCWNvbnN0IGNoYXIgKmZsYXZvcjsKKwljaGFyICpleHByOwogCXN0cnVjdCBzdHJzICpzdHJz
OwogCWludCByYyA9IDA7CiAKQEAgLTk2OSw3ICs5NzEsOCBAQCBzdGF0aWMgY2hhciAqY2F0c19l
Yml0bWFwX3RvX3N0cihzdHJ1Y3QgZWJpdG1hcCAqY2F0cywgY2hhciAqKnZhbF90b19uYW1lKQog
ewogCXN0cnVjdCBlYml0bWFwX25vZGUgKm5vZGU7CiAJdWludDMyX3QgaSwgc3RhcnQsIHJhbmdl
LCBmaXJzdDsKLQljaGFyICpjYXRzYnVmLCAqcCwgKmZtdDsKKwljaGFyICpjYXRzYnVmLCAqcDsK
Kwljb25zdCBjaGFyICpmbXQ7CiAJY2hhciBzZXA7CiAJaW50IGxlbiwgcmVtYWluaW5nOwogCkBA
IC0xNTczLDEwICsxNTc2LDkgQEAgZXhpdDoKIAogc3RhdGljIGNoYXIgKmF2dGFiX25vZGVfdG9f
c3RyKHN0cnVjdCBwb2xpY3lkYiAqcGRiLCBhdnRhYl9rZXlfdCAqa2V5LCBhdnRhYl9kYXR1bV90
ICpkYXR1bSkKIHsKLQljb25zdCBjaGFyICpmbGF2b3I7CisJY29uc3QgY2hhciAqZmxhdm9yLCAq
c3JjLCAqdGd0LCAqY2xhc3MsICpwZXJtcywgKm5ldzsKIAl1aW50MzJfdCBkYXRhID0gZGF0dW0t
PmRhdGE7CiAJdHlwZV9kYXR1bV90ICp0eXBlOwotCWNoYXIgKnNyYywgKnRndCwgKmNsYXNzLCAq
cGVybXMsICpuZXc7CiAJY2hhciAqcnVsZSA9IE5VTEw7CiAKIAlzd2l0Y2ggKDB4RkZGICYga2V5
LT5zcGVjaWZpZWQpIHsKLS0gCjIuMTEuMQoK
--94eb2c1cc2a4d82cb1054a79f43a--
