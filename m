Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9HHGMrT017164
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 13:16:23 -0400 (EDT)
Received: from mproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9HHF9xh004816
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 17:15:09 GMT
Received: by mproxy.gmail.com with SMTP id 73so117071rnk
        for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 10:16:23 -0700 (PDT)
Message-ID: <91981b3e04101710165e4ec67@mail.gmail.com>
Date: Sun, 17 Oct 2004 11:16:22 -0600
From: Chris Kuethe <chris.kuethe@gmail.com>
Reply-To: Chris Kuethe <chris.kuethe@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: writing rules to disallow a domain to read particular files
In-Reply-To: <20041017150125.GG19398@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1097940101.2569.5.camel@jsingh.india.ensim.com>
	 <1097948413.3872.3.camel@x-infinity.verbum.private>
	 <1098017660.2740.33.camel@jsingh.india.ensim.com>
	 <20041017141433.GF19398@lkcl.net>
	 <1098023488.3182.8.camel@jsingh.india.ensim.com>
	 <20041017150125.GG19398@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I could be way out to lunch here, but....

Jaspreet appears to work for Ensim - a maker of web hosting appliance
software. I think what he's after is trying to use the MAC features of
SELinux to provide stronger isolation between users of a hosting
appliance than the current chroot() and application leve controls will
provide. I have access to couple of ensim boxen - not a bad little
widget. It's quite exciting to hear that the suggestion that they're
trying to use SELinux for their next generation product...

CK

-- 
GDB has a 'break' feature; why doesn't it have 'fix' too?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
