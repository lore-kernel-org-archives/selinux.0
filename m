Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBJAosRb011288
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 05:50:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBJAoppp011483
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 10:50:53 GMT
Date: Fri, 19 Dec 2003 19:50:45 +0900
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
To: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Cc: ynakam@ori.hitachi-sk.co.jp, russell@coker.com.au, hdholm@epoch.ncsc.mil,
   himainu_ynakam@ybb.ne.jp
Subject: Apache on FedoraCore1(Was Re: log_domain macro)
Message-Id: <20031219195045.4425635f.ynakam@ori.hitachi-sk.co.jp>
In-Reply-To: <1071688353.1403.137.camel@moss-spartans.epoch.ncsc.mil>
References: <20031215190237.4f459090.ynakam@ori.hitachi-sk.co.jp>
	<1071503117.28044.76.camel@moss-spartans.epoch.ncsc.mil>
	<20031216133940.568e9795.ynakam@ori.hitachi-sk.co.jp>
	<1071688353.1403.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__19_Dec_2003_19_50_45_+0900_/91oO88T/OR/=1PJ"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Fri__19_Dec_2003_19_50_45_+0900_/91oO88T/OR/=1PJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


I tested apache on FedoraCore1 .
I found that some changes are needed. 
I modified apache.te,apache.fc and global_macros.te as attached patches.

Here I list important changes.
(1) 
can_exec(httpd_t,bin_t) is described in apache.te.
I think it is not good , because "execute_no_trans" is granted.
Apache and CGI worked without execute_no_trans.
So,I replaced it by using rx_file_perms.

(2) 
I tried not to grant write access of httpd_t to /etc/log/httpd.
I used append_log_domain macro posted before.
In FedoraCore1, 
it is better to modify SSLMutex path defined in /etc/httpd/conf.d/ssl.conf like following,
because file is written on SSLMutex path.
#SSLMutex  file:logs/ssl_mutex
SSLMutex   file:/var/cache/mod_ssl/ssl_mutex

(3)
I defined new type krb5_conf_t for /etc/krb5.conf
because write access to /etc/krb5.conf was denied.
However, Apache worked when access to /etc/krb5.conf is denied.
So,"allow httpd_t krb5_conf_t:file rw_file_perms;" is commented out now.



On Wed, 17 Dec 2003 14:12:33 -0500
Stephen Smalley <sds@epoch.ncsc.mil> wrote:

