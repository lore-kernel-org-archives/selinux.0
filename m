Subject: Re: [PATCH]: chcon: no longer abort on SELinux disabled kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: =?UTF-8?Q?Ond=C5=99ej_Va=C5=A1=C3=ADk?= <ovasik@redhat.com>,
        yaneti@declera.com, CoreutilsBugs <bug-coreutils@gnu.org>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <87zl85bs0e.fsf@meyering.net>
References: <1254727932.3849.8.camel@dhcp-lab-219.englab.brq.redhat.com>
	 <87zl85bs0e.fsf@meyering.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 05 Oct 2009 15:17:05 -0400
Message-Id: <1254770225.2251.152.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-10-05 at 20:44 +0200, Jim Meyering wrote:
> Ondřej Vašík wrote:
> > as reported in https://bugzilla.redhat.com/show_bug.cgi?id=527142 by
> > Yanko Kaneti, chcon aborts on SELinux disabled kernel due to missing
> > check for SELinux enabled kernel. Attached patch is fixing the issue.
> >
> > Additionally - for consistency - error message of this check in runcon
> > was changed to not hardcode "runcon" program name.
> 
> [Cc'ing the SELinux list for the question at the end
>  Summary: chcon(1) aborts when a successful getfilecon
>  result is passed to context_new and makes it return NULL. ]
> 
> Thanks, Ondřej.
> At first, I planned to use that patch, mostly as-is, but
> moving the chcon paragraph in NEWS "up" so that it's alphabetized.
> 
>   chcon no longer aborts on SELinux disabled system.
>   [the bug dates back to the initial implementation]
> 
> However, since I have so far been unable to reproduce the failure,
> (neither in mock, nor on bare-metal x86_64 with SELinux disabled)
> and know that merely running chcon with SELinux disabled is not
> enough to trigger the abort, what's written above is misleading.
> What if the only way to trigger the abort is with a strangely-
> or improperly-configured system?
> In fact, until I understand how/why the offending code is being
> reached, I hesitate to call this a bug or say where it originated.
> 
> If the getfilecon call succeeds, then why would context_new fail?
> Right after I wrote the line above, it clicked.
> Some versions of getfilecon can succeed (and return >= 0)
> yet set the context string to "unlabeled".  *That* is what
> causes trouble if you pass it to context_new.
> 
> This makes me want to write a getfilecon wrapper
> that would convert that surprising result into a return
> value of -1 with errno of ENOTSUP.  A wrapper would also
> protect us from the small risk of folks using the older
> libselinux versions that can return 0 and a NULL context.
> 
> Can the SELinux folks tell us under what circumstances
> getfilecon will return 10 and set *context to "unlabeled"?

Must have previously booted an ancient kernel with SELinux permissive
and no policy loaded.  Kernel was fixed by the commit below in 2006.
I'd recommend that he run the following to clean up the droppings in his
filesystem:
find / \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 \) -exec setfattr -x security.selinux {} \;

commit 8aad38752e81d1d4de67e3d8e2524618ce7c9276
Author: Stephen Smalley <sds@tycho.nsa.gov>
Date:   Wed Mar 22 00:09:13 2006 -0800

    [PATCH] selinux: Disable automatic labeling of new inodes when no policy is loaded
    
    This patch disables the automatic labeling of new inodes on disk
    when no policy is loaded.
    
    Discussion is here:
    https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=180296
    
    In short, we're changing the behavior so that when no policy is loaded,
    SELinux does not label files at all.  Currently it does add an 'unlabeled'
    label in this case, which we've found causes problems later.



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
