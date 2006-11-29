Subject: Re: Recovering .te and .fc files from modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <456DEFAD.6040706@mentalrootkit.com>
References: <456DEFAD.6040706@mentalrootkit.com>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 16:05:19 -0500
Message-Id: <1164834319.23019.268.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-29 at 15:38 -0500, Karl MacMillan wrote:
> We've been getting requests for a tool to extract the .te and .fc files 
> from modules. Red Hat bugzilla for this at 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=217761.
> 
> I think this is a good idea and the dismod tool (located in 
> checkpolicy/test in the sources) is a good start at this. I'm mentioning 
> it here in case anyone has time or interest in creating this tool.

You might want to separate the disassembling of a binary module to
source policy from unpackaging a policy package, e.g. a
semodule_unpackage utility could easily write out the individual
components (binary module, file contexts, netfilter contexts), and then
a nicer version of dismod could disassemble the binary module to textual
representation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
