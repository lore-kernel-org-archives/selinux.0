Subject: Re: Migrating older SELinux policies to new Linux releases
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Kim Lawson-Jenkins <lawson@itd.nrl.navy.mil>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1186580710.6916.85.camel@moss-spartans.epoch.ncsc.mil>
References: <001b01c7d9bc$9d227a70$c301000a@PC05>
	 <1186580710.6916.85.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=iso-8859-7
Date: Wed, 08 Aug 2007 09:54:23 -0400
Message-Id: <1186581263.18881.42.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-08 at 09:45 -0400, Stephen Smalley wrote:
> On Wed, 2007-08-08 at 08:04 -0500, Kim Lawson-Jenkins wrote:
> >  
> > 
> > I¢m migrating application software from Fedora Core 3 to RHEL5.  The
> > SELinux strict policy was used for Fedora Core 3 and as a first step I
> > only want to migrate the existing policy to RHEL5.  (Later I plan to
> > make changes to the policy using the newer SELinux development
> > tools.)  I¢ve seen several books and whitepapers that discuss
> > generating new policies using the current SELinux tools but I have
> > seen no whitepapers, examples, or guidelines on how to, say, migrate
> > older strict policies to the new reference policy.  Are there any such
> > guidelines or suggestions documented somewhere?
> 
> I'm not aware of anything specific, although there is certainly
> documentation of the refpolicy
> (http://oss.tresys.com/projects/refpolicy/wiki/Documentation) and the
> SELinux by Example book provides examples of writing both kinds of
> policies.  Looking at an example .te file from the refpolicy is always
> helpful too.  SLIDE is an Eclipse plugin for working with refpolicy if
> you like that sort of thing.
> 
> I was thinking that there was a mapping from example policy macros to
> refpolicy interfaces at one time, but I don't see it now.

Its still in the repository:

http://oss.tresys.com/projects/refpolicy/browser/docs/macro_conversion_guide

It was updated a year ago, so it may be a little out of date.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
