Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Timothy Wood <timothy@hallcomp.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: named pt2
Date: Thu, 4 Jul 2002 23:40:32 -0400
References: <1025732909.3620.136.camel@phobos>
In-Reply-To: <1025732909.3620.136.camel@phobos>
MIME-Version: 1.0
Message-Id: <20020706200822.5594276E1@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Jul 2002 17:48, Timothy Wood wrote:
> Can someone explain to my why bind works if I let init start it but it
> does not start if I start it as root from the cli?

You are supposed to use run_init to run the init script.  run_init causes the 
script to be run as system_u:system_r:initrc_t, and then a 
domain_auto_trans() rule transitions it to system_u:system_r:named_t which is 
the correct context of the daemon.

Running it in another context denies it access to port 53 (port 53 is only 
for named_t).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
