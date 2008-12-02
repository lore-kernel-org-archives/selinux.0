Subject: Re: Context transition error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vince Le Port <vince.rafale@gmail.com>
Cc: selinux@tycho.nsa.gov, Dave Quigley <dpquigl@tycho.nsa.gov>
In-Reply-To: <4935493A.8020301@gmail.com>
References: <492709F5.2090801@gmail.com>
	 <1227297581.7319.54.camel@moss-spartans.epoch.ncsc.mil>
	 <4935493A.8020301@gmail.com>
Content-Type: text/plain
Date: Tue, 02 Dec 2008 10:03:08 -0500
Message-Id: <1228230188.26101.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-12-02 at 15:42 +0100, Vince Le Port wrote:
> Hi list,
> 
> Your answer helped me so much. I have succeeded in making my test
> program running properly.
> 
> I am now working on the NFS server side modification.
> 
> I have made some searches around the use of setcon , and it seems that
> this function is only available in the user space, not into the kernel.
> Am I wrong saying that?
> 
> Does anybody know the equivalent of setcon in kernel mode?
> Moreover I did not find the source code of the setcon function... where
> could I find it ?

setcon() is a library function provided by libselinux.
The equivalent of setcon() in the kernel is security_setprocattr() whose
prototype is defined in include/linux/security.h.

If you look at an earlier version of the labeled NFS patch set, you can
see an example of using security_setprocattr() to set the nfsd context
from the remote label:
http://marc.info/?l=selinux&m=122270951204108&w=2

As before, I'd encourage you to follow the ongoing labeled NFS work.  A
newer version of the patch set was just posted, although this omits the
process label transport mechanism since that is being redesigned.
http://marc.info/?l=selinux&m=122814925716620&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
