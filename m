Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87Hp8fw005793
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:51:08 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l87Hp7dm017692
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 17:51:07 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Kernel panic when using refpolicy
Date: Fri, 7 Sep 2007 13:50:16 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801008CFA@exchange.columbia.tresys.com>
In-Reply-To: <000c01c7f17a$f2047130$c301000a@PC05>
From: "Brian M. Williams" <bwilliams@tresys.com>
To: "Kim Lawson-Jenkins" <lawson@itd.nrl.navy.mil>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please check which type of policy that you compiled in the build.conf, in RHEL5 if you build a non-mls non-mcs policy the system will not boot.  There is a bug in the RHEL5 kernel that will not be fixed until RHEL5 U1.

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov 
> [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of Kim Lawson-Jenkins
> Sent: Friday, September 07, 2007 14:15
> To: selinux@tycho.nsa.gov
> Subject: Kernel panic when using refpolicy
> 
> 
> Hi,
> 
> I'm running RHEL5.  I downloaded refpolicy-20070629.tar.bz2 and
> selinux-refpolicy-sources-20070629-1.noarch.rpm and installed 
> the files for
> the reference policy.  When rebooting the system there was a 
> fatal error -
> Kernel panic - not syncing: Fatal exception.
> 
> There were many unknown Boolean errors for 
> libsepol.load.booleans and there
> was the following error - 
> libsepol.sepol_genbools: error while reading 
> /etc/selinux/refpolicy/Booleans
> 
> It looks like ifconfig was running when the kernel panic occurred.  To
> recover booted into single-user mode and changed the 
> SELINUXTYPE in the file
> /etc/selinux/config from refpolicy to targeted.  I can easily 
> repeat the
> problem by using the SELinux Management Tool to change the 
> System Default
> Policy Type from targeted to refpolicy and rebooting.  I've 
> looked at all of
> the documentation to see if I missed a step or downloaded an 
> incorrect file
> but I can't find anything.  Can anyone give me some insight 
> into what the
> problem may be?  Thanks in advance for a response.
> 
> Kim
> 
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
