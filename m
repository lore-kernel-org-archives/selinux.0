Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7U7LqkD015200
	for <selinux@tycho.nsa.gov>; Sun, 30 Aug 2009 03:21:52 -0400
Received: from mail-gx0-f205.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7U7N6xS021181
	for <selinux@tycho.nsa.gov>; Sun, 30 Aug 2009 07:23:06 GMT
Received: by gxk1 with SMTP id 1so4061752gxk.17
        for <selinux@tycho.nsa.gov>; Sun, 30 Aug 2009 00:21:06 -0700 (PDT)
Message-ID: <4A9A2867.30403@gmail.com>
Date: Sun, 30 Aug 2009 00:21:11 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: zheyeung <zheyeung@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>, refpolicy <refpolicy@oss1.tresys.com>
Subject: Re: I've got a problem in my installing selinux
References: <200908301456154069423@gmail.com>
In-Reply-To: <200908301456154069423@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

zheyeung wrote:
> Hi,everybody, I'm a beginner . I've got a problem in selinux installing.
> At first, I install from selinux-policy-targeted.f11.rpm (which in 
> release CD), then edit /etc/ selinux/config. change the mode 
> to (enforcing,targeted),restart. everything is ok.
> Then ,I download refpolicy.tar.gz from tresys.com. make and make 
> install it  by Eclipse-Slide. Here the problem comes. No matter I 
> running selinux in enforcing or in permissive, my F11 failed in 
> rebooting .It stop at Init process, which can not enter the graphic 
> terminal.
> I guess , is there extra work I should do but I didn't ?
> 2009-08-30
> ------------------------------------------------------------------------
> zheyeung
have you added your boot params?

selinux=1 enforcing=0

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
