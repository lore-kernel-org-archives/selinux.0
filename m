Subject: Re: [patch 0/4] libsemanage: genhomedircon regressions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov, jbrindle@tresys.com
In-Reply-To: <1190986603.22078.1.camel@moss-spartans.epoch.ncsc.mil>
References: <20070927200712.950671948@tresys.com>
	 <1190986603.22078.1.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 28 Sep 2007 09:44:58 -0400
Message-Id: <1190987098.22078.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-28 at 09:36 -0400, Stephen Smalley wrote:
> On Thu, 2007-09-27 at 16:07 -0400, Todd C. Miller wrote:
> > This patch set fixes several regressions found in the new genhomedircon
> > replacement.  I've broken things up into their logical parts for easy
> > reading.  I've also included Dan's do_rebuild_file_context and swigify
> > patches as a 4th diff.  If we want to treat that completely separately
> > we can.
> 
> patch 1/4 yielded a non-buildable tree, so I applied 1/4 and 3/4
> together as a single commit.
> 
> 2/4 applied as a bug fix independent of the others.
> 
> 4/4 dropped except for Makefile swigify target.
> 
> libsemanage 2.0.10.

Looking again at the output, the order differs - the libsemanage
genhomedircon puts the specific user entries first and then the
generic /home entries, which seems wrong given that later entries take
precedence for matchpathcon.  genhomedircon script does the opposite.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
