Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBAFT3wp012947
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2007 10:29:03 -0500
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBAFT1M9003203
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2007 15:29:02 GMT
Received: by nf-out-0910.google.com with SMTP id k4so1253476nfd
        for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2007 07:29:01 -0800 (PST)
Message-ID: <cadfc0e40712100729t633a31ebwc15fa7fbb592df24@mail.gmail.com>
Date: Mon, 10 Dec 2007 09:29:00 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: Re: system_u:system_r:system_chkpwd_t:UNCLASSIFIED, how did I get here?
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
In-Reply-To: <1197298556.18120.53.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <475ACE83.30609@gmail.com>
	 <1197298556.18120.53.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 sudo /usr/sbin/semanage login -l

Login Name                SELinux User              MLS/MCS Range

__default__               system_u                  UNCLASSIFIED
root                      root                      UNCLASSIFIED-SystemHigh
system_u                  system_u                  UNCLASSIFIED-SystemHigh

So I did:
sudo /usr/sbin/semanage login -m -s "user_u" __default__

and now life is good
id -Z
user_u:user_r:user_t:UNCLASSIFIED

Dan, I'd think that the policy spec file should probably do this for
mls as it does similar a thing to set the default login user for
targeted.


On Dec 10, 2007 8:55 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Sat, 2007-12-08 at 11:04 -0600, Ted X Toth wrote:
> > I'm running F8 with MLS reference policy (in permissive right now) and
> > I'm trying to understand how I get into this context. I can understand
> > how at some point while authenticating a transition to
> > system_u:system_r:system_chkpwd_t would occur by virtue of running
> > unix_chkpwd but then why wouldn't a transition to user_u:user_r:<*>_t
> > happen? Also I'd like to understand how policy for pam, since it's a
> > bunch of shared libraries, works. Are there any good sources of
> > information on writing policy for shared libraries?
>
> getdefaultcon in libselinux/utils can help you with investigating what
> context will be returned for a given user and from-context (i.e. context
> of the login process).
>
> First question is why is the user being mapped to system_u?  Bad seusers
> configuration?  semanage login -l
>
> As for chkpwd, get_ordered_context_list() first asks the kernel for the
> full set of reachable contexts for the user via security_compute_user(),
> which merely checks process transition permission.  Thus, the chkpwd
> context is included in that set since it is reachable (since the login
> process does in fact transition to it when executing unix_chkpwd).  But
> it normally gets pruned from the final list based
> on /etc/selinux/$SELINUXTYPE/contexts/default_contexts.  However, if no
> matches are found there, it will return the original list from the
> kernel, and thus you could end up there (in permissive mode).  There has
> been some talk of overhauling get_ordered_context_list.
>
> With regard to pam, there are no domain transitions on function calls,
> only on execve, so there are no domain transitions when invoking pam
> modules, only when those modules invoke helper programs like
> unix_chkpwd.  The pam modules themselves run within the domain of the
> caller.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
