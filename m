Subject: Re: CentOS 5 RBAC
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Roy Badami <roy.badami@roboreus.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1314814992.6850.38.camel@moss-pluto>
References: <4E5E68DB.1030101@roboreus.com>
	 <1314810951.6850.26.camel@moss-pluto>  <4E5E7757.5030007@roboreus.com>
	 <1314814992.6850.38.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 31 Aug 2011 14:25:52 -0400
Message-ID: <1314815152.6850.39.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-08-31 at 14:23 -0400, Stephen Smalley wrote:
> On Wed, 2011-08-31 at 19:03 +0100, Roy Badami wrote:
> 
> > If the allow_sysadm_manage_security boolean was implemented in this
> > policy then I could simply set that to 'off'.   Given it's not -
> > what's the best way to grant this permission to secadm_r only?
> > Presumably I want to set secure_mode_loadpolicy to 'on' as now so that
> > the shipped policy doesn't give permissions, and then load some custom
> > TE rules to add the necessary permissions for secadm_r to administer
> > security policy? 
> 
> I think that would work and avoid the need to modify/rebuild the
> existing policy.
> 
> However, be aware that the sysadm vs secadm distinction is largely
> illusory even if you do this.  See this thread for further discussion:
> http://marc.info/?t=105457894700002&r=1&w=2

BTW, if you're looking to further harden your setup, you might want to
have a look at CLIP,
http://oss.tresys.com/projects/clip

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
