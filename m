Subject: Re: SELinux on Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov,
        James Morris
 <jmorris@namei.org>
In-Reply-To: <CAGGozWRoHG9TW0xEy7c3ji1ksfXeHt_Nb+53=j3hpZSp0fWmDw@mail.gmail.com>
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
	 <1321900374.9385.39.camel@moss-pluto>
	 <CAGGozWRoHG9TW0xEy7c3ji1ksfXeHt_Nb+53=j3hpZSp0fWmDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 22 Nov 2011 14:29:53 -0500
Message-ID: <1321990193.4161.63.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-11-22 at 20:25 +0100, Bhargava Shastry wrote:
> Thanks for pointing out. I am getting myself acquainted with SELinux
> policy semantics to be able to start from scratch. I have one question
> though and the answer to this would make my task of creating an
> Android specific policy much smoother. 
> I had previously loaded an Ubuntu SELinux policy on Android and it
> seemed to label all the filesystems correctly (except yaffs). I would
> like to diff a very basic policy (i.e., mdp output) with the default
> ubuntu policy so that I would get an idea of how filesystems are being
> labeled and how transitions are handled among other things; basically
> to learn from a delta between the two files. To do this, I need
> sources for Ubuntu-SELinux policy (in order to compile a
> policy.conf) . I have somehow not been able to locate the source for
> the policy binary that ubuntu uses (I looked in the /etc/selinux dir
> to no avail). Any ideas as to where I can find them? Alternatively, is
> there a tool to reverse engineer policy.conf from the policy binary
> (e.g. policy.24)?

You need the source package.  selinux-policy-src?

setools has a variety of tools that allow you to inspect a policy, even
a binary one.  seinfo, sesearch, apol, etc.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
