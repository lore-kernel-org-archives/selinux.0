Date: Wed, 14 Oct 2015 22:34:19 +0200
From: Dominick Grift <dac.override@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151014203418.GA7159@x250>
References: <20151014142952.GC5222@x250> <561E7840.50903@tycho.nsa.gov>
 <20151014154828.GA2909@x250> <561E7D47.7090306@tycho.nsa.gov>
 <20151014164145.GA11363@x250> <561E8872.3090404@tycho.nsa.gov>
 <20151014173416.GA15883@x250> <20151014173839.GB15883@x250>
 <561E937A.9080909@tycho.nsa.gov> <561EBB6A.1080907@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <561EBB6A.1080907@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Oct 14, 2015 at 04:30:34PM -0400, Christopher J. PeBenito wrote:
> On 10/14/2015 1:40 PM, Stephen Smalley wrote:
> > On 10/14/2015 01:38 PM, Dominick Grift wrote:
> >> On Wed, Oct 14, 2015 at 07:34:16PM +0200, Dominick Grift wrote:
> >>
> >>> Setools(4) doesnt work with my policy (it can't deal with cil namespaces
> >>> seemingly, and returns non-sense)
> 
> Dominick, would you mind sending me your policy off-list so I can debug
> this?

its public:

https://github.com/DefenSec/dssp

how to use it:

https://github.com/defensec/dssp/wiki

> 
> >> Besides. did you know that setools (4) does not use
> >> /sys/fs/selinux/policy? It uses /etc/selinux/SELINUXTYPE/policy/policy.X
> >> instead. This sounded to me like a bad idea. Mainly because you don't
> >> know if the /etc/selinux/SELINUXTYPE/policy/policy.X is the policy that
> >> is currently actually loaded into the system.
> > 
> > It should use selinux_current_policy_path() to find the policy.
> 
> It does use it, but as a fallback. I've since changed the code to try
> the selinux_current_policy_path() first.
> 
> 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWHrxFAAoJENAR6kfG5xmcwJUMAIo7kMjstv+yIupVzl2ZW+bK
AxuSEmmr9R2hF8hGb5pxdoFlimnwosUHFb00I31vrkQNZ1gaC8s7OG/FzELzFrfi
bCt5Ub5lhl0QWY38YStF3UWaP1DyqL90SNezDWS5fY+grEbjadxyGe8fuBzYOz57
KRWO5HpoGqN7i5O7OZ2VaqiU4t4MehYkCUj//dYdMbiVvDvgo2wFVMf9CYCZ5UTb
PxOE3TyX/rbLHXEFIVBdEEWw9AhS+zIYSFS1nVfh69xzoefLTUZ0cbcYaixhBBKA
deRK1pN6jauAXz1KUimhqo7/qGzD5MYKtvG0wCmBGaoibOVW8dNE0aQRkZ5xPsQZ
Y5fa4IklzIAzw2pLhuHdhgJsL96AqyU3fykmM+07k5mD5kQgD737XFAzQ4VUa7tI
ixaoK8/Gh8oTl4tGEL0DuSQBr9y2biP5/Z3RKrSzoJZIW5JavBozoYgXJTFXKiGQ
UcabVk6VoHlLre3wgK/M3SitytrqMZKN4nbQv4w7xg==
=qa39
-----END PGP SIGNATURE-----
