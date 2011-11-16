MIME-Version: 1.0
In-Reply-To: <CAGGozWR8pNNC6P1T8cYtbkfqZu56iVty+JdmXwudo3ZaAVbN-g@mail.gmail.com>
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	<1320409924.1015.7.camel@moss-pluto>
	<CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
	<1320425998.1015.31.camel@moss-pluto>
	<CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
	<1320930750.13691.5.camel@moss-pluto>
	<CAGGozWQpW3Tvj00Rt44EEhk1qYn-w8BE07naY+MRQUbXurpYmQ@mail.gmail.com>
	<1320942368.13691.7.camel@moss-pluto>
	<CAGGozWRK117G=93o1=v0yM6HxdtbDRSZ8sKybDEYNEKjpyHMNA@mail.gmail.com>
	<CAGGozWR8pNNC6P1T8cYtbkfqZu56iVty+JdmXwudo3ZaAVbN-g@mail.gmail.com>
Date: Wed, 16 Nov 2011 13:35:39 -0500
Message-ID: <CACLa4puuN_nt+Hw3LU3UjYAJ9gGua=bEzt-ioXGv3=W41=1bBg@mail.gmail.com>
Subject: Re: SELinux on Android
From: Eric Paris <eparis@parisplace.org>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sounds to me like you never loaded a policy.  I'd bet you are getting
inside the if (!ss_initialized) section of
security_sid_to_context_core.  You have to load a policy before you
can properly set and retrieve labels.

-Eric

On Wed, Nov 16, 2011 at 1:15 PM, Bhargava Shastry <bshas3@gmail.com> wrote:
> Hi again,
>
> I am trying to set/get file SELinux contexts using the set/getfilecon
> programs. I added debug prints in the kernel to track code flow. I notice
> that although setfilecon succeeds on a given file, a subsequent call to
> getfilecon on the same file returns the string "kernel" irrespective of the
> context that was set using setfilecon. On any other file whose context is
> not set yet, getfilecon properly returns the string "unlabeled"
>
> I suspect the inode struct in the kernel is not being updated properly after
> a setxattr call. Has anyone else faced a similar problem? I am working on
> Android's Nexus one phone.
>
> Thanks,
> Bhargava
>
> On Fri, Nov 11, 2011 at 12:33 PM, Bhargava Shastry <bshas3@gmail.com> wrote:
>>>
>>> Don't set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX, and then you
>>> don't need to set a value at all.  The only purpose of the option is to
>>> force the kernel to report an older version than it truly supports, and
>>> that was only to deal with a compatibility issue in Fedora 2/3.
>>
>> This somehow slipped my mind. Thanks, problem solved.
>>
>> Regards,
>> Bhargava Shastry
>
>
>
> --
> Bhargava Shastry
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
