Message-ID: <4B8DAD9A.5020200@ak.jp.nec.com>
Date: Wed, 03 Mar 2010 09:30:18 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH] libselinux: fix avc_netlink_loop() error caused by nonblocking
 mode.
References: <4B691583.5060608@ak.jp.nec.com> <4B881D79.4000500@tycho.nsa.gov> <4B8833C6.9070503@tycho.nsa.gov> <4B88356E.1040501@tycho.nsa.gov> <4B8C7C88.4090701@ak.jp.nec.com> <4B8D4AED.80203@tycho.nsa.gov>
In-Reply-To: <4B8D4AED.80203@tycho.nsa.gov>
Content-Type: multipart/mixed;
 boundary="------------010401080605080908040108"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010401080605080908040108
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

(2010/03/03 2:29), Eamon Walsh wrote:
> On 03/01/2010 09:48 PM, KaiGai Kohei wrote:
>> (2010/02/27 5:56), Eamon Walsh wrote:
>>
>>> avc_open() creates the netlink socket in nonblocking mode.  If the
>>> application later takes control of the netlink socket with
>>> avc_netlink_acquire_fd() and then calls avc_netlink_loop(), it
>>> will fail with EWOULDBLOCK.
>>>
>>> To remedy this, remove the O_NONBLOCK flag from the netlink socket
>>> at the start of avc_netlink_loop().  Also, with this fix, there is
>>> no need for avc_open() to ever create a blocking socket, so change
>>> that and update the man page.
>>>
>> Apart from this design is sane, the libselinux allows applications to
>> call avc_netlink_check_nb() directly.
>> If we call the function although its worker thread calls avc_netlink_loop(),
>> the invocation of avc_netlink_check_nb() can be blocked, because it
>> assumes the internal netlink socket is non-blocking mode.
>> (Of course, we will not see the matter in most of sane applications.)
>>
>> I think a better approach is to put select(2) with zero or infinite
>> timeout just before avc_netlink_receive() calls to check whether the
>> unread message is in the netlink socket, or not.
>> And the 'blocking' argument of avc_netlink_open() shall be obsoleted,
>> because this design makes nonsense whether the socket has O_NONBLOCK
>> flag, or not.
>>
> 
> OK I see your point. How about the following:
> 
> libselinux: fix avc_netlink_loop() error caused by nonblocking mode.
> 
> avc_open() creates the netlink socket in nonblocking mode.  If the
> application later takes control of the netlink socket with
> avc_netlink_acquire_fd() and then calls avc_netlink_loop(), it
> will fail with EWOULDBLOCK.
> 
> To remedy this, remove the O_NONBLOCK flag from the netlink socket
> at the start of avc_netlink_loop().  Also, with this fix, there is
> no need for avc_open() to ever create a blocking socket, so change
> that and update the man page.
> 
> -v2: use poll() in avc_netlink_check_nb().  This makes both
> avc_netlink_loop() and avc_netlink_check_nb() independent of the
> O_NONBLOCK flag.

It seems to me ok basically.

It is just my preference. Can you move the poll(2) at the head of
the avc_netlink_receive() call, like as the attachment?
How should I say...it seems to me itchy to change non-blocking mode
into blocking mode implicitly at avc_netlink_loop(), although we can
specify the mode at creation time (avc_netlink_open()).

Thanks,

