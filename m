Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: system_r and apm_t
Date: Fri, 2 Aug 2002 13:37:27 +0200
References: <200208020910.JAA06405@jazzband.ncsc.mil> <20020802095109.3403F7FB9@lyta.coker.com.au> <20020802105144.A01F0FA93@ivanova.coker.com.au>
In-Reply-To: <20020802105144.A01F0FA93@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <20020802113727.99614181@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2 Aug 2002 12:49, Carsten Grohmann wrote:
> This time I write rules to adapt SuSE on the original SELinux rules. I
> don't want rewrite SuSE to become it more secure.

You will probably discover that it's impossible to do that without 
compromising security in some ways.

> In this case I need for a cronjob access to apm_t via domain_auto_trans.

Cronjob as sysadm_crond_t I guess?

So:
domain_auto_trans(sysadm_crond_t, apm_exec_t, apm_t)

Let me know how it goes, I'll add it to my policy if it works.

> Your policy and the nsa policy are different. Do you merge you policy to
> the nsa policy periodical?

Periodically Steven Smalley examines my tree and copies things that he 
considers worthy.  Also when I make a change that I think it particularly 
useful or interesting (or something that breaks some degree of compatability) 
then I post to the list, and Steve often makes a matching change to his tree.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
