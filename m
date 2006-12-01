Subject: Re: [RFC] Ability to allow unknown class and permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <1164989217.2079.106.camel@localhost.localdomain>
References: <1164989217.2079.106.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 13:41:09 -0500
Message-Id: <1164998469.23019.1065.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-12-01 at 11:06 -0500, Eric Paris wrote:
> Denials will show up in the logs just as if it were 'permissive' even
> though we are allowing checks against undefined classes and permissions.

I don't think that this is the desired behavior.   If the policy
indicates that undefined classes/perms should be allowed (via a flag in
the policy header), then we want the checks allowed silently as if the
check was not present at all.  Logging them as if permissive could
easily flood the logs.

> Decisions about unknown classes are not cached in the avc.

I think that this should be transparent to the AVC.  At policy load
time, you know which permissions are not defined in the policy, so you
can immediately set to 1s all such permission bits in the access vectors
in the avtab if the desired behavior is to allow undefined permissions,
and you can also generate a table of default access vectors per class
for the case where this is no avtab entry.  Then security_compute_av
just needs to handle undefined classes (return allowed vector with all
1s) and defined class but no avtab entry (return the default access
vector for the class).
 
> I also really really don't like the way the function
> security_class_defined_perm works, but i couldn't find a better way to
> figure out if the permission was defined.  At one point I built a really
> simple u32 perm_array[128] when we loaded policy and got the result I
> get from security_class_defined_perm simply by doing (requested_perm &
> perm_array[tclass]) but I didn't like the static array and the waste of
> memory.  Maybe it's better than the terrible function I came up with to
> find the information.  I'd love opinions.

You don't want to impose any significant extra overhead at permission
check time.  Precomputing things at policy load time is the way to go.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
