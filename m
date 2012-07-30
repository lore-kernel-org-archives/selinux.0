Message-ID: <1343652345.2346.17.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Tuna bitbucket repository wont git clone
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
Date: Mon, 30 Jul 2012 08:45:45 -0400
In-Reply-To: <CAFftDdpF68z3VKakiXgtLzybuCp34HdwRaBzY5hJASOoPB0oOA@mail.gmail.com>
References: 
	<CAFftDdpF68z3VKakiXgtLzybuCp34HdwRaBzY5hJASOoPB0oOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2012-07-28 at 15:39 -0700, William Roberts wrote:
> I really think their is something borked on the device tuna repo, even
> doing a straight git clone is not working:
> 
> git clone --mirror https://bitbucket.org/seandroid/device-samsung-tuna
> Initialized empty Git repository in /home/git/device-samsung-tuna.git/
> remote: Counting objects: 5870, done.
> remote: Compressing objects: 100% (3180/3180), done.
> Receiving objects:  85% (5040/5870), 326.57 MiB | 658 KiB/s
> 
> Is this repo really that big? I have let it get all the way to 1023MB
> and still git never returns. It sticks at 95% of objects received....

du -sh device/samsung/tuna shows it as 1.2G here.
Maybe we are hitting some bitbucket.org limits as well.
I see it hanging at 95% (5617/5870), 1.01GiB here.
If you try to clone the tuna project from selinuxproject.org in the same
way, does it complete?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
