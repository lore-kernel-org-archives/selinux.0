Subject: Re: [RFC][PATCH] selinux: support distinctions among all network
 address families
To: Guido Trentalancia <guido@trentalancia.net>, selinux@tycho.nsa.gov
References: <1480604861-13982-1-git-send-email-sds@tycho.nsa.gov>
 <f89685d0-2088-6b27-2671-bfaafea57786@tycho.nsa.gov>
 <1480613322.4558.29.camel@trentalancia.net>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9b023671-606f-d3b2-9d70-3bbcbf5e5dba@tycho.nsa.gov>
Date: Thu, 1 Dec 2016 13:03:52 -0500
MIME-Version: 1.0
In-Reply-To: <1480613322.4558.29.camel@trentalancia.net>
Content-Type: multipart/mixed; boundary="------------95CE6785C44B7E9D93BB1486"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------95CE6785C44B7E9D93BB1486
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 12/01/2016 12:28 PM, Guido Trentalancia wrote:
> Hello again Stephen and Paul.
> 
> On Thu, 01/12/2016 at 10.57 -0500, Stephen Smalley wrote:
>> On 12/01/2016 10:07 AM, Stephen Smalley wrote:
> 
> [...]
> 
>> A couple of notes on this change:
>>
>> - To fully test (beyond just confirming that it doesn't break
>> anything
>> when the policy capability is not defined), we'll need a patched
>> libsepol and policy (and unfortunately it requires patching the base
>> policy; can't be done via a policy module).  Can certainly provide
>> those
>> too but figured I'd wait to see the response to the kernel patch
>> first.
> 
> The libsepol patch is straightforward.
> 
> You can have a look at the one I have posted on the 23rd of August 2016
> under the subject "[PATCH] Update libsepol to support the policy
> capability for AF_ALG sockets" and adapt it to the new policy
> capability name and to the fact that you are now removing the Redhat
> policy capability.
> 
> As for the Reference Policy patch, if you want, I can forward to you
> the one that I had created at that time for the ALG_SOCKET family, so
> that you can adapt it to the multiple socket types.
> 
> Same thing for the SELinux Testsuite patch: if you want, I can forward
> to you the one that I had created at that time for the ALG_SOCKET
> family and that would be enough for testing the new capability because
> it's representative of all the new socket types.
> 
> With kind regards,

Actually, I realized belatedly that CIL makes it possible to enable
testing of this change just through a policy module.  Attached is a CIL
policy module that one can insert via semodule -i
testextsockclass.cil (caveat: may break your system if using any of
these socket classes). Also attached is the libsepol patch.  So now I
just need a test case - will have a look at your AF_ALG patch.


--------------95CE6785C44B7E9D93BB1486
Content-Type: application/vnd.ms-artgalry;
 name="testextsockclass.cil"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="testextsockclass.cil"

KHBvbGljeWNhcCBleHRlbmRlZF9zb2NrZXRfY2xhc3MpCgooY2xhc3Njb21tb24gYXgyNV9z
b2NrZXQgc29ja2V0KQooY2xhc3MgYXgyNV9zb2NrZXQgKCkpCgooY2xhc3Njb21tb24gaXB4
X3NvY2tldCBzb2NrZXQpCihjbGFzcyBpcHhfc29ja2V0ICgpKQoKKGNsYXNzY29tbW9uIG5l
dHJvbV9zb2NrZXQgc29ja2V0KQooY2xhc3MgbmV0cm9tX3NvY2tldCAoKSkKCihjbGFzc2Nv
bW1vbiBicmlkZ2Vfc29ja2V0IHNvY2tldCkKKGNsYXNzIGJyaWRnZV9zb2NrZXQgKCkpCgoo
Y2xhc3Njb21tb24gYXRtcHZjX3NvY2tldCBzb2NrZXQpCihjbGFzcyBhdG1wdmNfc29ja2V0
ICgpKQoKKGNsYXNzY29tbW9uIHgyNV9zb2NrZXQgc29ja2V0KQooY2xhc3MgeDI1X3NvY2tl
dCAoKSkKCihjbGFzc2NvbW1vbiByb3NlX3NvY2tldCBzb2NrZXQpCihjbGFzcyByb3NlX3Nv
Y2tldCAoKSkKCihjbGFzc2NvbW1vbiBkZWNuZXRfc29ja2V0IHNvY2tldCkKKGNsYXNzIGRl
Y25ldF9zb2NrZXQgKCkpCgooY2xhc3Njb21tb24gYXRtc3ZjX3NvY2tldCBzb2NrZXQpCihj
bGFzcyBhdG1zdmNfc29ja2V0ICgpKQoKKGNsYXNzY29tbW9uIHJkc19zb2NrZXQgc29ja2V0
KQooY2xhc3MgcmRzX3NvY2tldCAoKSkKCihjbGFzc2NvbW1vbiBpcmRhX3NvY2tldCBzb2Nr
ZXQpCihjbGFzcyBpcmRhX3NvY2tldCAoKSkKCihjbGFzc2NvbW1vbiBwcHBveF9zb2NrZXQg
c29ja2V0KQooY2xhc3MgcHBwb3hfc29ja2V0ICgpKQoKKGNsYXNzY29tbW9uIGxsY19zb2Nr
ZXQgc29ja2V0KQooY2xhc3MgbGxjX3NvY2tldCAoKSkKCihjbGFzc2NvbW1vbiBpYl9zb2Nr
ZXQgc29ja2V0KQooY2xhc3MgaWJfc29ja2V0ICgpKQoKKGNsYXNzY29tbW9uIG1wbHNfc29j
a2V0IHNvY2tldCkKKGNsYXNzIG1wbHNfc29ja2V0ICgpKQoKKGNsYXNzY29tbW9uIGNhbl9z
b2NrZXQgc29ja2V0KQooY2xhc3MgY2FuX3NvY2tldCAoKSkKCihjbGFzc2NvbW1vbiB0aXBj
X3NvY2tldCBzb2NrZXQpCihjbGFzcyB0aXBjX3NvY2tldCAoKSkKCihjbGFzc2NvbW1vbiBi
bHVldG9vdGhfc29ja2V0IHNvY2tldCkKKGNsYXNzIGJsdWV0b290aF9zb2NrZXQgKCkpCgoo
Y2xhc3Njb21tb24gaXVjdl9zb2NrZXQgc29ja2V0KQooY2xhc3MgaXVjdl9zb2NrZXQgKCkp
CgooY2xhc3Njb21tb24gcnhycGNfc29ja2V0IHNvY2tldCkKKGNsYXNzIHJ4cnBjX3NvY2tl
dCAoKSkKCihjbGFzc2NvbW1vbiBpc2RuX3NvY2tldCBzb2NrZXQpCihjbGFzcyBpc2RuX3Nv
Y2tldCAoKSkKCihjbGFzc2NvbW1vbiBwaG9uZXRfc29ja2V0IHNvY2tldCkKKGNsYXNzIHBo
b25ldF9zb2NrZXQgKCkpCgooY2xhc3Njb21tb24gaWVlZTgwMjE1NF9zb2NrZXQgc29ja2V0
KQooY2xhc3MgaWVlZTgwMjE1NF9zb2NrZXQgKCkpCgooY2xhc3Njb21tb24gY2FpZl9zb2Nr
ZXQgc29ja2V0KQooY2xhc3MgY2FpZl9zb2NrZXQgKCkpCgooY2xhc3Njb21tb24gYWxnX3Nv
Y2tldCBzb2NrZXQpCihjbGFzcyBhbGdfc29ja2V0ICgpKQoKKGNsYXNzY29tbW9uIG5mY19z
b2NrZXQgc29ja2V0KQooY2xhc3MgbmZjX3NvY2tldCAoKSkKCihjbGFzc2NvbW1vbiB2c29j
a19zb2NrZXQgc29ja2V0KQooY2xhc3MgdnNvY2tfc29ja2V0ICgpKQoKKGNsYXNzY29tbW9u
IGtjbV9zb2NrZXQgc29ja2V0KQooY2xhc3Mga2NtX3NvY2tldCAoKSkKCihjbGFzc2NvbW1v
biBxaXBjcnRyX3NvY2tldCBzb2NrZXQpCihjbGFzcyBxaXBjcnRyX3NvY2tldCAoKSkKCihj
bGFzc29yZGVyICh1bm9yZGVyZWQgYXgyNV9zb2NrZXQgaXB4X3NvY2tldCBuZXRyb21fc29j
a2V0IGJyaWRnZV9zb2NrZXQgYXRtcHZjX3NvY2tldCB4MjVfc29ja2V0IHJvc2Vfc29ja2V0
IGRlY25ldF9zb2NrZXQgYXRtc3ZjX3NvY2tldCByZHNfc29ja2V0IGlyZGFfc29ja2V0IHBw
cG94X3NvY2tldCBsbGNfc29ja2V0IGliX3NvY2tldCBtcGxzX3NvY2tldCBjYW5fc29ja2V0
IHRpcGNfc29ja2V0IGJsdWV0b290aF9zb2NrZXQgaXVjdl9zb2NrZXQgcnhycGNfc29ja2V0
IGlzZG5fc29ja2V0IHBob25ldF9zb2NrZXQgaWVlZTgwMjE1NF9zb2NrZXQgY2FpZl9zb2Nr
ZXQgYWxnX3NvY2tldCBuZmNfc29ja2V0IHZzb2NrX3NvY2tldCBrY21fc29ja2V0IHFpcGNy
dHJfc29ja2V0KSkKCg==
--------------95CE6785C44B7E9D93BB1486
Content-Type: text/x-patch;
 name="0001-libsepol-Define-extended_socket_class-policy-capabil.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-libsepol-Define-extended_socket_class-policy-capabil.pa";
 filename*1="tch"

>From daaea4522b34a54c2cff319c458d7d1a0267ecbe Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 1 Dec 2016 11:08:06 -0500
Subject: [PATCH] libsepol: Define extended_socket_class policy capability

Define the extended_socket_class policy capability used to enable
the use of separate socket security classes for all network address
families rather than the generic socket class.

The legacy redhat1 policy capability that was only ever used in testing
within Fedora for ptrace_child is reclaimed for this purpose; as far as
I can tell, this policy capability is not enabled in any supported distro
policy.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/include/sepol/policydb/polcaps.h | 2 +-
 libsepol/src/polcaps.c                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 53d7994..c9e40f6 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -9,7 +9,7 @@ extern "C" {
 enum {
 	POLICYDB_CAPABILITY_NETPEER,
 	POLICYDB_CAPABILITY_OPENPERM,
-	POLICYDB_CAPABILITY_REDHAT1, /* reserved for RH testing of ptrace_child */
+	POLICYDB_CAPABILITY_EXTSOCKCLASS,
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	__POLICYDB_CAPABILITY_MAX
 };
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 43a71a7..3924cb8 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -8,7 +8,7 @@
 static const char *polcap_names[] = {
 	"network_peer_controls",	/* POLICYDB_CAPABILITY_NETPEER */
 	"open_perms",			/* POLICYDB_CAPABILITY_OPENPERM */
-	"redhat1",			/* POLICYDB_CAPABILITY_REDHAT1, aka ptrace_child */
+	"extended_socket_class",	/* POLICYDB_CAPABILITY_EXTSOCKCLASS */
 	"always_check_network",		/* POLICYDB_CAPABILITY_ALWAYSNETWORK */
 	NULL
 };
-- 
2.7.4


--------------95CE6785C44B7E9D93BB1486--
