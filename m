Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Special directories and links
Date: Mon, 5 Aug 2002 18:16:42 +0200
References: <200208051530.PAA26262@jazzswing.ncsc.mil>
In-Reply-To: <200208051530.PAA26262@jazzswing.ncsc.mil>
MIME-Version: 1.0
Message-Id: <20020805161643.23E4D3940@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 5 Aug 2002 17:30, Carsten Grohmann wrote:
> on / I have 3 links and 2 directories without a correct security context.
> The first direcory /mnt is for temporary mounted filesystems ( see FHS
> too). It could be labelling also as root_t I guess. I don't see any
> disadvantage if all people can read this directory.
> And now a SuSE and newer Red Hat specific question:
> On the root are follow links (/floppy, /cdrom and /cdrecorder) to
> /media/(floppy|cdrom|cdrecorder). /media is the second directory.
> In my oppinion, root_t is also a usable type to label this entries.
>
> What are you think?

Sounds reasonable to me.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
