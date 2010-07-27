Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6RCSfIn009065
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 08:28:41 -0400
Received: from e8.ny.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6RCSkeY028147
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 12:28:46 GMT
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6RCQO8o023187
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 08:26:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o6RCSdH4391846
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 08:28:40 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o6RCSdst008671
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 09:28:39 -0300
Received: from [9.65.112.245] (sig-9-65-112-245.mts.ibm.com [9.65.112.245])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id o6RCSdW7008647
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 09:28:39 -0300
Subject: ima-appraisal: CAP_MAC_ADMIN w/SELinux
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: selinux@tycho.nsa.gov
In-Reply-To: <201006010935.15976.sgrubb@redhat.com>
References: 
	 <OF4AB3814C.68684AEB-ON8625771A.0055A68D-8625771A.00587153@us.ibm.com>
	 <1273097271.11502.99.camel@localhost.localdomain>
	 <1275272007.8204.0.camel@localhost.localdomain>
	 <201006010935.15976.sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 08:28:38 -0400
Message-ID: <1280233718.19585.33.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm seeing some interesting behavior in ima_inode_setxattr() with an
SELinux targeted policy enabled. Unlike the definition for
CAP_SYS_ADMIN, CAP_MAC_ADMIN does not permit root to write extended
attributes. (Without SELinux enabled, root can write 'security.ima'.)
Is this the intended behavior?

Without this permission, restorecond is also unable to write extended
attributes. 

kernel: type=1400 audit(1279830569.844:4): avc:  denied  { mac_admin }
for  pid=447 comm="restorecon" capability=33
scontext=system_u:system_r:setfiles_t:s0
tcontext=system_u:system_r:setfiles_t:s0 tclass=capability2

/*
* ima_protect_xattr - protect 'security.ima'
*
* Ensure that not just anyone can modify or remove 'security.ima'.
*/
int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
                      const void *xattr_value, size_t xattr_value_len)
{
        if ((strcmp(xattr_name, XATTR_NAME_IMA) == 0)
            && !capable(CAP_MAC_ADMIN))
                return -EPERM;
        return 0;
}

Adding the following rules, permits root and restorecond to write
'security.ima'. 

module local-cap 1.0;

require {
	type setfiles_t;
	type unconfined_t;
	class capability2 mac_admin;
}

#============= setfiles_t ==============
allow setfiles_t self:capability2 mac_admin;
allow unconfined_t self:capability2 mac_admin;

thanks,

Mimi




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
