Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA23972
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 07:00:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA04285
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 10:58:26 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id KAA04281
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 10:58:24 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B734792457
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 21:00:01 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 40C662413
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 12:59:54 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: devfsd module
Date: Tue, 16 Apr 2002 12:59:53 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_TJQN6LBWIQWEJID986GL"
Message-Id: <20020416105954.40C662413@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_TJQN6LBWIQWEJID986GL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached the source to my latest devfsd code.  I don't anticipate any 
significant changes in future, could it be included in the next selinux-small 
archive release?

Also I added a new type for the frame buffer device, the following in 
types/device.te
# Type for frame buffer /dev/fb/*
type framebuf_device_t, file_type;

and the following for file_contexts:
/dev/fb[0-9]*                      system_u:object_r:framebuf_device_t


-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_TJQN6LBWIQWEJID986GL
Content-Type: application/x-gzip;
  name="devfsd-selinux.tgz"
Content-Transfer-Encoding: base64
Content-Description: devfsd-selinux.tgz
Content-Disposition: attachment; filename="devfsd-selinux.tgz"

H4sIAFUDvDwCA+1XbW/bNhD2V+tXsJ7T2Wlsy45sY07SdnWTwECWDEmGfWhaQZYom41ECiSVxVvy
33eU5Be5cjJMc1AMOsCWeCSfe3mOFOngO1c4rdI2RdcNvd/twlNv97tt9dT1Xid+xlLS+0a31+t2
jXa/pLfbMLCEuqUXkFBIiyNU4l/tJ8fBMNct/e/EifmPHw2bUdfD8r/mvw10G8Ym/vf7inPFP3Qa
HdC393vGfgnpBf9bl8vj09HV9fEl+lK79bH/oH4B47JeHp78dj68Hl2co6Q4BG4KhgSWpiAOqoKW
Wj5GYiYk9s1wwMZfsS1NPgAMxmcmDCA2NqW2tBG+4xZ1mJ8DPAbIApdyVs4BDD2AsIrYcoiwq3kw
XXKPHRNgbjMcbgUWl5/0xk+f31S3ZSOCb9lOHgMc6Lyzxh7OSrrrsSCYtbYF7wMDLS7tHPi2x+ys
1HwhlEhbejmgE4QUqscmOasQEFKIASdUYi7yJDnBWIs/CGWr5rNQ4AcfsvOA7zDNt/IV1kYeA2GF
99tAnwR+PiJjgHTWpX+fh0g1PwUoWEidPBxGAFnhW5NgAltJDmhAyAJ2OMlVy5xsrAUr8M0xYSKP
0wnEGm2imnP9AUQaMghyQcL8zJ1z3Gru5tr4OejHobsE17R/e/77xbrFLvHwds7/T5//9I7eUec/
w+j3e3qnB+M7RnH+exk5G31AR6nS07TV1mClz9bKE9tGjYsOari/joaoWhuenP18elWHt7OPyWtD
TC2OHdRgqPoeVQ9RwxPYDjnWNNvDFh1oZe4DgJoz+lDXSoV8N/c/RfKLr//9drsX3f/60G/0o/uf
3jGK9f8S8gOhthc6GB3CBwZOns3pWy2la8lZgMW3asiHTGtDSoR01kZKh7BvJ8PNx/LX1Gs2XM+C
G00oibemF2a8nSi11tpFv3MiJaZoPEOXoRDY89CQ3WKODnncfG+rZtNmftMK36LdVjTteoqRyzyP
/UHoBE2x5cAUIkDHkZA8tGWy85mUSeLOzEQJ05fOeISG9/HiMd0oAC1yjsBFkjimROqGQCwv+pQf
oUb7QNPgID7/utds2CrRrvq+76H4HbSmate1vzSE0mDQd6CUsSOKAASff6WyGRUyQUgac8vQkvhe
gvVK5mkHPJeVDRiUPT09pJ41xh5cPxUEYBC3RiATEXWYqkudU6vXoUMFE3UrrxMCa3HcryEG+Ifg
opHzsQjFBVk7uzg1jy8v91BlaNEfk7h3xADt+JU9FOXqIJnBsQw5RXrcfpzbTJGgWEjbUV7N85yE
a0oW8ZPRUV9LbAKC9hQvHqa1tf46eoPay0GvV5xJ4l16khHz2HIU7wN0U9kRN5XmDYWg100cLOan
MzDPwSITKgOvjlarMp2KiH0BhHzqdHuf5yAhFWRC4ZMelS70QphQEIL8iRlggmLhAdh4tciZqmW5
KCFlfA9lZVQkFRAjr2SlHBUMt/2gFo9ZFiSMKsOAVMZG5ycXkLJzBktzRyDL47CqZ2hqwftiKaF5
RTcATQVMJ3hZR+XVFJYfN2RxQ7XM1+6iFBaLWdXAP6vxTL4XOM8Uuj1VbiQuPG8Lcw6bXZQCtQde
jT5Gu1+8tiLDzxh9VGt+qX4sznKFFFJIIYUUUkghhRRSSCGFFPJdyt8glJF0ACgAAA==

--------------Boundary-00=_TJQN6LBWIQWEJID986GL--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
