Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB34f7VH029133
	for <selinux@tycho.nsa.gov>; Sat, 2 Dec 2006 23:41:08 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB34eN96028089
	for <selinux@tycho.nsa.gov>; Sun, 3 Dec 2006 04:40:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: root home directory and system cron jobs
Date: Sun, 3 Dec 2006 15:41:21 +1100
Cc: selinux@tycho.nsa.gov
References: <1165110951.19409.8.camel@hepcat.vitavonni.de>
In-Reply-To: <1165110951.19409.8.camel@hepcat.vitavonni.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200612031541.27320.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 03 December 2006 12:55, Erich Schubert <erich@debian.org> wrote:
> Does anyone have a good proposal on handling this issue?
> Maybe using something like HOME=/var/lib/system-cron-home in all system
> cron jobs? Any FHS information on that?

Sounds reasonable to me.

I think it would be worth proposing on a more general mailing list with a 
rationale that doesn't involve SE Linux.

> Apart from the SELinux issues, I believe that there are a couple of odd
> bugs that can be triggered by setting up weird dotfiles in /root on
> non-SELinux-systems. For example a cronjob using wget to download some
> files can probably be broken by setting up a non-working proxy
> in /root/.wgetrc

Yes, there's also other issues of system processes using /root.  One example 
is that RHGB (the Red Hat Graphical Boot) program used to read and write (or 
try to under SE Linux) dot files.  I expect that if the root user messed up 
their GNOME settings badly enough then the machine would fail to boot as a 
result.  I'm not sure if that bug ever got resolved or was just closed as an 
upstream issue.

> Also some cronjobs will try to use "su" to switch to a different userid.
> (e.g. the amavisd-new cronjob to do maintainance on the spamassassin
> bayes database); some might be able to be rewritten to use the other
> userid directly, but some might not...
> (e.g. because they're installed in /etc/cron.daily, which doesn't use
> the cronjob syntax but is just a collection of shell scripts; they need
> to use su to switch to a different user)

There is no reason why they couldn't be installed in /etc/cron.d instead.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
