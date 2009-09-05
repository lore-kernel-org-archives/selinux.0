Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n857d4dC012805
	for <selinux@tycho.nsa.gov>; Sat, 5 Sep 2009 03:39:04 -0400
Received: from mail-px0-f182.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n857cPQC011127
	for <selinux@tycho.nsa.gov>; Sat, 5 Sep 2009 07:38:26 GMT
Received: by pxi12 with SMTP id 12so1285297pxi.0
        for <selinux@tycho.nsa.gov>; Sat, 05 Sep 2009 00:39:02 -0700 (PDT)
MIME-Version: 1.0
From: waqar afridi <afridi.waqar@gmail.com>
Date: Sat, 5 Sep 2009 13:38:42 +0600
Message-ID: <78aaeffc0909050038s31108127y7cd9c66182175110@mail.gmail.com>
Subject: Problem install Reference Policy
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=000e0cd15756e4d6110472cfb5ec
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd15756e4d6110472cfb5ec
Content-Type: text/plain; charset=ISO-8859-1

Hello Every One,

I am new to selinux, I am using Ubuntu and i am trying to install reference
Policy on it, after running command make load, I get this error,
I dont know whats wrong

/usr/bin/checkpolicy policy.conf -o /etc/selinux/refpolicy/policy/policy.23
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
policy/modules/services/ifplugd.te":67:ERROR 'type netutils_exec_t is not
within scope' at token ';' on line 362418:
    allow ifplugd_t netutils_exec_t:file { getattr open read execute };
#line 67
checkpolicy:  error(s) encountered while parsing configuration
make: *** [/etc/selinux/refpolicy/policy/policy.23] Error 1


-- 
Waqar Afridi

--000e0cd15756e4d6110472cfb5ec
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Every One,<br><br>I am new to selinux, I am using Ubuntu and i am try=
ing to install reference Policy on it, after running command make load, I g=
et this error,<br>I dont know whats wrong<br><br>/usr/bin/checkpolicy polic=
y.conf -o /etc/selinux/refpolicy/policy/policy.23<br>


/usr/bin/checkpolicy:=A0 loading policy configuration from policy.conf<br>p=
olicy/modules/services/ifplugd.te&quot;:67:ERROR &#39;type netutils_exec_t =
is not within scope&#39; at token &#39;;&#39; on line 362418:<br>=A0=A0=A0 =
allow ifplugd_t netutils_exec_t:file { getattr open read execute };<br>


#line 67<br>checkpolicy:=A0 error(s) encountered while parsing configuratio=
n<br>make: *** [/etc/selinux/refpolicy/policy/policy.23] Error 1<br><br cle=
ar=3D"all"><br>-- <br>Waqar Afridi<br>

--000e0cd15756e4d6110472cfb5ec--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
