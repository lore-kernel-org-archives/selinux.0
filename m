Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Timothy Wood <timothy@hallcomp.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: new LSM ver
Date: Sun, 7 Jul 2002 09:32:15 -0400
References: <1025911273.8785.1.camel@phobos>
In-Reply-To: <1025911273.8785.1.camel@phobos>
MIME-Version: 1.0
Message-Id: <20020707133215.5D7BF304B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 5 Jul 2002 19:21, Timothy Wood wrote:
> Anyone notice that the default context for root in the new lsm package
> is a user_r and not sysadm_r?  Any specific reason for this change or is
> it a mistake?

I wouldn't expect Steve to make a mistake about such things.

I'm willing to bet that it's related to the recent sshd bugs...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
