Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA02538
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 16:51:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA07863
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 20:50:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA07859
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 20:50:49 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Ryan Bergauer" <privateryan@mindspring.com>, <selinux@tycho.nsa.gov>
Subject: Re: quota and ampd
Date: Tue, 9 Jul 2002 16:51:11 -0400
References: <000401c226ca$7a507e20$6501a8c0@donkey>
In-Reply-To: <000401c226ca$7a507e20$6501a8c0@donkey>
MIME-Version: 1.0
Message-Id: <20020709205111.97A622330@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 8 Jul 2002 17:57, Ryan Bergauer wrote:
> I just installed the new release of SELinux, and I get about 7 messages
> at boot-time requesting different permissions for quotaon, per the
> following:

I should have some new additions for the quota.te file soon which may address 
these issues.

> In addition, I'm getting quite a few denied messages at boot and
> shutdown regarding killall5 when I enable Advanced Power Management Bios
> in the kernel (with apmd_t wanting read-type permissions for items in
> init_t and kernel_t.) This sound familiar to anyone else? Please note
> that this was occurring before the new release, I just never got around
> to confronting it until now.

I'll check that out, I don't often check shutdown errors...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
