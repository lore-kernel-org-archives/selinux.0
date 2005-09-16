Message-ID: <432B1BAC.9000800@redhat.com>
Date: Fri, 16 Sep 2005 15:23:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Doing testing with MCS looks like we get initial roles/levels
 by using fromcon.
References: <4329DF91.2060208@redhat.com>	 <1126873821.25919.20.camel@moss-spartans.epoch.ncsc.mil>	 <432AFFE4.3010001@redhat.com>	 <1126894521.27393.81.camel@moss-spartans.epoch.ncsc.mil>	 <432B1157.8070703@redhat.com> <1126896683.27393.100.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126896683.27393.100.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2005-09-16 at 14:39 -0400, Daniel J Walsh wrote:
>  
>
>>Not sure how the admim would set this up.  I was thinking the admin 
>>would just state that
>>when dwalsh logs in I want this as his preferred context.  Policy could 
>>allow or modify the preferred context
>>as it sees fit.
>>    
>>
>
>No, I don't think we want them specifying a full context.  Considering
>it further, I don't think they should even specify the role.  They can
>just specify a SELinux username and a range, and let the rest of the
>context (role, type) be computed based on policy in the usual manner, so
>that we can still have per-fromcon roles and types for a given user.
>
>  
>
>>Correct and this translation would be purely option from libselinux 
>>point of view.  pam and other freinds need it.
>>    
>>
>
>But if pam and other SELinux userland depends on it and you put it into
>libsetrans, then it has to be provided by every libsetrans
>implementation, not just yours.  At which point it would be better to
>have it in a separate library that doesn't have multiple instances.  
>
>  
>
>>Yes.  This might be a reason to change the function call, although as 
>>your example showed it
>>might it be disconcerting from the user to request he logs in as role 
>>(nurse_r) but gets user_r when logging in locally.
>>    
>>
>
>Admin should just specify that the Linux user default to nurse_u and
>s0:c0,c3 and let the usual rules apply to role and type selection for
>nurse_u.
>
>  
>
Ok do you want a function like the following

int get_ordered_context_list_with_level (const char *user,
                     security_context_t fromcon,     
                     const char *level,
                     security_context_t **list)
{
    int rc;
    int freefrom = 0;
    security_context_t newcon=NULL;
    context_t con;

    if (!fromcon) {
    rc = getcon(&fromcon);
    if (rc < 0)
        return rc;
    freefrom = 1;
    }
    con=context_new(fromcon);
    context_range_set(con, level);
    newcon=strdup(context_str(con));
    context_free(con);

    rc = get_ordered_context_list (user, newcon, list);
    freecon(newcon);
    if (freefrom)
        freecon(fromcon);
    return rc;
}

Then we defined a functions

getseuserinfo(const char *username,  char **seusername,  char **selevel)


so pam calls
getseuserinfo(dwalsh, &sename, &selevel);
get_ordered_context_list_with_level(sename, 0, level, &conlist);

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