> On Mon, 2003-12-15 at 23:39, Yuichi Nakamura wrote:
> > As you say, "remove_name" granted by rw_dir_perms is not necessary.
> > So the following is better.
> > 
> > define(`append_log_domain', `
> > type $1_log_t, file_type, sysadmfile, logfile;
> > allow $1_t var_log_t:dir ra_dir_perms;
> > allow $1_t $1_log_t:file  { create ra_file_perms };
> > type_transition $1_t var_log_t:file $1_log_t;
> > ')
> >
> > In apache.te logdir_domain macro is used, 
> > but create_append_log_file will be prefered.
> > Because in FedoraCore1, apache create log files on its own directory(/var/log/httpd/).
> > 
> > append_log_domain macro will be useful when a daemon creates its own log file on  /var/log/.
> 
> Ok.  Care to submit a patch adding your macro and changing apache.te to
> use it (after testing your updated policy with apache on FC1, of
> course)?
> 

---
Yuichi Nakamura

--Multipart=_Fri__19_Dec_2003_19_50_45_+0900_/91oO88T/OR/=1PJ
Content-Type: application/octet-stream;
 name="apache.te.patch"
Content-Disposition: attachment;
 filename="apache.te.patch"
Content-Transfer-Encoding: base64

LS0tIHBvbGljeS5vcmlnL2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQvYXBhY2hlLnRlCTIwMDMtMTIt
MDYgMTA6MDE6NTcuMDAwMDAwMDAwICswOTAwCisrKyBwb2xpY3kvZG9tYWlucy9wcm9ncmFtL2Fw
YWNoZS50ZQkyMDAzLTEyLTE4IDIzOjE0OjEwLjAwMDAwMDAwMCArMDkwMApAQCAtMzAsNyArMzAs
MTggQEAKICMKIHR5cGUgaHR0cGRfY29uZmlnX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZTsKIAot
bG9nZGlyX2RvbWFpbihodHRwZCkKKyNjYW4gY3JlYXRlIGFwcGVuZC1vbmx5IGxvZ3MgdW5kZXIg
L3Zhci9sb2cKK2FwcGVuZF9sb2dkaXJfZG9tYWluKGh0dHBkKQorI2NhbiByZWFkIC9ldGMvaHR0
cGQvbG9ncworYWxsb3cgaHR0cGRfdCBodHRwZF9sb2dfdDpsbmtfZmlsZSB7IHJlYWQgfTsKKwor
I2NhbiB3cml0ZSBzc2xtdXRleCBmaWxlIHRvIC92YXIvbG9nL2h0dHBkCisjISFOb3RpY2U6SXQg
aXMgYmV0dGVyIG5vdCB0byBncmFudCB3cml0ZSBhY2Nlc3NzIHRvIC92YXIvbG9nL2h0dHBkLgor
I1RvIGNvbW1lbnQgb3V0IHRoZXNlLG1vZGlmeSBTU0xNdXRleCBlbnRyeSBpbiAvZXRjL2h0dHBk
L2NvbmYuZC9zc2wuY29uZixsaWtlIGZvbGxvd2luZworI1NTTE11dGV4IGZpbGU6L3Zhci9jYWNo
ZS9tb2Rfc3NsCithbGxvdyBodHRwZF90IGh0dHBkX2xvZ190OmRpciB7IHJlbW92ZV9uYW1lIH07
CithbGxvdyBodHRwZF90IGh0dHBkX2xvZ190OmZpbGUgeyBzZXRhdHRyIHVubGluayB9OworCiAK
ICMgRm9yIC9ldGMvaW5pdC5kL2FwYWNoZTIgcmVsb2FkCiBjYW5fdGNwX2Nvbm5lY3QoaHR0cGRf
dCwgaHR0cGRfdCkKQEAgLTk5LDExICsxMTAsMTQgQEAKICcpCiAKIHVzZXNfc2hsaWIoaHR0cGRf
dCkKK2FsbG93IGh0dHBkX3QgbGliX3Q6ZmlsZSB7IGdldGF0dHIgcmVhZCB9OwogCiAjIGV4ZWN1
dGUgcGVybAotY2FuX2V4ZWMoaHR0cGRfdCwgYmluX3QpCithbGxvdyBodHRwZF90IGJpbl90OmZp
bGUgcnhfZmlsZV9wZXJtczsKK2FsbG93IGh0dHBkX3QgYmluX3Q6ZGlyIHsgc2VhcmNoIH07CiAK
IGNhbl9uZXR3b3JrKGh0dHBkX3QpCithbGxvdyBodHRwZF90IGh0dHBkX3Q6bmV0bGlua19zb2Nr
ZXQgeyBiaW5kIGNyZWF0ZSBnZXRhdHRyIHJlYWQgd3JpdGUgfTsKIAogIyMjIyMjIyMjIyMjIyMj
IyMjIwogIyBBbGxvdyBodHRwZCB0byBzZWFyY2ggdXNlcnMgZGlyZXRvcmllcwpAQCAtMTE0LDcg
KzEyOCw3IEBACiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiAjIEFsbG93IHRoZSBodHRwZF90IHRoZSBj
YXBhYmlsaXR5IHRvIGJpbmQgdG8gYSBwb3J0IGFuZCB2YXJpb3VzIG90aGVyIHN0dWZmCiAjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjCi1hbGxvdyBodHRwZF90IGh0dHBkX3Q6Y2FwYWJpbGl0eSB7Y2hvd24g
bmV0X2JpbmRfc2VydmljZSBzZXRnaWQgc2V0dWlkIGtpbGwgZGFjX292ZXJyaWRlIGRhY19yZWFk
X3NlYXJjaCB9OworYWxsb3cgaHR0cGRfdCBodHRwZF90OmNhcGFiaWxpdHkge2Nob3duIG5ldF9i
aW5kX3NlcnZpY2Ugc2V0Z2lkIHNldHVpZCBraWxsIGRhY19vdmVycmlkZSBkYWNfcmVhZF9zZWFy
Y2ggbmV0X2FkbWluIH07CiAKICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKICMgQWxsb3cgdGhlIGh0dHBkX3QgdG8gcmVhZCB0aGUgd2ViIHNlcnZlcnMg
Y29uZmlnIGZpbGVzCkBAIC0yMTIsMyArMjI2LDcgQEAKIGFsbG93IGh0dHBkX3BocF90IG15c3Fs
ZF92YXJfcnVuX3Q6c29ja19maWxlIHsgd3JpdGUgfTsKICcpCiAKKyMgd3JpdGUgL2V0Yy9rcmI1
LmNvbmYKK3R5cGUga3JiNV9jb25mX3QsZmlsZV90eXBlLHN5c2FkbWZpbGU7CisjYWxsb3cgaHR0
cGRfdCBrcmI1X2NvbmZfdDpmaWxlIHJ3X2ZpbGVfcGVybXM7CisK

--Multipart=_Fri__19_Dec_2003_19_50_45_+0900_/91oO88T/OR/=1PJ
Content-Type: application/octet-stream;
 name="apache.fc.patch"
Content-Disposition: attachment;
 filename="apache.fc.patch"
Content-Transfer-Encoding: base64

LS0tIHBvbGljeS5vcmlnL2ZpbGVfY29udGV4dHMvcHJvZ3JhbS9hcGFjaGUuZmMJMjAwMy0xMi0w
NiAxMDowMTo1Ny4wMDAwMDAwMDAgKzA5MDAKKysrIHBvbGljeS9maWxlX2NvbnRleHRzL3Byb2dy
YW0vYXBhY2hlLmZjCTIwMDMtMTItMTggMjM6MDk6NTcuMDAwMDAwMDAwICswOTAwCkBAIC0yLDYg
KzIsNyBAQAogL2hvbWUvW14vXSsvKCh3d3cpfCh3ZWIpfChwdWJsaWNfaHRtbCkpKC8uKyk/IHN5
c3RlbV91Om9iamVjdF9yOmh0dHBkX3VzZXJfY29udGVudF90CiAvdmFyL3d3dwkJLWQJc3lzdGVt
X3U6b2JqZWN0X3I6aHR0cGRfc3lzX2NvbnRlbnRfdAogL3Zhci93d3cvaHRtbCgvLiopPwkJc3lz
dGVtX3U6b2JqZWN0X3I6aHR0cGRfc3lzX2NvbnRlbnRfdAorL3Zhci93d3cvZXJyb3IoLy4qKT8J
CXN5c3RlbV91Om9iamVjdF9yOmh0dHBkX3N5c19jb250ZW50X3QKIC92YXIvd3d3L21ydGcoLy4q
KT8JCXN5c3RlbV91Om9iamVjdF9yOmh0dHBkX3N5c19jb250ZW50X3QKIC92YXIvd3d3L2NnaS1i
aW4oLy4qKT8JCXN5c3RlbV91Om9iamVjdF9yOmh0dHBkX3N5c19zY3JpcHRfZXhlY190CiAvdXNy
L2xpYi9jZ2ktYmluKC8uKik/CQlzeXN0ZW1fdTpvYmplY3RfcjpodHRwZF9zeXNfc2NyaXB0X2V4
ZWNfdApAQCAtMTAsMTIgKzExLDE0IEBACiAvdmFyL2NhY2hlL2h0dHBkKC8uKik/CQlzeXN0ZW1f
dTpvYmplY3RfcjpodHRwZF9jYWNoZV90CiAvZXRjL2h0dHBkCQktZAlzeXN0ZW1fdTpvYmplY3Rf
cjpodHRwZF9jb25maWdfdAogL2V0Yy9odHRwZC9jb25mKC8uKik/CQlzeXN0ZW1fdTpvYmplY3Rf
cjpodHRwZF9jb25maWdfdAorL2V0Yy9odHRwZC9jb25mXC5kKC8uKik/CXN5c3RlbV91Om9iamVj
dF9yOmh0dHBkX2NvbmZpZ190CiAvZXRjL2h0dHBkL2xvZ3MJCQlzeXN0ZW1fdTpvYmplY3Rfcjpo
dHRwZF9sb2dfdAogL2V0Yy9odHRwZC9tb2R1bGVzCQlzeXN0ZW1fdTpvYmplY3RfcjpodHRwZF9t
b2R1bGVzX3QKIC9ldGMvYXBhY2hlKDIpPygvLiopPwkJc3lzdGVtX3U6b2JqZWN0X3I6aHR0cGRf
Y29uZmlnX3QKIC9ldGMvdmhvc3RzCQktLQlzeXN0ZW1fdTpvYmplY3RfcjpodHRwZF9jb25maWdf
dAogL3Vzci9saWIvYXBhY2hlKC8uKik/CQlzeXN0ZW1fdTpvYmplY3RfcjpodHRwZF9tb2R1bGVz
X3QKIC91c3IvbGliL2FwYWNoZTIvbW9kdWxlcygvLiopPwlzeXN0ZW1fdTpvYmplY3RfcjpodHRw
ZF9tb2R1bGVzX3QKKy91c3IvbGliL2h0dHBkKC8uKik/CQlzeXN0ZW1fdTpvYmplY3RfcjpodHRw
ZF9tb2R1bGVzX3QKIC91c3Ivc2Jpbi9odHRwZAkJLS0Jc3lzdGVtX3U6b2JqZWN0X3I6aHR0cGRf
ZXhlY190CiAvdXNyL3NiaW4vYXBhY2hlKDIpPwktLQlzeXN0ZW1fdTpvYmplY3RfcjpodHRwZF9l
eGVjX3QKIC91c3Ivc2Jpbi9zdWV4ZWMJLS0Jc3lzdGVtX3U6b2JqZWN0X3I6aHR0cGRfc3VleGVj
X2V4ZWNfdApAQCAtMjUsNCArMjgsNyBAQAogL3Zhci9sb2cvYXBhY2hlKDIpPygvLiopPwlzeXN0
ZW1fdTpvYmplY3RfcjpodHRwZF9sb2dfdAogL3Zhci9sb2cvY2dpd3JhcC5sb2cuKgktLQlzeXN0
ZW1fdTpvYmplY3RfcjpodHRwZF9sb2dfdAogL3Zhci9jYWNoZS9zc2wuKlwuc2VtCS0tCXN5c3Rl
bV91Om9iamVjdF9yOmh0dHBkX2NhY2hlX3QKKy92YXIvY2FjaGUvbW9kX3NzbCgvLiopPwlzeXN0
ZW1fdTpvYmplY3RfcjpodHRwZF9jYWNoZV90CiAvdmFyL3J1bi9hcGFjaGUoMik/LnBpZC4qIC0t
CXN5c3RlbV91Om9iamVjdF9yOmh0dHBkX3Zhcl9ydW5fdAorL2V0Yy9rcmI1LmNvbmYJCXN5c3Rl
bV91Om9iamVjdF9yOmtyYjVfY29uZl90CisK

--Multipart=_Fri__19_Dec_2003_19_50_45_+0900_/91oO88T/OR/=1PJ
Content-Type: application/octet-stream;
 name="global_macros.te.patch"
Content-Disposition: attachment;
 filename="global_macros.te.patch"
Content-Transfer-Encoding: base64

LS0tIHBvbGljeS5vcmlnL21hY3Jvcy9nbG9iYWxfbWFjcm9zLnRlCTIwMDMtMTItMDYgMTA6MDE6
NTcuMDAwMDAwMDAwICswOTAwCisrKyBwb2xpY3kvbWFjcm9zL2dsb2JhbF9tYWNyb3MudGUJMjAw
My0xMi0xOCAyMzoxNjo1Ny4wMDAwMDAwMDAgKzA5MDAKQEAgLTM2NSw2ICszNjUsMjAgQEAKIGFs
bG93ICQxX3QgJDFfbG9nX3Q6ZGlyIHsgc2V0YXR0ciByd19kaXJfcGVybXMgfTsKICcpCiAKKwor
ZGVmaW5lKGBhcHBlbmRfbG9nX2RvbWFpbicsIGAKK3R5cGUgJDFfbG9nX3QsIGZpbGVfdHlwZSwg
c3lzYWRtZmlsZSwgbG9nZmlsZTsKK2FsbG93ICQxX3QgdmFyX2xvZ190OmRpciByYV9kaXJfcGVy
bXM7CithbGxvdyAkMV90ICQxX2xvZ190OmZpbGUgIHsgY3JlYXRlIHJhX2ZpbGVfcGVybXMgfTsK
K3R5cGVfdHJhbnNpdGlvbiAkMV90IHZhcl9sb2dfdDpmaWxlICQxX2xvZ190OworJykKKworZGVm
aW5lKGBhcHBlbmRfbG9nZGlyX2RvbWFpbicsIGAKK2FwcGVuZF9sb2dfZG9tYWluKCQxKQorYWxs
b3cgJDFfdCAkMV9sb2dfdDpkaXIgeyBzZXRhdHRyIHJhX2Rpcl9wZXJtcyB9OworJykKKworCiBk
ZWZpbmUoYGxvY2tfZG9tYWluJywgYAogdHlwZSAkMV9sb2NrX3QsIGZpbGVfdHlwZSwgc3lzYWRt
ZmlsZSwgbG9ja2ZpbGU7CiBmaWxlX3R5cGVfYXV0b190cmFucygkMV90LCB2YXJfbG9ja190LCAk
MV9sb2NrX3QsIGZpbGUpCg==

--Multipart=_Fri__19_Dec_2003_19_50_45_+0900_/91oO88T/OR/=1PJ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
