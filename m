Message-ID: <1343659143.2346.60.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Tuna bitbucket repository wont git clone
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
Date: Mon, 30 Jul 2012 10:39:03 -0400
In-Reply-To: <1343657463.2346.59.camel@moss-pluto.epoch.ncsc.mil>
References: 
	<CAFftDdpF68z3VKakiXgtLzybuCp34HdwRaBzY5hJASOoPB0oOA@mail.gmail.com>
	 <1343652345.2346.17.camel@moss-pluto.epoch.ncsc.mil>
	 <1343657463.2346.59.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-30 at 10:11 -0400, Stephen Smalley wrote:
> On Mon, 2012-07-30 at 08:45 -0400, Stephen Smalley wrote:
> > On Sat, 2012-07-28 at 15:39 -0700, William Roberts wrote:
> > > I really think their is something borked on the device tuna repo, even
> > > doing a straight git clone is not working:
> > > 
> > > git clone --mirror https://bitbucket.org/seandroid/device-samsung-tuna
> > > Initialized empty Git repository in /home/git/device-samsung-tuna.git/
> > > remote: Counting objects: 5870, done.
> > > remote: Compressing objects: 100% (3180/3180), done.
> > > Receiving objects:  85% (5040/5870), 326.57 MiB | 658 KiB/s
> > > 
> > > Is this repo really that big? I have let it get all the way to 1023MB
> > > and still git never returns. It sticks at 95% of objects received....
> > 
> > du -sh device/samsung/tuna shows it as 1.2G here.
> > Maybe we are hitting some bitbucket.org limits as well.
> > I see it hanging at 95% (5617/5870), 1.01GiB here.
> > If you try to clone the tuna project from selinuxproject.org in the same
> > way, does it complete?
> 
> Maybe you could first clone from AOSP, then add the bitbucket remote and
> fetch it.  Then you only need to download our modifications from
> bitbucket and not the entire tree.  e.g.
> 
> git clone --mirror https://android.googlesource.com/device/samsung/tuna device-samsung-tuna.git
> cd device-samsung-tuna.git
> git remote add bitbucket https://bitbucket.org/seandroid/device-samsung-tuna
> git fetch bitbucket
> 
> Not sure if that would solve the problem for you.

You'd likely need to switch the origin over to bitbucket afterward, e.g.
git remote rm origin
git remote rename bitbucket origin

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
