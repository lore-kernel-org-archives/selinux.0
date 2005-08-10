Subject: Re: Category Translation patch for MCS/MLS Policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Daniel J Walsh <Dan-Walsh@comcast.net>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <42F9E53A.8080008@redhat.com>
References: <42F38DA8.4090300@comcast.net> <42F79CD4.1070404@trustedcs.com>
	 <42F79E2C.7060006@trustedcs.com>  <42F9E53A.8080008@redhat.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 08:02:15 -0400
Message-Id: <1123675335.3018.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-10 at 07:30 -0400, Daniel J Walsh wrote:
> Ok I will take a look at it. 
> 
> One thing I also want to think about is a mechanism to prevent 
> translation for certain apps.  One thing we are thinking about for MCS 
> is to allow an file to be in multiple categories.  So a c1-c3 
> translation might look like
> 
> "MedicalRecords,MassGeneral,Cancer"
> or
> "CompanyConfidential,IBMNonDisclosure5"
> 
> So we would want files to show this, but if I do a ps -eZ command I 
> don't want "System High" processes to translate it.
> So does MLS ps command translate?  Or does MCS have to add the concept 
> of "system high"?

IIRC, at present, procps doesn't use libselinux at all; procps directly
reads /proc/pid/attr/current and displays that value, since procps
already deals directly with /proc/pid entries and the maintainer
preferred to avoid a dependency of procps on libselinux (but was willing
to accept a dlopen of libselinux if we were to create such a patch, as
long as procps continues to work in the absence of libselinux).  Hence,
without further changes, procps won't perform any translation at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
