Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA01251
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 18:13:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA05811
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 22:13:27 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA05807
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 22:13:26 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Ryan Bergauer" <privateryan@mindspring.com>,
        "'Stephen Smalley'" <sds@tislabs.com>, <selinux@tycho.nsa.gov>
Subject: Re: Configuration issues on a new installation
Date: Thu, 27 Jun 2002 18:13:58 -0400
References: <000e01c21e1f$b04952d0$6501a8c0@donkey>
In-Reply-To: <000e01c21e1f$b04952d0$6501a8c0@donkey>
MIME-Version: 1.0
Message-Id: <20020627221358.E813A7D5A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 17:14, Ryan Bergauer wrote:
> Very good question. That confused me last night but I included it
> anyway. I've since switched to a single samba.te file (per Russell's
> suggestion), left out the initrc_t recvfrom permission, and haven't had
> it pop up again. Strange.

Using a single file does not require using a single domain.  You can have 
separate domains for nmbd and smbd in the same file.

Also better allow it to create it's log files...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
