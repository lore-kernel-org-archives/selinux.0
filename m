Subject: Re: selinux branch: new program: runcon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Jim Meyering <jim@meyering.net>, selinux@tycho.nsa.gov
In-Reply-To: <200702031233.14605.russell@coker.com.au>
References: <8764akxwqs.fsf@rho.meyering.net>
	 <200702031233.14605.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 10:21:53 -0500
Message-Id: <1170688913.12293.262.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-02-03 at 12:33 +1100, Russell Coker wrote:
> On Saturday 03 February 2007 05:03, Jim Meyering <jim@meyering.net> wrote:
> > +runcon: Russell Coker
> 
> I didn't write runcon, probably one of the NSA guys deserves credit for that.  
> But it's been hacked on by enough people that correct and detailed 
> attribution may be difficult.
> 
> It might be best to just have a section for attributing people who worked on 
> the SE Linux utilities and patches.  It'll save the effort of tracking 
> exactly who wrote what - and I doubt that anyone will be fighting about which 
> little patch should have their name on it.

IIRC, runcon was originally called "runas", and was first written by
someone from SCC, originally as a patch against the old sh-utils.
Russell ported the old fileutils and sh-utils patches over to coreutils
for Debian.  Dan Walsh ported runas (and most of the other selinux
userland patches) to use the new SELinux API in Linux 2.6, renaming it
to runcon at that time at my suggestion to make its purpose clearer.
TCS patched it to support the -c option (compute transition).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
