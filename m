Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1R3lBSf009423
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 22:47:11 -0500
Message-ID: <47C4DD28.90805@tycho.nsa.gov>
Date: Tue, 26 Feb 2008 22:46:48 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Adam Jackson <ajax@redhat.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Permissive mode for xace is broken.
References: <47C2CC18.6080801@redhat.com>	 <1203948764.2804.183.camel@moss-spartans.epoch.ncsc.mil>	 <1203949499.2804.188.camel@moss-spartans.epoch.ncsc.mil>	 <47C2D552.8060509@redhat.com>	 <1203965363.2804.201.camel@moss-spartans.epoch.ncsc.mil>	 <47C316EF.5090206@redhat.com> <47C3261C.1070508@tycho.nsa.gov>	 <47C36767.7030503@tycho.nsa.gov> <1204030752.2804.282.camel@moss-spartans.epoch.ncsc.mil> <47C40F85.60407@redhat.com> <47C4CB9A.40807@tycho.nsa.gov> <FD5B0C7C-60A9-46F4-8986-A8EB31BABDC8@nall.com>
In-Reply-To: <FD5B0C7C-60A9-46F4-8986-A8EB31BABDC8@nall.com>
Content-Type: multipart/mixed;
 boundary="------------030102060407010504010307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030102060407010504010307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Joe Nall wrote:
> On Feb 26, 2008, at 8:31 PM, Eamon Walsh wrote:
>   
>> I found the source of the BadWindow errors.  I'm going to fix this  
>> upstream and throw an SRPM patch to Dan so he can test.
>>
>> Also, I think I'm going to change XQueryPointer() from requring  
>> "read" to simply "getattr" permission on the device.  I really do  
>> think it should require "read," but too many things call it and we  
>> need to turn "read" off to prevent the xspy attack.
>>
>> Finally, I'm going to try and get the polyinstantiation code for  
>> properties and selections in before the feature freeze.
>>     
>
> Awesome. Can I get a copy of the patch too?
>
> joe
>   

Attached and selinux list cc'ed.

One more thing: the SELinux extension is part of extmod, so you can do 
this in your xorg.conf if you want to disable it:

Section "Module"
        SubSection "extmod"
		Option "omit SELinux"
        EndSubSection
EndSection


At the present time there is no enforcing/permissive switch for just the 
xserver.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--------------030102060407010504010307
Content-Type: text/x-patch;
 name="badwindow_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="badwindow_fix.patch"


--------------030102060407010504010307--
