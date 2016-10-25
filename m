Subject: Re: POSIX mqueues
To: David Graziano <david.graziano@rockwellcollins.com>, selinux@tycho.nsa.gov
References: <CA+RmS-_=5kQza1VcwXoqwF40nvXBv6t2z4=rESj494=nDJ7RnQ@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b5079eba-8796-c213-f61e-7e5fcdd18f5b@tycho.nsa.gov>
Date: Tue, 25 Oct 2016 12:32:57 -0400
MIME-Version: 1.0
In-Reply-To: <CA+RmS-_=5kQza1VcwXoqwF40nvXBv6t2z4=rESj494=nDJ7RnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/24/2016 03:25 PM, David Graziano wrote:
> I am attempting to write policy for a set of applications which use
> POSIX mqueues using named type_transistion rules to uniquely label the
> mqueue files in the /dev/mqueue directory then controlling access
> based on the types. Standard type transition rules seem to work but I
> cannot seem to get the named type transitions to apply the proper
> label. Are named type transitions not supported by the mqueue file
> system? I’m on a 3.14 series kernel with policy version 28 if that
> helps. I’d like to avoid needing to do a restorecon after a new queue
> is created. Named type transistions seem to work on other file systems
> like tmp and jffs2.

You would need to patch the kernel to support that; the filesystem
implementation must call security_inode_init_security() and pass the
&dentry->d_name in order to support name-based transitions.
