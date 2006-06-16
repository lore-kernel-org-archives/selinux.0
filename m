Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5GJvVn5003368
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 15:57:31 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5GJvUjX009418
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 19:57:30 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5GJvUOc007821
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 15:57:30 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5GJvObC021583
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 15:57:24 -0400
Message-ID: <44930D28.2010103@redhat.com>
Date: Fri, 16 Jun 2006 15:57:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Got up at 5 AM, and thought I would try to write a new role
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I wanted to try to create an auditadm_r.

I was surprised how easy it was.   Had to trim down the 
base_user_template, and add a couple of apache interfaces,
but basically ended up with the following.  Tried it out on an MLS 
machine and it seems to work pretty well.  I even
have it defined as a loadable module. Comments below.  One problem is we 
need an easier way of handling
/etc/selinux/mls/contexts/default_type.  Had to add httpdadm_r:httpdadm_t.

semanage users -m -R httpdadm_r SELINUXUSER

policy_module(httpdadm,1.0.0)

########################################
#
# Declarations
#
gen_require(`
        role staff_r;
        type staff_devpts_t, staff_tty_device_t, staff_t;
')


define(`role_change',`
        allow $1_r $2_r;
        type_change $2_t $1_devpts_t:chr_file $2_devpts_t;
        type_change $2_t $1_tty_device_t:chr_file $2_tty_device_t;
        # avoid annoying messages on terminal hangup
        dontaudit $1_t { $2_devpts_t $2_tty_device_t }:chr_file ioctl;
')
#####  Need to figure out a way make role_change a callable function.  
Perhaps just define staff_role_change and user_role_change

minimal_user_template(httpdadm)
####  Needed to strip down base_user_template.  Do not want to create 
homedirs and eliminate all of the optional policy.  Talked to Chris 
about breaking
####  base_user_template into a series of templates.
role_change(staff,httpdadm)
#### Would prefer staff_role_change (httpadm)

files_read_usr_files(httpdadm_t)
#### Probably should be defined in one of the base_user_templates, since 
this is pretty much required if you have a shell.

apache_manage_all_content(httpdadm_t)
apache_manage_log(httpdadm_t)
apache_manage_config(httpdadm_t)


##### Problems, I can't easily modify the running service.  IE I would 
figure the auditadmin would want to be able to start/stop/signal the 
service. 
##### But we do not have an easy way of doing only one service, and not 
all the rest.  Might have to add the ability to run su/sudo so if you 
newrole
##### first it will work.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
