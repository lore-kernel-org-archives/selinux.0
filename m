Subject: Re: SSH pubkey authentication & MLS policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Michael C Thompson <thompsmc@us.ibm.com>,
        "Serge E. Hallyn" <serue@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45129698.5080503@redhat.com>
References: <4511AAF2.8090809@us.ibm.com>  <45129698.5080503@redhat.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 12:31:59 -0400
Message-Id: <1158856319.3920.68.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-21 at 09:41 -0400, Daniel J Walsh wrote:
> Chris, how do you want to handle this?
[cut]
> > type=AVC msg=audit(1158784742.480:63): avc:  denied  { getattr } for 
> > pid=1798 comm="sshd" name="root" dev=sda3 ino=11436033 
> > scontext=system_u:system_r:sshd_t:s0-s15:c0.c255 
> > tcontext=root:object_r:sysadm_home_dir_t:s0-s15:c0.c255 tclass=dir
>
> > type=AVC msg=audit(1158784771.664:76): avc:  denied  { getattr } for 
> > pid=1827 comm="sshd" name="mcthomps" dev=sda3 ino=9175059 
> > scontext=system_u:system_r:sshd_t:s0-s15:c0.c255 
> > tcontext=user_u:object_r:user_home_dir_t:s0-s15:c0.c255 tclass=dir

Ok, I did two things.  I fixed userdom_search_all_users_home_content()
to use search_dir_perms instead of just search, and I changed the ssh
server template to use userdom_search_all_users_home_dirs() instead of
the above interface, since it only needs to search the top home dir to
get to $HOME/.ssh.  Searching subdirs of $HOME wouldn't be needed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
