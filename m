Subject: Re: [PATCH] refpolicy: add X object classes to unconfined_t
From: Joshua Brindle <jbrindle@tresys.com>
To: ewalsh@tycho.nsa.gov
Cc: cpebenito@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <450962DB.7050107@tresys.com>
References: <1158088282.7554.95.camel@moss-huskies.epoch.ncsc.mil>
	 <450962DB.7050107@tresys.com>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 08:46:56 -0400
Message-Id: <1158324416.8680.5.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-14 at 10:10 -0400, Joshua Brindle wrote:
> Eamon Walsh wrote:
> > Hello,
> > I'm working on the XSELinux code, which has just been brought up to date
> > with the current X.org code base.
> > 
> > The following patch adds the X Windows userspace object classes to
> > unconfined_t.
> > 
> 
> This patch doesn't add the types necessary to run the default XSELinux 
> installation. Do you have a module that adds those types so that we can 
> test the codebase out?

It also seems that the XSELinuxConfig in the git repository doesn't have
all the necessary entries, one for root_window_context needs to be added
to start the X server up.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
