Subject: Re: SELinux on Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov,
        James Morris
 <jmorris@namei.org>
In-Reply-To: <CAGGozWT9PP-p4-UA6WJtiZmwHE1ot_Of85pKQRLGeab37e4kaQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Nov 2011 10:51:37 -0500
Message-ID: <1321890697.9385.20.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-11-21 at 16:45 +0100, Bhargava Shastry wrote:
> Hello,
> 
> On loading an SELinux policy, I see that SELinux recognises the YAFFS
> blocks on Android as FS where labeling is not supported. Here is a
> sample dmesg print:
> "SELinux: initialized (dev mtdblock3, type yaffs2), not configured for
> labeling"
> 
> On looking into the SELinux code, I see that such a print is spat out
> on a check for a file-system superblock security attribute called
> "behavior". Could I possibly correct this by changing something in the
> YAFFS file-system code. I tried mounting the yaffs partition by
> appening the context= option in Android's init.rc but the mount fails.
> I should add that I am able to execute getfilecon on YAFFS (extended
> attributes have been ported to YAFFS) successfully but setfilecon
> fails possibly due to the above debug print. And as previously
> mentioned, I attempt set/getfilecon only after a load_policy. Also,
> all other filesystems (rootfs, procfs, tmpfs etc. are correctly
> initialised on policy load)

You need to add a fs_use_xattr statement to your policy configuration
for yaffs2.  Similar to the existing statements for ext[234].

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
