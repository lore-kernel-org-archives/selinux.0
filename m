Subject: Re: SELinux on Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov,
        James Morris
 <jmorris@namei.org>
In-Reply-To: <CAGGozWQXo5bXgVKa0t3pO+45Vj70LJA12dF2ovX6Hm9KnYNNQQ@mail.gmail.com>
References: 
	 <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	 <1320409924.1015.7.camel@moss-pluto>
	 <CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
	 <1320425998.1015.31.camel@moss-pluto>
	 <CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
	 <1320930750.13691.5.camel@moss-pluto>
	 <CAGGozWQpW3Tvj00Rt44EEhk1qYn-w8BE07naY+MRQUbXurpYmQ@mail.gmail.com>
	 <1320942368.13691.7.camel@moss-pluto>
	 <CAGGozWRK117G=93o1=v0yM6HxdtbDRSZ8sKybDEYNEKjpyHMNA@mail.gmail.com>
	 <CAGGozWR8pNNC6P1T8cYtbkfqZu56iVty+JdmXwudo3ZaAVbN-g@mail.gmail.com>
	 <CACLa4puuN_nt+Hw3LU3UjYAJ9gGua=bEzt-ioXGv3=W41=1bBg@mail.gmail.com>
	 <CAGGozWRxOzUiG33OvmEqX+Y4ywcGTfwx_8bVKuwQ31M_bdtN6Q@mail.gmail.com>
	 <1321537184.4836.9.camel@moss-pluto>
	 <CAGGozWT9PP-p4-UA6WJtiZmwHE1ot_Of85pKQRLGeab37e4kaQ@mail.gmail.com>
	 <1321890697.9385.20.camel@moss-pluto>
	 <CAGGozWQXo5bXgVKa0t3pO+45Vj70LJA12dF2ovX6Hm9KnYNNQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Nov 2011 13:32:53 -0500
Message-ID: <1321900374.9385.39.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-11-21 at 19:18 +0100, Bhargava Shastry wrote:
>         You need to add a fs_use_xattr statement to your policy
>         configuration
>         for yaffs2.  Similar to the existing statements for ext[234].
> 
> Thanks. I have the sources for a reference SELinux policy from the
> tresys website. Unfortunately, with default policy build options, the
> resulting monolithic policy is huge. I am using an Ubuntu machine; any
> hints as to where to start for a minimal policy for Android. I tried
> selectively building only basic modules but there are intricate
> dependencies (checkpolicy throws up unresolved symbols error) between
> modules that is hard to disentangle. 

It doesn't make much sense to use the reference policy for Android,
because the Android userspace is completely different from a typical
Linux distribution.  I created a policy from scratch for my work.

You can generate a minimal policy from the kernel tree (see
scripts/selinux/mdp).  However, that generated policy will only take you
so far since it lacks any of the macro definitions/build infrastructure
and since it places everything in a single type/domain.  So you can
start there, but you'll likely want to split it out into multiple files,
add some of the macros from refpolicy or the original example policy,
and start defining individual domains and types.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
