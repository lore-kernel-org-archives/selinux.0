Subject: Re: [PATCH] SELinux: hold tasklist_lock and siglock while waking
 wait_chldexit
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <alpine.LRH.1.10.0811050845350.1992@tundra.namei.org>
References: <1225829906.3320.10.camel@localhost.localdomain>
	 <alpine.LRH.1.10.0811050845350.1992@tundra.namei.org>
Content-Type: text/plain
Date: Tue, 04 Nov 2008 16:50:39 -0500
Message-Id: <1225835439.3320.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-11-05 at 08:46 +1100, James Morris wrote:
> On Tue, 4 Nov 2008, Eric Paris wrote:
> 
> > From: Eric Paris <eparis@redhat.com>
> > 
> > SELinux has long been calling wake_up_interruptible() on
> > current->parent->signal->wait_chldexit without holding any locks.  It
> > appears that this operation should hold the tasklist_lock to dereference
> > current->parent and we should hold the siglock when waking up the
> > signal->wait_chldexit.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> This seems correct to me, too, although I'll just push it to 
> security-testing#next at least for the moment so it gets some testing.
> 
> How did you find this issue?

sds over there noticed that we weren't doing any locking during code
review and thought it looked off.

I've also poked roland privately to try to get him to take a gander.
Who else knows this locking well to tell me if I got it right?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
