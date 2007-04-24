Subject: Re: [Fwd: restorecon single fs patch]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1175541324.5889.84.camel@moss-spartans.epoch.ncsc.mil>
References: <46115278.4020401@redhat.com>
	 <1175541324.5889.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 16:33:13 -0400
Message-Id: <1177446793.24282.199.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-02 at 15:15 -0400, Stephen Smalley wrote:
> On Mon, 2007-04-02 at 14:59 -0400, Daniel J Walsh wrote:
> > Patch to tell restorecon to only do one file system.
> 
> Observations:
> - This is yet another reason to coalesce setfiles and restorecon, as
> setfiles already stops on filesystem boundaries.
> - Here you introduce -l as meaning "limit to one filesystem" for
> restorecon, but -l means log to setfiles and to the fixfiles script
> front-end.  Seems prone to user confusion/conflict (think of what
> happens if I want to pass this option through fixfiles to restorecon)
> and it will get worse when/if we merge setfiles and restorecon together
> if we don't fix it now.
> 
> How hard would it be to just fold restorecon and setfiles into a single
> binary, and have them only differ in the default interfaces and
> behaviors they provide (based on their argv[0] value), and try to use a
> single standard set of options to the degree we can without breaking
> widely used ones?

FYI, I have work in progress to collapse all restorecon functionality
into setfiles and make it offer either user interface and default
behavior depending on how it is invoked.

Also, I don't object to having an option to the restorecon user
interface to only do one filesystem, but it should use an option other
than -l since that is already being used by both setfiles and fixfiles
to signify logging.  I'd also like to revisit the current options and
see whether we actually need/want them all - there seem to be multiple
ways of doing the same thing, just with slight variances.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
