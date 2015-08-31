Subject: Re: [PATCH] libselinux: simplify procattr cache
To: Dominick Grift <dac.override@gmail.com>
References: <1437412266-6462-1-git-send-email-sds@tycho.nsa.gov>
 <20150829170214.GA15275@x250> <55E455D5.7000608@tycho.nsa.gov>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55E45B82.2050705@tycho.nsa.gov>
Date: Mon, 31 Aug 2015 09:49:54 -0400
MIME-Version: 1.0
In-Reply-To: <55E455D5.7000608@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/31/2015 09:25 AM, Stephen Smalley wrote:
> On 08/29/2015 01:02 PM, Dominick Grift wrote:
>> On Mon, Jul 20, 2015 at 01:11:06PM -0400, Stephen Smalley wrote:
>>> https://github.com/systemd/systemd/issues/475 identified a problem
>>> in libselinux with using getpid(3) rather than getpid(2) due to direct
>>> use of the clone() system call by systemd.  We could change libselinux
>>> to use getpid(2) instead, but this would impose a getpid(2) system call
>>> overhead on each get*con() or set*con() call.  Rather than do this,
>>> we can instead simplify the procattr cache and get rid of the
>>> caching of the pid and tid entirely, along with the atfork handler.
>>> With commit 3430519109c0423a49b9350aa8444beec798d5a7 ("use
>>> /proc/thread-self when available"), we only need the tid when
>>> on Linux < 3.17, so we can just always call gettid() in that case (as
>>> done prior to the procattr cache) and drop the cached tid. The cached
>>> pid and atfork handlers were only needed to reset the cached tid, so
>>> those can also be dropped. The rest of the cached attributes are not
>>> reset by the kernel on fork, only on exec, so we do not need to
>>> flush them upon fork/clone.
>>
>> Today i tried out these two patches (I basically updated the procattr.c
>> in Fedoras' libselinux myself because It took them too long) However, this seems to not
>> fix the systemd-nspawn issue for me (at least not by itself). I do not know whether that is due to
>> libselinux or to systemd-nspawn, but the error message is still exactly
>> the same.
> 
> Can you provide a reproducer, along with information on what version of
> Fedora, systemd, etc you are using?

For me, the example from the systemd-nspawn man page of:

# chcon system_u:object_r:svirt_sandbox_file_t:s0:c0,c1 -R /srv/container
# systemd-nspawn -L system_u:object_r:svirt_sandbox_file_t:s0:c0,c1 -Z
system_u:system_r:svirt_lxc_net_t:s0:c0,c1 -D /srv/container /bin/sh

On F22: succeeded (no change required to libselinux),

On F23: failed with
setexeccon("system_u:system_r:svirt_lxc_net_t:s0:c0,c1") failed: No such
file or directory
with libselinux-2.4-1.fc23

But if I install upstream SELinux userspace, ala
# cd selinux
# make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel

It then succeeds:
# systemd-nspawn -L system_u:object_r:svirt_sandbox_file_t:s0:c0,c1 -Z
system_u:system_r:svirt_lxc_net_t:s0:c0,c1 -D /srv/container /bin/sh
Spawning container container on /srv/container.
Press ^] three times within 1s to kill container.
sh-4.3#

>From outside the container:
# ps -eZ | grep svirt
system_u:system_r:svirt_lxc_net_t:s0:c0,c1 11950 pts/3 00:00:00 sh

So it appears to fix the problem there.
