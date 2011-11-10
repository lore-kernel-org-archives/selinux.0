Subject: Re: SELinux on Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: SELinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris
 <jmorris@namei.org>
In-Reply-To: <CAGGozWQpW3Tvj00Rt44EEhk1qYn-w8BE07naY+MRQUbXurpYmQ@mail.gmail.com>
References: 
	 <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	 <1320409924.1015.7.camel@moss-pluto>
	 <CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
	 <1320425998.1015.31.camel@moss-pluto>
	 <CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
	 <1320930750.13691.5.camel@moss-pluto>
	 <CAGGozWQpW3Tvj00Rt44EEhk1qYn-w8BE07naY+MRQUbXurpYmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Nov 2011 11:26:08 -0500
Message-ID: <1320942368.13691.7.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-11-10 at 14:26 +0100, Bhargava Shastry wrote:

> The default value for
> CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE was 19 on my msm
> 2.6.32 kernel. I wonder why. Besides, like I mentioned before, I tried
> to change it to 24 (on seeing the policy mismatch print) but I can
> only set it to 23 (max value menuconfig allows me to enter).

Don't set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX, and then you
don't need to set a value at all.  The only purpose of the option is to
force the kernel to report an older version than it truly supports, and
that was only to deal with a compatibility issue in Fedora 2/3.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
