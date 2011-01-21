Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0LJoIcH013072
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2011 14:50:18 -0500
Received: from smtp107.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p0LJoHcZ001605
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2011 19:50:17 GMT
Message-ID: <4D39E377.2090102@schaufler-ca.com>
Date: Fri, 21 Jan 2011 11:50:15 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        john.johansen@canonical.com, penguin-kernel@I-love.SAKURA.ne.jp,
        takedakn@nttdata.co.jp, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: SELinux/SMACK/TOMOYO: ioctl permissions handling is wrong and
 nonsensicle
References: <1295638239.3403.15.camel@localhost.localdomain>
In-Reply-To: <1295638239.3403.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/21/2011 11:30 AM, Eric Paris wrote:
> [I've included an AA person as well in case you ever decide to try to
> mediate ioctl operations]
>
> SELinux used to recognize certain individual ioctls and check
> permissions based on the knowledge of the individual ioctl.  In commit
> 242631c49d4cf396 the SELinux code stopped trying to understand
> individual ioctls and to instead looked at the ioctl access bits to
> determine in we should check read or write for that operation.  This
> same suggestion was made to SMACK (and I believe copied into TOMOYO).
> But this suggestion is total rubbish.

Bugger bugger bugger ... (you get the idea) ... bugger.

This means calling out each and every ioctl separately,
unless someone has a magic access behavior detector for
device drivers. You can't even assume that two devices
that share an ioctl are going to do the same thing with
it. In the old Orange Book days almost half the work on
describing the access control implementation went into
iotcls and fcntls. Bugger.

What strategy is SELinux planning to take on getting the
ioctls right, and more importantly, keeping them correct
going forward?

> The ioctl access bits are
> actually the access requirements for the structure being passed into the
> ioctl, and are completely unrelated to the operation of the ioctl or the
> object the ioctl is being performed upon.
>
> Take FS_IOC_FIEMAP as an example.  FS_IOC_FIEMAP is defined as:
>
> FS_IOC_FIEMAP _IOWR('f', 11, struct fiemap)
>
> So it has access bits R and W.  What this really means is that the
> kernel is going to both read and write to the struct fiemap.  It has
> nothing at all to do with the operations that this ioctl might perform
> on the file itself!

Grrrrr.

> If anything, our logic is exactly backwards, since an ioctl which writes
> to userspace would be 'reading' something from the file and an ioctl
> which reads from userspace would be 'writing' something to the file...
>
> I'm planning to revert this SELinux commit, but I want other LSM authors
> to realize that (assuming I'm not completely off in the woods somewhere)
> you should take a look at your ioctl permissions checking as well....

Yeah. Good fun, that. Any chance we could share strategic thinking?
I hate the notion of brute forcing each ioctl, having done it in the
past for a system with lots fewer ioctls than Linux is supporting.

> -Eric

Thank you for the heads up on this. Bugger ... bugger.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
