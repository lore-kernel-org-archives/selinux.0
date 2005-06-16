Subject: Re: Making libselinux depend on libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118944064.28244.4.camel@celtics.boston.redhat.com>
References: <1118944064.28244.4.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 13:59:11 -0400
Message-Id: <1118944751.30202.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-16 at 13:47 -0400, Ivan Gyurdiev wrote:
> I plan to add a function with this signature:
> 
> int security_map_policy(void** newdata, size_t* newlen)
> or security_create_policy 
> or security_construct_policy if you prefer..
> 
> It will go into a file called policy.c in libselinux,
> and security_load_policy will go in that file too.
> 
> The function would basically do what policycoreutils/load_policy.c
> does right now - put the policy, users, and booleans together
> in one simple function in a library form, as opposed to
> calling a tool to do it.
> 
> However, that makes libselinux depend on libsepol....
> Is that a bad thing?

No, it seems fine, and it is already the case that /sbin/init is
depending on libsepol (for the same reason).  This should simplify the
SELinux patch for /sbin/init and avoid the need to keep customizing it
whenever we add another form of runtime policy manipulation (e.g. in
addition to booleans and local users, there have also been requests to
allow local customizations of network contexts).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
