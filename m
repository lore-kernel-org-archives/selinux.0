From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [RFC PATCH] SELinux: differentiate between open and r/w operations
Date: Fri, 22 Feb 2008 14:42:40 -0500
Cc: selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov, jmorris@namei.org,
        dwalsh@redhat.com
References: <1203706979.2914.46.camel@localhost.localdomain>
In-Reply-To: <1203706979.2914.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802221442.40801.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 22 February 2008 2:02:59 pm Eric Paris wrote:
> An often found problem with selinux in the wild is the use of things
> like stdout redirection to a file.  As an example it may be perfectly
> reasonable for a user to run a daemon in the foreground for debugging
> and pipe the output to a file in /tmp.  But it would unreasonable for
> that daemon to directly open a file in /tmp.  Currently SELinux sees
> both of these as the same security operation.
>
> By separating the open permission from the r/w permission we are able
> to more broadly grant r/w permissions while still being able to see
> and stop a number of attack vectors and misbehaving programs.
>
> ---
>
> This patch makes use of Paul Moore's new capability map but that was
> completely untested by me.  I actually just added a new selinuxfs
> file to turn these checks on and off at will during my testing and
> never even defined the permissions in my running policy.  So to say
> the least testing is a bit short.  Does it look right to you on first
> glance Paul?

The one thing that jumps out immediately is that you still need to add a 
policycap "name" to selinux_fs.c (search for "policycap_names" to see 
what I mean).  Other than that it looks reasonable to me - at first 
glance ;)  Also, don't forget to submit a patch to the userspace folks 
to add the new capability to the policy toolchain.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
