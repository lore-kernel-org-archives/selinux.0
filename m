Subject: Re: I have spit out my current diffs in policy on fedoraproject.org
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <47A33458.505@redhat.com>
References: <47A33458.505@redhat.com>
Content-Type: text/plain
Date: Fri, 01 Feb 2008 10:05:27 -0500
Message-Id: <1201878327.4568.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-01 at 10:01 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> http://people.fedoraproject.org/~dwalsh/Policy/
> 
> Patch is now up to 28000 lines.
> 
> I have it split into 147 patches.
> 
> Kernel patches should be fairly easy to merge,
> System patches other than userdomain should not be difficult.
> 
> Then we get to service/apps ...
> 
> 
> Going forward this is going to get more difficult.  I think we need more
> people with the ability to update the reference policy.  Even if they
> just cherry pick through the differences in my patches and upstream.  I
> don't believe one person can keep up with the volume of changes.

Maybe create a fedora branch of refpolicy?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
