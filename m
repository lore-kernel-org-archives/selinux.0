Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3UFcOQI004160
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2014 11:38:24 -0400
Received: by mail-lb0-f175.google.com with SMTP id p9so1336070lbv.6
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2014 08:38:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB9W1A1=Q7OAv9pDw5oj0Lrj8dt5aAL_t9TffcVPbnsT1zexjQ@mail.gmail.com>
References: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
 <1398826782.10979.9.camel@localhost> <5360F3C6.4090501@redhat.com>
 <1734421.ihMzWMu7WD@x2> <5360FC01.9090904@redhat.com>
 <CAB9W1A1=Q7OAv9pDw5oj0Lrj8dt5aAL_t9TffcVPbnsT1zexjQ@mail.gmail.com>
Date: Wed, 30 Apr 2014 08:38:23 -0700
Message-ID: <CAB9W1A1a=mkZmuDpMtF-uhYse4z+ArmStHp9k09mS9YJy6zSPA@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: Report result in avc messages
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/mixed; boundary=089e0158bf88ba810e04f8445640
Cc: Steve Grubb <sgrubb@redhat.com>, selinux <selinux@tycho.nsa.gov>,
 Eric Paris <eparis@redhat.com>, linux-audit@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e0158bf88ba810e04f8445640
Content-Type: text/plain; charset=UTF-8

Attached patch switches to reporting permissive=0|1 and only does it
for avc: denied messages.

On Wed, Apr 30, 2014 at 8:18 AM, Stephen Smalley
<stephen.smalley@gmail.com> wrote:
> I could make it permissive=0 or permissive=1 if that is less
> confusing.  It doesn't necessarily correspond to the result of the
> system call, just the avc_has_perm call, as e.g. the kernel checks
> CAP_DAC_OVERRIDE and falls back to CAP_DAC_READ_SEARCH if only
> read/search access was requested, and there are other cases where a
> permission denial has a side effect rather than preventing the system
> call (e.g. CAP_FSETID).
>
> On Wed, Apr 30, 2014 at 6:34 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>
>> On 04/30/2014 09:29 AM, Steve Grubb wrote:
>>> On Wednesday, April 30, 2014 08:59:50 AM Daniel J Walsh wrote:
>>>> How about permitted rather then allowed.
>>> I think permitted is already in an AVC.
>> Not sure where.
>>>
>>>> On 04/29/2014 10:59 PM, Eric Paris wrote:
>>>>> On Tue, 2014-04-29 at 16:54 -0700, Stephen Smalley wrote:
>>>>>> Requested for Android in order to distinguish denials that are not in
>>>>>> fact breaking anything yet due to permissive domains versus denials
>>>>>> that are being enforced, but seems generally useful.  result field was
>>>>>> already in the selinux audit data structure and was being passed to
>>>>>> avc_audit() but wasn't being used.  Seems to cause no harm to ausearch
>>>>>> or audit2allow to add it as a field.  Comments?
>>>>> I think it's a great idea, but I'm worried that Steve is going to get
>>>>> grumpy because an AVC record is going to have a result= field which is
>>>>> similar, but not necessarily related to the res= field of a SYSCALL
>>>>> record.
>>> I think that I'll have to parse this field no matter what. Its probably that
>>> important. In the syscall, we use success= to be the final determination.
>>>
>>>
>>>>> Seems easily confused (although probably 9999 times out of
>>>>> 10000 they will be the same)
>>> Why would this ever not be correct? Are there times when we get an AVC with a
>>> denial _and_ the syscall completes successfully?
>>>
>>> I'd suggest using res= since its in the audit dictionary and means exactly
>>> what you are wanting to use it for. In it, 1 is success, 0 is failure.
>>>
>> I have seen AVC's where the success=yes in enforcing mode.  Basically
>> the kernel takes a different code path and the syscall succeeds.  Most
>> of these end up as dontaudits.
>>>>> So while I wholeheartedly think we should take the idea, I wonder if
>>>>> someone can dream up a name that isn't confusingly similar...
>>>>>
>>>>> I can't think of anything...
>>> There is thesaurus.com. :-)
>>>
>>> consequence, outcome, effect, reaction,  conclusion, verdict, decision,
>>> judgement, finding, ruling, answer, solution, recommendation, order,  ...
>>>
>>> -Steve
>>

--089e0158bf88ba810e04f8445640
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-selinux-Report-permissive-mode-in-avc-denied-message.patch"
Content-Disposition: attachment;
	filename="0001-selinux-Report-permissive-mode-in-avc-denied-message.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_humsfclc0

