Subject: Re: [PATCH] SELinux: add .gitignore files for dynamic classes
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1256224823.2191.51.camel@moss-pluto.epoch.ncsc.mil>
References: <20091022150859.20503.17193.stgit@paris.rdu.redhat.com>
	 <1256224823.2191.51.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Oct 2009 11:23:28 -0400
Message-Id: <1256225008.4443.97.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-10-22 at 11:20 -0400, Stephen Smalley wrote:
> On Thu, 2009-10-22 at 11:08 -0400, Eric Paris wrote:
> > The SELinux dynamic class work in c6d3aaa4e35c71a32a86ececacd4eea7ecfc316c
> > creates a number of dynamic header files and scripts.  Add .gitignore files
> > so git doesn't complain about these.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> Acked-by:  Stephen D. Smalley <sds@tycho.nsa.gov>
> 
> I guess we also should add them to Documentation/dontdiff?

Sure, I'll send a new version with your ACK on it.  (I didn't even know
that existed)

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
