Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA12648
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 14:35:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA27348
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 18:35:28 GMT
Received: from lyta.coker.com.au (n136.ols.wavesec.net [209.151.19.136])
	by jazzswing.ncsc.mil  with ESMTP id SAA27338
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 18:35:27 GMT
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 366393CE
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 14:35:59 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Latest patches
Date: Tue, 25 Jun 2002 14:35:58 -0400
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_YBY92XY87JLEMROTHDA5"
Message-Id: <20020625183559.366393CE@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_YBY92XY87JLEMROTHDA5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Somewhere in recent times my Debian packages of SE Linux stopped becoming 
buildable.  I think it may have been at the last official SE Linux release, 
but it may have been one of the patches since then.

The problem is the function security_mls(), which is called from the library 
code in selinux-small but which is not provided.

I have attached a file to go into selinux-small/libsecure/src to address this.

NB I've never tested this under MLS as I don't use MLS.  It makes it compile 
and work for non-MLS...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_YBY92XY87JLEMROTHDA5
Content-Type: text/x-c;
  charset="us-ascii";
  name="security_mls.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="security_mls.c"

I2luY2x1ZGUgPHNzLmg+CgppbnQgc2VjdXJpdHlfbWxzKHZvaWQpCnsKCXJldHVybiBsc20oU0VM
SU5VWF9NQUdJQywgU0VMSU5VWENBTExfTUxTLCAwKTsKfQo=

--------------Boundary-00=_YBY92XY87JLEMROTHDA5--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
