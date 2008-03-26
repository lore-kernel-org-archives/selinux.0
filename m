Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2QHPEqB027846
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 13:25:14 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2QHP815023115
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 17:25:08 GMT
From: =?iso-8859-1?q?P=E4r_Aronsson?= <par.aronsson@telia.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: SELinux policy for Fedora Directory Server 1.1.0
Date: Wed, 26 Mar 2008 18:23:53 +0100
Cc: selinux@tycho.nsa.gov
References: <200803111734.10289.par.aronsson@telia.com> <47DFD303.4080004@redhat.com>
In-Reply-To: <47DFD303.4080004@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803261823.54027.par.aronsson@telia.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

tisdag 18 mars 2008 skrev Daniel J Walsh:
> Pär Aronsson wrote:
> > Hello,
> >
> > Attached is a SELinux policy for the Fedora Directory Server 1.1.0.
> > It is composed of three parts.
> > * dirsrv - directory server and setup programs
> > * dirsrv-admin - administration server and setup programs
> > * fedora-idm-console - java based console for administration
> >
> > The policies were developed on a CentOS 5.1 with the following packages:
> > fedora-ds-base-1.1.0-3.fc6
> > fedora-ds-admin-1.1.1-1.fc6
> > fedora-ds-console-1.1.0-5.fc6
> > selinux-policy-2.4.6-106.el5_1.3
> > kernel-2.6.18-53.1.4.el5
> >
> > I've succesfully tested the policies in targeted and strict mode.
> >
> > The dirsrv-admin policy requires that the apache policy module is loaded.
> > Also run:
> > setsebool -P httpd_enable_cgi on
> >
> > Comment out the following in /usr/sbin/start-ds-admin (line 63-65):
> > if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
> > 	SELINUX_CMD="runcon -t unconfined_t --"
> > fi
> >
> > I had trouble with the replication plugin so I haven't been able to do
> > any testing with replication.
> >
> > Any comments are welcome.
> >
> > // Pär Aronsson
>
> Just started looking at this policy
> dirsrv.te looks pretty good,  I have never setup a directory server, so
> I am guessing on some of this stuff.
>
> You want 	logging_search_logs($1) in
> dirsrv_read_setuplog
>
> The fedora-idm-console stuff makes no sense.  Looks like you are trying
> to fix bugs in javaplugin policy.
>
> Not sure if you want/need  dirserv-admin policy?  If this is just stuff
> to be run in cgi, just extend it.
>
> ALso not sure you need dirsrv_setup_t  Why not leave in admin context?

Thanks Dan!

How should I handle the fedora-idm-console? A patch? Against what? The console 
need read access to the directory server db-files. There's an interface for 
it in dirsrv policy. What should I do with that in a patch?

The cgi-scripts in dirsrv-admin are run from httpd and from the 
fedora-idm-console. Most of the policy extends the apache_content_template 
interface. The rest is for the start script.
Can you suggest how it should be dealt with?

The setup- and migration utilities in dirsrv and dirsrv-admin create files 
in /tmp that may contain sensitive information and need be readable by the 
daemons. I couldn't find another way to make the files private. Any 
suggestions?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
