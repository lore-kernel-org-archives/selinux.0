Subject: Re: Doing testing with MCS looks like we get initial roles/levels
	by using fromcon.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <432B1BAC.9000800@redhat.com>
References: <4329DF91.2060208@redhat.com>
	 <1126873821.25919.20.camel@moss-spartans.epoch.ncsc.mil>
	 <432AFFE4.3010001@redhat.com>
	 <1126894521.27393.81.camel@moss-spartans.epoch.ncsc.mil>
	 <432B1157.8070703@redhat.com>
	 <1126896683.27393.100.camel@moss-spartans.epoch.ncsc.mil>
	 <432B1BAC.9000800@redhat.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 15:34:45 -0400
Message-Id: <1126899285.27393.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-16 at 15:23 -0400, Daniel J Walsh wrote:
> Ok do you want a function like the following
> 
> int get_ordered_context_list_with_level (const char *user,
>                      security_context_t fromcon,     
>                      const char *level,
>                      security_context_t **list)
> {
>     int rc;
>     int freefrom = 0;
>     security_context_t newcon=NULL;
>     context_t con;
> 
>     if (!fromcon) {
>     rc = getcon(&fromcon);
>     if (rc < 0)
>         return rc;
>     freefrom = 1;
>     }
>     con=context_new(fromcon);
>     context_range_set(con, level);
>     newcon=strdup(context_str(con));
>     context_free(con);
> 
>     rc = get_ordered_context_list (user, newcon, list);
>     freecon(newcon);
>     if (freefrom)
>         freecon(fromcon);
>     return rc;
> }

Yes, but with more error checking (context_range_set, context_str, and
strdup could all fail above).  You could also avoid the extra memory
allocation/copy for newcon by just deferring the context_free until
after the get_ordered_context_list call.

> Then we defined a functions
> 
> getseuserinfo(const char *username,  char **seusername,  char **selevel)
> 
> 
> so pam calls
> getseuserinfo(dwalsh, &sename, &selevel);
> get_ordered_context_list_with_level(sename, 0, selevel, &conlist);

Right.

Note btw that putting getseuserinfo into libsetrans doesn't help with
avoiding the whole ldap dependency for libselinux users since libselinux
dlopen's libsetrans, so you might as well just put it into libselinux
unless you are going to create yet another library for it.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
