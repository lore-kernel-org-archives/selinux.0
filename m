Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2IECikf024963
	for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2013 10:12:44 -0400
Message-ID: <514720CC.6030801@tresys.com>
Date: Mon, 18 Mar 2013 10:12:28 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Kernel freak <kernelfreak@gmail.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: Compiling Selinux from Source
References: <CAOFt0CRpFTOD8S2iktjUdLDPVOhG9Cvq9j51sqxDsQLVno=irQ@mail.gmail.com>
In-Reply-To: <CAOFt0CRpFTOD8S2iktjUdLDPVOhG9Cvq9j51sqxDsQLVno=irQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/16/13 08:06, Kernel freak wrote:
> Hello,
>          I want to make some modifications to SElinux itself for some of my work. I am currently using Fedora v18 with KDE. I downloaded the Linux kernel, and also the reference policy source. Both seem to give me an error. The errors are
> While compiling the policy '@localhost serefpolicy-3.11.1]$ sudo make conf
> make: *** No rule to make target `policy/modules/contrib/metadata.xml', needed by `tmp/admin.xml'.  Stop.'
[...]
> I fail to understand what am i missing here. I checked the contrib directory, it turns out to be empty.

You also need to check out the contrib submodule:

$ git submodule init
$ git submodule update

See http://oss.tresys.com/projects/refpolicy/wiki/RepositoryCheckout for more details.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
