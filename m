Subject: Re: SELinux and LFS
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov
In-Reply-To: <1171573160.32574.138.camel@moss-spartans.epoch.ncsc.mil>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1171567396.3579.4.camel@desk.netwosix.org>
	 <1171567885.32574.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1171569528.4569.9.camel@desk.netwosix.org>
	 <1171569824.32574.91.camel@moss-spartans.epoch.ncsc.mil>
	 <1171571029.4569.18.camel@desk.netwosix.org>
	 <1171571692.32574.119.camel@moss-spartans.epoch.ncsc.mil>
	 <1171572168.5239.0.camel@desk.netwosix.org>
	 <1171572980.18488.30.camel@localhost.localdomain>
	 <1171573160.32574.138.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-htSJSwsPfDsJDO6muMy7"
Date: Thu, 15 Feb 2007 22:53:32 +0100
Message-Id: <1171576412.5239.15.camel@desk.netwosix.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-htSJSwsPfDsJDO6muMy7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Il giorno gio, 15/02/2007 alle 15.59 -0500, Stephen Smalley ha scritto:

> Don't know about the /bin and /boot issues, but for /dev, I'd suggest
> checking that your udev is built with selinux support enabled.  And also
> you should do a restorecon -R /dev from rc.sysinit or similar, as there
> will be some nodes created before selinux policy gets loaded.

Ops. In the attach the /etc/rc. It's really late here guys.

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>

--=-htSJSwsPfDsJDO6muMy7
Content-Disposition: attachment; filename=selinux-netwosix.txt
Content-Type: text/plain; name=selinux-netwosix.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

ELinux on Netwosix

/sbin/restorecon -R /dev

SELINUX=
if [ -r /selinux/enforce ] ; then
                SELINUX= 'cat /selinux/enforce'
else
        SELINUX=1
fi

# Other SELINUX stuff

        disable_selinux() {
                echo $"*** Warning -- SELinux is active"
                echo $"*** Disabling security enforcement for system recovery."
                echo $"*** Run 'setenforce 1' to reenable."

                echo "0" > /selinux/enforce

                }


   relabel_selinux() {
                echo
                echo $"*** Warning -- SELinux policy relabel is required. "
                echo $"*** Disabling security enforcement."
                echo $"*** Relabeling could take a very long time,"
                echo $"*** depending on file system size."

                echo "0" > /selinux/enforce
                /sbin/fixfiles -f -F relabel > /dev/null 2>&1
                rm -f /.autorelabel
                echo "*** Enabling security enforcement.        ***"
                echo $SELINUX > /selinux/enforce
}


--=-htSJSwsPfDsJDO6muMy7--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
