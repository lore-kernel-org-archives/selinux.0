Subject: Re: launching apps at level (MLS) and polyinstantiation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted X Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <463243E3.2060602@gmail.com>
References: <463243E3.2060602@gmail.com>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 15:01:31 -0400
Message-Id: <1177700491.3357.113.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-27 at 13:41 -0500, Ted X Toth wrote:
> I'm working on an application that launches other applications at a 
> specified level. I have also configured polyinstantiation for a some 
> directories. What I have found is that I had to make this application 
> pam aware in order for the child process to get polyinstantiated 
> directories. One issue is the reauthentication I've already 
> authenticated why should I have to reauthenticate so that a child 
> process can use polyinstantiated directories? Currently this app works 
> when run as root but not as other users because the unshare call in 
> pam_namespace fails for lack of permissions (CAP_SYS_ADMIN?). What do I 
> need to do so that the application has this capability? I tried making 
> the app setuid but that didn't help.

First, your application sounds similar to newrole -l, so hopefully you
can draw from it.

What precisely requires your app to perform authentication?  You control
your app's pam config, so you can define those modules as you see fit,
including using trivial ones like pam_permit.so.  And you control
whether your app calls pam_authenticate().  Possibly you may need to set
up state to make pam_open_session() happy.

newrole has the same issue wrt needing capabilities, so look to it as an
example - look at the NAMESPACE_PRIV code.  It needs to be suid but also
needs to run in a domain that is allowed those capabilities.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
