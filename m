Date: Mon, 20 Jun 2005 20:05:07 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "R. Steven Rainwater" <srainwater@ncc.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: dumb newbie questions
Message-ID: <20050620190507.GD8451@lkcl.net>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com> <1119210718.17213.6.camel@localhost.localdomain> <1119213695.17213.29.camel@localhost.localdomain> <1119238487.5253.23.camel@localhost.localdomain> <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu> <1119278717.30000.10.camel@rodan.ncc.com> <1119280474.2766.9.camel@celtics.boston.redhat.com> <1119281369.30000.56.camel@rodan.ncc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1119281369.30000.56.camel@rodan.ncc.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 20, 2005 at 10:29:29AM -0500, R. Steven Rainwater wrote:

> What can I say, I chose the subject line for a reason... :-)
 
 :)

 use ls -Z a _lot_.

 then go through the file named file_contexts checking the
 regexps to make sure that the file context you see with
 ls -Z matches one of the regexps you see in the file_contexts
 file.

 if it don't look like it's correct (because you did a mv rather than cp
 with the option to set the file context when the file is in its new
 location) then do a restorecon.

 but most critically, remember that only certain areas have been
 "allocated" as suitable areas for cgi-scripts.

 look in httpd.fc (or is it apache.fc) to see what those areas are.

 you will expect to see a line like:
 
 	/var/www/cgi-bin/*  -- httpd_cgi_exec_t

 which means that anything executed from /var/www/cgi-bin/
 will be given an selinux context of httpd_cgi_exec_t.

 [... but remember what i said above about file_contexts: if you then put
  files _into_ /var/www/cgi-bin/ you must double check that (in this
  case) they have (e.g.) a context of httpd_cgi_exec_t (by using ls -Z)
  and if they _don't_ then you _must_ do restorecon
  /var...../mynewscript.
 ]

 so.

 if you just blop files into /var/www/my-home-grown-cgi-server-directory
 and then don't also modify httpd.fc to reflect this new location
 (with an appropriate regexp) then no amount of restorecon'ing will
 help you.

 hope this helps.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
