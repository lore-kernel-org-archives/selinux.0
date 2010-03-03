Subject: Re: Problem with compiling refpolicy base.pp
From: Stephen Smalley <sds@tycho.nsa.gov>
To: AlannY <m@alanny.ru>
Cc: SELinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1267630096.6048.64.camel@moss-pluto.epoch.ncsc.mil>
References: <4B8E72D2.8030802@alanny.ru>
	 <1267629710.6048.63.camel@moss-pluto.epoch.ncsc.mil>
	 <1267630096.6048.64.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 03 Mar 2010 10:52:27 -0500
Message-Id: <1267631547.6048.93.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-03-03 at 10:28 -0500, Stephen Smalley wrote:
> On Wed, 2010-03-03 at 10:21 -0500, Stephen Smalley wrote:
> > On Wed, 2010-03-03 at 17:31 +0300, AlannY wrote:
> > > Hi there.
> > > 
> > > I'm trying to compile refpolicy. I have checkpolicy 2.0.20 and misc
> > > tools (libselinux policycoreutils). I'm trying to:
> > > 
> > >     make bare
> > >     make conf
> > >     make base.pp
> > > 
> > > My configuration:
> > > 
> > > TYPE=mcs
> > > NAME=refpolicy
> > > UNK_PERMS=allow
> > > DIRECT_INITRC=n
> > > MONOLITHIC=n
> > > UBAC=n
> > > MLS_CATS=1024
> > > MCS_CATS=1024
> > > 
> > > But, the last command failed with the following error:
> > > 
> > >     Creating refpolicy base module base.conf
> > >     cat tmp/pre_te_files.conf tmp/all_attrs_types.conf
> > > tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf > base.conf
> > >     Compiling refpolicy base module
> > >     /usr/bin/checkmodule -M -U allow base.conf -o tmp/base.mod
> > >     /usr/bin/checkmodule:  loading policy configuration from base.conf
> > >     base.conf:2032:ERROR 'syntax error' at token ':c0.c1023' on line 2032:
> > >     level s0:c0.c1023;
> > > 
> > > Seems to be, it's a good line (2032), but checkmodule can't eat it.
> > > 
> > > Where can be the probem?
> > 
> > Looks like a scanner problem to me.  There have been problems with some
> > versions of flex, e.g. see:
> > http://marc.info/?t=125613782400001&r=1&w=2
> > but no one has ever tracked it down precisely and I've never been able
> > to reproduce.  Modify your checkpolicy Makefile to pass -d to $(LEX) so
> > that it generates debug output and then capture the stderr of running
> > checkpolicy on base.conf.  Here I get the following output for that
> > line:
> > --accepting rule at line 55 ("
> > level s0:c0.c1023;")
> > --accepting rule at line 116 ("level")
> > --accepting rule at line 227 (" ")
> > --accepting rule at line 219 ("s0")
> > --accepting rule at line 235 (":")
> > --accepting rule at line 219 ("c0.c1023")
> > --accepting rule at line 236 (";")
> > 
> > Note that the ":" gets treated as a separate token above, as it should,
> > whereas your checkmodule seems to not be splitting it properly.
> > 
> > You can look at checkpolicy/policy_scan.l and see if anything strikes
> > you as problematic, but it looks sane to me.  Maybe it is matching on
> > ipv6_addr instead.  On second look, I'm wondering why ipv6_addr has . in
> > the pattern.  Does this help?
> > 
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 48128a8..b7b8f0a 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -219,7 +219,7 @@ PERMISSIVE			{ return(PERMISSIVE); }
> >  {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
> >  {digit}+|0x{hexval}+            { return(NUMBER); }
> >  {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
> > -{hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
> > +{hexval}{0,4}":"{hexval}{0,4}":"({hexval}|":")*  { return(IPV6_ADDR); }
> >  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
> >  #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
> >  #line[ ]{digit}+	        { source_lineno = atoi(yytext+6)-1; }
> 
> Hmm...and does the second "." in VERSION_IDENTIFIER need to be quoted or
> escaped via backslash as well?

According to prior discussion, it does not (different interpretation of
characters within []).  Which would mean that IDENTIFIER and PATH are
wrong too.  Patch below should fix all three definitions.  This needs
some wider testing - I don't think we even have nodecons by default in
refpolicy anymore.

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 48128a8..87c7278 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -215,11 +215,11 @@ policycap |
 POLICYCAP			{ return(POLICYCAP); }
 permissive |
 PERMISSIVE			{ return(PERMISSIVE); }
-"/"({alnum}|[_\.\-/])*	        { return(PATH); }
-{letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
+"/"({alnum}|[_./-])*	        { return(PATH); }
+{letter}({alnum}|[_-])*([.]?({alnum}|[_-]))*	{ return(IDENTIFIER); }
 {digit}+|0x{hexval}+            { return(NUMBER); }
 {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
-{hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
+{hexval}{0,4}":"{hexval}{0,4}":"({hexval}|":")*  { return(IPV6_ADDR); }
 {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
 #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
 #line[ ]{digit}+	        { source_lineno = atoi(yytext+6)-1; }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
