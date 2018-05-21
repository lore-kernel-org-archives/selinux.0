MIME-Version: 1.0
In-Reply-To: <20180514141911.GA61110@baraddur.perfinion.com>
References: <1526129620.28749.19.camel@cepl.eu>
 <CAJfZ7==pQDfffb8zW47YUYbzm0Lxqbi_F89K2wjVzL6BntcQvA@mail.gmail.com>
 <b72c36a6-f10d-a4af-bacf-2844faf843cd@tycho.nsa.gov>
 <20180514141911.GA61110@baraddur.perfinion.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Mon, 21 May 2018 22:25:18 +0200
Message-ID: <CAJfZ7=mF2+WSLwY5+ETLrD_nEeEm7FOPBAfi=ZHo9Q=y5Jdw0g@mail.gmail.com>
To: Jason Zaman <jason@perfinion.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>,
 selinux-devel@alioth-lists.debian.net, selinux@lists.fedoraproject.org,
 selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Packaging policycoreutils for OpenSUSE
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 14, 2018 at 4:19 PM, Jason Zaman <jason@perfinion.com> wrote:
> On Mon, May 14, 2018 at 09:30:41AM -0400, Stephen Smalley wrote:
>> On 05/13/2018 07:43 AM, Nicolas Iooss wrote:
>> > On Sat, May 12, 2018 at 2:53 PM, Matěj Cepl <mcepl@cepl.eu> wrote:
>> >> Hi,
>> >>
>> >> I am changing jobs (Red Hat -> SUSE; R&D, but not a security
>> >> related job), and although I will be switching my workstation to
>> >> OpenSUSE, I would love to keep SELinux working. Which meant I had
>> >> to dig into the current situation of SELinux and it is … not
>> >> good. So, I started to repackage all SELinux packages 2.7 for
>> >> OpenSUSE in my home build area
>> >> https://build.opensuse.org/project/show/home:mcepl:SELinux
>> >> . So,far I have packaged successfully packages for libselinux,
>> >> libselinux-bindings, checkpolicy, libsemanage, libsepol, and
>> >> python-semanage. Mostly I use original OpenSUSE packages for 2.6,
>> >> but if needed I seek inspiration in Fedora packages.
>> >>
>> >> Unfortunately, I have trouble to package policycoreutils. First
>> >> of all, I don’t understand what’s the difference between two
>> >> upstream tarballs for it:
>> >> https://github.com/SELinuxProject/selinux/archive/policycoreutils
>> >> -2.7.tar.gz
>> >> (linked from https://github.com/SELinuxProject/selinux/releases)
>> >> and
>> >> https://raw.githubusercontent.com/wiki/SELinuxProject/selinux/fil
>> >> es/releases/20170804/policycoreutils-2.7.tar.gz
>> >> (linked from
>> >> https://github.com/SELinuxProject/selinux/wiki/Releases). What’s
>> >> the point of confusing users with two different tarballs of the
>> >> same name?
>> >>
>> >> Second, I don’t understand the behavior of the installation
>> >> scripts. Looking at https://is.gd/MivaE1 , why in the world that
>> >> installation scripts tons of stuff which is not part of
>> >> policycoreutils? Could anybody help me to get through this
>> >> obstacle, please?
>> >>
>> >> Thank you for any suggestions,
>> >>
>> >> Matěj
>> >
>> > Hi,
>> > After we have discussed about it on IRC (#selinux on freenode), I have
>> > performed some tests on Github to better understand how its "Releases
>> > page" work. The main issue here is that Github shows tags of the git
>> > repository in the Releases page
>> > (https://github.com/SELinuxProject/selinux/releases) and there is no
>> > way to disabled this behavior. This has several consequences:
>> >
>> > * Each tarball in https://github.com/SELinuxProject/selinux/releases
>> > contains the full tree of the project (which is why "that installation
>> > scripts tons of stuff which is not part of policycoreutils"), whereas
>> > the tarballs in the wiki page are created by properly splitting the
>> > subdirectories.
>> > * It is not possible to delete what is currently in Github's release
>> > page without deleting the tags.
>> > * It is possible to "upgrade" a tag to a release by adding release
>> > notes and files to them. For example
>> > https://github.com/gentilkiwi/mimikatz/releases uses this (you can see
>> > the differences between "Releases" and "Tags" pages of this project).
>> > When there are releases like this, it is possible to remove them all
>> > (for example using
>> > https://github.com/stevemao/github-remove-all-releases), which
>> > transforms the release page back to a list of tags (I have tested this
>> > today on a test repository).
>> >
>> > Moreover it seems that the Releases page can not be disabled (if it
>> > can, I have not found how).
>> >
>> > If my analysis of Github's release system is correct, would it make
>> > sense to change the way the releases are currently tagged to only
>> > create one tag (like "selinux-2.8-rc3") instead of creating one tag
>> > per sub-project? Would this break some tools? (If distribution
>> > packagers use tools to automatically detect when a new release is
>> > available, would such a change break these tools?)
>>
>> Not speaking for the distributions obviously, but I have no objection to dropping
>> the per-component tags if they aren't being used and are causing confusion.
>>
>> A bit of historical context: originally, we released the selinux userspace as a single
>> tarball with a single date-based version.  When SELinux was first being integrated into Fedora,
>> the Fedora packagers wanted releases to be split into separate source tarballs for each component each
>> with its own independent version, so this was done for formal releases but the source continued to live
>> in a single source code repository. (This all predates the move to GitHub, of course).
>> The individual component versioning has limited utility in my view given that there is almost always
>> at least one source level change to every component between any two releases and there tends to be
>> a strong coupling among many of the components.
>>
>> In the past, we have considered either going back to a single source tarball with a single version,
>> or splitting the source code repository itself to be per-component.  Either approach would allow direct
>> use of the github releases as the official release mechanism and avoid the need to separately create
>> and maintain the release tarballs on the wiki pages.
>
> I'd rather not rely on the github automatic releases, they have been
> known to change over time randomly. Especially for security sensitive
> stuff, its better to have the tarballs generated with the sha sums like
> they are now.
>
> Having many tags or one doesnt make a huge difference but I dont see any
> reason to change either so *shrug*. perhaps we could just put a small
> note in the github releases part that links to the wiki page for that
> specific release and a note to not use the github tarballs.
>
> -- Jason

I agree I prefer not to rely on Github automatic releases, because the
associated tarball seems like being generated by git and can be
modified if Github's toolchain changes (I have already experienced
issues with "commit.patch" files like [1] which changed because git
added a hexdigit to the "index ..." line, in another project).

Nevertheless it is possible to create a "Github release" and to attach
binary files to it, with their SHA sums in the release text. I have
written a PoC on my repository, by copying the text of the wiki page
and by adding some tarballs [2]. This would also have the advantage of
not hosting the release tarballs in the wiki git repository [3], which
is quite huge (180.92 MiB).

Anyway, I am fine with either migrating to "create only one tag per
release, continue to create several tarballs, and use the Github
release page to host these tarballs with their sums", or continuing
what we are currently doing and creating a "stub" Github release which
tells to look at the wiki to download the releases.

Nicolas

[1] https://github.com/SELinuxProject/selinux/commit/f1735ebbec97773b8716f53a47b1fbeed9c0c98d.patch
[2] https://github.com/fishilico/selinux/releases/tag/selinux-2.8-rc3
[3] git clone https://github.com/SELinuxProject/selinux.wiki.git
