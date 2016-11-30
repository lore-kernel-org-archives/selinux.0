Subject: Re: [PATCH] seobject: Handle python error returns correctly
To: Kyle Walker <kwalker@redhat.com>
References: <1480520874-22034-1-git-send-email-kwalker@redhat.com>
 <f1c73866-31dc-86ad-5650-9be050770b4e@tycho.nsa.gov>
 <CAEPKNTLKdamwns+ZeJkgitOWuKfB=QQuuqYcMahA5NvOKyRh-w@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <94237459-7311-77a6-f9b7-6b7f69a0d28b@tycho.nsa.gov>
Date: Wed, 30 Nov 2016 12:26:08 -0500
MIME-Version: 1.0
In-Reply-To: <CAEPKNTLKdamwns+ZeJkgitOWuKfB=QQuuqYcMahA5NvOKyRh-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/30/2016 11:48 AM, Kyle Walker wrote:
> On Wed, Nov 30, 2016 at 11:05 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> Hmm...even after this patch, we still get the error message from
>> dbase_llist_query.  Wondering if we should drop that or if that would
>> hide anything useful for other errors.  Doesn't seem overly useful at
>> present.
> 
> It does still emit that warning, it stems from the dbase_llist_query_local
> not returning any entries and falling back to the dbase_llist_query. It is
> chatty, and not necessarily helpful. I can't really think of a use-case for
> it myself. Outside of being able to verify that a fcontext is not in the
> file_contexts.local, but in the underlying file_contexts database on
> modification.
> 
> I.E. If you see that message, you are modifying from the defaults. If you
> don't, you are modifying a fcontext that has already been modified on the
> system previously.

Yes, so I applied your patch, but I think it would make sense to drop
that message from libsemanage too.  Otherwise, users are likely to be
confused by the error message and think the change did not take effect.
