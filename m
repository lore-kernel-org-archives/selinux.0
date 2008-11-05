Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA5GIwE4018362
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 11:18:58 -0500
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA5GIreQ002581
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 16:18:58 GMT
Received: by nf-out-0910.google.com with SMTP id b21so39943nfd.4
        for <selinux@tycho.nsa.gov>; Wed, 05 Nov 2008 08:18:52 -0800 (PST)
Message-ID: <dd18b0c30811050818j42da8ae3q8c1f95450ed6c926@mail.gmail.com>
Date: Wed, 5 Nov 2008 08:18:52 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Andy Warner" <warner@rubix.com>
Subject: Re: using roles with mls policy
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4911BCB9.1060407@rubix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4911BCB9.1060407@rubix.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 5, 2008 at 7:33 AM, Andy Warner <warner@rubix.com> wrote:
> I am using Fedora 9 with the MLS policy. I have been using it in permissive
> mode for a while (integrating SELinux with a DBMS and its objects) and now
> must do some work/testing in enforcing mode. As soon as I switch to
> enforcing mode I seem unable to perform any action which requires privilege.
>
> What is the anticipated method to shutdown/reboot the system and to toggle
> the enforcing mode while in MLS/Enforcing? What I assumed was to transition
> to an appropriate role (sysadm_r and secadm_r respectively) and then issue
> the corresponding command (shutdown and setenforce). This fails and I
> believe my difficulty is that in both cases I need to also be the linux root
> user. There does not seem to be an obvious way to execute a command as the
> lunux root user as neither su nor sudo seem available while in the sysadm_r
> and secadm_r roles. Executing something like seaudit while in the auditadm_r
> role fails to allow me to authenticate as root. Despite being the correct
> password it continuously loops asking for the password.
>
> As a related but less important question, in general, is it intended that a
> user initially have the staff_r role upon login and then transition to a
> more trusted role (i.e., secadm_r) using the newrole command? (as opposed to
> having the secadm_r upon login.
>
> Thanks for any help,
>
> Andy
>
>
>

Not sure how red hat works,
but for me using ubuntu having to change roles
I first needed to collect all of the allow rules, i.g.
allow newrole_t staff_t:process  etc...
then after after a reboot into enforce mode
using newrole -r works fine.(just haven't defined secadm_r yet).
As for toggling from enforce to permissive
using setenforce 0 or 1
or echo 0/1 > /selinux/enforce.


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
