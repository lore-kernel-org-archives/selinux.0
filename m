Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h56DwtI4003697
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 09:58:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h56DwKss023924
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 13:58:20 GMT
Received: from mail.vegaa.de (mail.vegaa.de [213.203.196.181])
	by jazzswing.ncsc.mil  with ESMTP id h56DwJhY023918
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 13:58:19 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: Wayne Salamon <wsalamon@nailabs.com>, <selinux@tycho.nsa.gov>
Subject: Re: A vulnerability in SELinux (fwd)
Date: Fri, 6 Jun 2003 15:58:21 +0200
References: <Pine.LNX.4.33.0306060756200.10200-100000@vox.rv.nailabs.com>
In-Reply-To: <Pine.LNX.4.33.0306060756200.10200-100000@vox.rv.nailabs.com>
MIME-Version: 1.0
Message-Id: <200306061558.21468.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Freitag, 6. Juni 2003 13:58 schrieb Wayne Salamon:
>   'Sorry about the previously terse note, the version below was
> meant to be sent to an internal list first.
>
>  I received the email from Rafal Wojtczuk and I thought others on
> this list would be interested. I haven't had time yet to verify
> his claim.
>
>   Comments?

I try it as user root (root:user_r:user_t) with 
lsm-2.4-selinux-2003011510.tgz and the patched SuSE 8.1 packages.
On my system schfn don't accept parameters, It exists with " wrapper 
does not accept arguments". 
# bash -c "ulimit -s 10000; LD_PRELOAD=/lib/libSegfault.so
SEGFAULT_USE_ALTSTACK=true SEGFAULT_OUTPUT_NAME=/etc/passwd
/usr/local/selinux/bin/schfn"
runs fine and set the correct values in /etc/passwd.
It runs fine with smaller stack size values values.
This time I can't reproduce it the in section II descripted attack.

Carsten



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
