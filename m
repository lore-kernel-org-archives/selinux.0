Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA26928
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 14:52:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA11206
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 18:52:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA11202
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 18:52:13 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: oops
Date: Mon, 17 Jun 2002 20:52:23 +0200
References: <Pine.GSO.4.33.0206171425590.12900-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206171425590.12900-100000@raven>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020617185223.CCE8B1621@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Jun 2002 20:27, you wrote:
> The trace looks garbled to me.  Is the derived patch publically available?

The cobalt patch is now online at http://www.coker.com.au/cobalt/ .  However 
this is probably not of any great benefit to you as a kernel with that patch 
will not boot on a machine other than a Cobalt machine.

Anyway it's only happened once so it could have just been bad luck, or 
something related to the 110V AC that went through the Ethernet port the 
other day.  :(

The Oops seemed to be related to repeatedly loading the policy, maybe putting 
a machine in an infinite loop of load_policy will turn something up...

Anyway the machine is available now.  Ssh to port 222 on adsl.coker.com.au, 
root password is "1".

SE Linux is locked down quite tightly (much more than the default permissions 
for user_t), so as root you can't do any damage (apart from the usual issues 
of fork bombs and OOM conditions).

Stephen, if you or Peter want a sysadm_r account on the machine then let me 
know.  But then if your work conditions prevent you from logging in entirely 
I'll understand.


PS  Please don't forward this to /. in a hurry, my Qube has 128M of RAM and 
will die when /. gets to it.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
