Message-ID: <4501BB5A.1060301@redhat.com>
Date: Fri, 08 Sep 2006 14:50:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, janak@us.ibm.com,
        sgrubb@redhat.com, tmraz@redhat.com, ltcgcw@us.ibm.com,
        klaus@atsec.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] newrole: use pam session management services - v4
References: <1157403682.7223.16.camel@localhost.localdomain>	 <45004926.5010206@trustedcs.com>	 <1157736146.31695.145.camel@moss-spartans.epoch.ncsc.mil>	 <4501A841.4060006@redhat.com> <1157740847.31695.207.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1157740847.31695.207.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-09-08 at 13:28 -0400, Daniel J Walsh wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> On Thu, 2006-09-07 at 11:30 -0500, Darrel Goeddel wrote:
>>>   
>>>       
>>>> Could we untangle the pam/lspp bits like I have below if we include
>>>> pam_permit as a session module in the "regular" pam config?  I think
>>>> that should take care of the case where we use pam, but do not have
>>>> any session management needs.  The use of pam_permit in this situation
>>>> seems perfectly acceptable to me.  This would give us real session
>>>> management capabilities via pam even if we are not using the lspp
>>>> configuration which requires privilege for pam_namespace.so.
>>>>     
>>>>         
>>> Even better would be if there was an easy way for newrole to dynamically
>>> probe for whether pam_namespace is in its pam config, and to only enable
>>> those capabilities if it is there.  Then we can have a single newrole
>>> binary built with the LSPP support, but it will still drop all
>>> capabilities other than CAP_AUDIT_WRITE at startup if there is no
>>> pam_namespace in its config (as in a non-LSPP system).
>>>
>>>   
>>>       
>> Could we label it differently.  So if it runs in newrole_lspp_t domain 
>> it does not drop, otherwise it does.
>>     
>
> For the strict policy, we can easily wrap the allow rules for the
> additional capabilities for newrole_t in a conditional with a boolean
> that is only enabled in the LSPP config, or we can put the allow rules
> in a separate policy module that is only added in the LSPP config.  But
> that doesn't help in the case of the default targeted policy where
> neither newrole nor its caller are confined by SELinux.
>
> Part of the confusion here is what you plan to put in vanilla
> Fedora/RHEL versus the LSPP certified configuration.  I assume you want
> a single newrole binary that can handle either case (which means it has
> to be setuid root, and include the capability manipulation code and
> pam_open_session call).  Do you plan to include pam_namespace in the pam
> config always, or only in the LSPP certified configuration?  If the
> former, then checking for it at runtime serves no purpose; the build
> time option is sufficient.  If the latter, then policycoreutils itself
> should never install a newrole pam config that includes pam_namespace;
> that should only be done by some LSPP-specific package, and having a
> runtime check of whether pam_namespace is present would allow newrole to
> immediately shed those capabilities for vanilla Fedora/RHEL users so
> that they have no additional exposure.
>
>   

Why not have newrole not be setuid at all, but when you install the LSPP 
package is sets it setuid.  Then we can only call pam_session if we are 
setuid.  (I think you can check that.)
If you want to use pam_namespace you need to setuid the app, for strict 
policy.

This way the bulk of users do not have another setuid app around.  
newrole is of little use currently in targeted policy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
