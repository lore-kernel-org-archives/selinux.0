MIME-Version: 1.0
In-Reply-To: <52FB8288.1080004@tycho.nsa.gov>
References: <CACBeRbb2fZCWgH93aJ61nfkCCZoJSG3aeaW=9ODSccVXzRQ9xg@mail.gmail.com>
 <52FB8288.1080004@tycho.nsa.gov>
Date: Mon, 10 Mar 2014 14:31:29 +0700
Message-ID: <CACBeRbY32sYaN8LWKxQ5f=6kyV6_dNgdhVkesTV07i-DRwkKrA@mail.gmail.com>
Subject: Re: Detail description of some projects in TO DO list page
From: nguyen thai <thai.bkset@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 selinux maillist <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 12, 2014 at 9:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 02/11/2014 09:24 PM, nguyen thai wrote:
>> Hi everyone,
>>
>> I have started my study in SELinux recently. I found some projects in TO DO
>> list page were really interesting. Can anyone give me more details (what's
>> problem now? it's effects or drawbacks) of one of following projects or any
>> other projects that i can start to work on?
>>  - Investigate security policy for cgroups
>>  - CIFS support for single-context clients
>>  - Real device labeling and access control
>>
>> Thank you very much.
>
> That TODO list is old and not actively maintained, so it may be better
> to look at recent mailing list archives to see areas where you can
> contribute most effectively.  Also look for recent discussions of
> selinux in the linux-security-module and linux-kernel mailing list archives.
>
> On the cgroup item, it should be possible to support finer-grained
> labeling of cgroup files now that cgroup supports xattrs, but it will
> require a small kernel change (similar to the changes previously made
> for sysfs and rootfs; need to generalize that), and thereby enabling
> policy control over specific cgroup files.  There may also be work
> required inside the cgroup code to add security hooks and permission
> checks for MAC; that would require analysis of the cgroup
> implementation, existing DAC checks, ways in which they can permit
> different security labels to interact/interfere with each other, etc.
>
>
>

Hi,
I have spent several weeks on digging into cgroup code and its problems.
As i understand, there are several reasons why you want to enable MAC
checks over specific cgroup file:

+ The cgroup interface is filesystem, means that users can change
permissions on subdirectories and
   give access to a non-privileged security domain, ie non-root users.
Leading to an individual application
   can interact directly with the cgroup filesystem. It ends up
exposing control knobs which are tightly
   coupled to kernel implementation details right into lay binaries
and scripts directly used by end users.

+ The cgroups trees are a shared resource. Many applications can use
it simultaneously. So they can
   conflicts with others. Ex, move tasks, delete or move the cgroups
that belong to  other applications.

MAC check can improve some of the cgroup problems. But I've heard that
cgroup and systemd developers have
been making really big changes to fix these cgroup problems. As they
described here
http://lists.freedesktop.org/archives/systemd-devel/2013-June/011521.html
or http://www.freedesktop.org/wiki/Software/systemd/ControlGroupInterface/
They are creating a centralized userland authority which takes full
ownership of the cgroup filesystem
interface, and makes policy decisions based on configuration and
requests. This may solve above problems.

So does implementing MAC checks on cgroup can is needed anymore? Can
it help improving some other problems?
I'm getting stuck finding something to do here.

Thanks,
Thai
