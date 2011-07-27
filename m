Message-ID: <4E302662.4030300@tresys.com>
Date: Wed, 27 Jul 2011 10:53:22 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Bumping Version Numbers
References: <4E2EDD81.8080608@tresys.com> <1311702695.27231.91.camel@moss-pluto>
In-Reply-To: <1311702695.27231.91.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/26/2011 01:51 PM, Stephen Smalley wrote:
> On Tue, 2011-07-26 at 11:30 -0400, Steve Lawrence wrote:
>> A while ago ago we discussed bumping the minor version number and
>> resetting the revision version number when we do a release [1]. We are
>> now preparing for a release and wanted some feedback before we bumped
>> the version numbers.
>>
>> We're thinking of only bumping minor version numbers if the revision
>> version number is non-zero.
>>
>> So the version numbers will become:
>>
>> checkpolicy-2.1.0
>> libselinux-2.1.0
>> libsepol-2.1.0
>> libsemanage-2.1.0
>> policycoreutils-2.1.0
>> sepolgen-1.1.0
>>
>> We could alternatively always bump minor version numbers even if the
>> revision number was zero (i.e. no changes since the last release). This
>> has the advantange that all releases share the same version number. If
>> we do that, it might make sense to bump sepolgen to 2.1.0 this release
>> as well, unless there is some significance between 1.x and 2.x with
>> sepolgen.
>>
>> Thoughts?
> 
> The latter approach is akin to what we used to do when we released the
> entire SELinux userspace as a single tarball with a single (date-based)
> version.  The separate versions were introduced when we started
> releasing each component individually in support of distribution
> packaging (originally for Fedora).  As long as the distributions
> continue to package them separately, I doubt they want a single version
> number across them all, as that obscures when a change has occurred to
> the individual component and likely will yield unnecessary updates.
> Ideally you shouldn't even generate a new tarball if there are no
> changes since the last release as that will break checking that their
> package sources are pristine.
> 
> sepolgen was first introduced when the other components were bumped to
> 2.x.  It isn't packaged separately in Fedora (bundled into
> policycoreutils-python), although it is packaged separately in Debian
> and Ubuntu.  If you want to bump it to 2.1.0 for this release just so
> that they are all in the 2.x series, I don't really care (and nothing
> should break), but it doesn't need to be the same as the others.
> 
> One thing that we aren't doing that would be useful would be to
> introduce a version script (.map file) for libselinux and maintain it to
> ensure proper interface compatibility.  Also to be better about managing
> the libsepol and libsemanage .map files, introducing new version nodes
> when we add new interfaces.
> 

Ok, sounds like the first option is the best choice. When we do
releases, we'll bump the minor number and reset the revision number, but
only if there have been changes since the last release (ie. the revision
number is non-zero).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
