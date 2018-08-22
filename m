MIME-Version: 1.0
References: <20180813194214.20929-1-hollis_blanchard@mentor.com>
 <CAPc65ax7Dz_niNOxypfds2hLCdiP=x8C2_KFWShVpBnWP62fFg@mail.gmail.com>
 <6a93e71c-a31a-d7e2-546c-e0e63d85c62d@mentor.com>
 <CAPc65azY7nrTRLARYfMMPAm7R+=rpmQby=wtbWaMZ=CfACOTBw@mail.gmail.com>
 <1b1bd436-f443-d75b-c747-e34831b89339@mentor.com>
In-Reply-To: <1b1bd436-f443-d75b-c747-e34831b89339@mentor.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 22 Aug 2018 22:57:22 +0200
Message-ID: <CAJfZ7==p9QNJGtc60j4n02RznNjcyshmOTUUvFxTQ3VQim1=_A@mail.gmail.com>
To: hollis_blanchard@mentor.com
Cc: tomcherry@google.com, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] Fix build break around __atomic_*() with GCC<4.7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 14, 2018 at 2:02 PM Hollis Blanchard
<hollis_blanchard@mentor.com> wrote:
>
> On 08/13/2018 02:18 PM, Tom Cherry wrote:
> > On Mon, Aug 13, 2018 at 1:49 PM Hollis Blanchard
> > <hollis_blanchard@mentor.com> wrote:
> >> On 08/13/2018 01:45 PM, Tom Cherry wrote:
> >>> On Mon, Aug 13, 2018 at 12:43 PM Hollis Blanchard
> >>> <hollis_blanchard@mentor.com> wrote:
> >>>> The __atomic_* GCC primitives were introduced in GCC 4.7, but Red Hat
> >>>> Enterprise Linux 6.x (for example) provides GCC 4.4. Tweak the current code to
> >>>> use the (most conservative) __sync_synchronize() primitive provided by those
> >>>> older GCC versions.
> >>>>
> >>>> Fixes https://github.com/SELinuxProject/selinux/issues/97
> >>>>
> >>>> (Really, no __atomic or __sync operations are needed here at all, since POSIX
> >>>> 4.12 "Memory Synchronization" says pthread_mutex_lock() and
> >>>> pthread_mutex_unlock() "synchronize memory with respect to other threads"...)
> >>> That section means that pthread_mutex_lock() and
> >>> pthread_mutex_unlock() will perform an acquire / release operation
> >>> respectively, so if you're guarding shared data with them, you don't
> >>> need additional memory synchronization.
> >>>
> >>> In this case however, the fast path does not call pthread_mutex_lock()
> >>> and thus there is no acquire operation.  pthread_mutex_unlock() will
> >>> perform a release operation in the thread that actually compiled the
> >>> regex (so technically, we don't actually need the __atomic_store_n),
> >>> but we still need an acquire operation on the fast path, which is why
> >>> we need the atomic.
> >> You really don't. The fast path access will race whether it's "atomic"
> >> or not. Luckily, it doesn't matter if you get false positives or false
> >> negatives, because it will be checked for real under the mutex.
> > It does matter if you get false positives.  False positives do not
> > lock the mutex and return immediately that the regex has been
> > compiled.  Without the acquire operation, it's possible that
> > spec->regex_compiled is true, but the value of spec->regex hasn't been
> > made visible to the processor executing this thread, which results in
> > an error.
> Well, since there are no objections to this patch, I am happy to have it
> committed to fix the build problem. :-)

I have applied this patch. Thanks!

Nicolas
