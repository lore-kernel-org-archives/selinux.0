Subject: Re: [ SEPOL ] Mls cleanups (2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <43799085.4000608@cornell.edu>
References: <437931EA.8080605@cornell.edu>  <43799085.4000608@cornell.edu>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 08:26:07 -0500
Message-Id: <1132061167.5415.342.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 02:38 -0500, Ivan Gyurdiev wrote:
> >
> > - Hide functions mls_to_string and mls_from string into internal 
> > header, since they have no user in the static lib. I introduced those 
> > functions, and we should not be adding any functions to the static lib 
> > - we should be removing them.
> > - Hide functions mls_sid_to_context, mls_context_to_sid, and 
> > mls_compute_context_len in the internal header, since they have no 
> > user in the static lib *and* are deprecated (though I still use them 
> > in a few places)
> On second thought, this whole header is not used outside of libsepol (no 
> in-tree users).
> Move the rest of it into src/mls.h. Applies on top of the other patch.

Thanks, both merged as of libsepol 1.9.40.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
