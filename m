Date: Fri, 12 Apr 2002 14:59:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Sung Kim <hunkim@cse.ucsc.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: How can I change the rols?
In-Reply-To: <Pine.GSO.4.44.0204121134280.9478-100000@sundance.cse.ucsc.edu>
Message-ID: <Pine.GSO.4.33.0204121451520.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Sung Kim wrote:

> 1. Can I change users' role without editing ploicy/users file?
>    Is there any command such as chgrole or something?

You need to edit policy/users (and reload the policy) if you want to
authorize a user for a new role.  If a user is already authorized for a
role and simply needs to enter it after login, he can use the newrole
command.

> 2. I specified root as sysadm_r, but it doesn't work.
>
> $id
> uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel)
> context=system_u:system_r:user_t sid=208

Looks like you aren't using the modified login and/or sshd programs.  Did
you do a full installation of SELinux in accordance with the instructions
in selinux/README on one of the recommended base platforms (RH7.1 or
RH7.2)?  Or, if you are using Debian, are you using Russell Coker's Debian
selinux package?

> 3. What is system_u and system_r?
>
> 4. How many role in selinux? system_r, user_r, sysadm_r, object_r?
> Can I make or specify a new role?
>
> 5. Is http_port_t (or *_t) kind of a role?

Please read the documentation available from
http://www.nsa.gov/selinux/docs.html, and check the mailing list archives
for prior questions and answers.  There is also a new policy report that
should be available soon.

To quickly cover your questions:
3.  system_u and system_r are a generic user identity and role for system
processes.
4.  The example policy defines three roles (system_r, user_r, sysadm_r)
plus the implicit object_r role for objects.  You can define new roles
simply by editing the policy configuration and reloading the policy.
5.  The http_port_t (or *_t) is a type.

Much more complete explanations are already available in the documentation
on the site.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
