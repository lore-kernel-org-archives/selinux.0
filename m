From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: policy patches
Date: Thu, 30 Sep 2004 06:20:41 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200409292354.15227.russell@coker.com.au> <20040929174540.GA4373@rom.cip.ifi.lmu.de>
In-Reply-To: <20040929174540.GA4373@rom.cip.ifi.lmu.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZkxWBO06lnK2Yw5"
Message-Id: <200409300620.41527.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_ZkxWBO06lnK2Yw5
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 30 Sep 2004 03:45, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> > +ifdef(`unlimitedUsers', `
> > +role staff_r types rpm_t;
> > +domain_auto_trans(staff_t, rpm_exec_t, rpm_t)
> > +')
>
> AFAIK unlimitedUsers was removed recently, so this snippet makes no
> sense anymore.

Thanks, I've removed that from my tree.

> On Debian, it's
> /usr/sbin/nagios                --      system_u:object_r:nagios_exec_t
> and
> /usr/lib/cgi-bin/nagios         --      system_u:object_r:nagios_cgi_exec_t
>
> These should be added also.

Thanks for that.  I've attached a new nagios.fc with that change.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_ZkxWBO06lnK2Yw5
Content-Type: text/plain;
  charset="iso-8859-15";
  name="nagios.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nagios.fc"

# nagios - network monitoring server
/var/log/netsaint(/.*)?			system_u:object_r:nagios_log_t
/usr/lib(64)?/netsaint/plugins(/.*)?		system_u:object_r:bin_t
/usr/lib(64)?/cgi-bin/netsaint/.+	--	system_u:object_r:nagios_cgi_exec_t
# nagios
ifdef(`distro_debian', `
/usr/sbin/nagios		--	system_u:object_r:nagios_exec_t
/usr/lib/cgi-bin/nagios/.+	--	system_u:object_r:nagios_cgi_exec_t
', `
/usr/bin/nagios			--	system_u:object_r:nagios_exec_t
/usr/lib(64)?/nagios/cgi/.+	--	system_u:object_r:nagios_cgi_exec_t
')
/etc/nagios(/.*)?			system_u:object_r:nagios_etc_t
/var/log/nagios(/.*)?			system_u:object_r:nagios_log_t
/usr/lib(64)?/nagios/plugins(/.*)?	system_u:object_r:bin_t

--Boundary-00=_ZkxWBO06lnK2Yw5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
