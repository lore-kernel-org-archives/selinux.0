Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA21170
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 05:42:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA04308
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 09:41:50 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id JAA04304
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 09:41:48 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Natr Brazell <brazell@bmh.com>, selinux@tycho.nsa.gov
Subject: Re: Installation question
Date: Tue, 23 Jul 2002 11:42:24 +0200
References: <63114.137.246.8.231.1027290964.squirrel@austin.bmh.com>
In-Reply-To: <63114.137.246.8.231.1027290964.squirrel@austin.bmh.com>
MIME-Version: 1.0
Message-Id: <20020723094224.E64137CC4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 22 Jul 2002 00:36, Natr Brazell wrote:
> Please see the below /var/log/messages entries and tell me what I have to
> do to correct them.  2.4.18 LSM kernel in passive mode.
>
> Jul 21 15:53:42 Foundry1CFI kernel: avc:  denied  { write } for  pid=2440
> exe=/usr/stow/JSAF5/src/JSAF/jsaf path=/usr/stow/JSAF5 dev=08:03
> ino=278875 scontext=system_u:system_r:xdm_t
> tcontext=safuser:object_r:usr_t tclass=dir

You have two choices.  One is to not use stow and instead use a distribution 
that puts all the files in the proper places.  Another is to re-write the 
file contexts files to refer to where stow puts things (that is a lot of work 
with multiple directories containing bin or sbin files).

It'll be a lot easier to use a distribution.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
