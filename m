Subject: Re: [ SEPOL ] Another debugging system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <434BD63B.7020003@cornell.edu>
References: <434B62B8.4080309@cornell.edu>  <434B7FF2.2090306@cornell.edu>
	 <1129041930.3308.137.camel@moss-spartans.epoch.ncsc.mil>
	 <434BD63B.7020003@cornell.edu>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 11:15:25 -0400
Message-Id: <1129043725.3308.157.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-11 at 11:11 -0400, Ivan Gyurdiev wrote:
> I'm confused - what's the difference between an "old" interface that has 
> a corresponding "new" interface... and an obsoleted interface. Seems 
> like the same thing to me. Yes, we'll need need to preserve 
> compatibility until all users are fixed, and then we can get rid of the 
> old interfaces..right?

No, we should provide ABI stability, as discussed in section 3 of
http://people.redhat.com/drepper/dsohowto.pdf

Updated users can be limited to the new interfaces, but old binaries
should continue to work even with the new libsepol, i.e. the libsepol
DSO must continue to provide versions of those interfaces that are
consistent with its previously exported ABI.

Since some interfaces will be obsoleted by the transition to
regenerating policy on all local customizations, it won't be necessary
to provide new versions of those interfaces at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
