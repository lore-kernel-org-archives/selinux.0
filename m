Subject: Re: Policy loading problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dennis Wronka <linuxweb@gmx.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200905202207.31829.linuxweb@gmx.net>
References: <1242641994.470.5.camel@notebook2.grift.internal>
	 <200905202146.54559.linuxweb@gmx.net>
	 <1242827392.20082.392.camel@localhost.localdomain>
	 <200905202207.31829.linuxweb@gmx.net>
Content-Type: text/plain
Date: Wed, 20 May 2009 10:09:56 -0400
Message-Id: <1242828596.20082.395.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-20 at 22:07 +0800, Dennis Wronka wrote:
> Sorry I got to ask, but what do you actually mean by "initial policy loading 
> logic"?
> 
> I haven't actually written any code that handles the policy. I took the 
> attached patch for SysVInit and applied it. From what I know this is the 
> commonly used patch for this, as it seems to be pretty identical wherever I'm 
> looking.

That's what I wanted to see, thanks.

Now, if you boot permissive in single-user mode (enforcing=0 single) and
run "load_policy -i" (note the -i option), does that work?  That calls
the same function for initial policy loading as the patch for sysvinit.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
