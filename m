Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA09205
	for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 17:10:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA02254
	for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 22:08:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA02250
	for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 22:08:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: devfs@oss.sgi.com
Subject: devfsd module for SE Linux
Date: Thu, 7 Mar 2002 23:07:38 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QSIMC8981PGHU4V9YPTM"
Message-Id: <20020307220939.1F80622B30@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_QSIMC8981PGHU4V9YPTM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached the source to a devfsd module for SE Linux security settings 
with a sample config file (which mostly matches the settings in file_contexts 
for /dev).

Let me know what you think.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_QSIMC8981PGHU4V9YPTM
Content-Type: application/x-gzip;
  name="devfsd-flask.tgz"
Content-Transfer-Encoding: base64
Content-Description: devfsd-flask.tgz
Content-Disposition: attachment; filename="devfsd-flask.tgz"

H4sIADDhhzwCA+1YbXOjNhD2V/Mrtq5ztXOxgRjbU+fSdprmbjxzTTq59FPTYzAIWxdAjCTSuE3+
e1eAneDDl3wg7suwMwmwEs+zenYlJPf1xoubYVjGeDjEq2GOh6a6GsboMLtm1jDGlmWOR4ZlKf94
NBo1YNjYgSVCOhygwT+5X+yH3Xy/8b+zvu6RG194PZdFfkDki+TfxHRb1rb8W+PBYJ1/w8R+5uHQ
HDTAqPP/4nZx+m764fL0Aj5GSRA0m82Tt7+enVxOz89ATwTXAzpbVYgfOOK6LxgIIu30wRbUgzY2
R05IQCyFJKGdTNjsE3GlzScK0sZm6hJbag9UfxLOKqZSkGVUWNaCBaRashy0jK9zHZLwTv3FjMtu
pbSIyviyjDX5njuRx8Jqh5lhlvFJuaw4f9iCoI9JdI8Kt10xjU9viWcj8nXJsPTY4fI3o/ft76/b
O6RNGXXXq5iTY7XcOLPyMvUDFsdLfYeMIWZT59KteCYGzC3T9CONqHRlUC1bDlogCti8+qmAoAWS
mNNIEi4qTlgOuyFcnEi9E7JEkLsQZb0jNySqeiVT6FurJBZOctvcDeE8DisvkwyzmEAZ3lZcJgqy
wCFYEnkVV0iKWaabM4/nuFpWy4agZVwep1VPMU63Vp8Th/aMMlHx0HLUjaoQ7eoXD0RFFk175v7/
Z+ea+DQgL3j++/L+3zDxsJft/4fjQwvvTXMwGNX7/13Y++mPcAwb5aZpG45JsYerNeeuC73zQ+j5
v0xPoCcWDice9Bi0f4D2G+gFgrgJJ5rmBsSJJlqTh9gX2h0k7GqN2v5t5/88s//A/McpP87n/6E1
GA/U+d8yrXr+78K+ppEbJB6BN/gtwW1nf/GdVvDpchkT8bkb9ZBFbxJRIb2NntKj7POX8aDlhBtu
EtAoudWFKPdnX79E0mBLu7CzJUc1a/o+XC4I+CwI2B80msOCOB7hQAX6OAjJE1fmi5odMUn9pZ07
9/VH6Bl22s/208i0lIXiWZV6tgR1JKBOkH6Wj6FnHmka7qmL3+uOi6sj7Ksv9gFk9+i11XNX+0sD
KEJi25FyZuEonWGW+MqlfneQOUL+sOLHJ0luJcbQKt0UYPyyhcEBUL9DRR4cidRxzet0u9igIkmb
FWUuZicL+hUGgP8xsrTnqi9AVjSd9+fv7NOLiwNonTjRN3nQe2ICe2HrANKBHuVvcCITHoGRPd+v
OAs6KiGLPCqqlUj5UG3JUnFLGrobquQgcKBEDUjU2WjvwmswHzq9ehRMPt6HSErGPHM8lbQJXLX2
xFWrfxXhoDcpjtbvFxVYabBWQinw1fHjwtoq+fTs7TnynzEs1T0BTsCxypewcPB+XVSwKo0eREwV
TzQnz0zKNslX1bvWc13OSsjnFUqpaGucJwJzFyqMPISnuQjnOOnToau14MP0p3QVyAo0JX6C9F5N
nAf3fb2Bqa222mqrrbbaaqutttpqq+2/ZX8DPL6S/wAoAAA=

--------------Boundary-00=_QSIMC8981PGHU4V9YPTM--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
