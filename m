Subject: Re: Error while trying to copy /proc files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: rachita@in.ibm.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20051214111921.GA439@in.ibm.com>
References: <20051214111921.GA439@in.ibm.com>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 10:43:29 -0500
Message-Id: <1134575010.3421.226.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-12-14 at 16:49 +0530, Rachita Kothiyal wrote:
> Hi
> 
> I am running a 2.6.15-rc1-mm2 kernel, with CONFIG_SECURITY_SELINUX=y
> in the config. When i try to copy a file from the /proc directory,
> I get the following error message:
> 
> cp: listing attributes of '/proc/cmdline': Numerical result out of range
> 
> But this error seems to go away when I boot with 'selinux=0' in
> the commandline.
> 
> Any thoughts on what could be going wrong?

Already fixed in
http://marc.theaimsgroup.com/?l=git-commits-head&m=113441088019750&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
