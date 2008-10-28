Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9S5N3Qr006837
	for <selinux@tycho.nsa.gov>; Tue, 28 Oct 2008 01:23:03 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9S5N2ou019275
	for <selinux@tycho.nsa.gov>; Tue, 28 Oct 2008 05:23:02 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m9S5N2V0001480
	for <selinux@tycho.nsa.gov>; Tue, 28 Oct 2008 01:23:02 -0400
Message-ID: <4906A1B1.8050403@redhat.com>
Date: Tue, 28 Oct 2008 15:22:57 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>
Subject: user guide drafts: "Changing the Default Mapping" and "xguest: Kiosk
 Mode"
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The following are drafts for two sections for the "Confining Users" 
chapter. Any comments appreciated:

Changing the Default Mapping

In Fedora 10, Linux users are mapped to the SELinux __default__ login by 
default (which is mapped to the SELinux unconfined_u user). If you would 
like new Linux users, and Linux users not specifically mapped to an 
SELinux user to be confined by default, change the default mapping with 
the semanage login command.

The following example changes the default mapping from unconfined_u to 
user_u:

/usr/sbin/semanage login -m -S targeted -s "user_u" -r s0 __default__

As the Linux root user, run the semanage login -l command to verify that 
the __default__ login is mapped to user_u:

[example output]

If a new Linux user is created and an SELinux user is not specified, or 
if an existing Linux user logs in and does not match a specific entry 
from the semanage login -l output, they are mapped to user_u, as per the 
__default__ login.

To change back to the default behavior, run the following command as the 
Linux root user to map the __default__ login to the SELinux unconfined_u 
user:

/usr/sbin/semanage login -m -S targeted -s "unconfined_u" -r\
s0-s0:c0.c1023 __default__

xguest: Kiosk Mode

The xguest package provides a kiosk user account. This account is used 
to secure machines that people walk up to and use, such as those at 
libraries, banks, airports, information kiosks, and coffee shops. The 
kiosk user account is very locked down: essentially, it only allows 
users to log in, and then use the Firefox application to browse Internet 
websites. Any changes made while logged in with his account, such as 
creating files or changing settings, are lost when you log out.

To set up the kiosk account:

1. As the Linux root user, run yum install xguest command to install the 
xguest package. Install dependencies as required.

2. In order to allow the kiosk account to be used by a variety of 
people, the account is not password-protected, and as such, the account 
can only be protected if SELinux is running in enforcing mode. Before 
logging in with this account, use the getenforce command to confirm that 
SELinux is running in enforcing mode:

$ /usr/sbin/getenforce
Enforcing

If this is not the case, refer to Section 5.5, “SELinux Modes” for 
information about changing to enforcing mode. It is not possible to log 
in with this account if SELinux is in permissive mode or disabled.

3. You can only log in to this account via the GNOME Display Manager 
(GDM). Once the xguest package is installed, a Guest account is added to 
GDM. To log in, click on the Guest account:

[GDM screenshot]

Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
