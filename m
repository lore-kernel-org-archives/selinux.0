Date: Fri, 16 Dec 2005 17:32:57 +0530
From: Rachita Kothiyal <rachita@in.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Error while trying to copy /proc files
Message-ID: <20051216120257.GB14007@in.ibm.com>
Reply-To: rachita@in.ibm.com
References: <20051214111921.GA439@in.ibm.com> <1134575010.3421.226.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1134575010.3421.226.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Dec 14, 2005 at 10:43:29AM -0500, Stephen Smalley wrote:
> On Wed, 2005-12-14 at 16:49 +0530, Rachita Kothiyal wrote:
> > Hi
> > 
> > I am running a 2.6.15-rc1-mm2 kernel, with CONFIG_SECURITY_SELINUX=y
> > in the config. When i try to copy a file from the /proc directory,
> > I get the following error message:
> > 
> > cp: listing attributes of '/proc/cmdline': Numerical result out of range
> > 
> > But this error seems to go away when I boot with 'selinux=0' in
> > the commandline.
> > 
> > Any thoughts on what could be going wrong?
> 
> Already fixed in
> http://marc.theaimsgroup.com/?l=git-commits-head&m=113441088019750&w=2

Thanks for the pointer.
I tried it with a 2.6.15-rc5-mm2 kernel and it worked
fine.

Regards
Rachita

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
