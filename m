Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6K2bX8c027530
	for <selinux@tycho.nsa.gov>; Mon, 19 Jul 2010 22:37:33 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6K2aZVj018648
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2010 02:36:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>, "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: transactions in semanage
Date: Tue, 20 Jul 2010 12:37:03 +1000
References: <201007182205.10960.russell@coker.com.au> <AANLkTimgmHVcXK_6MRnr-uGi4R5XSymdANqThNeZvgJd@mail.gmail.com> <4C445A13.6030500@redhat.com>
In-Reply-To: <4C445A13.6030500@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QvQRMtCxJw70qUt"
Message-Id: <201007201237.04224.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_QvQRMtCxJw70qUt
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 19 Jul 2010, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Not well documented bug
> semanage -S targeted -i - << _EOF

Thanks for that, I have attached a patch for the man page.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--Boundary-00=_QvQRMtCxJw70qUt
Content-Type: text/x-patch;
  charset="UTF-8";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /tmp/semanage.8	2010-07-20 12:31:17.758929241 +1000
+++ ./semanage/semanage.8	2010-07-20 12:33:24.406954909 +1000
@@ -21,6 +21,8 @@
 .br
 .B semanage permissive \-{a|d} type
 .br
+.B semanage -i command-file
+.br
 .B semanage dontaudit [ on | off ]
 .P
 
@@ -99,6 +101,10 @@
 .TP
 .I                \-t, \-\-type       
 SELinux Type for the object
+.TP
+.I                \-i
+Take a set of commands from a specified file and load them in a single
+transaction.
 
 .SH EXAMPLE
 .nf

--Boundary-00=_QvQRMtCxJw70qUt--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
