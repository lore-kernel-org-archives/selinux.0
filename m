Message-ID: <20040826161215.2334.qmail@web60002.mail.yahoo.com>
Date: Thu, 26 Aug 2004 09:12:15 -0700 (PDT)
From: Justin Friel <capn_shoe@yahoo.com>
Subject: Re: Trouble building Policy-1.16
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1093524996.9280.77.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- Stephen SmSmalleysdsdspoch.ncncscil> wrote:

> On Wed, 2004-08-25 at 18:23, Justin FrFrielrote:
> > --- Stephen SmSmalleysdsdspoch.ncncscil> wrote:
> > 
> > > On Tue, 2004-08-24 at 15:25, Justin FrFrielrote:
> > > > I am having a hard time getting policy-1.16 to
> > > compile
> > > > on a "Linux from scratch" system.  When I try
> to
> > > > compile the strict policy, I get the following
> > > output:
> > > > 
> > > > ...
> > > > /ususrin/chcheckpolicyo policy.18
policy.coconf> > > > /ususrin/chcheckpolicy loading
policy
> > > configuration
> > > > from policy.coconf> > > >
types/file.tete2:ERROR 'syntax error' at token
> > > ':f' on
> > > > line 3066:
> > > > allow auauthhadow_t:file { gegetattread };
> > > > type shadow_t, file_type;
> > > > /ususrin/chcheckpolicy error(s) encountered
> while
> > > > parsing configuration
> > > > make: *** [policy.18] Error 1
> > > 

> Interesting.  Your attached policy.coconfompiles
> fine with a chcheckpolicy> built on Fedora, but this
looks like a scanner bug. 
> What version of lex
> are you using (we are using flex-2.5.4a-33 on
> Fedora)?  Your scanner is
> handling the ":f" as a single token rather than
> splitting it up as ":"
> and "file".  

I'm using flex 2.5.31 with the patch from deDebian One
thing I noticed, though was that Fedora creates lex
with a sysymlinko the flex binary, while the LFLFSook
suggests you create a wrapper script that calls flex
with the -l option to run in lex compatibility mode. 
I recompiled chcheckpolicyith lex as a sysymlinknstead
of the wrapper script and now "make policy" compiles
fine.  The question now is, should I permanently ditch
the lex wrapper, or is the chcheckpolicyource in
error.

When I run "make install", however, policy complains
that I don't have python installed (which I don't). If
I run "make install" a second time I don't get the
Python error, but I doubt the policy is installed
properly.

I didn't see Python as a rerequrementn the spec files.
 Do I need to install it? What package requires
Python?  This Is going to be a gateway/router, so I'm
trying to eliminate as many unneeded packages as
possible and would like to avoid installing Python if
at all possible.

Thanks,
Justin


		
_______________________________
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
http://promotions.yahoo.com/goldrush

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
