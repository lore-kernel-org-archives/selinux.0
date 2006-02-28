Subject: Re: Context translation and MLS categories
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Chad Hanson <chanson@TrustedCS.com>, joe@nall.com,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <SELinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <44047455.4010601@cornell.edu>
References: <4403E1A0.8030704@cornell.edu>
	 <1141132115.22297.158.camel@moss-spartans.epoch.ncsc.mil>
	 <44047455.4010601@cornell.edu>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 11:32:02 -0500
Message-Id: <1141144322.22297.267.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-28 at 11:03 -0500, Ivan Gyurdiev wrote:
> Should I be exporting APIs from libsetrans... or from libselinux using 
> libsetrans?

At present, libselinux wraps and exports the libsetrans APIs for context
translation since it has to dlopen it and determine whether translations
are enabled during initialization anyway and libsetrans didn't have a
public API last I looked.  Not sure whether we ultimately want a
separate public libsetrans API called directly by applications.  In the
latter case, there is a potential for mismatches, e.g. application uses
one libsetrans while libselinux uses another.

> Translation aside, this is a list of pairs from an enforcement 
> perspective, is it not?
>
> Maybe I'm confused about this, I haven't looked at MLS in detail yet...

No, not necessarily.  The kernel and libsepol logic is fairly
straightforward, but more elaborate rules end up being applied by
certain kinds of security-aware applications.

> How do I tell if s0:c0,c1,c3,c7 is translated as a whole or a list of 
> parts.

You have to assume as a whole at all times, IMHO.

>  If it's translated as a list of parts, which libsetrans later 
> concats using some kind of separator (but are logically independent), I 
> want to know what those parts are, and I want them each on a separate 
> like in nautilus. If it's interpreted as a whole, then I only want the 
> final result. How can I tell? Should I be editing the resultant string?

I think you just need to treat it as a single blob and only deal with
the final result.  No editing in the application.

> What do I present to the user if they want their file accessible by 
> s0:c0, and s0:c3, but not the other two.

It doesn't work that way - it isn't an ACL.  s0:c0,c3 means that the
file can only be accessed by processes with both c0 and c3 in its
low/sensitivity level (or high/clearance level in the MCS case).  Adding
a category to a file further restricts who can access it - it isn't
additive.

> Also, it seems like the translation is possibly non-unique. If there are 
> translation strings for s0:c0,c1, and s0:c3,c7, why are those overridden 
> to give precedence to s0:c0,c1,c3,c7. What kind of sorting is applied to 
> setrans.conf? Does this make sense in the nautilus case?

I don't know what libsetrans does now, but trying to do partial matches
is likely to produce problems.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
