Date: Wed, 5 Nov 2008 08:46:27 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: hold tasklist_lock and siglock while waking
 wait_chldexit
In-Reply-To: <1225829906.3320.10.camel@localhost.localdomain>
Message-ID: <alpine.LRH.1.10.0811050845350.1992@tundra.namei.org>
References: <1225829906.3320.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Nov 2008, Eric Paris wrote:

> From: Eric Paris <eparis@redhat.com>
> 
> SELinux has long been calling wake_up_interruptible() on
> current->parent->signal->wait_chldexit without holding any locks.  It
> appears that this operation should hold the tasklist_lock to dereference
> current->parent and we should hold the siglock when waking up the
> signal->wait_chldexit.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

This seems correct to me, too, although I'll just push it to 
security-testing#next at least for the moment so it gets some testing.

How did you find this issue?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
