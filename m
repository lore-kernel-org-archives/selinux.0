Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: jw@centraltexasit.com, "SELinux" <SELinux@tycho.nsa.gov>
Subject: Re: Make errors from newrole in utils
Date: Mon, 8 Jul 2002 16:04:13 -0400
References: <200207080116.57947.jw@centraltexasit.com>
In-Reply-To: <200207080116.57947.jw@centraltexasit.com>
MIME-Version: 1.0
Message-Id: <20020709162533.822977672@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 8 Jul 2002 02:16, JW wrote:
> When I run make in utils I get errors in newrole.c about
> security/pam_appl.h security/pam_misc.h missing:

To build on a Debian machine you need the libpam0g-dev package installed 
(it's in the build-depends for my SE Linux package).  For other distributions 
you need the equivalent package.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
