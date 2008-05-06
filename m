Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m46HXoWR007144
	for <selinux@tycho.nsa.gov>; Tue, 6 May 2008 13:33:51 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m46HXl9Z028170
	for <selinux@tycho.nsa.gov>; Tue, 6 May 2008 17:33:48 GMT
Subject: Re: refpolicy: patch for gpg-agent
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <20080415132602.GA6685@bobek.pm.i.cz>
References: <20080220170300.GA13312@bobek.pm.i.cz>
	 <1204660301.14217.26.camel@gorn> <20080321130315.GA21980@bobek.pm.i.cz>
	 <1206544272.16113.228.camel@gorn>  <20080415132602.GA6685@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 06 May 2008 13:33:35 -0400
Message-Id: <1210095215.12360.10.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-04-15 at 15:26 +0200, Václav Ovsík wrote:
> Hi,
> after a longer period of inactivity I'm back with a new try :)
> 
> On Wed, Mar 26, 2008 at 11:11:12AM -0400, Christopher J. PeBenito wrote:
> > On Fri, 2008-03-21 at 14:03 +0100, Václav Ovsík wrote:
> > > On Tue, Mar 04, 2008 at 02:51:41PM -0500, Christopher J. PeBenito wrote:
> > > > On Wed, 2008-02-20 at 18:03 +0100, Václav Ovsík wrote:
> > > > > I'm running HEAD refpolicy on Debian Sid, but this patch is not
> > > > > Debian-specific this time.
> > > > > Having a copy of my std bash profile on the testing machine with
> > > > > a snippet (from gpg-agent man page):
> > > > > 
> > > > >     if test -f $HOME/.gpg-agent-info \
> > > > >              && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info`
> > > > > 2>/dev/null
> > > > >     then
> > > > >         . $HOME/.gpg-agent-info
> > > > >         export GPG_AGENT_INFO
> > > > >         export SSH_AUTH_SOCK
> > > > >         export SSH_AGENT_PID
> > > > >     else
> > > > >         eval `gpg-agent --daemon --write-env-file`
> > > > >     fi
> > > > > 
> > > > > I got a number of denials for this snippet of commands.
> > > > > 
> > > > > 1. Found a typo for permissions to create socket in the /tmp.
> > > > > 2. Added permission to send signal 0 by the user (see above).
> > > > > 3. Added permissions for writing agent info file into users home
> > > > >    directory.
> > > > > 
> > > > > Index: policy/modules/apps/gpg.if
> > > > > ===================================================================
> > > > > --- policy/modules/apps/gpg.if  (revision 2617)
> > > > > +++ policy/modules/apps/gpg.if  (working copy)
> > > > > @@ -212,6 +212,12 @@
> > > > >         manage_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
> > > > >         manage_lnk_files_pattern($1_gpg_agent_t,$1_gpg_secret_t,$1_gpg_secret_t)
> > > > >  
> > > > > +       # write ~/.gpg-agent-info (gpg-agent --write-env-file option)
> > > > > +       allow $1_gpg_agent_t { $1_home_dir_t $1_home_t }:dir add_entry_dir_perms;
> > > > > +       type_transition $1_gpg_agent_t $1_home_dir_t:file $1_home_t;
> > > > > +       allow $1_gpg_agent_t $1_home_t:file create_file_perms;
> > > > > +       allow $1_gpg_agent_t $1_home_t:file write_file_perms;
> > > > 
> > > > I'm a little hesitant to add this unconditionally, I don't think we want
> > > > gpg-agent to write out to general home dir content.  Perhaps we should
> > > > have a tunable, or a specific type for this.
> > > 
> > > I added this rules, so an example from gpg-agent manpage can work
> > > out-of-the-box. Adding a tunable (with the default to disallow) will not
> > > satisfy this. Maybe the later - specific type, but what security risk
> > > poses this rules?
> > > I thought, that domain X_gpg_agent_t is very trusted domain, that
> > > manages my secret keys and should be shielded against the world around
> > > and not the opposite.
> > 
> > Its trusted for handling keys, not trusted for handling general content
> > in the user's home directory.  Remember that if the rules are made
> > conditional, theres nothing stopping distros from making the tunable
> > default to true.
[...]
> Another patch is attached with the specific type for home file
> (<ROLE>_gpg_agent_home_t). I hope, this is better than general write
> permission from the previous patch and without administrative overhead
> of tunable.
> 
> Allowed rules for userdomain on gpg-agent tmp files (socket) are
> contained, but I'm not completely certain this is needed. Gpg-agent
> creates socket while starting and cleans it up when exits. The socket
> file remains in /tmp only when gpg-agent is killed by SIGKILL, and there
> is probably no need to remove this stuff by the userdomain either.
> Tmpreaper/tmpwatch cron job should do cleanup. Although I hope including
> these rules for userdomain is harmless.

I've been kicking this one around in my head for a while since this
doesn't seem clear cut.  I think adding another type is too much for
such a file, so I still think the best choice is to have a tunable that
allows writing to $1_home_t files, as I suggested before.

Another suggestion that was made to me would be to use the same type
used by the socket ($1_gpg_agent_tmp_t).  I'm not convinced there
actually a security equivalence, but if you can come up with a good
argument, then I'm open to it.  If that happens the type will have to be
renamed since creating a *_tmp_t file in a user home directory is
confusing.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
