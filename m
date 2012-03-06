Subject: Re: SE Android and Finer Grained Permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: noloader@gmail.com
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        SE Linux
 <SELinux@tycho.nsa.gov>
In-Reply-To: <CAH8yC8nte8z4Az7C-zU3aB9U0mPJtaPWZofcpgOw8vkUQJ8J3Q@mail.gmail.com>
References: 
	 <CAH8yC8kE6fEGijSyjz4_VrqoogbrqLAsHwCXsRQH3qd52e=kVw@mail.gmail.com>
	 <4F556212.50303@schaufler-ca.com>
	 <CAH8yC8nte8z4Az7C-zU3aB9U0mPJtaPWZofcpgOw8vkUQJ8J3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Mar 2012 10:08:39 -0500
Message-ID: <1331046520.26027.53.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-03-05 at 21:39 -0500, Jeffrey Walton wrote:
> For what its worth, here's what I envision:
> 
> READ_PHONE_STATE gives the house away (confer:
> http://android-permissions.org/ and the Permission Map). As a matter
> of fact, Goolge forced the permission on *all* apps, whetehr it was
> needed or not (confer:
> http://stackoverflow.com/questions/1747178/android-permissions-phone-calls-read-phone-state-and-identity).
> 
> I want finer permissions than READ_PHONE_STATE. Perhaps
> READ_PHONE_UNIQUE_ID, READ_PHONE_IMEI, READ_PHONE_INCOMING_CALLER,
> READ_PHONE_LINE_STATE, READ_PHONE_LOG, etc. Ditto for many other
> permissions.

While SE Android may ultimately support finer grained permissions for
the application layer access controls, that isn't what we consider to be
the largest issue for the existing Android security model and thus is
not our first priority.  Privilege escalation via confused deputy and
collusion attacks and controlled sharing are the more significant
concerns.  "Towards Taming Privilege Escalation Attacks on Android" from
NDSS 2012 and "Permission Re-Delegation: Attacks and Defenses" from
Usenix Security 2011 are good background on the problems and some
previously proposed solutions.
 
> When it comes time to install an application, I can look at what
> actually is requested (not just READ_PHONE_STATE), and choose Yes or
> No. If I choose Yes, I'd like to take away permissions at a later
> time. For example, I might get suspicious and remove READ_PHONE_LOG at
> a later time.
> 
> For the Enterprise, SE Android/Management Server *should* allow one to
> do the same, but from a central console. I should be able to install
> (or deny an install), or uninstall, or yank a permission at a later
> date.

Permission revocation is already fairly easily supported on existing
Android (and I think supported in some custom builds like CyanogenMod).
But it doesn't address the issues above.

> > But, that's my well known opinion, and as such you may wish to take
> > it with a grain of salt. I will be sad to see the Android policy grow
> > with the same unbridled exuberance as the Fedora and reference policies.
> Not at all.
> 
> Unfortunately, I can't comment on policy bloat since Fedora works
> great for me out of the box as a single user (no Enterprise). Perhaps
> the policy tools are lacking. Again, I've never seen their GUIs, but
> the front end should be simple for admins and users who understand
> policy (confer: Microsoft, MMC, and Local Security Policy or GPOs).

Since we are focused on a limited set of security goals at the kernel
layer for SE Android, and since Android provides a much more constrained
environment for apps than a general purpose Linux distribution, it is
significantly easier to keep the SE Android kernel policy small and
manageable.

To the extent that we keep our focus on mitigating privilege escalation
attacks and controlled sharing for the application layer access
controls, I think we'll also be able to keep the application layer
policy small and manageable.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
