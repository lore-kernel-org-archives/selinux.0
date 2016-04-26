Subject: Re: trying to understand a cronie issue anno 2008
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov,
 Daniel J Walsh <dwalsh@redhat.com>
References: <017f000a-3ecc-1e01-514f-a6106cfca8b9@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <571F6A25.6050802@tycho.nsa.gov>
Date: Tue, 26 Apr 2016 09:16:21 -0400
MIME-Version: 1.0
In-Reply-To: <017f000a-3ecc-1e01-514f-a6106cfca8b9@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/26/2016 07:28 AM, Dominick Grift wrote:
> 
> I am trying to understand an issue
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=426704#c20
> 
> "Suggestion:  load_user() to pass NULL if pw is NULL, and change
> get_security_context() to handle a NULL name by directly calling
> get_default_context() on "system_u" rather than calling
> getseuserbyname at all. Then we don't need a system_u entry in seusers."
> 
> Is the suggestion above about hard coding "system_u"?

No, it is about skipping the getseuserbyname() call when dealing with
system cron jobs.  "system_u" was already hardcoded as the lookup key
for determining the context of system cron jobs.
https://bugzilla.redhat.com/show_bug.cgi?id=426704#c19 explained the
background.

> 
> Also about:
> 
> "Then we don't need a system_u entry in seusers."
> 
> We seem to have the above anyway, even with the system_u hard coded.
> Wondering whether it was left in for some other reason?

Not that I know of.

> Cronie refuses to run in an environment where system_u is not
> available when system_u is hard coded like that (i believe):
> 
> https://git.fedorahosted.org/cgit/cronie.git/commit/?id=e5280235809844f5
> 4d5956ec281472b63dcfc3f4

There are two different issues here:

1) Requiring system_u to be mapped in the seusers configuration, which
maps Linux usernames to SELinux users (and ranges).  This was what the
above bug was about.  We shouldn't require a system_u entry in seusers
because it isn't a Linux username.  It was a bug in vixie-cron that it
was performing a getseuserbyname() call on "system_u"; it should have
only done a get_default_context() on it (as in the original SELinux cron
patch, before seusers was introduced).

2) Requiring the system_u user to be defined in the users portion of the
SELinux kernel policy.  That was always required by the cron SELinux
patch in order to look up the context for system cron jobs.  The commit
you reference above appears to eliminate that as well, which is good, as
long as it yields the right behavior.  One question I have is what
happens if one restarts cronie manually; historically there have been
issues with the correct user identity being assigned but that is
probably no longer an issue with systemd.
