Subject: Re: MCS and default labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20090908055806.GA24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 11:35:28 -0400
Message-Id: <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-09-08 at 07:58 +0200, Michal Svoboda wrote:
> Hello,
> 
> I have implemented a simple MCS based system for hosting SVN
> repositories. I was happy with the performance until I found out that
> the s0-s0:c1 processes will happily create new revisions (ie. new files)
> as s0 inside a s0:c1 directory. According to various sources, new files
> are always created using the lowest security level in the range of the
> creating process, despite an inheritance mechanism already working for
> types. What is the reasoning behind this?

This may help in understanding:
http://marc.info/?l=selinux&m=124688422726897&w=2

Understand that MCS is merely an alternative configuration of the MLS
policy engine. Under MLS, new objects are labeled with the low level of
the creating process.  In a MLS system, the process would have a low
level of s0:c1 and thus the files it creates would automatically be
labeled as such.  MCS deviates from this scheme by only using the high
level and by requiring the user/application to intentionally label the
objects as desired up to their high level - that is part of what makes
it discretionary.

Perhaps you ought to use MLS instead.  Or just use TE and define domains
and types for these processes and files.

> I tried to mitigate this by forcing a ssh session into a certain MCS
> range, as in ssh user/foo_r:foo_t:s0:c1, however this only works for
> changing roles but not for MCS. Not even setting the MCS level in
> default_contexts works as one would expect. Again, why?
>
> Running out of ideas, my solution for now is to hope that a s0 process
> cannot search / modify the s0:c1 directory, even with s0 files present
> and to periodically "restorecon" the whole dir (no, restorecond does not
> seem to be working on dirs recursively). So the third question is, are
> there any better ways?
> 
> Regards,
> Michal Svoboda
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
