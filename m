Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4OEkxCR009575
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 10:46:59 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4OEkwc3004867
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 14:46:58 GMT
Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Mark Goldman <mgoldman@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1180015458.3930.173.camel@tresys-winxppro>
References: <20070521095414.832619201@tresys.com>
	 <20070521095518.515998898@tresys.com>
	 <1179868119.9092.38.camel@localhost.localdomain>
	 <1180015458.3930.173.camel@tresys-winxppro>
Content-Type: text/plain
Date: Thu, 24 May 2007 10:45:21 -0400
Message-Id: <1180017921.2940.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-24 at 10:04 -0400, Mark Goldman wrote:
> On Tue, 2007-05-22 at 17:08 -0400, Karl MacMillan wrote:
> <snip>
> > > +int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd)
> > > +{
> > > +	state_t s;
> > > +
> > > +	char outfile[PATH_MAX];
> > > +	char hdt[PATH_MAX];
> > > +	char fcf[PATH_MAX];
> > > +
> > > +	FILE *out = NULL;
> > > +	int retval = 0;
> > > +
> > > +	assert(sh);
> > > +
> > > +	s.homedir_template_path = hdt;
> > > +	snprintf(s.homedir_template_path, PATH_MAX - 1, "%s",
> > > +		 semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
> > > +
> > > +	snprintf(outfile, PATH_MAX - 1, "%s",
> > > +		 semanage_path(SEMANAGE_TMP, SEMANAGE_FC_HOMEDIRS));
> > > +
> > 
> > strdup?
> The paths are allocated on the stack.  Can't strdup them.  All things being
> equal, I would prefer to keep them on the stack since that is three
> fewer items I could possibly leak.
> 

I think malloc'd would be better because otherwise you have to do this
fun with PATH_MAX and snprintfs (which is hard to read) and end up with
a lot of data on the stack. Question - do you even need to copy these?
Why not just store a pointer to what is returned by semanage_path?

> > > +static list_t *default_shell_list(void)
> > > +{
> > 
> > What is this function for? Why not error out when /etc/shells is not
> > available?
> Well, the justification here as with several other places is
> "genhomedircon didn't".
> 

I think the behavior should be similar, but there is no reason that we
can't make changes to corner case behavior if we think it would be
better. So I don't think an _exact_ port is necessary.

> > > +	list_t *list = NULL;
> > 
> > Why are you adding another list type when we just merged one into
> > libsepol? If you want this merged into trunk before policyrep let's move
> > the list type over early.
> I'm working off of trunk.  If it isn't in trunk it I can't use it.
> 

I think another list type is unacceptable so you can either work off
policyrep or propose early merging of the list types. Either one is fine
with me.

> <snip>
> > > +	shells = fopen("/etc/shells", "r");
> > > +	if (!shells)
> > > +		return default_shell_list();
> > 
> > See above - when is this error possible and why not make it fatal.
> Again, "it wasn't fatal in genhomedircon"
> 

Dan / anyone - why have the default shell list?

> <snip>
> > > +	setpwent();
> > > +	while ((pwbuf = getpwent())) {
> > 
> > You need to check errno to see if there was an error.
> > 
> > It is not clear from the python docs, but getpwent will definitely pull
> > user entries from LDAP, NIS, etc. Is that what we want or should we
> > limit to /etc/passwd only?
> >From what I've been able to gather, python's getpwall is a wrapper 
> for getpwent. As for whether we want this behavior or not, I'm open 
> to suggestions.
> 

Ok - I'm really just concerned that if we try this against a large LDAP
database things will not go well. Anyone else have an opinion?

> <snip>
> > > +static int fwriteheader(state_t * s, FILE * out)
> > > +{
> > 
> > Needs a better function name.
> Suggestions?
> 

write_file_context_header? Or don't make it a function at all.

> <snip>
> > > +static int write_home_dir_context(FILE * out, list_t * tpl, char *user,
> > > +				  char *seuser, char *home, char *prefix)
> > > +{
> > > +	char *temp;
> > > +	char *line;
> > > +
> > > +	fprintf(out, "\n\n#\n# Home Context for user %s\n#\n\n", user);
> > > +	for (; tpl; tpl = tpl->next) {
> > > +		temp = semanage_sed(tpl->data, "HOME_DIR", home);
> > 
> > Wow - I understand that this string handling in C is painful, but is
> > this really the best alternative? Perhaps parsing the input to make the
> > substitution easier would be better? Perhaps we should look for some
> > library code to do this?
> I am not really sure what the problem with this is.  We need to replace
> arbitrary substrings.  I searched in the C libraries for something that
> might do what I want.  I couldn't find anything, so I wrote a function
> to do it.
> 

This substitution is inefficient and this type of string manipulation in
general is error prone.

> As for parsing the input to make the substitution easier, I think it
> would be a lot more work to write or use a full fledged parser.  What
> we want in this situation is what I wrote in my opinion, although I am
> open to suggestions.
> 
> <snip>
> > > +static int fwriteoutput(state_t * s, FILE * out)
> > > +{
> > 
> > This function name should be more descriptive.
> Suggestions?
> 

Not at the moment - but this is the main entrypoint as far as I can tell
and the name doesn't imply that at all.

> <snip>
> > > +	for (h = homedirs; h; h = h->next) {
> > > +		s1len = strlen(h->data);
> > > +		temp = malloc(s1len + sizeof("/[^/]*"));
> > > +		strcpy(temp, h->data);
> > > +		strcpy(temp + s1len, "/[^/]*");
> > 
> > strdup
> I needed extra space at the end of the string for the suffix, so I malloc'd
> it all in one go.
> 

Ok.

> <snip>
> > > +char *semanage_findval(char *file, char *var, char *delim)
> > > +{
> > > +	FILE *fd;
> > > +
> > > +	char *buff;
> > > +	char *temp = NULL;
> > > +
> > > +	if (!file || !var || !delim)
> > > +		return NULL;
> > 
> > assert?
> As with other things, genhomedircon would not have aborted on this
> condition.  It returned "" on all exceptional paths.
> 

Is it possible for these to be NULL or a sign of an earlier error?

> <snip>
> > > +char *semanage_split(char *str, char *delim)
> > > +{
> > > +	char *temp = str;
> > > +
> > > +	if (!str)
> > > +		return NULL;
> > > +	if (!delim || (*delim == '\0'))
> > > +		return semanage_split_on_space(str);
> > 
> > Having NULL mean space seems odd.
> This function was a python emulation function.  It behaves in the manner
> that python's split would if you don't pass in a delimiter.
> 

I'd prefer things to be more idiomatic to C rather than a straight
python port.

> Consider all unmentioned comments Noted and fixed.
> 

Great.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
