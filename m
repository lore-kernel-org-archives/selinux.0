Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA14099
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 10:04:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA29667
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 14:04:08 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA29663
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 14:04:07 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <blacknet@simplyaquatics.com>
Subject: Re: Your debain install
Date: Tue, 4 Jun 2002 16:04:07 +0200
References: <000801c20bcd$aeb56580$0a01a8c0@ed>
In-Reply-To: <000801c20bcd$aeb56580$0a01a8c0@ed>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020604140408.1A15673EF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Jun 2002 15:42, you wrote:
> I mostly run custom kernels under debian.  Been playing with the d/l
> kernel from the nsa's site.  Everything seems to be going find but not
> sure if setfiles "conflicing specifications for /dev/scX and /dev/srX,
> using system_u:object_r:removable_device_t." is normal or not.  Seems
> like there was something on the mailing list recently about this.

I think that's a bug in the policy from the NSA.  scX and srX are documented 
as hard links in the devices.txt for 2.4.18.  So they should both have the 
same settings in types.fc.

I'm now using the regex "/dev/s(cd|r)[^/]*" in my tree.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
