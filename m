Date: Fri, 18 Mar 2005 23:00:15 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: concerns about object-inheritance wrt files/directories
Message-ID: <20050318230015.GK8040@lkcl.net>
References: <20050316135008.GA24000@lkcl.net> <1110980748.4802.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1110980748.4802.61.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 16, 2005 at 08:45:48AM -0500, Stephen Smalley wrote:
> On Wed, 2005-03-16 at 13:50 +0000, Luke Kenneth Casson Leighton wrote:
> >  for file types, i have a major concern.
> > 
> >  if not careful, we are going to be getting into the "multiple file
> >  types" thing again, which it has already been discussed that, whilst
> >  doable, has some hair-raising implications that make it too complex to
> >  a) understand for implementation purposes b) understand the resultant
> >  policy.
> 
> No, I think you misunderstood.  The objection to multiple contexts on
> files is that you can't analyze the resulting policy without pulling in
> the entire filesystem state, and a modification to the filesystem state
> at any time can change the policy.  

 sorry, yes: i remember the objection but not the details.

 i remember that we disagreed over the conclusion because i
 could see that what you were proposing and what i was proposing
 were topologically equivalent (as best i could make out),
 such that one of us _had_ to be wrong :)

 hence my warnings that kaigai's scheme could also be another
 [topologically equivalent] scheme where filetypes could also
 get into trouble - or not - depending on whose conclusion is
 correct.

 i be watching the discussions with beady-eyed interest -
 without comment unless invited - to see what happens.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