RnJvbSAyNmUxMDM5OTVjZTkwMzc4Y2E5YTgwYTg2ZjExYmYzYTI1Yzk2YzM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVwaGVuIFNtYWxsZXkgPHNkc0B0eWNoby5uc2EuZ292PgpE
YXRlOiBUdWUsIDI5IEFwciAyMDE0IDExOjI5OjA0IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gc2Vs
aW51eDogIFJlcG9ydCBwZXJtaXNzaXZlIG1vZGUgaW4gYXZjOiBkZW5pZWQgbWVzc2FnZXMuCgpX
ZSBjYW5ub3QgcHJlc2VudGx5IHRlbGwgZnJvbSBhbiBhdmM6IGRlbmllZCBtZXNzYWdlIHdoZXRo
ZXIgYWNjZXNzIHdhcyBpbgpmYWN0IGRlbmllZCBvciB3YXMgYWxsb3dlZCBkdWUgdG8gZ2xvYmFs
IG9yIHBlci1kb21haW4gcGVybWlzc2l2ZSBtb2RlLgpBZGQgYSBwZXJtaXNzaXZlPSBmaWVsZCB0
byB0aGUgYXZjIG1lc3NhZ2UgdG8gcmVmbGVjdCB0aGlzIGluZm9ybWF0aW9uLgoKU2lnbmVkLW9m
Zi1ieTogU3RlcGhlbiBTbWFsbGV5IDxzZHNAdHljaG8ubnNhLmdvdj4KLS0tCiBzZWN1cml0eS9z
ZWxpbnV4L2F2Yy5jICAgICAgICAgfCA3ICsrKysrKy0KIHNlY3VyaXR5L3NlbGludXgvaG9va3Mu
YyAgICAgICB8IDUgKysrLS0KIHNlY3VyaXR5L3NlbGludXgvaW5jbHVkZS9hdmMuaCB8IDQgKyst
LQogMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3NlY3VyaXR5L3NlbGludXgvYXZjLmMgYi9zZWN1cml0eS9zZWxpbnV4L2F2Yy5j
CmluZGV4IGZjM2U2NjIuLmExOGYxZmEgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L3NlbGludXgvYXZj
LmMKKysrIGIvc2VjdXJpdHkvc2VsaW51eC9hdmMuYwpAQCAtNDQ0LDExICs0NDQsMTUgQEAgc3Rh
dGljIHZvaWQgYXZjX2F1ZGl0X3Bvc3RfY2FsbGJhY2soc3RydWN0IGF1ZGl0X2J1ZmZlciAqYWIs
IHZvaWQgKmEpCiAJYXZjX2R1bXBfcXVlcnkoYWIsIGFkLT5zZWxpbnV4X2F1ZGl0X2RhdGEtPnNz
aWQsCiAJCQkgICBhZC0+c2VsaW51eF9hdWRpdF9kYXRhLT50c2lkLAogCQkJICAgYWQtPnNlbGlu
dXhfYXVkaXRfZGF0YS0+dGNsYXNzKTsKKwlpZiAoYWQtPnNlbGludXhfYXVkaXRfZGF0YS0+ZGVu
aWVkKSB7CisJCWF1ZGl0X2xvZ19mb3JtYXQoYWIsICIgcGVybWlzc2l2ZT0ldSIsCisJCQkJIGFk
LT5zZWxpbnV4X2F1ZGl0X2RhdGEtPnJlc3VsdCA/IDAgOiAxKTsKKwl9CiB9CiAKIC8qIFRoaXMg
aXMgdGhlIHNsb3cgcGFydCBvZiBhdmMgYXVkaXQgd2l0aCBiaWcgc3RhY2sgZm9vdHByaW50ICov
CiBub2lubGluZSBpbnQgc2xvd19hdmNfYXVkaXQodTMyIHNzaWQsIHUzMiB0c2lkLCB1MTYgdGNs
YXNzLAotCQl1MzIgcmVxdWVzdGVkLCB1MzIgYXVkaXRlZCwgdTMyIGRlbmllZCwKKwkJdTMyIHJl
cXVlc3RlZCwgdTMyIGF1ZGl0ZWQsIHUzMiBkZW5pZWQsIGludCByZXN1bHQsCiAJCXN0cnVjdCBj
b21tb25fYXVkaXRfZGF0YSAqYSwKIAkJdW5zaWduZWQgZmxhZ3MpCiB7CkBAIC00NzcsNiArNDgx
LDcgQEAgbm9pbmxpbmUgaW50IHNsb3dfYXZjX2F1ZGl0KHUzMiBzc2lkLCB1MzIgdHNpZCwgdTE2
IHRjbGFzcywKIAlzYWQudHNpZCA9IHRzaWQ7CiAJc2FkLmF1ZGl0ZWQgPSBhdWRpdGVkOwogCXNh
ZC5kZW5pZWQgPSBkZW5pZWQ7CisJc2FkLnJlc3VsdCA9IHJlc3VsdDsKIAogCWEtPnNlbGludXhf
YXVkaXRfZGF0YSA9ICZzYWQ7CiAKZGlmZiAtLWdpdCBhL3NlY3VyaXR5L3NlbGludXgvaG9va3Mu
YyBiL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYwppbmRleCBiNGJlYjc3Li5lMTU2YjVmIDEwMDY0
NAotLS0gYS9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMKKysrIGIvc2VjdXJpdHkvc2VsaW51eC9o
b29rcy5jCkBAIC0yNzcwLDYgKzI3NzAsNyBAQCBzdGF0aWMgaW50IHNlbGludXhfaW5vZGVfZm9s
bG93X2xpbmsoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgbmFtZWlkYXRhICpuYQogCiBz
dGF0aWMgbm9pbmxpbmUgaW50IGF1ZGl0X2lub2RlX3Blcm1pc3Npb24oc3RydWN0IGlub2RlICpp
bm9kZSwKIAkJCQkJICAgdTMyIHBlcm1zLCB1MzIgYXVkaXRlZCwgdTMyIGRlbmllZCwKKwkJCQkJ
ICAgaW50IHJlc3VsdCwKIAkJCQkJICAgdW5zaWduZWQgZmxhZ3MpCiB7CiAJc3RydWN0IGNvbW1v
bl9hdWRpdF9kYXRhIGFkOwpAQCAtMjc4MCw3ICsyNzgxLDcgQEAgc3RhdGljIG5vaW5saW5lIGlu
dCBhdWRpdF9pbm9kZV9wZXJtaXNzaW9uKHN0cnVjdCBpbm9kZSAqaW5vZGUsCiAJYWQudS5pbm9k
ZSA9IGlub2RlOwogCiAJcmMgPSBzbG93X2F2Y19hdWRpdChjdXJyZW50X3NpZCgpLCBpc2VjLT5z
aWQsIGlzZWMtPnNjbGFzcywgcGVybXMsCi0JCQkgICAgYXVkaXRlZCwgZGVuaWVkLCAmYWQsIGZs
YWdzKTsKKwkJCSAgICBhdWRpdGVkLCBkZW5pZWQsIHJlc3VsdCwgJmFkLCBmbGFncyk7CiAJaWYg
KHJjKQogCQlyZXR1cm4gcmM7CiAJcmV0dXJuIDA7CkBAIC0yODIyLDcgKzI4MjMsNyBAQCBzdGF0
aWMgaW50IHNlbGludXhfaW5vZGVfcGVybWlzc2lvbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBpbnQg
bWFzaykKIAlpZiAobGlrZWx5KCFhdWRpdGVkKSkKIAkJcmV0dXJuIHJjOwogCi0JcmMyID0gYXVk
aXRfaW5vZGVfcGVybWlzc2lvbihpbm9kZSwgcGVybXMsIGF1ZGl0ZWQsIGRlbmllZCwgZmxhZ3Mp
OworCXJjMiA9IGF1ZGl0X2lub2RlX3Blcm1pc3Npb24oaW5vZGUsIHBlcm1zLCBhdWRpdGVkLCBk
ZW5pZWQsIHJjLCBmbGFncyk7CiAJaWYgKHJjMikKIAkJcmV0dXJuIHJjMjsKIAlyZXR1cm4gcmM7
CmRpZmYgLS1naXQgYS9zZWN1cml0eS9zZWxpbnV4L2luY2x1ZGUvYXZjLmggYi9zZWN1cml0eS9z
ZWxpbnV4L2luY2x1ZGUvYXZjLmgKaW5kZXggZjUzZWUzYy4uZGRmOGVlYyAxMDA2NDQKLS0tIGEv
c2VjdXJpdHkvc2VsaW51eC9pbmNsdWRlL2F2Yy5oCisrKyBiL3NlY3VyaXR5L3NlbGludXgvaW5j
bHVkZS9hdmMuaApAQCAtMTAyLDcgKzEwMiw3IEBAIHN0YXRpYyBpbmxpbmUgdTMyIGF2Y19hdWRp
dF9yZXF1aXJlZCh1MzIgcmVxdWVzdGVkLAogfQogCiBpbnQgc2xvd19hdmNfYXVkaXQodTMyIHNz
aWQsIHUzMiB0c2lkLCB1MTYgdGNsYXNzLAotCQkgICB1MzIgcmVxdWVzdGVkLCB1MzIgYXVkaXRl
ZCwgdTMyIGRlbmllZCwKKwkJICAgdTMyIHJlcXVlc3RlZCwgdTMyIGF1ZGl0ZWQsIHUzMiBkZW5p
ZWQsIGludCByZXN1bHQsCiAJCSAgIHN0cnVjdCBjb21tb25fYXVkaXRfZGF0YSAqYSwKIAkJICAg
dW5zaWduZWQgZmxhZ3MpOwogCkBAIC0xMzcsNyArMTM3LDcgQEAgc3RhdGljIGlubGluZSBpbnQg
YXZjX2F1ZGl0KHUzMiBzc2lkLCB1MzIgdHNpZCwKIAlpZiAobGlrZWx5KCFhdWRpdGVkKSkKIAkJ
cmV0dXJuIDA7CiAJcmV0dXJuIHNsb3dfYXZjX2F1ZGl0KHNzaWQsIHRzaWQsIHRjbGFzcywKLQkJ
CSAgICAgIHJlcXVlc3RlZCwgYXVkaXRlZCwgZGVuaWVkLAorCQkJICAgICAgcmVxdWVzdGVkLCBh
dWRpdGVkLCBkZW5pZWQsIHJlc3VsdCwKIAkJCSAgICAgIGEsIDApOwogfQogCi0tIAoxLjguMy4x
Cgo=
--089e0158bf88ba810e04f8445640--
