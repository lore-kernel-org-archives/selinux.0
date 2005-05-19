Subject: Re: targeted policy patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Serge Hallyn <serge.hallyn@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46ce702f050519081136af356@mail.gmail.com>
References: <46ce702f050519081136af356@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 19 May 2005 11:29:42 -0400
Message-Id: <1116516582.7682.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-05-19 at 10:11 -0500, Serge Hallyn wrote:
> Hi,
> 
> In order to compile the sf.net targeted policy on a gentoo system with
> the sf.net checkpolicy, I needed the following patch.  It does several
> small things, the last of which I expect is actually wrong, but at
> least gets me a compiling policy:
> 
> 1. preserves kernel.te to get its type declaration.
> 2. fixes what i assume is a type, 'rm -rf domains/misc/used' instead of unused
> 3. deletes setfiles.fc, since setfiles_exec_t is not declared in the policy
> 4. adds the unrestricted attribute to the insmod_t domain.  This stops
> a conflict with the neverallow rule for ~signal -> unconfined_t.

I'd advise using the targeted policy spec file from the Fedora Core CVS
tree instead; we only update our spec files occasionally (e.g. prior to
an updated release on nsa.gov) and they are only intended as examples.
FC4 targeted policy includes many more domains.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
