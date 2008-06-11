Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BM6WFo006666
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 18:06:32 -0400
Message-ID: <48504C67.2050308@tycho.nsa.gov>
Date: Wed, 11 Jun 2008 18:06:31 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: Chad Hanson <chanson@TrustedCS.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: X in MLS enforcing problem
References: <cadfc0e40806091430j7d4734c6l7af3cfbce395eeae@mail.gmail.com>	 <D709A20F2164C84E8B7014B0301F5EF8012E7F32@HAVOC.tcs-sec.com>	 <cadfc0e40806091535k1929bbc8gd4eebefb4b6069ff@mail.gmail.com>	 <484DC4D2.7050201@tycho.nsa.gov> <484FD7A5.5070806@gmail.com> <cadfc0e40806111442j5c7ec784k7c65c4df67214571@mail.gmail.com> <48504AD4.2020109@tycho.nsa.gov>
In-Reply-To: <48504AD4.2020109@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:

[snip]
>     security_class_mapping map[] = { { "x_drawable", { NULL } }, { NULL } };
>   

I meant "x_selection" above.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
