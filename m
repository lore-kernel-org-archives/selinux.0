Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: gdsmarshall@hushmail.com, Selinux@tycho.nsa.gov
Subject: Re: errors installing.....
Date: Thu, 27 Jun 2002 15:40:56 -0400
References: <200206271655.g5RGtjM07176@mailserver4.hushmail.com>
In-Reply-To: <200206271655.g5RGtjM07176@mailserver4.hushmail.com>
MIME-Version: 1.0
Message-Id: <20020627194529.060527D01@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 12:55, gdsmarshall@hushmail.com wrote:
> /etc/selinux# make -C /etc/selinux relabel
> make: Entering directory `/etc/selinux'
> /usr/bin/load_policy /ss_policy
> security_load_policy: Invalid argument
> make: *** [tmp/load] Error 2
> make: Leaving directory `/etc/selinux'
>
> In /var/log/messages, I get
> Jun 27 17:51:52 gatekeeper kernel: ss:  loading policy configuration from
> /ss_policy Jun 27 17:51:52 gatekeeper kernel: security:  policydb magic
> number 8 does not match expected magic number -109248628
>
> does anyone know what the problem is please? and how do I fix it.

Looks like your kernel doesn't have the same policy version as the database.

What version of my packages are you using?  Are you using "woody" not 
"unstable"?  Maybe you should get the core selinux packages from my site too.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
