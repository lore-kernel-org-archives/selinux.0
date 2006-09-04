Subject: newrole policy changes for lspp specific requirements ..
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: sds@tycho.nsa.gov, sgrubb@redhat.com, dwalsh@redhat.com, tmraz@redhat.com,
        klaus@atsec.com
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 04 Sep 2006 17:05:52 -0400
Message-Id: <1157403953.7223.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In order for newrole to correctly re-polyinstantiate directories
when a user changes context, newrole calls session management
services of pam_namespace. pam_namespace needs CAP_SYS_ADMIN
(for bind mount/unmount) and CAP_DAC_OVERRIDE, CAP_FOWNER and
CAP_CHOWN capabilities (for creating and assigning appropriate
mode to potential new instance directories). In the current
mls policy, newrole_t has all of needed capabilities except
the CAP_CHOWN. The following allow rule should go in the
the appropriate lspp related loadable policy module's *.te
file. 

allow newrole_t self:capability chown;

This can be added to the loadable module that adds the
auditallow rule to audit setfscreate actions.

Thanks.

-Janak




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
