Date: Wed, 8 Nov 2006 23:15:13 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 4/8] make newrole suid (take 3)
Message-ID: <20061109051513.GA7208@sergelap.austin.ibm.com>
References: <454A8F35.2020006@us.ibm.com> <454A95BC.7000807@us.ibm.com> <20061107052338.GB11273@sergelap.austin.ibm.com> <4550E7E4.4000505@us.ibm.com> <20061108173224.GB15592@sergelap.austin.ibm.com> <45523185.40502@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45523185.40502@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Michael C Thompson (thompsmc@us.ibm.com):
> This is a short list of what we do prior to the uid change:
> - locale actions
> - calls into libselinux, libaudit and libc
> - calls to pam
> 
> In short, for the case where we want namespace support, we execute as 
> root for nearly the entire lifetime of the application, and the parent 
> process retains euid 0 as well while the shell has been exec'd and is 
> waiting for the child to die.
> 
> We don't actually *need* to do this, but my reason was that if we retain 
> the ability to setuid and retain the capabilities on the permitted (but 
> not effective) list, then if an exploit would be discovered for the 
> program, then all the attacker would need to do is re-raise those 
> capabilities and game over.
> 
> I've only briefly consider the effects of maintaining euid=0 during the 
> life-time of the application, but it seems to me the only impact it will 
> have is during the pam_open_session call.
> 
> Does that make sense?

If I'm thinking straight, the main advantage of still dropping euid=0
is that if the attacker has limited space for shellcode, or for some
other reason can only do exec(/bin/sh), the caps will be dropped on
exec, but euid=0 will not.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
