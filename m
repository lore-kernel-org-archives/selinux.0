Message-ID: <4E60BFF0.1070002@roboreus.com>
Date: Fri, 02 Sep 2011 12:37:20 +0100
From: Roy Badami <roy.badami@roboreus.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: CentOS 5 RBAC
References: <4E5E68DB.1030101@roboreus.com>	 <1314810951.6850.26.camel@moss-pluto>  <4E5E7757.5030007@roboreus.com> <1314814992.6850.38.camel@moss-pluto>
In-Reply-To: <1314814992.6850.38.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I think that would work and avoid the need to modify/rebuild the
> existing policy.
>
> However, be aware that the sysadm vs secadm distinction is largely
> illusory even if you do this.  See this thread for further discussion:
> http://marc.info/?t=105457894700002&r=1&w=2
>

Any idea what it is that gives sysadm_t write access to 
selinux_config_t:file ?

I can see the rule when I opne the binary policy in apol but I haven't 
had much luck tracking down where it comes from in the policy source.


-- 
Roy Badami
Roboreus Ltd
1 New Oxford Street
London WC1A 1NU


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
