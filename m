MIME-Version: 1.0
In-Reply-To: <1484339481-3260-1-git-send-email-sds@tycho.nsa.gov>
References: <1484339481-3260-1-git-send-email-sds@tycho.nsa.gov>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Date: Tue, 17 Jan 2017 15:30:47 +0000
Message-ID: <CANmMgnGvNHCigq8Nd3Tj33pRuh9jjzSdpGFLi2YTzhb=sFMhsg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: selinux_restorecon: only log no default label
 warning for caller-supplied pathname
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, richard_c_haines@btinternet.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 13/01/2017, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> $ touch /tmp/foo
> $ chcon -t etc_t /tmp/foo
> $ restorecon /tmp/foo
> Warning no default label for /tmp/foo
> $ restorecon -R /tmp/foo
> Warning no default label for /tmp/foo
> $ restorecon -R /tmp

Thanks again!

restorecon works as advertised.  I notice there are some other
spurious messages from fixfiles on master, which I didn't see before.
I suspect in passing, you in particular might know where they came
from :-P.  Extract from `fixfiles check`:

filespec hash table stats: 89 elements, 89/65536 buckets used, longest
chain length 1
/dev/tty3 not reset as customized by admin to
unconfined_u:object_r:user_tty_device_t:s0
/dev/tty2 not reset as customized by admin to
unconfined_u:object_r:user_tty_device_t:s0
filespec hash table stats: 558 elements, 558/65536 buckets used,
longest chain length 1

Messages about /dev/tty* are informative; statistics about hash tables are not.

Testing method:

* install selinux to ~/obj, according to README
* backup /sbin/restorecon and /sbin/setfiles
* overwrite them
* run LD_LIBRARY_PATH=~/obj/lib fixfiles check

(I believe fixfiles is running "/sbin/restorecon" or "/sbin/setfiles",
regardless of the install location or current PATH).

(I had some great undefined behaviour, before I realized I needed to
set LD_LIBRARY_PATH.  I've been spoilt by other projects, providing
scripts that magically set LD_LIBRARY_PATH when you try to run
something like restorecon from the build directory).
