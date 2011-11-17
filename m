Subject: Re: SELinux on Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov,
        James Morris
 <jmorris@namei.org>
In-Reply-To: <CAGGozWRxOzUiG33OvmEqX+Y4ywcGTfwx_8bVKuwQ31M_bdtN6Q@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Nov 2011 08:39:44 -0500
Message-ID: <1321537184.4836.9.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-11-17 at 11:15 +0100, Bhargava Shastry wrote:
>         Sounds to me like you never loaded a policy.  I'd bet you are
>         getting
>         inside the if (!ss_initialized) section of
>         security_sid_to_context_core.  You have to load a policy
>         before you
>         can properly set and retrieve labels.
> 
> Thanks, loading policy fixed the problem although I wonder why one
> shouldn't be able to set xattr in the absence of a policy. 

Because SELinux has no way to interpret the xattr value if there is no
policy loaded.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
