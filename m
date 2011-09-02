Message-ID: <4E60CC80.1030001@tresys.com>
Date: Fri, 2 Sep 2011 08:30:56 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Roy Badami <roy.badami@roboreus.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Subject: Re: CentOS 5 RBAC
References: <4E5E68DB.1030101@roboreus.com>	 <1314810951.6850.26.camel@moss-pluto>  <4E5E7757.5030007@roboreus.com> <1314814992.6850.38.camel@moss-pluto> <4E60BFF0.1070002@roboreus.com>
In-Reply-To: <4E60BFF0.1070002@roboreus.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/02/11 07:37, Roy Badami wrote:
> 
>> I think that would work and avoid the need to modify/rebuild the
>> existing policy.
>>
>> However, be aware that the sysadm vs secadm distinction is largely
>> illusory even if you do this.  See this thread for further discussion:
>> http://marc.info/?t=105457894700002&r=1&w=2
>>
> 
> Any idea what it is that gives sysadm_t write access to selinux_config_t:file ?
> 
> I can see the rule when I opne the binary policy in apol but I haven't had much luck tracking down where it comes from in the policy source.

The auth_manage_all_files_except_shadow() call in userdom_admin_user_template().

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
