From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Getting started with SELinux and Slackware
Date: Wed, 12 Mar 2008 11:58:14 +1100
Cc: "Martin J. Green" <mail@martinjgreen.me.uk>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <77FD49B9B8D2394FB1B63A63934913126A55770EA8@exchange.home.martinjgreen.me.uk> <54EE10FFA0116B408D3A5172CB52729F012DC48610D7@exchange.home.martinjgreen.me.uk> <1205249581.23866.151.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1205249581.23866.151.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803121158.16830.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 12 March 2008 02:33, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> As far as login goes, Fedora doesn't patch it since they use
> pam_selinux.  If you can't use pam_selinux, then just look to see if
> login.c calls setexeccon() anywhere - it would need to do that to set up
> the user security context for the shell.

I recommend converting a Slackware system to use PAM.

If the same login is used in Slackware as in Debian (there are several login 
programs to choose from) then the code is quite hairy and it's easy to make a 
mistake.

Back in 2002 I released a login package for Debian which allowed a user to 
login with the wrong SE Linux context due to a mistake when patching login 
(the Debian login is not the same as the Red Hat login which the patch was 
originall written for).

Even sshd (which has a high code quality) is not something that's easy to 
modify.

Taking the PAM source from Debian or Fedora and building it on Slackware 
should not be that difficult and will probably give a better result than 
doing some entirely new development.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
