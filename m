Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: rw_dir_file and similar macros
Date: Fri, 2 Aug 2002 17:16:40 +0200
References: <200208021450.OAA20775@jazzband.ncsc.mil>
In-Reply-To: <200208021450.OAA20775@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <20020802151641.3F6B918CC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2 Aug 2002 16:39, Carsten Grohmann wrote:
> This macros works fine. But I think it is not necessary to give lnk_file
> rw_file_perms, a simple read should work too. Or?

Right, { read getattr link access } will probably do.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
