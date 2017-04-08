MIME-Version: 1.0
In-Reply-To: <CAFJ0LnGQPYAxugZfak6az6ruB9Ea8J34nPXQYTUey_YOg4g1BQ@mail.gmail.com>
References: <CAFJ0LnGQPYAxugZfak6az6ruB9Ea8J34nPXQYTUey_YOg4g1BQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 8 Apr 2017 09:42:57 -0400
Message-ID: <CAHC9VhQe8VBV_SmdYBiqs7nby71fHaRpqHTCH0YHSMDLckr9pQ@mail.gmail.com>
Subject: Re: add CONFIG_SECURITY_SELINUX_LOAD_ONCE
To: Nick Kralevich <nnk@google.com>
Cc: SELinux <Selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Apr 7, 2017 at 1:34 PM, Nick Kralevich <nnk@google.com> wrote:
> I wanted to draw people's attention to the following proposed change:
>
>   https://android-review.googlesource.com/367695
>
> In the case of Android, it's common for security policy to be loaded once,
> and never reloaded again. In that case, the locking / unlocking surrounding
> the in-kernel policy is unnecessary and can be avoided. The patch above
> turns the locks into no-ops and ensures that the kernel cannot load a policy
> more than once. End result is that locking and preemption overhead is
> avoided and there's less attack surface / code compiled into the kernel.

Without looking at any of the proposed code (see my comment at the end
of this mail), my initial reaction is that isn't something we want to
have to support in the mainline kernel.  For the majority (all?) of
the general purpose and enterprise Linux distributions, the ability to
reload SELinux policy is critical (run time customization, policy
module installs/updates, etc.), and I'm not convinced that this
facility would ever be enabled outside of some embedded/appliance
scenarios.  Even then, I question the usefulness since the policy
itself should be able to prevent policy reloads.

If you are seeing measurable, and problematic, overhead with the
policy locks I'm open to new locking approaches.  From an attack
surface reduction point of view, I have no objection to looking at
removing some of the interfaces from the selinuxfs mount if the loaded
SELinux policy completely removes that privilege from all domains ...
although the code here might be more trouble than it is worth.

On Fri, Apr 7, 2017 at 1:57 PM, Nick Kralevich <nnk@google.com> wrote:
> In the interests of avoiding duplicate conversation in multiple
> places, let's continue this discussion at
> https://android-review.googlesource.com/367695

Posting links to discussions about Android specific changes is fine as
a FYI, and welcome as far as I'm concerned.  However, SELinux patches
which you wish to submit for review and possible inclusion into the
mainline Linux Kernel need to be posted and discussed on the SELinux
mailing list.

-- 
paul moore
www.paul-moore.com