> Signed-off-by: Eamon Walsh<ewalsh@tycho.nsa.gov>
> --
> 
>   man/man3/avc_netlink_loop.3 |   11 +++--------
>   src/avc.c                   |    2 +-
>   src/avc_internal.c          |   13 +++++++++++++
>   3 files changed, 17 insertions(+), 9 deletions(-)
> 
> 
> diff --git a/libselinux/man/man3/avc_netlink_loop.3 b/libselinux/man/man3/avc_netlink_loop.3
> index 67df6e4..785be4c 100644
> --- a/libselinux/man/man3/avc_netlink_loop.3
> +++ b/libselinux/man/man3/avc_netlink_loop.3
> @@ -41,12 +41,9 @@ descriptor is stored internally; use
>   .BR avc_netlink_acquire_fd (3)
>   to take ownership of it in application code.  The
>   .I blocking
> -argument specifies whether read operations on the socket will block.
> +argument controls whether the O_NONBLOCK flag is set on the socket descriptor.
>   .BR avc_open (3)
> -calls this function internally, specifying non-blocking behavior (unless
> -threading callbacks were explicitly set using the deprecated
> -.BR avc_init (3)
> -interface, in which case blocking behavior is set).
> +calls this function internally, specifying non-blocking behavior.
> 
>   .B avc_netlink_close
>   closes the netlink socket.  This function is called automatically by
> @@ -66,9 +63,7 @@ checks the netlink socket for pending messages and processes them.
>   Callbacks for policyload and enforcing changes will be called;
>   see
>   .BR selinux_set_callback (3).
> -This function does not block unless
> -.BR avc_netlink_open (3)
> -specified blocking behavior.
> +This function does not block.
> 
>   .B avc_netlink_loop
>   enters a loop blocking on the netlink socket and processing messages as they
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index 881b915..5c8def0 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -222,7 +222,7 @@ int avc_init(const char *prefix,
>   		avc_enforcing = rc;
>   	}
> 
> -	rc = avc_netlink_open(avc_using_threads);
> +	rc = avc_netlink_open(0);
>   	if (rc<  0) {
>   		avc_log(SELINUX_ERROR,
>   			"%s:  can't open netlink socket: %d (%s)\n",
> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
> index 8372f52..7a39c61 100644
> --- a/libselinux/src/avc_internal.c
> +++ b/libselinux/src/avc_internal.c
> @@ -15,6 +15,7 @@
>   #include<unistd.h>
>   #include<fcntl.h>
>   #include<string.h>
> +#include<poll.h>
>   #include<sys/types.h>
>   #include<sys/socket.h>
>   #include<linux/types.h>
> @@ -205,8 +206,18 @@ int avc_netlink_check_nb(void)
>   {
>   	int rc;
>   	char buf[1024] __attribute__ ((aligned));
> +	struct pollfd pfd = { fd, POLLIN | POLLPRI, 0 };
> 
>   	while (1) {
> +		rc = poll(&pfd, 1, 0);
> +		if (rc == 0)
> +			return 0;
> +		if (rc<  0) {
> +			avc_log(SELINUX_ERROR, "%s:  netlink poll: error %d\n",
> +				avc_prefix, errno);
> +			return rc;
> +		}
> +
>   		errno = 0;
>   		rc = avc_netlink_receive(buf, sizeof(buf));
>   		if (rc<  0) {
> @@ -233,6 +244,8 @@ void avc_netlink_loop(void)
>   	int rc;
>   	char buf[1024] __attribute__ ((aligned));
> 
> +	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0)&  ~O_NONBLOCK);
> +
>   	while (1) {
>   		errno = 0;
>   		rc = avc_netlink_receive(buf, sizeof(buf));
> 
> 
> 


-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------010401080605080908040108
Content-Type: application/octect-stream;
 name="avc-netlink-poll.2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="avc-netlink-poll.2.patch"

IGxpYnNlbGludXgvbWFuL21hbjMvYXZjX25ldGxpbmtfbG9vcC4zIHwgICAxMSArKystLS0t
LS0tLQogbGlic2VsaW51eC9zcmMvYXZjLmMgICAgICAgICAgICAgICAgICAgfCAgICAyICst
CiBsaWJzZWxpbnV4L3NyYy9hdmNfaW50ZXJuYWwuYyAgICAgICAgICB8ICAgMjAgKysrKysr
KysrKysrKysrKystLS0KIDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGlic2VsaW51eC9tYW4vbWFuMy9hdmNfbmV0
bGlua19sb29wLjMgYi9saWJzZWxpbnV4L21hbi9tYW4zL2F2Y19uZXRsaW5rX2xvb3AuMwpp
bmRleCA2N2RmNmU0Li43ODViZTRjIDEwMDY0NAotLS0gYS9saWJzZWxpbnV4L21hbi9tYW4z
L2F2Y19uZXRsaW5rX2xvb3AuMworKysgYi9saWJzZWxpbnV4L21hbi9tYW4zL2F2Y19uZXRs
aW5rX2xvb3AuMwpAQCAtNDEsMTIgKzQxLDkgQEAgZGVzY3JpcHRvciBpcyBzdG9yZWQgaW50
ZXJuYWxseTsgdXNlCiAuQlIgYXZjX25ldGxpbmtfYWNxdWlyZV9mZCAoMykKIHRvIHRha2Ug
b3duZXJzaGlwIG9mIGl0IGluIGFwcGxpY2F0aW9uIGNvZGUuICBUaGUKIC5JIGJsb2NraW5n
Ci1hcmd1bWVudCBzcGVjaWZpZXMgd2hldGhlciByZWFkIG9wZXJhdGlvbnMgb24gdGhlIHNv
Y2tldCB3aWxsIGJsb2NrLgorYXJndW1lbnQgY29udHJvbHMgd2hldGhlciB0aGUgT19OT05C
TE9DSyBmbGFnIGlzIHNldCBvbiB0aGUgc29ja2V0IGRlc2NyaXB0b3IuCiAuQlIgYXZjX29w
ZW4gKDMpCi1jYWxscyB0aGlzIGZ1bmN0aW9uIGludGVybmFsbHksIHNwZWNpZnlpbmcgbm9u
LWJsb2NraW5nIGJlaGF2aW9yICh1bmxlc3MKLXRocmVhZGluZyBjYWxsYmFja3Mgd2VyZSBl
eHBsaWNpdGx5IHNldCB1c2luZyB0aGUgZGVwcmVjYXRlZAotLkJSIGF2Y19pbml0ICgzKQot
aW50ZXJmYWNlLCBpbiB3aGljaCBjYXNlIGJsb2NraW5nIGJlaGF2aW9yIGlzIHNldCkuCitj
YWxscyB0aGlzIGZ1bmN0aW9uIGludGVybmFsbHksIHNwZWNpZnlpbmcgbm9uLWJsb2NraW5n
IGJlaGF2aW9yLgogCiAuQiBhdmNfbmV0bGlua19jbG9zZQogY2xvc2VzIHRoZSBuZXRsaW5r
IHNvY2tldC4gIFRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIGF1dG9tYXRpY2FsbHkgYnkKQEAg
LTY2LDkgKzYzLDcgQEAgY2hlY2tzIHRoZSBuZXRsaW5rIHNvY2tldCBmb3IgcGVuZGluZyBt
ZXNzYWdlcyBhbmQgcHJvY2Vzc2VzIHRoZW0uCiBDYWxsYmFja3MgZm9yIHBvbGljeWxvYWQg
YW5kIGVuZm9yY2luZyBjaGFuZ2VzIHdpbGwgYmUgY2FsbGVkOwogc2VlCiAuQlIgc2VsaW51
eF9zZXRfY2FsbGJhY2sgKDMpLgotVGhpcyBmdW5jdGlvbiBkb2VzIG5vdCBibG9jayB1bmxl
c3MKLS5CUiBhdmNfbmV0bGlua19vcGVuICgzKQotc3BlY2lmaWVkIGJsb2NraW5nIGJlaGF2
aW9yLgorVGhpcyBmdW5jdGlvbiBkb2VzIG5vdCBibG9jay4KIAogLkIgYXZjX25ldGxpbmtf
bG9vcAogZW50ZXJzIGEgbG9vcCBibG9ja2luZyBvbiB0aGUgbmV0bGluayBzb2NrZXQgYW5k
IHByb2Nlc3NpbmcgbWVzc2FnZXMgYXMgdGhleQpkaWZmIC0tZ2l0IGEvbGlic2VsaW51eC9z
cmMvYXZjLmMgYi9saWJzZWxpbnV4L3NyYy9hdmMuYwppbmRleCA4ODFiOTE1Li41YzhkZWYw
IDEwMDY0NAotLS0gYS9saWJzZWxpbnV4L3NyYy9hdmMuYworKysgYi9saWJzZWxpbnV4L3Ny
Yy9hdmMuYwpAQCAtMjIyLDcgKzIyMiw3IEBAIGludCBhdmNfaW5pdChjb25zdCBjaGFyICpw
cmVmaXgsCiAJCWF2Y19lbmZvcmNpbmcgPSByYzsKIAl9CiAKLQlyYyA9IGF2Y19uZXRsaW5r
X29wZW4oYXZjX3VzaW5nX3RocmVhZHMpOworCXJjID0gYXZjX25ldGxpbmtfb3BlbigwKTsK
IAlpZiAocmMgPCAwKSB7CiAJCWF2Y19sb2coU0VMSU5VWF9FUlJPUiwKIAkJCSIlczogIGNh
bid0IG9wZW4gbmV0bGluayBzb2NrZXQ6ICVkICglcylcbiIsCmRpZmYgLS1naXQgYS9saWJz
ZWxpbnV4L3NyYy9hdmNfaW50ZXJuYWwuYyBiL2xpYnNlbGludXgvc3JjL2F2Y19pbnRlcm5h
bC5jCmluZGV4IDgzNzJmNTIuLmJlNGMwYTMgMTAwNjQ0Ci0tLSBhL2xpYnNlbGludXgvc3Jj
L2F2Y19pbnRlcm5hbC5jCisrKyBiL2xpYnNlbGludXgvc3JjL2F2Y19pbnRlcm5hbC5jCkBA
IC0xNSw2ICsxNSw3IEBACiAjaW5jbHVkZSA8dW5pc3RkLmg+CiAjaW5jbHVkZSA8ZmNudGwu
aD4KICNpbmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlIDxwb2xsLmg+CiAjaW5jbHVkZSA8
c3lzL3R5cGVzLmg+CiAjaW5jbHVkZSA8c3lzL3NvY2tldC5oPgogI2luY2x1ZGUgPGxpbnV4
L3R5cGVzLmg+CkBAIC05MiwxMyArOTMsMjYgQEAgdm9pZCBhdmNfbmV0bGlua19jbG9zZSh2
b2lkKQogCWNsb3NlKGZkKTsKIH0KIAotc3RhdGljIGludCBhdmNfbmV0bGlua19yZWNlaXZl
KGNoYXIgKmJ1ZiwgdW5zaWduZWQgYnVmbGVuKQorc3RhdGljIGludCBhdmNfbmV0bGlua19y
ZWNlaXZlKGNoYXIgKmJ1ZiwgdW5zaWduZWQgYnVmbGVuLCBpbnQgYmxvY2tpbmcpCiB7CiAJ
aW50IHJjOworCXN0cnVjdCBwb2xsZmQgcGZkID0geyBmZCwgUE9MTElOIHwgUE9MTFBSSSwg
MCB9OwogCXN0cnVjdCBzb2NrYWRkcl9ubCBubGFkZHI7CiAJc29ja2xlbl90IG5sYWRkcmxl
biA9IHNpemVvZiBubGFkZHI7CiAJc3RydWN0IG5sbXNnaGRyICpubGggPSAoc3RydWN0IG5s
bXNnaGRyICopYnVmOwogCisJcmMgPSBwb2xsKCZwZmQsIDEsIChibG9ja2luZyA/IC0xIDog
MCkpOworCisJaWYgKHJjID09IDAgJiYgIWJsb2NraW5nKSB7CisJCWVycm5vID0gRVdPVUxE
QkxPQ0s7CisJCXJldHVybiAtMTsKKwl9CisJZWxzZSBpZiAocmMgPCAxKSB7CisJCWF2Y19s
b2coU0VMSU5VWF9FUlJPUiwgIiVzOiAgbmV0bGluayBwb2xsOiBlcnJvciAlZFxuIiwKKwkJ
CWF2Y19wcmVmaXgsIGVycm5vKTsKKwkJcmV0dXJuIHJjOworCX0KKwogCXJjID0gcmVjdmZy
b20oZmQsIGJ1ZiwgYnVmbGVuLCAwLCAoc3RydWN0IHNvY2thZGRyICopJm5sYWRkciwKIAkJ
ICAgICAgJm5sYWRkcmxlbik7CiAJaWYgKHJjIDwgMCkKQEAgLTIwOCw3ICsyMjIsNyBAQCBp
bnQgYXZjX25ldGxpbmtfY2hlY2tfbmIodm9pZCkKIAogCXdoaWxlICgxKSB7CiAJCWVycm5v
ID0gMDsKLQkJcmMgPSBhdmNfbmV0bGlua19yZWNlaXZlKGJ1Ziwgc2l6ZW9mKGJ1ZikpOwor
CQlyYyA9IGF2Y19uZXRsaW5rX3JlY2VpdmUoYnVmLCBzaXplb2YoYnVmKSwgMCk7CiAJCWlm
IChyYyA8IDApIHsKIAkJCWlmIChlcnJubyA9PSBFV09VTERCTE9DSykKIAkJCQlyZXR1cm4g
MDsKQEAgLTIzNSw3ICsyNDksNyBAQCB2b2lkIGF2Y19uZXRsaW5rX2xvb3Aodm9pZCkKIAog
CXdoaWxlICgxKSB7CiAJCWVycm5vID0gMDsKLQkJcmMgPSBhdmNfbmV0bGlua19yZWNlaXZl
KGJ1Ziwgc2l6ZW9mKGJ1ZikpOworCQlyYyA9IGF2Y19uZXRsaW5rX3JlY2VpdmUoYnVmLCBz
aXplb2YoYnVmKSwgMSk7CiAJCWlmIChyYyA8IDApIHsKIAkJCWlmIChlcnJubyA9PSAwIHx8
IGVycm5vID09IEVJTlRSKQogCQkJCWNvbnRpbnVlOwo=
--------------010401080605080908040108--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
