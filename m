Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA01758
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 20:14:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA20731
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 00:13:13 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA20727 for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 00:13:12 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Ryan Bergauer" <privateryan@mindspring.com>, <selinux@tycho.nsa.gov>
Subject: Re: Configuration issues on a new installation
Date: Thu, 27 Jun 2002 20:14:48 -0400
References: <001201c21e29$28ce5b20$6501a8c0@donkey>
In-Reply-To: <001201c21e29$28ce5b20$6501a8c0@donkey>
MIME-Version: 1.0
Message-Id: <20020628001449.268C12CE3@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 18:22, Ryan Bergauer wrote:
> On 6/27/02, Russell Coker wrote:
> > Using a single file does not require using a single domain.  You can
>
> have
>
> > separate domains for nmbd and smbd in the same file.
>
> Good point. Although they require very close to the same privileges, so
> I don't believe it matters too much in this case.

nmbd needs UDP, smbd needs TCP.  smbd needs read/write access to all user 
files, nmbd doesn't.

If nmbd has a bug (it's had one before) then you're better off with different 
domains.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
