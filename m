Message-ID: <55267.202.6.84.11.1036007034.squirrel@www.crypt.gen.nz>
Date: Thu, 31 Oct 2002 08:43:54 +1300 (NZDT)
Subject: Re: kernel warning
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: <SELinux@tycho.nsa.gov>
In-Reply-To: <Pine.GSO.4.33.0210280741410.29887-100000@raven>
References: <20021027042301.GA18290@snoopy.apana.org.au>
        <Pine.GSO.4.33.0210280741410.29887-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The 'Everything in one Part' download at
http://www.nsa.gov/selinux/archives/lsm-2.4-selinux-2002102211.tgz doesn't
seem to have this patch included, and the NSA site isn't very clear that
the patch is required. Could we please have the patch added to the next
all-in-one snapshot?

Kerry

Stephen Smalley said:
>
> SELinux has always included a separate SELinux-specific kernel patch to
> be applied on top of the LSM patch, although the precise purpose of the
> patch has varied over time.  In the current release, the patch is
> available in the SELinux archive in selinux/module/selinux-2.4.patch or
> directly from
> http://www.nsa.gov/selinux/patches/selinux-2.4-2002102211.patch.gz.  In
> the latest release, the dependence of the SELinux module on this patch
> has increased due to the elimination of precondition functions.  Some of
> the changes in this patch may find their way back into the mainstream
> LSM patch in a more general form in the future (they have all been
> discussed on the LSM mailing list), but some changes are likely to
> remain
> SELinux-specific.



-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
