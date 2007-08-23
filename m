Subject: Re: [patch 2/5] libsemanage: genhomedircon replacement
From: Stephen Smalley <sds@tycho.nsa.gov>
To: tmiller@tresys.com
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1187876361.1451.480.camel@moss-spartans.epoch.ncsc.mil>
References: <20070821191042.482612921@tresys.com>
	 <20070821191045.857181383@tresys.com>
	 <1187876361.1451.480.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 11:03:21 -0400
Message-Id: <1187881401.1451.498.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-23 at 09:39 -0400, Stephen Smalley wrote:
> On Tue, 2007-08-21 at 15:10 -0400, tmiller@tresys.com wrote:
> > plain text document attachment (genhomedircon-replacement-initial)
> > Remove python script genhomedircon from libsemanage and replace
> > with C functionality.
> > 
> > Note: This code fixes a bug in the orignal genhomedircon python script; the
> > following two lines are added to the file contexts whereas the old
> > genhomedircon would not add them: 
> > 
> > /tmp/\.exchange-.*(/.*)?      user_u:object_r:user_evolution_exchange_tmp_t:s0
> > /tmp/\.exchange-root(/.*)?    root:object_r:user_evolution_exchange_tmp_t:s0
> 
> Still wrong.  I still get extra blank lines and sds_home_t rather than
> staff_home_t out of it.

Ah, it would help if I ran semodule against the right set of shared
libs.  Oops, sorry.

Thanks, merged all 5 patches onto trunk.

Caveat:  libselinux needs to be updated at the same time since it now
relies on its path name function for file_contexts.homedirs.

There also seemed to be some unimplemented todo items noted in comments,
like:
+
+       /* clean up some files from the sandbox before install */
+       /* remove homedir_template from sandbox */
+

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
