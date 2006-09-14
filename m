Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8EIso5A014116
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 14:54:50 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8EIsNTl003265
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 18:54:24 GMT
In-Reply-To: <1158178755.15278.186.camel@moss-spartans.epoch.ncsc.mil>
References: <p06002030c12ded62fc17@[192.168.50.32]> <1158178755.15278.186.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <76A138F7-7C39-423B-B6D8-6D6E5EA03CEA@nall.com>
Cc: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>, janak@us.ibm.com,
        LSPP <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov
From: Joe Nall <joe@nall.com>
Subject: Re: [redhat-lspp] Re: Polyinstantiation based on context with MLS
Date: Thu, 14 Sep 2006 13:54:12 -0500
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sep 13, 2006, at 3:19 PM, Stephen Smalley wrote:

>
> As a side bar, it looks like there is an error in the build of the - 
> mls
> policy that is leaving the usual polyinstantiation-related rules
> disabled (controlled by the POLY= build option).

I think this spec file change will fix the error

--- selinux-policy.spec.orig    2006-09-14 08:46:07.000000000 -0500
+++ selinux-policy.spec 2006-09-14 08:46:59.000000000 -0500
@@ -73,8 +73,8 @@ SELinux Policy development package
%dir %{_usr}/share/selinux/mls

%define setupCmds() \
-make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} POLY=%3 bare \
-make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} POLY=%3  conf \
+make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} POLY=%4 bare \
+make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} POLY=%4  conf \
cp -f ${RPM_SOURCE_DIR}/modules-%1.conf  ./policy/modules.conf \
cp -f ${RPM_SOURCE_DIR}/booleans-%1.conf ./policy/booleans.conf \

@@ -82,18 +82,18 @@ cp -f ${RPM_SOURCE_DIR}/booleans-%1.conf
awk '$1 !~ "/^#/" && $2 == "=" && $3 == "module" { printf "-i %%s.pp  
", $1 }' %{_sourcedir}/modules-%{1}.conf )

%define installCmds() \
-make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} POLY=%3 base.pp \
-make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} POLY=%3 modules \
-make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} DESTDIR=%{buildroot} POLY=%3 install \
-make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} DESTDIR=%{buildroot} POLY=%3 install-appconfig \
+make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} POLY=%4 base.pp \
+make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} POLY=%4 modules \
+make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} DESTDIR=%{buildroot} POLY=%4 install \
+make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} DESTDIR=%{buildroot} POLY=%4 install-appconfig \
#%{__cp} *.pp %{buildroot}/%{_usr}/share/selinux/%1/ \
%{__mkdir} -p %{buildroot}/%{_sysconfdir}/selinux/%1/policy \
%{__mkdir} -p %{buildroot}/%{_sysconfdir}/selinux/%1/modules/active \
%{__mkdir} -p %{buildroot}/%{_sysconfdir}/selinux/%1/contexts/files \
touch %{buildroot}/%{_sysconfdir}/selinux/%1/modules/ 
semanage.read.LOCK \
touch %{buildroot}/%{_sysconfdir}/selinux/%1/modules/ 
semanage.trans.LOCK \
-make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} POLY=%3  enableaudit \
-make -W base.conf NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3  
MONOLITHIC=%{monolithic} POLY=%3 base.pp \
+make NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3 MONOLITHIC=% 
{monolithic} POLY=%4  enableaudit \
+make -W base.conf NAME=%1 TYPE=%2 DISTRO=%{distro} DIRECT_INITRC=%3  
MONOLITHIC=%{monolithic} POLY=%4 base.pp \
install -m0644 base.pp %{buildroot}%{_usr}/share/selinux/%1/ 
enableaudit.pp \
rm -rf %{buildroot}%{_sysconfdir}/selinux/%1/booleans \
touch %{buildroot}%{_sysconfdir}/selinux/%1/seusers \
@@ -179,7 +179,7 @@ mkdir -p %{buildroot}%{_usr}/share/selin

# Install devel
make clean
-make NAME=targeted TYPE=targeted-mcs DISTRO=%{distro}  
DIRECT_INITRC=y MONOLITHIC=%{monolithic} DESTDIR=%{buildroot} PKGNAME= 
%{name}-%{version} POLY=%3 install-headers install-docs
+make NAME=targeted TYPE=targeted-mcs DISTRO=%{distro}  
DIRECT_INITRC=y MONOLITHIC=%{monolithic} DESTDIR=%{buildroot} PKGNAME= 
%{name}-%{version} POLY=n install-headers install-docs
mkdir %{buildroot}%{_usr}/share/selinux/devel/
mv %{buildroot}%{_usr}/share/selinux/targeted/include %{buildroot}% 
{_usr}/share/selinux/devel/include
install -m 755 ${RPM_SOURCE_DIR}/policygentool %{buildroot}%{_usr}/ 
share/selinux/devel/



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
