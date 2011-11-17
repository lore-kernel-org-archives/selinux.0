Subject: Re: SELinux on Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: SELinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris
 <jmorris@namei.org>
In-Reply-To: <CAGGozWR8pNNC6P1T8cYtbkfqZu56iVty+JdmXwudo3ZaAVbN-g@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Nov 2011 08:37:14 -0500
Message-ID: <1321537034.4836.8.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-11-16 at 19:15 +0100, Bhargava Shastry wrote:
> Hi again,
> 
> I am trying to set/get file SELinux contexts using the set/getfilecon
> programs. I added debug prints in the kernel to track code flow. I
> notice that although setfilecon succeeds on a given file, a subsequent
> call to getfilecon on the same file returns the string "kernel"
> irrespective of the context that was set using setfilecon. On any
> other file whose context is not set yet, getfilecon properly returns
> the string "unlabeled"
> 
> I suspect the inode struct in the kernel is not being updated properly
> after a setxattr call. Has anyone else faced a similar problem? I am
> working on Android's Nexus one phone.

- Do you have a policy loaded (requires patching init to load the
policy)?

- Do you have yaffs xattr support enabled in your kernel
(CONFIG_YAFFS_XATTR=y)?

- Do you have the two patches for yaffs that I posted (one of which they
did take, the other they ignored)?
http://www.aleph1.co.uk/lurker/message/20110412.193746.891b5e18.en.html
http://www.aleph1.co.uk/lurker/message/20110413.203654.65d7ee58.en.html

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
