Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBSEwQQA007244
 for <selinux@tycho.nsa.gov>; Thu, 28 Dec 2017 09:58:26 -0500
Received: by mail-io0-f179.google.com with SMTP id k202so30299775ioe.10
 for <selinux@tycho.nsa.gov>; Thu, 28 Dec 2017 06:57:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <30dd3248-b703-828b-13ba-8d7ace8a09da@huawei.com>
References: <30dd3248-b703-828b-13ba-8d7ace8a09da@huawei.com>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Thu, 28 Dec 2017 09:57:58 -0500
Message-ID: <CAB9W1A0fN2QSA60JwYEjrCOHxFnobypJdDskkQ8Fz4zrXycy6Q@mail.gmail.com>
To: Li Kun <hw.likun@huawei.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Qiuxishi <qiuxishi@huawei.com>, wangboshi <wangboshi@huawei.com>,
 Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary="001a1144539ce65fba056167bd2f"
Subject: Re: [BUG RFD]selinux: sidtab_context_to_sid return -NOMEM
 when concurrent with security_load_policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1144539ce65fba056167bd2f
Content-Type: text/plain; charset="UTF-8"

On Sat, Dec 23, 2017 at 3:03 AM, Li Kun <hw.likun@huawei.com> wrote:

> Hi all,
> When i start a docker container, the runc will call selinux_setprocattr to
> set the exec_sid before start the container.
> Meanwhile if i use "semodule -i" to load a policy pp, the old sidtab will
> be shutdown before switch to the new sidtab, and cause
> sidtab_context_to_sid  failed with the errno -NOMEM.
>
> Error message:
> Dec 14 09:18:18 wuwenming_vudfua_0 docker: time="2017-12-14T09:18:18.549862564+08:00"
> level=error msg="Handler for GET /v1.23/containers/192.168.0.2:9082/dfs_d:
> V100R013C11SPC000BCD2/json returned error: No such container:
> 192.168.0.2:9082/dfs_d:V100R013C11SPC000BCD2"
> Dec 14 09:18:18 wuwenming_vudfua_0 kernel: [   48.463179] SELinux:
> security_context_to_sid(system_u:object_r:svirt_sandbox_file_t:s0:c290,c371)
> failed for (dev overlay, type overlay) errno=-12
> Dec 14 09:18:18 wuwenming_vudfua_0 dbus-daemon: dbus[720]: avc:  received
> policyload notice (seqno=2)
> Dec 14 09:18:18 wuwenming_vudfua_0 dbus[720]: avc:  received policyload
> notice (seqno=2)
>
>
> runc
>
>     semodule
> ->selinux_setprocattr
>
> ->security_load_policy
>     ->security_context_to_sid
>
> ->sidtab_shutdown(oldsidtab)
>         ->read_lock(&policy_rwlock);
>
> ->sidtab_map(&oldsidtab, clone_sid, &newsidtab);
>
>         ->sidtab_context_to_sid
>
>             {
>                         ....
>                         if (s->next_sid == UINT_MAX || s->shutdown) {
>                         ret = -ENOMEM;
>                         ....
>             }
>         ->read_unlock(&policy_rwlock);
>
>
>
> ->write_lock_irq(&policy_rwlock);
>
>
> ->"switch to new policydb"
>
>
> ->write_unlock_irq(&policy_rwlock);
>
> I wonder that if this is the intention or a bug?
> If it is the intention, what should the application do when it get -ENOMEM
> error,  to try again?
> If it is a bug, may the two options below suitable to solve the issue?
> Option1:
>     use policy_rwlock to protect the "sidtab_shutdown" & "sidtab_map" ,
> load_policy is rarely to be called after system bringing up,
> so i think it will not impact much on the performance.
> Option2:
>     Use a temp list to store the sid in oldsidtab after it is shutdown,
> and deal with it
> after cloning the major sids from oldsidtab to newsidtab and getting the
> policy_rwlock.
>

The current logic is intentional.  One might argue that a different error
code might be more suitable in this situation (e.g. EAGAIN or something),
but ENOMEM is already a possible error code when loading policy upon
transient OOM conditions, so the caller might have to retry regardless.
The policy write lock must only be held for the minimal critical section as
otherwise all system activity could be blocked; it is only held when making
the new policydb and sidtab active not during their allocation and setup -
ideally it would be further reduced to a couple of pointer updates. Is this
scenario something you are encountering in actual practice or just a
theoretically possible one?

--001a1144539ce65fba056167bd2f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiBTYXQsIERlYyAyMywgMjAxNyBhdCAzOjAzIEFNLCBMaSBLdW4gPHNwYW4gZGly
PSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86aHcubGlrdW5AaHVhd2VpLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPmh3Lmxpa3VuQGh1YXdlaS5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KICANCg0KICAgIA0KICAN
CiAgPGRpdiBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMDAwMDAwIj4NCiAgICBIaSBhbGwsPGJy
Pg0KICAgIFdoZW4gaSBzdGFydCBhIGRvY2tlciBjb250YWluZXIsIHRoZSBydW5jIHdpbGwgY2Fs
bA0KICAgIHNlbGludXhfc2V0cHJvY2F0dHIgdG8gc2V0IHRoZSBleGVjX3NpZCBiZWZvcmUgc3Rh
cnQgdGhlIGNvbnRhaW5lci48YnI+DQogICAgTWVhbndoaWxlIGlmIGkgdXNlICZxdW90O3NlbW9k
dWxlIC1pJnF1b3Q7IHRvIGxvYWQgYSBwb2xpY3kgcHAsIHRoZSBvbGQgc2lkdGFiDQogICAgd2ls
bCBiZSBzaHV0ZG93biBiZWZvcmUgc3dpdGNoIHRvIHRoZSBuZXcgc2lkdGFiLCBhbmQgY2F1c2Ug
PGJyPg0KICAgIHNpZHRhYl9jb250ZXh0X3RvX3NpZMKgIGZhaWxlZCB3aXRoIHRoZSBlcnJubyAt
Tk9NRU0uPGJyPg0KICAgIDxicj4NCiAgICBFcnJvciBtZXNzYWdlOjxicj4NCiAgICBEZWMgMTQg
MDk6MTg6MTggd3V3ZW5taW5nX3Z1ZGZ1YV8wIGRvY2tlcjoNCiAgICB0aW1lPSZxdW90OzIwMTct
MTItMTRUMDk6MTg6MTguPHdicj41NDk4NjI1NjQrMDg6MDAmcXVvdDsgbGV2ZWw9ZXJyb3IgbXNn
PSZxdW90O0hhbmRsZXINCiAgICBmb3IgR0VUDQogICAgL3YxLjIzL2NvbnRhaW5lcnMvPGEgaHJl
Zj0iaHR0cDovLzE5Mi4xNjguMC4yOjkwODIvZGZzX2Q6VjEwMFIwMTNDMTFTUEMwMDBCQ0QyL2pz
b24iIHRhcmdldD0iX2JsYW5rIj4xOTIuMTY4LjAuMjo8d2JyPjkwODIvZGZzX2Q6PHdicj5WMTAw
UjAxM0MxMVNQQzAwMEJDRDIvanNvbjwvYT4NCiAgICByZXR1cm5lZCBlcnJvcjogTm8gc3VjaCBj
b250YWluZXI6DQogICAgPGEgaHJlZj0iaHR0cDovLzE5Mi4xNjguMC4yOjkwODIvZGZzX2Q6VjEw
MFIwMTNDMTFTUEMwMDBCQ0QyIiB0YXJnZXQ9Il9ibGFuayI+MTkyLjE2OC4wLjI6OTA4Mi9kZnNf
ZDo8d2JyPlYxMDBSMDEzQzExU1BDMDAwQkNEMjwvYT4mcXVvdDs8YnI+DQogICAgRGVjIDE0IDA5
OjE4OjE4IHd1d2VubWluZ192dWRmdWFfMCBrZXJuZWw6IFvCoMKgIDQ4LjQ2MzE3OV0gU0VMaW51
eDoNCnNlY3VyaXR5X2NvbnRleHRfdG9fc2lkKDx3YnI+c3lzdGVtX3U6b2JqZWN0X3I6c3ZpcnRf
PHdicj5zYW5kYm94X2ZpbGVfdDpzMDpjMjkwLGMzNzEpDQogICAgZmFpbGVkIGZvciAoZGV2IG92
ZXJsYXksIHR5cGUgb3ZlcmxheSkgZXJybm89LTEyPGJyPg0KICAgIERlYyAxNCAwOToxODoxOCB3
dXdlbm1pbmdfdnVkZnVhXzAgZGJ1cy1kYWVtb246IGRidXNbNzIwXTogYXZjOsKgDQogICAgcmVj
ZWl2ZWQgcG9saWN5bG9hZCBub3RpY2UgKHNlcW5vPTIpPGJyPg0KICAgIERlYyAxNCAwOToxODox
OCB3dXdlbm1pbmdfdnVkZnVhXzAgZGJ1c1s3MjBdOiBhdmM6wqAgcmVjZWl2ZWQNCiAgICBwb2xp
Y3lsb2FkIG5vdGljZSAoc2Vxbm89Mik8YnI+DQogICAgPGJyPg0KICAgIDxicj4NCnJ1bmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8
d2JyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoDx3YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqDCoMKgwqDCoA0KICAgIMKgwqDCoCDCoMKgwqAgc2Vt
b2R1bGU8YnI+DQotJmd0O3NlbGludXhfc2V0cHJvY2F0dHLCoMKgwqDCoMKgwqDCoMKgwqA8d2Jy
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoDx3YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgPHdicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqA8d2JyPsKgwqDCoMKgwqDCoMKgDQogICAgLSZndDtzZWN1cml0
eV9sb2FkX3BvbGljeTxicj4NCiAgICDCoMKgwqAgLSZndDtzZWN1cml0eV9jb250ZXh0X3RvX3Np
ZMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgDQogICAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgwqDCoA0KICAgIC0mZ3Q7c2lkdGFiX3NodXRkb3duKG9sZHNpZHRhYik8YnI+
DQogICAgwqDCoMKgwqDCoMKgwqAgLSZndDtyZWFkX2xvY2soJmFtcDtwb2xpY3lfcndsb2NrKTvC
oMKgPHdicj7CoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgDQogICAgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgwqDCoA0KICAg
IMKgwqDCoCAtJmd0O3NpZHRhYl9tYXAoJmFtcDtvbGRzaWR0YWIsIGNsb25lX3NpZCwgJmFtcDtu
ZXdzaWR0YWIpOzxicj4NCiAgICDCoMKgwqAgwqDCoMKgIDxicj4NCiAgICDCoMKgwqDCoMKgwqDC
oCAtJmd0O3NpZHRhYl9jb250ZXh0X3RvX3NpZMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqANCiAgICDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgwqDCoCA8YnI+DQogICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7PGJyPg0K
ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLi4uLjxi
cj4NCiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChzLSZndDtuZXh0X3NpZCA9PSBVSU5UX01BWCB8fCBzLSZndDs8Zm9udCBjb2xvcj0iI2ZmMDAw
MCI+c2h1dGRvd248L2ZvbnQ+KSB7PGJyPg0KICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gLTxmb250IGNvbG9yPSIjZmYwMDAwIj5FTk9NRU08
L2ZvbnQ+Ozxicj4NCiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC4uLi48YnI+DQogICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9PGJyPg0KICAgIMKg
wqDCoMKgwqDCoMKgIC0mZ3Q7cmVhZF91bmxvY2soJmFtcDtwb2xpY3lfcndsb2NrKTs8d2JyPsKg
wqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgDQogICAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoA0KICAgIMKg
wqDCoCA8YnI+DQogICAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoA0KICAgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqANCiAgICDCoMKgwqAgwqDCoMKgIC0mZ3Q7d3Jp
dGVfbG9ja19pcnEoJmFtcDtwb2xpY3lfPHdicj5yd2xvY2spOzxicj4NCiAgICDCoMKgwqAgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgDQogICAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoCDCoMKg
DQogICAgwqDCoMKgIMKgwqDCoCDCoCAtJmd0OyZxdW90O3N3aXRjaCB0byBuZXcgcG9saWN5ZGIm
cXVvdDs8YnI+DQogICAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoA0KICAgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqANCiAgICDCoMKgwqAgwqDCoMKgIC0mZ3Q7d3Jp
dGVfdW5sb2NrX2lycSgmYW1wO3BvbGljeV88d2JyPnJ3bG9jayk7PGJyPg0KICAgIDxicj4NCiAg
ICBJIHdvbmRlciB0aGF0IGlmIHRoaXMgaXMgdGhlIGludGVudGlvbiBvciBhIGJ1Zz88YnI+DQog
ICAgSWYgaXQgaXMgdGhlIGludGVudGlvbiwgd2hhdCBzaG91bGQgdGhlIGFwcGxpY2F0aW9uIGRv
IHdoZW4gaXQgZ2V0DQogICAgLUVOT01FTSBlcnJvcizCoCB0byB0cnkgYWdhaW4/PGJyPg0KICAg
IElmIGl0IGlzIGEgYnVnLCBtYXkgdGhlIHR3byBvcHRpb25zIGJlbG93IHN1aXRhYmxlIHRvIHNv
bHZlIHRoZQ0KICAgIGlzc3VlPzxicj4NCiAgICBPcHRpb24xOjxicj4NCiAgICDCoMKgwqAgdXNl
IHBvbGljeV9yd2xvY2sgdG8gcHJvdGVjdCB0aGUgJnF1b3Q7c2lkdGFiX3NodXRkb3duJnF1b3Q7
ICZhbXA7DQogICAgJnF1b3Q7c2lkdGFiX21hcCZxdW90OyAsIGxvYWRfcG9saWN5IGlzIHJhcmVs
eSB0byBiZSBjYWxsZWQgYWZ0ZXIgc3lzdGVtDQogICAgYnJpbmdpbmcgdXAswqAgPGJyPg0KICAg
IHNvIGkgdGhpbmsgaXQgd2lsbCBub3QgaW1wYWN0IG11Y2ggb24gdGhlIHBlcmZvcm1hbmNlLjxi
cj4NCiAgICBPcHRpb24yOjxicj4NCiAgICDCoMKgwqAgVXNlIGEgdGVtcCBsaXN0IHRvIHN0b3Jl
IHRoZSBzaWQgaW4gb2xkc2lkdGFiIGFmdGVyIGl0IGlzDQogICAgc2h1dGRvd24sIGFuZCBkZWFs
IHdpdGggaXQgPGJyPg0KICAgIGFmdGVyIGNsb25pbmcgdGhlIG1ham9yIHNpZHMgZnJvbSBvbGRz
aWR0YWIgdG8gbmV3c2lkdGFiIGFuZCBnZXR0aW5nDQogICAgdGhlIHBvbGljeV9yd2xvY2suPC9k
aXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhlIGN1cnJlbnQgbG9naWMgaXMg
aW50ZW50aW9uYWwuwqAgT25lIG1pZ2h0IGFyZ3VlIHRoYXQgYSBkaWZmZXJlbnQgZXJyb3IgY29k
ZSBtaWdodCBiZSBtb3JlIHN1aXRhYmxlIGluIHRoaXMgc2l0dWF0aW9uIChlLmcuIEVBR0FJTiBv
ciBzb21ldGhpbmcpLCBidXQgRU5PTUVNIGlzIGFscmVhZHkgYSBwb3NzaWJsZSBlcnJvciBjb2Rl
IHdoZW4gbG9hZGluZyBwb2xpY3kgdXBvbiB0cmFuc2llbnQgT09NIGNvbmRpdGlvbnMsIHNvIHRo
ZSBjYWxsZXIgbWlnaHQgaGF2ZSB0byByZXRyeSByZWdhcmRsZXNzLsKgIFRoZSBwb2xpY3kgd3Jp
dGUgbG9jayBtdXN0IG9ubHkgYmUgaGVsZCBmb3IgdGhlIG1pbmltYWwgY3JpdGljYWwgc2VjdGlv
biBhcyBvdGhlcndpc2UgYWxsIHN5c3RlbSBhY3Rpdml0eSBjb3VsZCBiZSBibG9ja2VkOyBpdCBp
cyBvbmx5IGhlbGQgd2hlbiBtYWtpbmcgdGhlIG5ldyBwb2xpY3lkYiBhbmQgc2lkdGFiIGFjdGl2
ZSBub3QgZHVyaW5nIHRoZWlyIGFsbG9jYXRpb24gYW5kIHNldHVwIC0gaWRlYWxseSBpdCB3b3Vs
ZCBiZSBmdXJ0aGVyIHJlZHVjZWQgdG8gYSBjb3VwbGUgb2YgcG9pbnRlciB1cGRhdGVzLiBJcyB0
aGlzIHNjZW5hcmlvIHNvbWV0aGluZyB5b3UgYXJlIGVuY291bnRlcmluZyBpbiBhY3R1YWwgcHJh
Y3RpY2Ugb3IganVzdCBhIHRoZW9yZXRpY2FsbHkgcG9zc2libGUgb25lP8KgwqA8L2Rpdj48L2Rp
dj48L2Rpdj48L2Rpdj4NCg==
--001a1144539ce65fba056167bd2f--
