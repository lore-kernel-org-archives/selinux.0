Message-ID: <1346767505.30701.38.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: RBAC to SELinux policy migration
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Marcel Butucea <marcelbutucea@gmail.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Date: Tue, 04 Sep 2012 10:05:05 -0400
In-Reply-To: <CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com>
References: 
	<CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-09-03 at 23:41 +0100, Marcel Butucea wrote:
> Hello SELinux Team,
> 
> As I am a beginner in deciphering the depths of SELinux I come to you
> with the following predicament in hope of guidance and help:
> 
> We are migrating an application from Solaris to Linux and the main
> user is allowed, through the use of RBAC roles, to run a few system
> commands like svccfg/svcadm (chkconfig on redhat).
> 
> Is it possible, using only SElinux (no sudo), to allow a normal user
> to run chkconfig off/on <service> (basically giving it the ability to
> add/remove services) ?(my ultimate goal would be to allow this user to
> run other "root-only" utilities as well). One of my concerns is that
> chkconfig might have some internal check for the uid of the calling
> user, ergo blocking this account from running the utility irrespective
> of my selinux policy, is my worry legitimate or am
> I imagining things ?
> 
> My approach was to try to create an SElinux user with a corresponding
> SElinux role that manages the app's domain/type and is allowed to
> transition to all other domains required to run chkconfig, tcpdump or
> any other system utility usually restricted to root access only. All
> my attempts so far have failed, so my second question would be where
> could I find good documentation that applies to this specific
> problem ?
> 
> Thank you for your support!

Not possible via SELinux alone, as presently we don't provide a way to
grant capabilities that would not otherwise be granted, only to further
restrict them.  There were patches floated to support that kind of
functionality but they were shouted down by the mob.

So you need to use something else (sudo or file caps or whatever) to
first grant the capabilities, and then you can use SELinux to help lock
down the user to only what is required.  sudo does have SELinux support
these days, both via command-line options and sudoers configuration.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
