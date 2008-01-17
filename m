Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0HFZNLp014665
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 10:35:23 -0500
Received: from g1t0029.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0HFZMg6009329
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 15:35:22 GMT
Message-ID: <478F72FC.4020803@hp.com>
Date: Thu, 17 Jan 2008 10:23:40 -0500
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: newrole -l error
References: <dd18b0c30801161448kd990a86h35b1c664439f4488@mail.gmail.com>
In-Reply-To: <dd18b0c30801161448kd990a86h35b1c664439f4488@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Justin Mattock wrote:
> Hello does anybody have a fix for newrole -l s? Error: you are not allowed
> to change levels on a non secure terminal;
> I'm using refpolicy-20071214 from tresys, my build.config has  mls
> monolithic enabled.

I wonder if the problem is with your libselinux version.  The patch 
which included support for that file was included in version 1.33.4 so 
you'll need that or later in order to use the 
/etc/selinux/mls/contexts/securetty_types file.

-matt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
