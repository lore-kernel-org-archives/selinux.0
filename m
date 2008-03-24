Subject: Re: /bin/passwd and a basic MLS install of Fedora 8
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200803240035.40028.russell@coker.com.au>
References: <200803240035.40028.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 24 Mar 2008 08:00:45 -0400
Message-Id: <1206360045.3302.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-24 at 00:35 +1100, Russell Coker wrote:
> -rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/bin/newgrp
> -rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/bin/rcp
> -rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/bin/rlogin
> -rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/bin/rsh
> -rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/kerberos/bin/ksu
> -rwsr-xr-x  root root 
> system_u:object_r:bin_t:SystemLow /usr/sbin/ccreds_validate
> -rws--x--x  root root system_u:object_r:bin_t:SystemLow /usr/sbin/userhelper
> -rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/sbin/userisdnctl
> -rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/sbin/usernetctl
> 
> 
> /tmp/a.out is a test program I wrote which calls setresuid(0,0,0); 
> system("/bin/bash");  But for the sake of discussion, let's assume it's one 
> of the above programs (from a minimal install of Fedora 8) which has been 
> cracked.  Of course it could also be one of the other SUID root programs 
> which are probably installed in a default or typical install but which have 
> no special labelling.
> 
> $ ls -lZ /tmp/a.out
> -rwsr-xr-x  root test user_u:object_r:bin_t:SystemLow  /tmp/a.out
> $ /tmp/a.out
> # id
> uid=0(root) gid=500(test) groups=500(test) 
> context=user_u:user_r:user_t:SystemLow
> # passwd
> Changing password for user root.
> New UNIX password:
> BAD PASSWORD: it is too short
> Retype new UNIX password:
> passwd: all authentication tokens updated successfully.
> 
> 
> Then of course I just ssh back in to the machine as root and get the context 
> root:sysadm_r:sysadm_t:SystemLow:SystemLow-SystemHigh.
> 
> 
> It seems to me that a reasonable way of preventing this particular attack (and 
> many others of a similar nature) is to have /bin/passwd check which identity 
> may be used for a login of the account which is getting it's password (or 
> finger name or shell) changed and then verify that it matches the identity 
> used to run /bin/passwd.  So for example if you change the password for 
> the "root" account then merely having UID=0 should not be sufficient, but 
> also having an identity of "root" (in the case of the default MLS policy) 
> would be required.
> 
> One possible ways of mitigating this are to cause domain transitions on every 
> execution of a SUID root program by labelling them all in an appropriate 
> manner (maybe even with a non_exec_t type for ones which can't be properly 
> supported with the policy that is running).  This could be helped by denying 
> user_t access to the setuid capability.
> 
> But then we have programs such as crontab which by design will run programs in 
> a different UID and if tricked into choosing the wrong UID will bring the 
> same problem back.  This is not to say that relabelling some of the programs 
> such as rcp, rlogin, etc isn't a good idea - merely that I don't think it 
> removes the need for extra checks in /bin/passwd.

Should be blocked by SELinux permission checks applied by passwd and
friends.  If not, that's a bug that needs to be filed against those
programs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
