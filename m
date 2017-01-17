Message-ID: <1484668315.20454.14.camel@tycho.nsa.gov>
Subject: Re: Has anyone ever looked into adding labeling support for the
 cgroup file system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Date: Tue, 17 Jan 2017 10:51:55 -0500
In-Reply-To: <11517275-0f09-97cd-0353-312c890a4a09@redhat.com>
References: <11517275-0f09-97cd-0353-312c890a4a09@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-01-17 at 10:34 -0500, Daniel J Walsh wrote:
> In order to allow processes to modify the cgroup hierarchy in a
> container from an SELinux point of view, we need to allow read/write
> access to cgroup_t, which means that a container process could break
> out
> and modify all cgroups, we want to allow them to only modify the
> portion
> of the hierarchy handed to them.
> 
> Would be a nice security improvement for docker.

Probably as easy as adding cgroup to the list of filesystem types that
use genfscon but also support setxattr (like sysfs) in
selinux_is_sblabel_mnt() in security/selinux/hooks.c.  sysfs and cgroup
are both implemented on top of kernfs in modern kernels, so they should
both support proper setting of security labels.
