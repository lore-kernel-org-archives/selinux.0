Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA20700
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 02:57:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id GAA00544
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 06:56:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id GAA00539 for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 06:56:18 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Shaun Savage <savages@pcez.com>, SCC <SCC@securecomputing.com>,
        selinux@tycho.nsa.gov
Subject: Re: Message from Secure Computing
Date: Sat, 27 Jul 2002 08:57:47 +0200
References: <7124107ACDA2D3118B7300A0C99D99A107DB53CB@stpntmx01.share.rsvl.securecomputing.com> <3D41F204.3010205@pcez.com>
In-Reply-To: <3D41F204.3010205@pcez.com>
MIME-Version: 1.0
Message-Id: <20020727065748.72E5712AF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 27 Jul 2002 03:06, Shaun Savage wrote:
> In the paragraph
>
> "SELinux Limitation."  ......
> However, Secure Computing does not extend the Assurance to software that
> merely interoperates with SELinux, or is merely included with a
> distribution of SELinux.
>
> What does this mean?
> That there is only ONE version of SELinux distribution?

I interpret that to mean that you can't have another LSM module which uses 
the same patents stacked on top of SE Linux and claim patent exclusion for 
that module too.  That part seems reasonable to me.

> Also the paragraph   "Limited Assurance."
>
> Does this mean that the contract between the open source community and
> SCC, created by earlier written statements has been changed?

Yes, the section "Secure Computing disclaims all othjer promises, commitments 
or assurances of any kind, whether express or implied, including but not 
limited to any assurance that SELinux DOES NOT INFRINGE ANY PATENT OR OTHER 
INTELLECTUAL PROPERTY RIGHT OWNED OR ENFORCEABLE BY SECURE COMPUTING or any 
other party or person" does seem to say that they aren't even guaranteeing 
that it doesn't infringe their own patents.

It seems that this assurance is essentially free of any content.


Russell Coker

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
