Message-ID: <52FB8288.1080004@tycho.nsa.gov>
Date: Wed, 12 Feb 2014 09:17:44 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: nguyen thai <thai.bkset@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Detail description of some projects in TO DO list page
References: <CACBeRbb2fZCWgH93aJ61nfkCCZoJSG3aeaW=9ODSccVXzRQ9xg@mail.gmail.com>
In-Reply-To: <CACBeRbb2fZCWgH93aJ61nfkCCZoJSG3aeaW=9ODSccVXzRQ9xg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/11/2014 09:24 PM, nguyen thai wrote:
> Hi everyone,
> 
> I have started my study in SELinux recently. I found some projects in TO DO
> list page were really interesting. Can anyone give me more details (what's
> problem now? it's effects or drawbacks) of one of following projects or any
> other projects that i can start to work on?
>  - Investigate security policy for cgroups
>  - CIFS support for single-context clients
>  - Real device labeling and access control
> 
> Thank you very much.

That TODO list is old and not actively maintained, so it may be better
to look at recent mailing list archives to see areas where you can
contribute most effectively.  Also look for recent discussions of
selinux in the linux-security-module and linux-kernel mailing list archives.

On the cgroup item, it should be possible to support finer-grained
labeling of cgroup files now that cgroup supports xattrs, but it will
require a small kernel change (similar to the changes previously made
for sysfs and rootfs; need to generalize that), and thereby enabling
policy control over specific cgroup files.  There may also be work
required inside the cgroup code to add security hooks and permission
checks for MAC; that would require analysis of the cgroup
implementation, existing DAC checks, ways in which they can permit
different security labels to interact/interfere with each other, etc.
