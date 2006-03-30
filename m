Subject: Re: Latest policy
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <442C0940.5050800@redhat.com>
References: <442AEEF3.70406@redhat.com> <1143734415.13732.51.camel@sgc>
	 <442C0940.5050800@redhat.com>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 12:04:21 -0500
Message-Id: <1143738261.24555.226.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-03-30 at 11:37 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > I dropped this; I'm pretty sure its related to the leaked file
> > descriptors in semodule t
> >   
> I have the leak code fixed, but am still seeing this.  I will try it 
> again without this code.

libsemanage patch wasn't right, so it is still leaking the descriptor.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
