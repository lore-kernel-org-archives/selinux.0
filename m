Subject: Re: CentOS 5 RBAC
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Roy Badami <roy.badami@roboreus.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4E5E68DB.1030101@roboreus.com>
References: <4E5E68DB.1030101@roboreus.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 31 Aug 2011 13:15:51 -0400
Message-ID: <1314810951.6850.26.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-08-31 at 18:01 +0100, Roy Badami wrote:
> I'm trying to understand the RBAC features in the version of the mls 
> (and also strict) policies that ship with CentOS 5.6 - I'm not sure if 
> this is the best place to ask or if there's a more appropriate list.
> 
> Starting with the mls policy, and setting the secure_mode_loadpolicy 
> boolean to 'on'  I then get that *neither* sysadm_r *nor* secadm_r can 
> issue commands such as setenforce.

secure_mode_policyload = 1 means "Don't allow any further policy
reloads, changing enforcing mode, or boolean changes (until next
reboot)."

The logic in selinux_set_enforce_mode() in
policy/modules/kernel/selinux.if is:
...
      if(!secure_mode_policyload) {
                allow $1 security_t:security setenforce;
...
}

Notice the logical negation (!) in the above if statement.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
