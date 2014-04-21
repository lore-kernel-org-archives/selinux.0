Message-ID: <5355265D.30007@tycho.nsa.gov>
Date: Mon, 21 Apr 2014 10:08:29 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: jkmeinde@rockwellcollins.com
Subject: Re: Unreadable or missing xattr security.selinux on jffs2
References: <OFBD9B9F38.B7665B76-ON86257CBE.006D959B-86257CBE.006E7F32@rockwellcollins.com>
 <535513D3.7000702@tycho.nsa.gov>
 <OF91F5EBCA.1A99E04C-ON86257CC1.004B42D3-86257CC1.004DB17B@rockwellcollins.com>
In-Reply-To: <OF91F5EBCA.1A99E04C-ON86257CC1.004B42D3-86257CC1.004DB17B@rockwellcollins.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/21/2014 10:08 AM, jkmeinde@rockwellcollins.com wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote on 04/21/2014 07:49:23 AM:
> 
>> From: Stephen Smalley <sds@tycho.nsa.gov>
>> To: jkmeinde@rockwellcollins.com, selinux@tycho.nsa.gov
>> Date: 04/21/2014 07:53 AM
>> Subject: Re: Unreadable or missing xattr security.selinux on jffs2
>>
>> On 04/18/2014 04:06 PM, jkmeinde@rockwellcollins.com wrote:
>> > Hello fellow selinux users:
>> > I apologize if this is a duplicate email, the first one I sent was from
>> > an address that I think is not on the list.
>> >
>> > I am currently working on a system that uses embedded linux with a few
>> > jffs2 file systems on NAND flash.  Each time my device boots, several
>> > flash partitions are mounted to various mount points throughout my root
>> > fs.  Some are readonly, a couple are rw.
>> >
>> > What I am seeing is that sometimes, when the mount happens on a rw
>> > partition, the label that shows for the mount point is "file_t".  This
>> > is not the label that was contained in the xattr on the last boot.  My
>> > selinux policy is set up to mark file systems which are missing the
>> > security.selinux attrs as file_t.  In each subsequent boot/mount, the
>> > root directory of the mounted filesystem remains "file_t" until I
>> > manually chcon or restorecon (in premissive)
>> >
>> > Furthermore, there are no domains in the selinux policy that have
>> > permissions to relabel directories of the type that I am mounting.  So
>> > my first question is, does anyone have any idea as to how the label
>> > could disappear?  Has anyone ever seen behavior like this on JFFS2?
>> >
>> > Is this more of a jffs2 question?  Other attrs like date modified, and
>> > DAC permissions remain intact.
>> >
>> > I thank anyone for the consideration.
>>
>> You said it happens sometimes.  Any distinguishing characteristics of
>> when it happens versus when it does not?  And how often does it occur?
>> When it does happen, are there any messages with SELinux: in dmesg that
>> appear?
>>
>> If you boot with SELinux disabled (selinux=0 on kernel command line) and
>> manually inspect the xattr via getfattr -n security.selinux
>> /path/to/root, does it report the correct value?
>>
>> Can you set any other xattrs on the root directory of the filesystem
>> (e.g. a user.* attribute, a trusted.* attribute, a POSIX acl) and have
>> them preserved across reboot?
>>
>> I haven't heard of this behavior but I'm not sure how many people use
>> jffs2 with SELinux (I have not).
>>
> Thanks for the reply Stephen.  I would say that a file system xattrs
> will survive approx. 40-50 boots before I run into this "missing xattrs"
> problem.  Then, after I fix the security.selinux label, it will last as
> long again.  I am only speculating that the security.selinux xattr is
> totally missing because my selinux policy is a derivation of CLIP, which
> uses the same default context for unlabeled file systems as described
> here.
> <https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Security-Enhanced_Linux/sect-Security-Enhanced_Linux-Working_with_SELinux-The_file_t_and_default_t_Types.html><https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Security-Enhanced_Linux/sect-Security-Enhanced_Linux-Working_with_SELinux-The_file_t_and_default_t_Types.html>
> 
> I have not been able to identify any distinguishing characteristics of
> what happened between the two boots where the context is lost.
> I can preserve other xattrs across boot (along with security.selinux), I
> have just now set an ACL which I will look for the next time the
> "file_t" problem manifests.
> I suppose I can implement a work around that would restore the labels to
> these file systems during rc.sysinit or something like that, but this is
> not totally desirable as files within these file systems are dynamically
> named and placed with type transitions, so I have no way to predict what
> is there within file_contexts.
> I will reply again with my findings on dmesg output and the results of
> the ACL test.

Does it happen for anything other than the root directory itself?  If
not, then you could force the root directory context to a specific
context value at mount time via the rootcontext= mount option, although
it is obviously still a bug if jffs2 is not preserving the root
directory context across reboots.
