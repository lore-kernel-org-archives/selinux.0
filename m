Message-ID: <432AFFE4.3010001@redhat.com>
Date: Fri, 16 Sep 2005 13:24:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Doing testing with MCS looks like we get initial roles/levels
 by using fromcon.
References: <4329DF91.2060208@redhat.com> <1126873821.25919.20.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126873821.25919.20.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2005-09-15 at 16:54 -0400, Daniel J Walsh wrote:
>  
>
>>As a test I added the following function to pam_selinux.so
>>
>>security_context_t getprefcon(const char *name);
>>security_context_t getprefcon(const char *name) {
>>    security_context_t fromcon;
>>    security_context_t newcon=NULL;
>>    context_t con;
>>    if (strcmp(name, "root") == 0)
>>        return NULL;
>>    if (getcon(&fromcon) < 0)
>>      return NULL;
>>    con=context_new(fromcon);
>>    context_range_set(con, "s0:c1,c4");
>>    newcon=strdup(context_str(con));
>>    context_free(con);
>>    freecon(fromcon);
>>    return newcon;
>>}
>> ...
>>
>>
>>  fromcon=getprefcon(username);
>>  num_contexts = get_ordered_context_list(username, fromcon, &contextlist);
>>  if (fromcon)
>>      freecon(fromcon);
>>
>>And it seems to handle the levels fine, so I don't think we need 
>>anything special in libselinux.  Just need to figure out how pam will 
>>get the preferred context.  Did not test with prefered fole.
>>    
>>
>
>Hi,
>
>A few observations:
>1) We need this functionality in more than just pam_selinux, as we need
>the same logic to be applied from sshd (direct selinux patch), crond
>(direct selinux patch), etc.  So that's why it needs to go into
>libselinux or glibc or some shared library.
>
>  
>
Yes, I agree I just hacked this up to test it and see if 
get_ordered_context_list did the right thing.
And I was happily surprised when it did.

>2) The idea is supposed to be that we have a mapping from Linux username
>to (SELinux username, default role, default range) so that we no longer
>need to add SELinux users whenever we want a different default role or a
>different default range for a given Linux user.  So the idea is that we
>call a function to lookup the (SELinux username, <context blob ==
>default role:default range>) for the Linux username, then pass that data
>to another function to create an actual context for the user.  For
>example, the mapping might contain:
>dwalsh	staff_u	staff_r:s0:c0,c12
>sds	staff_u sysadm_r:s1:c2,c3
>And the SELinux policy would just have:
>user staff_u roles { staff_r sysadm_r } level s0 range s0-s9:c0.c127
>
>  
>
>And then when you login, you become staff_u:staff_r:s0:c0,c12 but I
>become staff_u:sysadm_r:s1:c2,c3.  So the sysadmin can assign default
>roles and ranges for individual Linux users just by changing the mapping
>file, without needing to touch the policy.
>
>  
>
Yes, but with this change the "username" field in the 
get_ordered_context_list becomes useless.
I know this was discussed heavily in the past but not sure we came to 
conclusion.

Since we are looking to add this functionality to make MCS work, I think 
we need to finalize this now.

Options seem to be:

pam modules and some apps like sshd will call


int getseprefcon(const char *name,  selinux_context_t *prefcon)

to get the preferred context.

This function will be defined in one of the following libraries.

libselinux:
I don't think it should.  Libselinux should just deal with selinux users.
libsemanage:
Might be a first use of libsemanage
libsetrans:
Could add functionality to allow it to "translate" Linux users into 
selinux users.

First release will probably be a flat file that defaults to returning 
"u_default" entry.
for targeted something like...
u_default=user_u:system_r:unconfined_t:s0
for strict something like:
u_default=user_u:user_r:user_t:s0

Eventually this will be build a "selinux" daemon which will provide this 
information and translations from remote information sources (LDAP).

>3) Watch out for differences between targeted and strict; testing under
>targeted isn't going to show you much about what will happen when you
>have multiple user roles.
>  
>
Understood.

>4) This discussion should be occurring on list. 
>
>  
>
I added it to list.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
