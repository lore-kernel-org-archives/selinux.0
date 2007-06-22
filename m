Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5M2vq1B011176
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 22:57:52 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5M2vfnL015161
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2007 02:57:46 GMT
Received: by wa-out-1112.google.com with SMTP id j5so535927wah
        for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 19:57:41 -0700 (PDT)
Message-ID: <467B3A22.4080602@gmail.com>
Date: Fri, 22 Jun 2007 10:55:30 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: Linux user / SELinux user changes...
References: <1181917726.17547.750.camel@moss-spartans.epoch.ncsc.mil> <1182365766.15064.199.camel@moss-spartans.epoch.ncsc.mil> <20070620201333.GC32520@sergelap.austin.ibm.com> <1182372732.15064.268.camel@moss-spartans.epoch.ncsc.mil> <20070620210835.GA21869@sergelap.austin.ibm.com> <1182428692.15064.277.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D03ABC378@de01exm68.ds.mot.com>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D03ABC378@de01exm68.ds.mot.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hasan Rezaul-CHR010 wrote:
>  
> Hi All,
> 
> If I have Linux users "root"  and "test"     and I have
> SELinux users  "staff_u", and "user_u",  and 
> SELinux roles  "staff_r", and "user_r"  
> 
> If I ssh into the Linux machine as test, my SELinux identity is user_u.
> If I ssh into the Linux machine as root, my SELinux identity is staff_u.
> 
> Lets say I ssh into my Linux machine as Linux user "root".
> "id -Z"  shows   staff_u:staff_r:staff_t
> 
> Now if I downgrade my Linux user priviledge to user "test" by using  su
> as follows:
> 
> su - test
> Pass: test
> 
> id -Z  =>  still shows me that I am staff_u , even though I am Linux
> user "test" (Linux user test should ideally be mapped to user_u).
> 
> Is there a way for SELinux to automatically adjust/change the SELinux
> user, whenever the Linux user is changed via "su"  ???

in original selinux, su can change context, including selinux user,
but now, su can not change selinux user at all, su/pam_selinux
had been reverted for a while. if you want to switch to admin role,
you must use "newrole"

furthermore, user_r can not switch to staff_r, you must map your
linux user identity to staff_u via semanage, before you switch to
admin role. the difference between staff_u and user_u is the former
can switch to admin role, i.e. sysadm_r(root)

http://marc.info/?l=selinux&m=118121922201142&w=2

this thread maybe help you


> 
> Thanks in advance,
> 
> - Rezaul.
> 
> P.S. I can appreciate why first logging in as Linux user test, and then
> su to root, will still keep my SELinux user to user_u.  But just curious
> if there is any flexibility in this regard ?
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
