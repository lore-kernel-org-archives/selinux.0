Date: Tue, 3 Jun 2003 19:20:34 +0200
From: Tom <tom@lemuria.org>
To: SELinux@tycho.nsa.gov
Subject: Re: Default Policy question?
Message-ID: <20030603192034.C5693@lemuria.org>
References: <3EDB7585.8050308@redhat.com> <1054574512.1053.178.camel@moss-huskers.epoch.ncsc.mil> <20030602230314.C3637@lemuria.org> <1054642843.1053.276.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1054642843.1053.276.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Tue, Jun 03, 2003 at 08:20:44AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 03, 2003 at 08:20:44AM -0400, Stephen Smalley wrote:
> secadm_r has far more dependencies than that short list.  What happens
> if you let sysadm_r set other user's passwords?  What happens if
> sysadm_r has any form of raw access to the disk or memory?  What happens
> if sysadm_r can upgrade any of the authentication programs (e.g.
> /bin/login, /usr/bin/sshd) or any of their dependencies (pam modules,
> libc)?  What happens if sysadm_r can upgrade secadm_r's shell?  His
> editor?  You get the idea.

I get it. It seems my "core tools" idea won't work out.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
