Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4OJK8nt025409
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 15:20:08 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4OJK6EP022768
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 19:20:06 GMT
Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: Mark Goldman <mgoldman@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1180017921.2940.24.camel@localhost.localdomain>
References: <20070521095414.832619201@tresys.com>
	 <20070521095518.515998898@tresys.com>
	 <1179868119.9092.38.camel@localhost.localdomain>
	 <1180015458.3930.173.camel@tresys-winxppro>
	 <1180017921.2940.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 24 May 2007 15:20:01 -0400
Message-Id: <1180034401.3930.203.camel@tresys-winxppro>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-24 at 10:45 -0400, Karl MacMillan wrote:
> On Thu, 2007-05-24 at 10:04 -0400, Mark Goldman wrote:
> > On Tue, 2007-05-22 at 17:08 -0400, Karl MacMillan wrote:
> > <snip>
> > > > +int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd)
> > > > +{
> > > > +	state_t s;
> > > > +
> > > > +	char outfile[PATH_MAX];
> > > > +	char hdt[PATH_MAX];
> > > > +	char fcf[PATH_MAX];
> > > > +
> > > > +	FILE *out = NULL;
> > > > +	int retval = 0;
> > > > +
> > > > +	assert(sh);
> > > > +
> > > > +	s.homedir_template_path = hdt;
> > > > +	snprintf(s.homedir_template_path, PATH_MAX - 1, "%s",
> > > > +		 semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
> > > > +
> > > > +	snprintf(outfile, PATH_MAX - 1, "%s",
> > > > +		 semanage_path(SEMANAGE_TMP, SEMANAGE_FC_HOMEDIRS));
> > > > +
> > > 
> > > strdup?
> > The paths are allocated on the stack.  Can't strdup them.  All things being
> > equal, I would prefer to keep them on the stack since that is three
> > fewer items I could possibly leak.
> > 
> 
> I think malloc'd would be better because otherwise you have to do this
> fun with PATH_MAX and snprintfs (which is hard to read) and end up with
> a lot of data on the stack. Question - do you even need to copy these?
> Why not just store a pointer to what is returned by semanage_path?
RE snprintf, I don't think snprintfs are hard to read, I think this is a
style issue.

RE Do I need a copy of these.  Not really, but I didn't want to make
assumptions that the strings would necessarily remain valid.

Fixed: storing the pointers semanage_path() returns instead of copying
them.

> > > > +static list_t *default_shell_list(void)
> > > > +{
> > > 
> > > What is this function for? Why not error out when /etc/shells is not
> > > available?
> > Well, the justification here as with several other places is
> > "genhomedircon didn't".
> > 
> 
> I think the behavior should be similar, but there is no reason that we
> can't make changes to corner case behavior if we think it would be
> better. So I don't think an _exact_ port is necessary.
I didn't know if this particular instance was, in fact, a corner case.
I'd be just as happy for it to error if it is truly a rare condition.
Comments?

> > > > +	list_t *list = NULL;
> > > 
> > > Why are you adding another list type when we just merged one into
> > > libsepol? If you want this merged into trunk before policyrep let's move
> > > the list type over early.
> > I'm working off of trunk.  If it isn't in trunk it I can't use it.
> > 
> 
> I think another list type is unacceptable so you can either work off
> policyrep or propose early merging of the list types. Either one is fine
> with me.
If you would like to move the list types out of policyrep and into
trunk, I'll be happy to use it.  Otherwise it is out of the scope of
this patch.

<snip>
> > > > +char *semanage_findval(char *file, char *var, char *delim)
> > > > +{
> > > > +	FILE *fd;
> > > > +
> > > > +	char *buff;
> > > > +	char *temp = NULL;
> > > > +
> > > > +	if (!file || !var || !delim)
> > > > +		return NULL;
> > > 
> > > assert?
> > As with other things, genhomedircon would not have aborted on this
> > condition.  It returned "" on all exceptional paths.
> > 
> 
> Is it possible for these to be NULL or a sign of an earlier error?
At the moment, the code is never called in a manner where  file or var will
be NULL.  I don't have too strong of an opinion, will assert().

> > <snip>
> > > > +char *semanage_split(char *str, char *delim)
> > > > +{
> > > > +	char *temp = str;
> > > > +
> > > > +	if (!str)
> > > > +		return NULL;
> > > > +	if (!delim || (*delim == '\0'))
> > > > +		return semanage_split_on_space(str);
> > > 
> > > Having NULL mean space seems odd.
> > This function was a python emulation function.  It behaves in the manner
> > that python's split would if you don't pass in a delimiter.
> > 
> 
> I'd prefer things to be more idiomatic to C rather than a straight
> python port.
Noted.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
