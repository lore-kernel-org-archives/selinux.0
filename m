Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8TCs2VI001706
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 08:54:02 -0400
From: Raj Srinivasan <raj@bivio.net>
To: Dominick Grift <dac.override@gmail.com>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: RE: Question on restricting file access
Date: Thu, 29 Sep 2016 12:53:57 +0000
Message-ID: <DM5PR01MB25711347944701EE93A5901DA9CE0@DM5PR01MB2571.prod.exchangelabs.com>
References: <DM5PR01MB257160569D7A4541EB83024FA9CF0@DM5PR01MB2571.prod.exchangelabs.com>
 <1cf62e3d-c674-97ce-e598-aff042f4e877@gmail.com>
In-Reply-To: <1cf62e3d-c674-97ce-e598-aff042f4e877@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks, Dominick. As my last email indicated, I think I have solved my issue, albeit sub-optimally. I will direct further questions, if I have any, to the mailing list you have indicated. Selinux is indeed a very complex framework, but the rewards seem to be well worth the effort spent learning it!

Regards,
Raj

-----Original Message-----
From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of Dominick Grift
Sent: Thursday, September 29, 2016 12:46 AM
To: selinux@tycho.nsa.gov
Subject: Re: Question on restricting file access

On 09/28/2016 09:05 PM, Raj Srinivasan wrote:
> Hi,
> 
> I have just started with Selinux, and was trying (unsuccessfully) to restrict the sysadm role as my first exercise.
> 
> I am using RHEL 7.1, and running Selinux with the minimum configuration in enforcing mode.
> 

Hi, This is not the optimal list for reference policy related questions.
refpolicy@oss.tresys.com is the list for reference policy

> I have a user called "admin" with the context "sysadm_u:sysadm_r:sysadm_t:s0-s0:c0.c1023", and uid 1000. When I login as admin and use su to become root, the context still remains the same, as one would expect.
> 
> I created a simple policy to restrict the sysadm_r role for testing purposes, and was able to compile and load it.
> 
> policy_module(localpolicy, 1.0.0)
> 
> gen_require(`
>   type sysadm_t;
>   type sshd_key_t;
> ')
> 
> allow sysadm_t sshd_key_t:file { create_file_perms write_file_perms };
> 
> The idea was to prevent the sysadm_r role from being able to read a file with the sshd_key_t type even if the uid is changed to root via the su command, by allowing "create" and "write" permissions, but not "read" permission.
> 
> I would appreciate it very much if anyone could let me know what I am missing, or if there is an easy way to troubleshoot. I tried to use the "neverallow" directive (with "read" permission) but after waiting for 10 minutes, the policy did not even load. I suspect there is some other rule in effect that grants read permission that I am not able to see using "sesearch -A".
> 

The above is not easily possible currently. This is mainly due to limitations of the module policy language and due the reference policy model

SELinux is a denial-by-default access control framework. That means that access is denied unless it is explicitly allowed. In this case sysadm is explicitly allowed access to all non-auth files (https://github.com/TresysTechnology/refpolicy/blob/master/policy/modules/system/userdomain.if#L1233).
Ideally you would have to start by removing that rule (if you wish to not break the reference policy model).

In theory it should have been possible to remove the rule by replacing the userdomain module with a version that does not include the above rule (at a minimum). However this, i believe, is currently not possible due to aforementioned limitations, and if it would be possible then it would be hard to maintain over time.

There is a new (intermediate) policy language that should make things like this possible, but it is not available in RHEL7 yet, and even when it becomes available then it still requires a policy written in a new additional high-level language that takes advantage of the new
(intermediate) policy language to be able to take advantage of the features that it brings.

The alternative would be to create a new set of rules and identifiers, possibly based on the existing sysadm set of rules and identifiers, that is then tailored to your specific requirements.

The above is however a non-trivial task, and not easy to explain in a e-mail thread.

My advice to you is:

You are clearly interested in taking advantage of SELinux. It may be worth it for you to learn more about the SELinux framework, security models, and language(s).

Once you have enough knowledge of the aforementioned then you will find how to achieve your goals, and you will be able to implement solutions for a wide array of access control requirements with SELinux

> Thanks,
> Raj
> 
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 


--
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
