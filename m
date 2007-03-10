Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2ADX6CF032683
	for <selinux@tycho.nsa.gov>; Sat, 10 Mar 2007 08:33:06 -0500
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2ADX4pT012582
	for <selinux@tycho.nsa.gov>; Sat, 10 Mar 2007 13:33:05 GMT
In-Reply-To: <1173476884.29664.21.camel@sgc>
References: <44406275-10D4-4C48-A050-D8ECA4127216@sf-net.com> <200703050858.29982.russell@coker.com.au> <1173476884.29664.21.camel@sgc>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C85F5DDA-FEB4-4C4B-B77D-85D9F16D231F@sf-net.com>
Cc: russell@coker.com.au, SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: Changes to apt policy
Date: Sat, 10 Mar 2007 14:31:44 +0100
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 09.03.2007, at 22:48, Christopher J. PeBenito wrote:

> On Mon, 2007-03-05 at 08:58 +1100, Russell Coker wrote:
>> On Sunday 04 March 2007 10:08, Stefan Schulze Frielinghaus  
>> <stefan@sf-net.com>
>> wrote:
>>> to get aptitude working quite nice a logfile and a lockfile have to
>>> be created. The patches attached should allow this. Also aptitude
>>> writes to the home directory $HOME/.aptitude where configfiles etc.
>>> are in. I tried to learn from the gpg and screen policy files how to
>>> handle such a situation (per_role_template) but please look at it  
>>> and
>>> correct any mistakes ;-)
>>
>> The apt.te patch seems OK.
>
> I have some changes, for example, you can't require a type.  Also, we
> don't need the append files pattern here since the log file doesn't  
> have
> its own directory.  I also suspect it should be able to create the  
> file
> too.  This is how I suspect it should be:
>
> Index: policy/modules/admin/apt.te
> ===================================================================
> --- policy/modules/admin/apt.te (revision 2209)
> +++ policy/modules/admin/apt.te (working copy)
> @@ -12,6 +12,14 @@
>  domain_system_change_exemption(apt_t)
>  role system_r types apt_t;
>
> +# lock file
> +type apt_lock_t;
> +files_lock_file(apt_lock_t)
> +
> +# logfile
> +type apt_log_t;
> +logging_log_file(apt_log_t)
> +
>  type apt_tmp_t;
>  files_tmp_file(apt_tmp_t)
>
> @@ -46,6 +54,14 @@
>  allow apt_t self:msgq create_msgq_perms;
>  allow apt_t self:msg { send receive };
>
> +# lock file access
> +allow apt_t apt_lock_t:file { create_file_perms lock rw_file_perms };
> +files_lock_filetrans(apt_t,apt_lock_t,file)
> +
> +# logging
> +allow apt_t apt_log_t:file { create_file_perms append_file_perms };
> +logging_log_filetrans(apt_t,apt_log_t,file)
> +
>  # Access /var/cache/apt files
>  manage_files_pattern(apt_t,apt_var_cache_t,apt_var_cache_t)
>  files_var_filetrans(apt_t,apt_var_cache_t,dir)

Jep the patch is working fine for me.

But what about the problem writing to the sysadm home dir? Here is an  
output from audit2allow:

allow apt_t sysadm_home_t:dir { add_name read remove_name search  
write };
allow apt_t sysadm_home_t:file { create read rename unlink write };

This is due the fact that aptitude is writing and reading to  
$HOME/.aptitude

I would suggest to add a per role template like I added some emails  
ago. Another suggestion would be to add a hardcoded file context to "/ 
root/.aptitude" and label these files as "sysadm_home_apt_t". I think  
both versions are ok because only a sysadm + root will run aptitude  
but you never now what the future will bring and a per role template  
grants us more liberty ;-)

Regards,
Stefan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
