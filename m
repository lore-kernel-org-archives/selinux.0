Date: Mon, 12 May 2008 10:34:54 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC][PATCH] selinux:  simplify ioctl checking
In-Reply-To: <1210336991.6434.200.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0805121034110.22560@us.intercode.com.au>
References: <1210336991.6434.200.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 9 May 2008, Stephen Smalley wrote:

> Simplify and improve the robustness of the SELinux ioctl checking by 
> using the "access mode" bits of the ioctl command to determine the 
> permission check rather than dealing with individual command values.
> This removes any knowledge of specific ioctl commands from SELinux
> and follows the same guidance we gave to Smack earlier.

Looks good to me, let me know if you want it applied to for-akpm.

-- 
James Morris <jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
