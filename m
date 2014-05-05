Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s45GlHoL009397
 for <selinux@tycho.nsa.gov>; Mon, 5 May 2014 12:47:17 -0400
Message-ID: <5367C08F.1010804@redhat.com>
Date: Mon, 05 May 2014 12:47:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve Huston <huston@astro.princeton.edu>, selinux@tycho.nsa.gov
Subject: Re: staff_u permission
References: <CANnpg5Q8Uf23hKB1s3OtOQiXJSuUh5hyB08wkecWQ6U7oMusBA@mail.gmail.com>
In-Reply-To: <CANnpg5Q8Uf23hKB1s3OtOQiXJSuUh5hyB08wkecWQ6U7oMusBA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 05/05/2014 12:06 PM, Steve Huston wrote:
> Apologies if this subject doesn't make sense, I'm not only fairly new
> to selinux but also on Sudafed :>
>
> I'm setting up a Puppet server, and will have a Mercurial repository
> behind it; as a post-push hook I will have hg do a checkout of the
> repo to /etc/puppet (after having done some sanity checks on the
> changeset).  Right now, all the files in /etc/puppet are owned by root
> with a group that I and another can access, and have the context
> system_u:object_r:puppet_etc_t.
>
> My user account is part of the staff_u context, and I would like to
> tell selinux on this machine that anyone in that context should be
> allowed to edit those files.  Looking through with "sesearch -A -t
> puppet_etc_t -c file -p write" I see the puppet_t context allows such.
>  What I do not know is how to configure a transition or what else I
> could/should do to allow staff_u to write to just those files.  While
> I'm sure I could use a larger hammer, I would like to be in the
> practice of only allowing what should be allowed by default, and not a
> larger amount of permission just because it's easier.
>
> Can someone point me to the proper documentation for this?  If you
> want to spell out the answer that's great too, provided you tell me
> how you got it :>
>
First off, I hope you realize that you still need to allow DAC
permissions, meaning if users on the system were not allowed to edit
these files with SELinux in permissive mode or disabled, they still
would not be allowed to edit the files with SELinux in enforcing, no
matter the label.  You could add a group permissions to the /etc/puppet
directory and allow users in that group to write.  Another option would
be to allow the users to use sudo to get access to this directory.

If we want to leave the files labeled as puppet_etc_t, then simply
adding a custom policy like

# cat mystaff.te
policy_module(mystaff,1.0)
gen_require(`
type staff_t, puppet_etc_t;
')
manage_dirs_pattern(staff_t, puppet_etc_t, puppet_etc_t)
manage_files_pattern(staff_t, puppet_etc_t, puppet_etc_t)
manage_lnk_files_pattern(staff_t, puppet_etc_t, puppet_etc_t)

# make -f /usr/share/selinux/devel/Makefile
# semodule -i mystaff.pp
