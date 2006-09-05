Subject: Re: [PATCH 0/3] range_transition revisited
From: Joshua Brindle <jbrindle@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>
In-Reply-To: <44F318A2.60100@trustedcs.com>
References: <44F318A2.60100@trustedcs.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 10:40:51 -0400
Message-Id: <1157467251.15886.31.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-28 at 11:24 -0500, Darrel Goeddel wrote:
> The kernel portion of the range_transition work has been included in the -mm
> tree and should go into 2.6.19.  I hope that I finally some userspace patches
> that are acceptable to take advantage of that kernel patch...
> 
> The first patch is just an update of the last patch posted to this list:
> http://marc.theaimsgroup.com/?l=selinux&m=115471167305358&w=2
> This is just an update to the latest svn tree - no logic changes.  I separated
> this out because it seemed that everyone was good with this code.
> 
> The second patch addresses the question "Is an mls_range_t semantic enough for
> use in modules?".  Unfortunately, the answer was no.
> 
> The third patch used the new semantic MLS representation for storing user's MLS
> data in modules.  This format will allow users in MLS modules in the future.
> 
> Note that these patches are intended to go together.  There are two new ideas
> put into the modular policy version, but the number is only bumped once.  Once
> again, I think that the policy formats are ready to go and should support
> everything we could ever possibly want in the future (well a few things anyway).
> 
> As before, this patch only addresses the necessary format changes to get modular
> support for range_transition statements (and now users).  However, it does allow
> immediate use of the extended range_transition statements where they were valid
> before.
> 

Thanks, merged as of checkpolicy 1.30.11 and libsepol 1.12.26 with
changes to patch 2 for endieness correctness.

I'd like to see some unit tests for the linker and expander portions of
this when you get a chance..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
