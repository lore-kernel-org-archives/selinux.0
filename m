Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q84EXOZn005855
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2012 10:33:24 -0400
From: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
To: Marcel Butucea <marcelbutucea@gmail.com>,
        "selinux@tycho.nsa.gov"
	<selinux@tycho.nsa.gov>
CC: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
Subject: RE: RBAC to SELinux policy migration
Date: Tue, 4 Sep 2012 14:33:21 +0000
Message-ID: <33006C99F5A5194A9B7A7715DFA3E3836518BBC2@ALA-MBB.corp.ad.wrs.com>
References: <CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com>,<CADxHy9e0sQu8h82KVUQ8k_q4as46NNW90u0ZH6i5yAk--gu64A@mail.gmail.com>
In-Reply-To: <CADxHy9e0sQu8h82KVUQ8k_q4as46NNW90u0ZH6i5yAk--gu64A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One thing that hasn't yet been mentioned:

Using DAC, you can always set the file permission on the utilities you need so that the SUID bit is set and the file is owned by root.

If you "chown root tcpdump ; chmod 4755 tcpdump", then anyone can execute tcpdump, regardless of their UID and without sudo.

You can then use SELinux to restrict that, so that only some users can use tcpdump, or put other restrictions on it.

This is not a pure SELinux solution, which is what you requested, though.

________________________________________
From: owner-selinux@tycho.nsa.gov [owner-selinux@tycho.nsa.gov] on behalf of Marcel Butucea [marcelbutucea@gmail.com]
Sent: Tuesday, September 04, 2012 3:29 AM
To: selinux@tycho.nsa.gov
Subject: Re: RBAC to SELinux policy migration

Clarifying to avoid confusion:

1. I assumed I would be able to allow a user the ability to run system utilities like tcpdump, chkconfig, etc. by using selinux (either by using domain transitions or applying a sysadm_u context to the user or ...)
Is that correct ?
2. I am not sure capabilities can do that, my understanding was that they work on a per file basis not per user.....
3. if the uid is checked by the utility I won't be able to workaround that by means of selinux, right ?

Regards,
Marcel

On 3 September 2012 23:41, Marcel Butucea <marcelbutucea@gmail.com<mailto:marcelbutucea@gmail.com>> wrote:

Hello SELinux Team,

As I am a beginner in deciphering the depths of SELinux I come to you with the following predicament in hope of guidance and help:

We are migrating an application from Solaris to Linux and the main user is allowed, through the use of RBAC roles, to run a few system commands like svccfg/svcadm (chkconfig on redhat).

Is it possible, using only SElinux (no sudo), to allow a normal user to run chkconfig off/on <service> (basically giving it the ability to add/remove services) ?(my ultimate goal would be to allow this user to run other "root-only" utilities as well). One of my concerns is that chkconfig might have some internal check for the uid of the calling user, ergo blocking this account from running the utility irrespective of my selinux policy, is my worry legitimate or am I imagining things ?

My approach was to try to create an SElinux user with a corresponding SElinux role that manages the app's domain/type and is allowed to transition to all other domains required to run chkconfig, tcpdump or any other system utility usually restricted to root access only. All my attempts so far have failed, so my second question would be where could I find good documentation that applies to this specific problem ?

Thank you for your support!

Best Regards,

Marcel



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
