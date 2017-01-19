Message-ID: <1484845904.28584.6.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: selinux_restorecon: only log no default
 label warning for caller-supplied pathname
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, richard_c_haines@btinternet.com
Date: Thu, 19 Jan 2017 12:11:44 -0500
In-Reply-To: <CANmMgnGvNHCigq8Nd3Tj33pRuh9jjzSdpGFLi2YTzhb=sFMhsg@mail.gmail.com>
References: <1484339481-3260-1-git-send-email-sds@tycho.nsa.gov>
 <CANmMgnGvNHCigq8Nd3Tj33pRuh9jjzSdpGFLi2YTzhb=sFMhsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-01-17 at 15:30 +0000, Alan Jenkins wrote:
> On 13/01/2017, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > 
> > $ touch /tmp/foo
> > $ chcon -t etc_t /tmp/foo
> > $ restorecon /tmp/foo
> > Warning no default label for /tmp/foo
> > $ restorecon -R /tmp/foo
> > Warning no default label for /tmp/foo
> > $ restorecon -R /tmp
> 
> Thanks again!
> 
> restorecon works as advertised.  I notice there are some other
> spurious messages from fixfiles on master, which I didn't see before.
> I suspect in passing, you in particular might know where they came
> from :-P.  Extract from `fixfiles check`:
> 
> filespec hash table stats: 89 elements, 89/65536 buckets used,
> longest
> chain length 1

Yes, I'll reduce that to debug level or drop it altogether.

Also, should probably add a logging callback to setfiles/restorecon so
that it can prepend any messages from libselinux with argv[0] so these
don't show up with no indication of the program.

> /dev/tty3 not reset as customized by admin to
> unconfined_u:object_r:user_tty_device_t:s0
> /dev/tty2 not reset as customized by admin to
> unconfined_u:object_r:user_tty_device_t:s0
> filespec hash table stats: 558 elements, 558/65536 buckets used,
> longest chain length 1
> 
> Messages about /dev/tty* are informative; statistics about hash
> tables are not.
> 
> Testing method:
> 
> * install selinux to ~/obj, according to README
> * backup /sbin/restorecon and /sbin/setfiles
> * overwrite them
> * run LD_LIBRARY_PATH=~/obj/lib fixfiles check
> 
> (I believe fixfiles is running "/sbin/restorecon" or
> "/sbin/setfiles",
> regardless of the install location or current PATH).
> 
> (I had some great undefined behaviour, before I realized I needed to
> set LD_LIBRARY_PATH.  I've been spoilt by other projects, providing
> scripts that magically set LD_LIBRARY_PATH when you try to run
> something like restorecon from the build directory).
