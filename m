Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3RM4eCJ026676
 for <selinux@tycho.nsa.gov>; Thu, 27 Apr 2017 18:04:40 -0400
Received: by mail-vk0-f66.google.com with SMTP id e15so3279474vkd.1
 for <selinux@tycho.nsa.gov>; Thu, 27 Apr 2017 15:04:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493299166.2524.5.camel@tycho.nsa.gov>
References: <20170420153130.8992-1-sds@tycho.nsa.gov>
 <CAHC9VhRKjNywMFAa5USpPzy1EttiPVx9XyfH4t5EvGY6WDWE3A@mail.gmail.com>
 <1493299166.2524.5.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Apr 2017 18:04:24 -0400
Message-ID: <CAHC9VhS5qwKjBQEMsAfV=VV54DpqRGvxaSnmtd-ZZikdKA7_zg@mail.gmail.com>
Subject: Re: [PATCH] selinux: only invoke capabilities and selinux for
 CAP_MAC_ADMIN checks
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, casey@schaufler-ca.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 27, 2017 at 9:19 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-04-26 at 17:36 -0400, Paul Moore wrote:
>> On Thu, Apr 20, 2017 at 11:31 AM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
>> > SELinux uses CAP_MAC_ADMIN to control the ability to get or set a
>> > raw,
>> > uninterpreted security context unknown to the currently loaded
>> > security
>> > policy. When performing these checks, we only want to perform a
>> > base
>> > capabilities check and a SELinux permission check.  If any other
>> > modules that implement a capable hook are stacked with SELinux, we
>> > do
>> > not want to require them to also have to authorize CAP_MAC_ADMIN,
>> > since it may have different implications for their security model.
>> > Rework the CAP_MAC_ADMIN checks within SELinux to only invoke the
>> > capabilities module and the SELinux permission checking.
>> >
>> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> > ---
>> >  security/selinux/hooks.c | 23 +++++++++++++++--------
>> >  1 file changed, 15 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> > index e67a526..1aef63c 100644
>> > --- a/security/selinux/hooks.c
>> > +++ b/security/selinux/hooks.c
>> > @@ -3107,6 +3107,18 @@ static int
>> > selinux_inode_setotherxattr(struct dentry *dentry, const char
>> > *name)
>> >         return dentry_has_perm(cred, dentry, FILE__SETATTR);
>> >  }
>> >
>> > +static bool has_cap_mac_admin(bool audit)
>> > +{
>> > +       const struct cred *cred = current_cred();
>> > +       int cap_audit = audit ? SECURITY_CAP_AUDIT :
>> > SECURITY_CAP_NOAUDIT;
>> > +
>> > +       if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN,
>> > cap_audit))
>> > +               return false;
>> > +       if (cred_has_capability(cred, CAP_MAC_ADMIN, cap_audit,
>> > true))
>> > +               return false;
>> > +       return true;
>> > +}
>>
>> Granted, I'm being nitpicky here, but that is one awful function name
>> IMHO.  What's wrong with current_cap_mac_admin()?
>
> Maybe it's just me, but has_cap_mac_admin() seems better to me. It
> reads correctly as English and fits its boolean nature.

I've never bought into the function names as English-phrases argument.
I actively dislike it to be honest.

> We don't call any other permission checking function current_*().

You assume I like the way they are currently names ;)

> has_cap_mac_admin() is also shorter.  Remember that you only get so
> many keystrokes in this life ;)

I'd rather use them on meaningful names than rubbish ones ;)

Joking aside, like I said earlier, it's fine - don't respin - I just
wanted to go on record that it is an awful function name.

>> Unless you're really bored don't worry about a respin, the rest of
>> the
>> patch looks fine to me, I'll queue it up for after the next merge
>> window.

-- 
paul moore
www.paul-moore.com
