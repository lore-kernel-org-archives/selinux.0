Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA12325
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 14:07:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA09993
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 18:05:36 GMT
Received: from lyta.coker.com.au (n136.ols.wavesec.net [209.151.19.136])
        by jazzband.ncsc.mil  with ESMTP id SAA09989 for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 18:05:33 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Ed Street <blacknet@simplyaquatics.com>
Subject: Re: Default policy under debian
Date: Tue, 25 Jun 2002 13:25:09 -0400
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206240717270.10386-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206240717270.10386-100000@raven>
MIME-Version: 1.0
Message-Id: <20020625172509.7012E293C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Jun 2002 07:50, Stephen Smalley wrote:
> On Fri, 21 Jun 2002, Ed Street wrote:
> > Just to let everyone know, using woody bf2.4 minimal install with
> > selinux we found remote root could execute /sbin/poweroff
>
> Can you clarify what you mean by this statement?  "Remote root" is
> ambiguous, as there is a difference between having the Linux root uid and
> having the SELinux root user identity, and you also need to specify the
> role and domain.  Notice that processes with the Linux root uid do

Here is the results of poweroff on Debian when uid=0 domain=user_t:

root@lyta:/# /sbin/poweroff
shutdown: warning: cannot open /var/run/shutdown.pid
init: /dev/initctl: Permission denied
root@lyta:/# id
uid=0(root) gid=0(root) groups=0(root) context=rjc:user_r:user_t sid=440
root@lyta:/#

If you ssh into a Debian machine as root in a typical setup it will log you 
in as root:sysadm_r:sysadm_t by default.  But that can easily be changed.  If 
you deny the "root" identity access to the sysadm_r role then they can't shut 
the machine down (as I recently proved).

> You can certainly remove the corresponding domain_trans rule from sshd.te
> if you do not wish to permit remote administrator shells, although you
> would also need to do something about newrole if you want to completely
> prevent the use of newrole by remote sessions (e.g. setting up a separate
> user domain for remote shells that cannot transition to newrole_t).

With all the bugs in ssh recently I have been thinking of doing this.  Make 
sshd go to user_t first (and prevent user_t having dac_override capability or 
suid/sgid capabilities) and then require newrole to change to sysadm_r.  It 
would still be possible to damage things, but it would be a lot harder and 
the damage would be a lot less.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
