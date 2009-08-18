Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7IGFDCS029510
	for <selinux@tycho.nsa.gov>; Tue, 18 Aug 2009 12:15:13 -0400
Received: from zucker.argus-systems.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7IGGK9K026223
	for <selinux@tycho.nsa.gov>; Tue, 18 Aug 2009 16:16:20 GMT
Received: from [192.0.0.172] (chaos.argus-systems.com [66.209.209.174])
	by zucker.argus-systems.com (Postfix) with ESMTP id 2999323C93
	for <selinux@tycho.nsa.gov>; Tue, 18 Aug 2009 11:13:26 -0500 (CDT)
Message-ID: <4A8AD3A1.30109@argus-systems.com>
Date: Tue, 18 Aug 2009 11:15:29 -0500
From: Paul McNabb <mcnabb@argus-systems.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Not quite MLS.
References: <1250285426.3588.87.camel@rxm-581b.stl.gtri.gatech.edu> <1250509252.3629.84.camel@moss-pluto.epoch.ncsc.mil> <1250545104.3588.149.camel@rxm-581b.stl.gtri.gatech.edu> <4A89F878.1040604@sun.com>
In-Reply-To: <4A89F878.1040604@sun.com>
Content-Type: multipart/mixed;
 boundary="------------010902030206090403020606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010902030206090403020606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Glenn is right that the Mitre LEF can only work on a per-system rather 
than a per-user basis for disallowing certain classification and 
compartment/category constraints.  The only MLS system that I know of 
that did what you are asking for is the old Addamax B1st system.  That 
MLS system had user clearances as a set of labels and label ranges that 
allowed a specific user clearance to be something like:

{ unc - ts:1,2,3; unc:4 - sec:4 ; con:5 }

which would allow the user to be cleared from unc to ts in categories 1, 
2, and 3 but have only a unc to sec clearance in category 4 and only con 
for category 5.

Strictly speaking, a system can be "fully MLS" regardless of the 
clearance functionality.  Some MLS systems have been built (and bought) 
without any notion of a user clearance at all, particularly some MLS 
systems built to the first generation of TCSEC requirements.

paul

Glenn Faden wrote:
> rob myers wrote:
>>
>> I believe the difference between SELinux with MLS policy and what I am
>> trying to build is that I want higher sensitivity levels to dominate
>> lower sensitivity levels only on a per category basis.
>>
>> For example, it is my understanding that under MLS UserB must have
>> sensitivity level 3 access to category 3 because UserB has access to
>> sensitivity level 3 access to other categories.  Another possibility
>> under MLS would be to remove UserB's access to category 3 for all
>> sensitivities.  Neither of these is what I want the system to do.
>>   
> For MLS systems based on the Mitre/DIA label encodings format it is 
> possible to exclude specific categories on a per sensitivity label 
> basis from the User Accreditation Range. For an example, see:
>
>
> So it is possible to specify a User Accreditation Range conforming to 
> either the UserA or UserB matrix. However, the format only provides 
> for a single User Accreditiation Range that would apply to all users. 
> In MLS systems I'm familiar with, there is no facility to exclude 
> categories from the kernel dominance checks.
>
> --Glenn

--------------010902030206090403020606
Content-Type: text/x-vcard; charset=utf-8;
 name="mcnabb.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mcnabb.vcf"

begin:vcard
fn:Paul McNabb
n:McNabb;Paul
org:Argus Systems Group
adr:;;1809 Woodfield Drive;Savoy;IL;61874-9505;USA
email;internet:mcnabb@argus-systems.com
title:Chief Security Architect
tel;work:+1 217-355-6308
tel;fax:+1 217-355-1433
tel;cell:+1 217-493-3818
url:http://www.argus-systems.com
version:2.1
end:vcard


--------------010902030206090403020606--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
