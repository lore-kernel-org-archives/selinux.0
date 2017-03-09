Message-ID: <1489073315.10847.40.camel@tycho.nsa.gov>
Subject: Re: isolate selinux_enforcing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: yangshukui <yangshukui@huawei.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Cc: serge.hallyn@ubuntu.com, oleg@redhat.com, Lizefan <lizefan@huawei.com>,
 james.l.morris@oracle.com, Kees Cook <keescook@chromium.org>, Nick
 Kralevich <nnk@google.com>
Date: Thu, 09 Mar 2017 10:28:35 -0500
In-Reply-To: <58C11A6C.7000408@huawei.com>
References: <58732BCF.4090908@huawei.com> <58734284.1060504@huawei.com>
 <b7f75f65-592a-5102-0ac5-4d3aa43f0b55@huawei.com>
 <58736B2E.90201@huawei.com> <58C11A6C.7000408@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-03-09 at 17:03 +0800, yangshukui wrote:
> I want to use SELinux in system container and only concern the
> function 
> in the container.
> this system container run in vm and every vm has only one system
> container.
> 
> How do I use now?
> docker run ... system-contaier /sbin/init
> after init is running ,the following service is also running:
> 
> #this is the part of service file which will run in container after 
> starting the container.
> ...
> semodule -R     #use the policy in container.
> restorecon /     #if needed
> ...
> 
> this method seem to work if host os and the docker images use the
> same 
> content for rootfs, but if host use
> redhat7 and docker images use centos7, it will deny many normal 
> operations , and this let some host service not work.
> 
> If SELinux is permissive in host and enforcing in container ,it will 
> resolve my problem. Unfortunately,
> there is no namespace for SELinux.
> 
> Isolate SELinux is difficult and it has a lot of work to do, but is 
> easier to isolate selinux_enforcing.
> 
> What do you think ?

I'd rather see proper SELinux policy namespace support implemented.
Admittedly, that won't be straightforward.

FWIW, ChromiumOS appears to have done something similar to what you
suggest for supporting Android containers (i.e. SELinux enforcing for
the Android container, permissive for ChromiumOS processes outside the
container), but they never discussed it with upstream SELinux
developers AFAIK.  My only knowledge of what they have done comes from
their kernel repository [1]. It appears that they experimented with a
hack to narrow the scope of selinux_enforcing to a PID namespace [2],
then reverted that change later and just implemented an option to
suppress audit denials for permissive domains [3] (evidently they are
running the Chromium OS processes in a permissive domain; I haven't
seen their policy).  I wouldn't recommend either approach; the former
won't properly handle permission checks that occur outside of process
context or certain permission checks where the source context is not
the current task context (e.g. an inter-object relationship check),
while the latter requires leaving a permissive domain in the production
policy (which seemingly would violate CTS; not sure why that gets a
pass, and if that is ok, then why didn't they just create a domain
allowed all permissions and use that outside the container instead -
then they won't need to suppress audit at all?) and further requires
use of a separate kernel for policy development/debugging.  Note btw
that they could have silenced the permissive denials via dontaudit
rules instead (as Android does for its su domain) but chose not to do
so to avoid taking the slow path.

[1] https://chromium.googlesource.com/chromiumos/third_party/kernel
[2] https://chromium-review.googlesource.com/c/361464/
[3] https://chromium-review.googlesource.com/c/424948/
