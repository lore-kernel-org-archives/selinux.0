Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: file_t or root_t
Date: Fri, 2 Aug 2002 19:54:54 +0200
References: <20020802151300.497ACFA93@ivanova.coker.com.au>
In-Reply-To: <20020802151300.497ACFA93@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <20020802175454.BF5ED164@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2 Aug 2002 17:12, Carsten Grohmann wrote:
> If it not recommend to use file_t, why labelling we all unknown entries
> with it.

Because file_t is the default for unknown entries we don't want to use it for 
anything.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
