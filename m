Message-ID: <1486060482.1887.73.camel@tycho.nsa.gov>
Subject: Re: possible regression in "semanage user"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Date: Thu, 02 Feb 2017 13:34:42 -0500
In-Reply-To: <3837461d-1104-fcd3-eb01-77faf3bb4b0b@redhat.com>
References: <3837461d-1104-fcd3-eb01-77faf3bb4b0b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-02-02 at 18:22 +0100, Vit Mojzis wrote:
> Hi list,
> we have a report about a possible regression in "semanage user" and
> I'd 
> like to hear your opinion on what the correct behaviour should be.
> 
> Given that local changes have been made to a SELinux user definition 
> (originally defined in policy)
> e.g. # semanage user -m staff_u -r "s0"
> and the SELinux user is mapped to some Linux user
> # semanage login -a -s staff_u staff
> both
> # semanage user -d staff_u
> and
> # semanage user --deleteall
> will fail to remove the local change with the following message:
> "libsemanage.lookup_seuser: staff_u is being used by staff login
> record 
> (Invalid argument)."
> 
> Is this the intended behaviour?
> 
> I would assume that this error message was intended only for locally 
> defined SELinux users (in which case "semanage user -d selinux_user" 
> would remove the only definition of "selinux_user"). If so, is there
> any 
> way to determine if a SELinux user has been defined only locally (as 
> opposed to being defined in policy) after some local changes have
> been made?

This appears to work correctly for me with release 20161014 (2.6); the
two delete commands you specified above succeeded and the entry was
removed.  What version are you using?
