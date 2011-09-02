Message-ID: <4E60DEE6.4030605@roboreus.com>
Date: Fri, 02 Sep 2011 14:49:26 +0100
From: Roy Badami <roy.badami@roboreus.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: CentOS 5 RBAC
References: <4E5E68DB.1030101@roboreus.com>	 <1314810951.6850.26.camel@moss-pluto>  <4E5E7757.5030007@roboreus.com> <1314814992.6850.38.camel@moss-pluto> <4E60BFF0.1070002@roboreus.com> <4E60CC80.1030001@tresys.com>
In-Reply-To: <4E60CC80.1030001@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> Any idea what it is that gives sysadm_t write access to selinux_config_t:file ?
>>
>> I can see the rule when I opne the binary policy in apol but I haven't had much luck tracking down where it comes from in the policy source.
> The auth_manage_all_files_except_shadow() call in userdom_admin_user_template().
>

Ah, thank you!  I would never have found that on my own, given the 
number of macros and attributes that everything indirects through!

So I'm beginning to realise that sysadm_r is probably the wrong starting 
point for me.  I think what I really want to be doing is probably 
creating a new 'limited admin' role (perhaps based on staff_r) and 
adding in only those permissions the role actually needs.

Thanks again,

roy

-- 
Roy Badami
Roboreus Ltd
1 New Oxford Street
London WC1A 1NU


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
