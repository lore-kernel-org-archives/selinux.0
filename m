From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [ SEMANAGE ] Stub pserver backend
Date: Tue, 15 Nov 2005 11:02:16 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux-dev@tresys.com, selinux@tycho.nsa.gov
References: <437907D7.8090002@cornell.edu> <1132063930.5415.364.camel@moss-spartans.epoch.ncsc.mil> <4379F2D9.4030808@redhat.com>
In-Reply-To: <4379F2D9.4030808@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511151102.16314.csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 15 November 2005 09:38, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> > On Tue, 2005-11-15 at 08:38 -0500, Daniel J Walsh wrote:
> >> refpolicy went in last night.   Now we need to get strict/mls working.
> >> As well as clean up the bugs that
> >> refpolicy will cause.
> >
> > Ok, I'm presently updated a rawhide targeted system, and have attached
> > three files with relevant output from yum, dmesg, and avc audit.  The
> > yum output shows what booleans were lost in translation and what files
> > were relabeled by restorecon.  The dmesg output shows what security
> > contexts were no longer valid in the new policy, which then triggers
> > subsequent inode_doinit errors upon the relabeling.  The avc audit
> > output shows the denials that would have occurred during the restorecon
> > if I had done this in enforcing mode.  I also noticed that policy is
> > reloaded twice; second load occurs during cleanup phase for some reason.
>
> Ok I should not have turned off xdm, there is a bug in the spec for jvm.
>
> sendmail_launch was a last minute change to targeted from Russell that
> has not been ported into refpolicy yet.
>
> ypxfr is a partial policy to implement ypxfr, but is not used yet.
>
> We need to get procmail ported to reference policy
>
> I turned off lvm, because it brought a lot of other pieces in that I did
> not want to deal with.   We can revisit this decision.
>
> reference policy has added some confinement of some user space tools,
> which we will have to monitor for breakage.
>
> Dan
>
Note that most of these issues fall into one of the following 3 areas (sent 
off-list before, so I reposted them on-list)

1) Policy modules organization involving including policy from multiple old 
policy .te files
usermanage - passwd, crack, and useradd
authlogin - login, utempter, pam, pamconsole
locallogin - login, sulogin
cron - crond and crontab
netutils - traceroute and ping
spamassassin - spamd and spamassassin

2) additional policies for mount and bootloader.  These policies are currently 
required for refpolicy to function, and would require a significant rewrite 
to remove this dependency.  Since they are small and easily verifiable, they 
have been left in.

3) Policy differences due to very new (less than 2 weeks) policy in rawhide.  
We have not tracked all changes in rawhide up to today.  These include the 
addition of procmail policy to targeted, the rewrite of mta/sendmail, and 
numerous other changes.  The invalidated contexts are coming from here.

Also, I believe Dan added the secondary policy reload to solve the problem 
where rpm removed the policy binary after install.  This is a %triggerpostun 
in the rpm, which will only trigger when upgrading from a version less than 2 
(i.e. only when upgrading from traditional to refpolicy).

Thanks,
Chad

-- 
----------------------
Chad Sellers
Tresys Technology, LLC
csellers@tresys.com
(410)290-1411 x117
http://www.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
