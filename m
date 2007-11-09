MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Effect of changing SELinux package versions...
Date: Fri, 9 Nov 2007 17:26:50 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D0420621B@de01exm68.ds.mot.com>
in-reply-to: <1194637184.624.78.camel@moss-spartans.epoch.ncsc.mil>
References: <472B817D.3030400@redhat.com> <1194625539.624.57.camel@moss-spartans.epoch.ncsc.mil> <47349353.7080203@redhat.com> <D06FE0A2807BC145B0D38744789D4F5D0420612B@de01exm68.ds.mot.com> <1194637184.624.78.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes, by "newer version of Linux", I meant a newer Linux distribution
that has newer versions of the SELinux packages in it.

Is it safe to say that the latest STABLE versions of the core userland
SELinux packages are:

libsepol-1.16.6
checkpolicy-1.34.3
libselinux-1.34.13
libsemanage-1.10.5
policycoreutils-1.34.11

Regarding the "Enforcing" mode problems, I will dig into it a bit more
and then will give you more accurate details...

Thanks,

- Rezaul. 


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Friday, November 09, 2007 1:40 PM
To: Hasan Rezaul-CHR010
Cc: Daniel J Walsh; SE Linux; Christopher J. PeBenito; Karl MacMillan;
Steve Grubb
Subject: Re: Effect of changing SELinux package versions...

On Fri, 2007-11-09 at 13:59 -0500, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> The current customized version of Linux that I have comes with certain
> versions of the SELinux libs/packages  (shown on the left column
below).
> 
> Lets just say I am being forced to move to a newer version of Linux,
> which will force me to move to the SELinux libs/packages shown below
(on
> the right column). 
 
By "newer version of Linux", do you just mean a newer kernel or a newer
distribution?  If the former, why do you think you need to move to newer
SELinux userland?  Are these just the versions of the packages that
happened to ship in a given distribution release and you're moving from
e.g. FC6 to F7?

> 
> 1.  audit 1.0.14-1            audit 1.5.3
> 2.  libselinux 1.34.7         libselinux 2.0.13
> 3.  libsemanage 1.6.17-1      libsemanage 2.0.1
> 4.  libsepol 1.16.1           libsepol 2.0.3
> 5.  libsetrans 0.1.18         libsetrans 0.1.18
> 6.  mcstrans N/A              mcstrans 0.2.5
> 7.  policycoreutils 1.34.6    policycoreutils 2.0.16
> 8.  setools 3.0-2             setools 3.2-0
> 
> 
> With the libs/package versions that I have on the left column, I am
> moderately happy  :-)  Everything generally works the way I need them
to
> in "Permissive" mode.  The only problematic behavior I have seen is
with
> the Enforcing mode, where my Linux Card just resets after ~5 minutes
for
> no reason !

Hmm...well, it would be nice to know more about that.

> I was trying to evaluate any risks/surprises of upgrading to the
> versions shown on the right. 
> 
> Would anyone be able to give me a risk/benefit/concern  assessment for
> upgrading each of the libs/packages shown above. I am trying to
> anticipate any problems I might have by going to the newer versions.

Offhand I don't see any cause for concern there, but am wondering
whether there is any particular reason for the specific versions above
(vs. the latest).  The only real issue is ensuring that you update to a
consistent snapshot of all the packages at once, as they can have
interdependencies (e.g. newer policycoreutils will often depend on new
interfaces introduced in the newer libsemanage or libselinux).

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
