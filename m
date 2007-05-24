Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4OE6Knm006324
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 10:06:20 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4OE6FXo022805
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 14:06:15 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
Date: Thu, 24 May 2007 10:04:18 -0400
Message-ID: <1180015458.3930.173.camel@tresys-winxppro>
In-Reply-To: <1179868119.9092.38.camel@localhost.localdomain>
References: <20070521095414.832619201@tresys.com> <20070521095518.515998898@tresys.com> <1179868119.9092.38.camel@localhost.localdomain>
From: "Mark Goldman" <mgoldman@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-22 at 17:08 -0400, Karl MacMillan wrote:
<snip>
> > +int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd)
> > +{
> > +	state_t s;
> > +
> > +	char outfile[PATH_MAX];
> > +	char hdt[PATH_MAX];
> > +	char fcf[PATH_MAX];
> > +
> > +	FILE *out = NULL;
> > +	int retval = 0;
> > +
> > +	assert(sh);
> > +
> > +	s.homedir_template_path = hdt;
> > +	snprintf(s.homedir_template_path, PATH_MAX - 1, "%s",
> > +		 semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
> > +
> > +	snprintf(outfile, PATH_MAX - 1, "%s",
> > +		 semanage_path(SEMANAGE_TMP, SEMANAGE_FC_HOMEDIRS));
> > +
> 
> strdup?
The paths are allocated on the stack.  Can't strdup them.  All things being
equal, I would prefer to keep them on the stack since that is three
fewer items I could possibly leak.

> > +static list_t *default_shell_list(void)
> > +{
> 
> What is this function for? Why not error out when /etc/shells is not
> available?
Well, the justification here as with several other places is
"genhomedircon didn't".

> > +	list_t *list = NULL;
> 
> Why are you adding another list type when we just merged one into
> libsepol? If you want this merged into trunk before policyrep let's move
> the list type over early.
I'm working off of trunk.  If it isn't in trunk it I can't use it.

<snip>
> > +	shells = fopen("/etc/shells", "r");
> > +	if (!shells)
> > +		return default_shell_list();
> 
> See above - when is this error possible and why not make it fatal.
Again, "it wasn't fatal in genhomedircon"

<snip>
> > +	setpwent();
> > +	while ((pwbuf = getpwent())) {
> 
> You need to check errno to see if there was an error.
> 
> It is not clear from the python docs, but getpwent will definitely pull
> user entries from LDAP, NIS, etc. Is that what we want or should we
> limit to /etc/passwd only?
>From what I've been able to gather, python's getpwall is a wrapper 
for getpwent. As for whether we want this behavior or not, I'm open 
to suggestions.

<snip>
> > +static int fwriteheader(state_t * s, FILE * out)
> > +{
> 
> Needs a better function name.
Suggestions?

<snip>
> > +static int write_home_dir_context(FILE * out, list_t * tpl, char *user,
> > +				  char *seuser, char *home, char *prefix)
> > +{
> > +	char *temp;
> > +	char *line;
> > +
> > +	fprintf(out, "\n\n#\n# Home Context for user %s\n#\n\n", user);
> > +	for (; tpl; tpl = tpl->next) {
> > +		temp = semanage_sed(tpl->data, "HOME_DIR", home);
> 
> Wow - I understand that this string handling in C is painful, but is
> this really the best alternative? Perhaps parsing the input to make the
> substitution easier would be better? Perhaps we should look for some
> library code to do this?
I am not really sure what the problem with this is.  We need to replace
arbitrary substrings.  I searched in the C libraries for something that
might do what I want.  I couldn't find anything, so I wrote a function
to do it.

As for parsing the input to make the substitution easier, I think it
would be a lot more work to write or use a full fledged parser.  What
we want in this situation is what I wrote in my opinion, although I am
open to suggestions.

<snip>
> > +static int fwriteoutput(state_t * s, FILE * out)
> > +{
> 
> This function name should be more descriptive.
Suggestions?

<snip>
> > +	for (h = homedirs; h; h = h->next) {
> > +		s1len = strlen(h->data);
> > +		temp = malloc(s1len + sizeof("/[^/]*"));
> > +		strcpy(temp, h->data);
> > +		strcpy(temp + s1len, "/[^/]*");
> 
> strdup
I needed extra space at the end of the string for the suffix, so I malloc'd
it all in one go.

<snip>
> > +char *semanage_findval(char *file, char *var, char *delim)
> > +{
> > +	FILE *fd;
> > +
> > +	char *buff;
> > +	char *temp = NULL;
> > +
> > +	if (!file || !var || !delim)
> > +		return NULL;
> 
> assert?
As with other things, genhomedircon would not have aborted on this
condition.  It returned "" on all exceptional paths.

<snip>
> > +char *semanage_split(char *str, char *delim)
> > +{
> > +	char *temp = str;
> > +
> > +	if (!str)
> > +		return NULL;
> > +	if (!delim || (*delim == '\0'))
> > +		return semanage_split_on_space(str);
> 
> Having NULL mean space seems odd.
This function was a python emulation function.  It behaves in the manner
that python's split would if you don't pass in a delimiter.

Consider all unmentioned comments Noted and fixed.

-mdg 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
