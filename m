Message-ID: <42F9E53A.8080008@redhat.com>
Date: Wed, 10 Aug 2005 07:30:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: Daniel J Walsh <Dan-Walsh@comcast.net>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Category Translation patch for MCS/MLS Policy
References: <42F38DA8.4090300@comcast.net> <42F79CD4.1070404@trustedcs.com> <42F79E2C.7060006@trustedcs.com>
In-Reply-To: <42F79E2C.7060006@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:

> Darrel Goeddel wrote:
>
>> Attached is our latest incarnation of the translation framework.
>
>
> Since I hit send before I actually attached the patch...  The patch
> can be found at:
>
> http://home.insightbb.com/~dgoeddel/translation.patch
>
> Sorry about that.
>
Ok I will take a look at it. 

One thing I also want to think about is a mechanism to prevent 
translation for certain apps.  One thing we are thinking about for MCS 
is to allow an file to be in multiple categories.  So a c1-c3 
translation might look like

"MedicalRecords,MassGeneral,Cancer"
or
"CompanyConfidential,IBMNonDisclosure5"

So we would want files to show this, but if I do a ps -eZ command I 
don't want "System High" processes to translate it.
So does MLS ps command translate?  Or does MCS have to add the concept 
of "system high"?

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
