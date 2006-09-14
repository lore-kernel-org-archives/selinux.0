Message-ID: <450962DB.7050107@tresys.com>
Date: Thu, 14 Sep 2006 10:10:35 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: ewalsh@tycho.nsa.gov
CC: cpebenito@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] refpolicy: add X object classes to unconfined_t
References: <1158088282.7554.95.camel@moss-huskies.epoch.ncsc.mil>
In-Reply-To: <1158088282.7554.95.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Hello,
> I'm working on the XSELinux code, which has just been brought up to date
> with the current X.org code base.
> 
> The following patch adds the X Windows userspace object classes to
> unconfined_t.
> 

This patch doesn't add the types necessary to run the default XSELinux 
installation. Do you have a module that adds those types so that we can 
test the codebase out?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
