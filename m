Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA29397
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 05:47:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA11253
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 09:46:46 GMT
Received: from smtp3.libero.it (smtp3.libero.it [193.70.192.127])
	by jazzswing.ncsc.mil  with ESMTP id JAA11249
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 09:46:45 GMT
Received: from localhost.localdomain (151.27.175.212) by smtp3.libero.it (6.5.015)
        id 3D009AC800EEE506 for selinux@tycho.nsa.gov; Sat, 13 Jul 2002 11:47:21 +0200
Content-Type: text/plain;
  charset="us-ascii"
From: Belch <belch76@libero.it>
To: selinux@tycho.nsa.gov
Subject: Compiling a simple policy
Date: Sat, 13 Jul 2002 11:42:51 +0200
MIME-Version: 1.0
Message-Id: <200207131142.51302.belch76@libero.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
i've just patched my kernel with SELinux....
when i compile the "example" policy the following error occours


[root@localhost policy]# make policy
......
/usr/local/selinux/bin/checkpolicy -o tmp/policy.11-mls policy.conf
/usr/local/selinux/bin/checkpolicy:  loading policy configuration from policy.conf
ERROR 'no range for user' at token ';' on line 126447:
#
user system_u roles system_r ;
/usr/local/selinux/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.11-mls] Error 1
[root@localhost policy]#

Line 126447:
user system_u roles system_r ;



What's wrong?

thanx in advantages

-- 
-*-*-*-*-*-*-*-*-*-*-*-*-

     Daniele Bellucci

_*_*_*_*_*_*_*_*_*_*_*_*_

belch76@libero.it
daniele@impact.dyn.unipg.it
ICQ# 104896040

_*_*_*_*_*_*_*_*_*_*_*_*_




-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

mQGiBDzP9kERBAC9Ff4JqfRY7BcGJpmg/N1gpyaqbhW8sfKauT8NYsHtJKUqiiQ3
Sdl0E6ZbGPisByig6j0ve+X0QJc8mB9Qlt/zN05Si6xS6W59EV4EebcRCVlKGRgU
lgvFuSydOEDJQKgKttFPO7NiGbIyf4iENasX1DsqqjBeBJOw+PfsfxGgfwCglX/G
FYYGW7ABeD+H2qwflRYMnFUEAJ9OAFSp6UgYtT6MrlqRapUyXvZ2gf4Gz2I8Q5m7
RxJAIAubNFoK1g11dhU9GIFrXRFIDtD+qAVD6mPuUbtRSXCJbaqhSs1VuS2zA8In
fbW1cDOsXzq/v35zzQmdzatalnx8WxuPgX276fqNxydovsuszwh4E3zOJrGKPuH8
AYImA/9sIAhKNcRedQNJO1ggQmKedLlRm95kxbJ1eWjG+jCWtdw9zVrjK2lGQb6B
9Wk4KxYSaArkpYHSivS06LDrmKlmfKCCEBK2uNS+w4ybNs66Sf58uZ8dOPSgsVfs
TO7vY/8rlsWncPlOwmov3z9yRcyh8QoE1WG4Yz3VdcSBAfRHD7QsRGFuaWVsZSBC
ZWxsdWNjaSAoYmVsY2gpIDxiZWxjaDc2QGxpYmVyby5pdD6IVwQTEQIAFwUCPM/2
QQULBwoDBAMVAwIDFgIBAheAAAoJEFt6nDoa8Ff5QRwAnixzm6LwFZpJwviPGrv1
OU/Ckv0hAJ4wtBYLaQmB0h6Ff0vGjkbnBYbk/bkBDQQ8z/ZCEAQAxAMlqFknkrRG
zuZucuQXrLRM/xWT138pdm8C+Y0uDQWSxFLVBCvdF4YAWJbaV7b4rhCi+mbSqodR
YHzPLPdh+ieEhqabkJ4pekV09m/QrfeCpCvnCrrZJ+R4KnMWKIeDHvHkdtOQY6I6
RTFkpAG7TMYie5H/Eh+3k1Kjmq5rHH8AAwUEAJvWEJykO/okvNnqgbmM1kL9MRou
KN8K219TVt9eDiz2h8j1YjM4YDoFCuO8aiAE2YWe8y1BAaXLBL9HbiwplCEloZqv
a+Py+UyO3wwYqnBO3jaKzMlPyYycp4qSM9/lvf0fX/sdFve2S5TkBHKDNme7+rQu
ggkJ2Yl7UkkH0UuoiEYEGBECAAYFAjzP9kIACgkQW3qcOhrwV/mnPgCaA07VtZFf
jYUyGqmoj0aYDxmapyAAn2efk8L+AvOxrHfvDEsqAyFKHBXx
=e8/U
-----END PGP PUBLIC KEY BLOCK-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
