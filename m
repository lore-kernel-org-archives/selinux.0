Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA25140
	for <selinux@tycho.nsa.gov>; Tue, 24 Dec 2002 19:47:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA08736
	for <selinux@tycho.nsa.gov>; Wed, 25 Dec 2002 00:45:13 GMT
Received: from prserv.net (asmtp2.prserv.net [32.97.166.52])
	by jazzswing.ncsc.mil  with ESMTP id AAA08732
	for <selinux@tycho.nsa.gov>; Wed, 25 Dec 2002 00:45:12 GMT
Message-Id: <200212250045.AAA08732@jazzswing.ncsc.mil>
Date: Tue, 24 Dec 2002 19:47:24 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: Russell Coker <russell@coker.com.au>, selinux <selinux@tycho.nsa.gov>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: avc: denied
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I downloaded your policy.tgz and compared the "mrtg.fc" file with the your file.
They are the same.

In the listed example, you are seeing only mrtg, but there are lot more than the MRTG errors (or messages).

Please remember that most of this "avc: denied" message comes on at bootup time and during login sessions
as well.  When in VI the messages keep poping up.

Subba Rao
sailorn@attglobal.net
2002-12-24

======= At 2002-12-22, 16:52:00 you wrote: =======

>On Sun, 22 Dec 2002 15:58, Subba Rao wrote:
>> ===================
>> avc:  denied  { search } for  pid=848 exe=/usr/bin/perl path=/var/www/mrtg
>> dev=03:01 ino=272926 scontext=system_u:system_r:crond_t
>> tcontext=system_u:object_r:httpd_sys_content_t tclass=dir
>
>Did you install my mrtg policy?
>

= = = = = = = = = = = = = = = = = = = =
			





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
