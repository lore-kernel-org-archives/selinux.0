Subject: Re: su problems again
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1202221519.2801.201.camel@bluejay.goodinassociates.com>
References: <1202151733.2801.116.camel@bluejay.goodinassociates.com>
	 <1202152318.3070.121.camel@moss-spartans.epoch.ncsc.mil>
	 <1202154013.2801.119.camel@bluejay.goodinassociates.com>
	 <1202155858.3070.127.camel@moss-spartans.epoch.ncsc.mil>
	 <1202156505.2801.122.camel@bluejay.goodinassociates.com>
	 <1202156860.3070.132.camel@moss-spartans.epoch.ncsc.mil>
	 <1202157694.2801.128.camel@bluejay.goodinassociates.com>
	 <1202158361.3070.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1202221519.2801.201.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 09:27:42 -0500
Message-Id: <1202221662.27371.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-05 at 08:25 -0600, Jeremiah Jahn wrote:
> Would it be worthwhile to submit a patch against the Rules.modular that
> disables the dontaudits? Seems like a simple and useful patch without
> requiring a whole new tool chain.

Seems useful to me.  Although it would be very nice if semodule -DB
support could get back ported into a RHEL 5 update...

> -jj- 
> 
> On Mon, 2008-02-04 at 15:52 -0500, Stephen Smalley wrote:
> > On Mon, 2008-02-04 at 14:41 -0600, Jeremiah Jahn wrote:
> > > Any idea what this is about?
> > > 
> > > policy/modules/system/mount.te:18:ERROR 'syntax error' at token
> > > 'typeattribute' on line 844559:
> > > 
> > > This is the third one I've gotten. I got the same error for mono and
> > > monop. This is why I didn't just change the build.conf file. I seem to
> > > be able to move on to the next on if I set this back to module instead
> > > of base, but this seems to not seem right to me. 
> > 
> > Yes, sounds like a bug in the policy.  Surrounding context from that
> > line might be useful, although I'm sure Chris can reproduce easily
> > enough just by trying a build that puts everything into base.
> > 
> Paradise is exactly like where you are right now ... only much, much
> better. -- Laurie Anderson
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
