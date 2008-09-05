Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m852qbL2026178
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 22:52:37 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m852qaK8026622
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 02:52:37 GMT
Received: by py-out-1112.google.com with SMTP id a78so186635pyh.32
        for <selinux@tycho.nsa.gov>; Thu, 04 Sep 2008 19:52:36 -0700 (PDT)
Message-ID: <48C09EF0.10109@gmail.com>
Date: Thu, 04 Sep 2008 22:52:32 -0400
From: Ivan Gyurdiev <ivg231@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Joshua Brindle <method@manicmethod.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libsemage patch to not compile modules for seusers and fcontext
References: <48A48B8C.3070908@redhat.com>	 <1219412317.18600.60.camel@moss-spartans.epoch.ncsc.mil>	 <48B41D0E.6060509@redhat.com>  <48B4B348.2080801@gmail.com> <1219838648.5708.10.camel@moss-spartans.epoch.ncsc.mil> <48B5D8D4.8010502@tresys.com> <48BFFBD7.9070806@manicmethod.com> <48C03421.2040406@redhat.com>
In-Reply-To: <48C03421.2040406@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Testing results. On my rawhide system.
>
>
> NOTE: Rebuild policy old fashioned way
> # rpm -Uhv --force
> /home/dwalsh/sources/RPMS/noarch/selinux-policy*3.5.6-2.fc10.noarch.rpm
> Preparing...                ###########################################
> [100%]
>    1:selinux-policy         ###########################################
> [ 50%]
>    2:selinux-policy-targeted###########################################
> [100%]
>
>
> # grep root /etc/selinux/targeted/seusers
> /etc/selinux/targeted/modules/active/seusers
> /etc/selinux/targeted/modules/active/seusers.final
> /etc/selinux/targeted/seusers:root:unconfined_u:s0-s0:c0.c1023
> /etc/selinux/targeted/modules/active/seusers:root:unconfined_u:s0-s0:c0.c1023
> /etc/selinux/targeted/modules/active/seusers.final:root:unconfined_u:s0-s0:c0.c1023
>
> Note all three seusers files reference root.
>
> # semanage login -d root
> NOTE: Command did not fail.  This command is actually deleting the
> customization of root to use unconfined_u.
>
> # grep root /etc/selinux/targeted/seusers \
> /etc/selinux/targeted/modules/active/seusers \
> /etc/selinux/targeted/modules/active/seusers.final
> /etc/selinux/targeted/seusers:root:root:s0-s0:c0.c1023
> /etc/selinux/targeted/modules/active/seusers.final:root:root:s0-s0:c0.c1023
>
> NOTE root entry is still in
> /etc/selinux/targeted/modules/active/seusers.final and
> /etc/selinux/targeted/seusers
> But it is using SELinux User "root" now which is the default in the base
> package.
>   
This is very strange, since it is really not supposed to do that - how 
does it get the "root:root:s0-s0:c0.c1023" out of the base package 
without going through here ?
Is it still going through the old code path somehow ?

                if (sepol_module_package_get_seusers_len(base)) {
                        ofilename = semanage_path(SEMANAGE_TMP, 
SEMANAGE_SEUSERS);

There are other things to worry about, such as whether prefix 
information (users_extra file) is correctly merged from the base package.

Ivan






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
