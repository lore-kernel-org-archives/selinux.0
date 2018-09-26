To: sajjad ahmed <sajjad_ahmed782@yahoo.com>, selinux@tycho.nsa.gov
References: <1622272321.2871056.1537970133583.ref@mail.yahoo.com>
 <1622272321.2871056.1537970133583@mail.yahoo.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a799af1b-81bb-a54b-599c-176930ad8ce6@tycho.nsa.gov>
Date: Wed, 26 Sep 2018 10:18:26 -0400
MIME-Version: 1.0
In-Reply-To: <1622272321.2871056.1537970133583@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: setfiles rootfs labeling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/26/2018 09:55 AM, sajjad ahmed via Selinux wrote:
> Hi all,
> 
> I'm trying to use the setfiles utility (v 2.7) from policycoreutils to 
> label rootfs, it seems like setfiles exclude all the directories 
> straight away and labels nothing. I tried an older version (< 2.6) that 
> works fine. I'm using the yocto project to build packages and using 
> native setfiles utility to "label rootfs on the build system". Is it 
> utility who is not doing what is supposed to?
> 
> I'm using the following command to label rootfs,
> /sudosetfiles -v -r /tmp/sid/ 
> /etc/selinux/refpolicy/contexts/files/file_contexts /tmp/sid//
> /
> /

I'll guess that your build host OS has SELinux disabled and that 
consequently /proc/mounts does not show the seclabel option for the 
filesystem.  Trying using the -m option to setfiles to ignore /proc/mounts.
