Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s68E34SZ007539
 for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2014 10:03:04 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so467947oag.21
 for <selinux@tycho.nsa.gov>; Tue, 08 Jul 2014 07:03:07 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 8 Jul 2014 17:03:07 +0300
Message-ID: <CAAR0pUPCWWbK+VAE2u+yL87TXuW2P+-L7u+1Rky+z26opqnSyg@mail.gmail.com>
Subject: genhomedircon support for groups
From: Cretu Adrian <adycrt@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11c20c561b7d9904fdaf0d46
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c20c561b7d9904fdaf0d46
Content-Type: text/plain; charset=UTF-8

Hello,

It seems that if for login mappings are used groups instead of users
genhomedircon does not updates file_contexts.homedirs. I was wondering if
this is a bug or a feature.

ex:

[root@test-rhel7b ~]# semanage login -l

Login Name           SELinux User         MLS/MCS Range        Service

__default__          unconfined_u         s0-s0:c0.c1023       *
root                 unconfined_u         s0-s0:c0.c1023       *
system_u             system_u             s0-s0:c0.c1023       *
[root@test-rhel7b ~]# semanage login -a -s staff_u test
[root@test-rhel7b ~]# matchpathcon /home/test/blah
/home/test/blah    staff_u:object_r:user_home_t:s0
[root@test-rhel7b ~]# semanage login -d -s staff_u test
[root@test-rhel7b ~]# semanage login -a -s staff_u %test
[root@test-rhel7b ~]# matchpathcon /home/test/blah
/home/test/blah    unconfined_u:object_r:user_home_t:s0
[root@test-rhel7b ~]#

--001a11c20c561b7d9904fdaf0d46
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkhlbGxvLDxicj48YnI+PC9kaXY+SXQgc2VlbXMgdGhh
dCBpZiBmb3IgbG9naW4gbWFwcGluZ3MgYXJlIHVzZWQgZ3JvdXBzIGluc3RlYWQgb2YgdXNlcnMg
Z2VuaG9tZWRpcmNvbiBkb2VzIG5vdCB1cGRhdGVzIGZpbGVfY29udGV4dHMuaG9tZWRpcnMuIEkg
d2FzIHdvbmRlcmluZyBpZiB0aGlzIGlzIGEgYnVnIG9yIGEgZmVhdHVyZS48YnI+PGJyPg0KPC9k
aXY+ZXg6PGJyPjxicj5bcm9vdEB0ZXN0LXJoZWw3YiB+XSMgc2VtYW5hZ2UgbG9naW4gLWw8YnI+
PGJyPkxvZ2luIE5hbWXCoMKgwqDCoMKgwqDCoMKgwqDCoCBTRUxpbnV4IFVzZXLCoMKgwqDCoMKg
wqDCoMKgIE1MUy9NQ1MgUmFuZ2XCoMKgwqDCoMKgwqDCoCBTZXJ2aWNlPGJyPjxicj5fX2RlZmF1
bHRfX8KgwqDCoMKgwqDCoMKgwqDCoCB1bmNvbmZpbmVkX3XCoMKgwqDCoMKgwqDCoMKgIHMwLXMw
OmMwLmMxMDIzwqDCoMKgwqDCoMKgICo8YnI+cm9vdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHVuY29uZmluZWRfdcKgwqDCoMKgwqDCoMKgwqAgczAtczA6YzAuYzEwMjPCoMKgwqDC
oMKgwqAgKjxicj4NCnN5c3RlbV91wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN5c3RlbV91wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMwLXMwOmMwLmMxMDIzwqDCoMKgwqDCoMKgICo8YnI+W3Jv
b3RAdGVzdC1yaGVsN2Igfl0jIHNlbWFuYWdlIGxvZ2luIC1hIC1zIHN0YWZmX3UgdGVzdDxicj5b
cm9vdEB0ZXN0LXJoZWw3YiB+XSMgbWF0Y2hwYXRoY29uIC9ob21lL3Rlc3QvYmxhaDxicj4vaG9t
ZS90ZXN0L2JsYWjCoMKgwqAgc3RhZmZfdTpvYmplY3Rfcjp1c2VyX2hvbWVfdDpzMDxicj4NClty
b290QHRlc3QtcmhlbDdiIH5dIyBzZW1hbmFnZSBsb2dpbiAtZCAtcyBzdGFmZl91IHRlc3Q8YnI+
W3Jvb3RAdGVzdC1yaGVsN2Igfl0jIHNlbWFuYWdlIGxvZ2luIC1hIC1zIHN0YWZmX3UgJXRlc3Q8
YnI+W3Jvb3RAdGVzdC1yaGVsN2Igfl0jIG1hdGNocGF0aGNvbiAvaG9tZS90ZXN0L2JsYWg8YnI+
L2hvbWUvdGVzdC9ibGFowqDCoMKgIHVuY29uZmluZWRfdTpvYmplY3Rfcjp1c2VyX2hvbWVfdDpz
MDxicj4NCltyb290QHRlc3QtcmhlbDdiIH5dIyA8YnI+PGJyPjxicj48L2Rpdj4NCg==
--001a11c20c561b7d9904fdaf0d46--
