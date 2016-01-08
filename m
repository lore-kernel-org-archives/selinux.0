Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u08NCDp9029012
 for <selinux@tycho.nsa.gov>; Fri, 8 Jan 2016 18:12:13 -0500
Received: by mail-ob0-f179.google.com with SMTP id bx1so339341098obb.0
 for <selinux@tycho.nsa.gov>; Fri, 08 Jan 2016 15:12:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <568ED656.5030106@tycho.nsa.gov>
References: <568ECC43.40500@m4x.org>
	<568ED656.5030106@tycho.nsa.gov>
Date: Fri, 8 Jan 2016 18:12:11 -0500
Message-ID: <CAHC9VhQ6c5VrRK3m7mB=+Myexsr9RbTjfSdf+qcWx_J+9B8iUA@mail.gmail.com>
Subject: Re: Labeling nsfs filesystem
From: Paul Moore <paul@paul-moore.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jan 7, 2016 at 4:19 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 01/07/2016 03:36 PM, Nicolas Iooss wrote:
>>
>> Hello,
>>
>> Since Linux 3.19 targets of /proc/PID/ns/* symlinks have lived in a fs
>> separated from /proc, named nsfs [1].  These targets are used to enter
>> the namespace of another process by using setns() syscall [2].  On old
>> kernels, they were labeled with procfs default type (for example
>> "getfilecon /proc/self/ns/uts" returned system_u:object_r:proc_t:s0).
>> When using a recent kernel with a policy without nsfs support, the
>> inodes are not labeled, as reported for example in Fedora bug #1234757
>> [3].  As I encounter this issue on my systems, I asked yesterday on the
>> refpolicy ML how nsfs inodes should be labeled [4].
>>
>> After digging a little bit about the possibilities, here is a summary of
>> the options I have considered so far.
>>
>> Option 1: define a new type to label nsfs inodes, nsfs_t.  This works as
>> expected (c.f. [5] for more details) ...
>
> Only option 1 makes sense to me.

Agreed.

-- 
paul moore
www.paul-moore.com
