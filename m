Message-ID: <432B1157.8070703@redhat.com>
Date: Fri, 16 Sep 2005 14:39:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Doing testing with MCS looks like we get initial roles/levels
 by using fromcon.
References: <4329DF91.2060208@redhat.com>	 <1126873821.25919.20.camel@moss-spartans.epoch.ncsc.mil>	 <432AFFE4.3010001@redhat.com> <1126894521.27393.81.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126894521.27393.81.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2005-09-16 at 13:24 -0400, Daniel J Walsh wrote:
>  
>
>>Yes, I agree I just hacked this up to test it and see if 
>>get_ordered_context_list did the right thing.
>>And I was happily surprised when it did.
>>    
>>
>
>For the range, yes - the fromcon range implicitly bounds the possible
>range of the user.  But it won't generalize to the role (fromcon user
>may not be authorized for the role of the user at all), and it is really
>a misuse of the existing interface.
>
>  
>
>>Yes, but with this change the "username" field in the 
>>get_ordered_context_list becomes useless.
>>I know this was discussed heavily in the past but not sure we came to 
>>conclusion.
>>    
>>
>
>Not sure I follow; username argument to libselinux is supposed to be the
>SELinux username, as looked up previously based on the Linux username.
>It is true that if the <context data> includes both a default role and a
>default range for the Linux user, the only thing we are getting from
>libselinux is taking the inputs (SELinux username, default role:default
>range), determining the default type, and putting it all together into a
>context.  At which point we are fairly close to just defining
>per-Linuxuser default contexts directly in this mapping configuration
>without needing to query libselinux at all.
>
>  
>
>>Since we are looking to add this functionality to make MCS work, I think 
>>we need to finalize this now.
>>
>>Options seem to be:
>>
>>pam modules and some apps like sshd will call
>>
>>
>>int getseprefcon(const char *name,  selinux_context_t *prefcon)
>>
>>to get the preferred context.
>>    
>>
>
>Hmmm...the original idea IIRC was to change current callers of
>get_default_context or get_ordered_context_list (including pam_selinux,
>sshd, crond, sudo, and others) to first call an interface like
>getuserseinfo(const char *linuxuser, char **seuser, char
>**secontextdata) that could be implemented in libselinux or elsewhere
>(since glibc/nss wasn't accepted) and then call a new libselinux
>interface like getseusercontext(const char *seuser, const char
>*secontextdata, security_context_t *usercon) to get the actual user
>context based on the result of the first call.
>  
>
Not sure how the admim would set this up.  I was thinking the admin 
would just state that
when dwalsh logs in I want this as his preferred context.  Policy could 
allow or modify the preferred context
as it sees fit.  Anyways we need this interface now, in order to make 
MCS and eventually MLS usefull.

>  
>
>>This function will be defined in one of the following libraries.
>>
>>libselinux:
>>I don't think it should.  Libselinux should just deal with selinux users.
>>    
>>
>
>If we can't get the first function in glibc/nss, then the most natural
>place is libselinux.  In which case we can actually simplify the
>interface by just providing a single unified getseusercontext(const char
>*linuxuser, security_context_t *usercon) function that internally does
>both the lookup and the creation of the context.  Then
>pam_selinux/sshd/crond/etc just call that one interface.
>
>  
>
I disagree.  I think we need them separate so that we could eventually 
get them into glibc/nss.  Putting them in libselinux, forces everything 
that links with libselinux to eventually link ldap and friends.  

>>libsemanage:
>>Might be a first use of libsemanage
>>    
>>
>
>No, login et al shouldn't be invoking libsemanage at all.
>
>  
>
>>libsetrans:
>>Could add functionality to allow it to "translate" Linux users into 
>>selinux users.
>>    
>>
>
>Doesn't seem quite right, as presently libsetrans is purely optional and
>only indirectly called through libselinux.  If pam_selinux and the
>SELinux patches for sshd, crond, etc are going to directly invoke these
>new interfaces, I think they have to go into libselinux.
>
>  
>
Correct and this translation would be purely option from libselinux 
point of view.  pam and other freinds need it.

>>First release will probably be a flat file that defaults to returning 
>>"u_default" entry.
>>for targeted something like...
>>u_default=user_u:system_r:unconfined_t:s0
>>for strict something like:
>>u_default=user_u:user_r:user_t:s0
>>    
>>
>
>One issue to keep in mind here is that the current default_contexts
>scheme allows for different default contexts based on the fromcon, so
>local root login can default to sysadm_r while remote root login can
>default to staff_r, and cron jobs can run in derived domains (e.g.
>staff_r:staff_crond_t) with a more limited permission set.  This new
>scheme doesn't take the fromcon into account.
>
>  
>
Yes.  This might be a reason to change the function call, although as 
your example showed it
might it be disconcerting from the user to request he logs in as role 
(nurse_r) but gets user_r when logging in locally.



-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
