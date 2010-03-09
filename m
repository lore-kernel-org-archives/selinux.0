Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o29DrZbG004633
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 08:53:35 -0500
Received: from mail-ww0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o29DrAJS014300
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 13:53:11 GMT
Received: by wwb17 with SMTP id 17so32256wwb.12
        for <selinux@tycho.nsa.gov>; Tue, 09 Mar 2010 05:53:27 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 9 Mar 2010 17:23:27 +0330
Message-ID: <bb74313d1003090553k3e3d092ep619f337a8591670@mail.gmail.com>
Subject: domain transition issue
From: michel m <michel.mcgregor@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=0016e6d99f6a93ac3304815e8117
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e6d99f6a93ac3304815e8117
Content-Type: text/plain; charset=ISO-8859-1

Hello,
I need to run an unconfined process in a confined domain, say httpd_t. To do
so, I changed executable file's context to a confined one, say httpd_exec_t,
but after running it, its process was in unconfined domain again.
As I searched more, I found that there is not a legal transition for an
unconfined process to a confined one in normal form. I created an script
file which contained scripts for running my desired application, changed
script's context to initrc_exec_t. after running this script, I get my
process unconfined again.
may some one guide me how to resolve this issue and run my application is
unconfined domain?

Regards.

--0016e6d99f6a93ac3304815e8117
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br>I need to run an unconfined process in a confined domain, say htt=
pd_t. To do so, I changed executable file&#39;s context to a confined one, =
say httpd_exec_t, but after running it, its process was in unconfined domai=
n again. <br>
As I searched more, I found that there is not a legal transition for an unc=
onfined process to a confined one in normal form. I created an script file =
which contained scripts for running my desired application, changed script&=
#39;s context to initrc_exec_t. after running this script, I get my process=
 unconfined again.<br>
may some one guide me how to resolve this issue and run my application is u=
nconfined domain?<br><br>Regards.<br>

--0016e6d99f6a93ac3304815e8117--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
