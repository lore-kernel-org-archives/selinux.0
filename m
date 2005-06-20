Date: Mon, 20 Jun 2005 19:57:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "R. Steven Rainwater" <srainwater@ncc.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: dumb newbie questions
Message-ID: <20050620185738.GC8451@lkcl.net>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com> <1119210718.17213.6.camel@localhost.localdomain> <1119213695.17213.29.camel@localhost.localdomain> <1119238487.5253.23.camel@localhost.localdomain> <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu> <1119278717.30000.10.camel@rodan.ncc.com> <1119280474.2766.9.camel@celtics.boston.redhat.com> <1119281369.30000.56.camel@rodan.ncc.com> <1119282248.2766.31.camel@celtics.boston.redhat.com> <1119285617.30000.88.camel@rodan.ncc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1119285617.30000.88.camel@rodan.ncc.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 20, 2005 at 11:40:17AM -0500, R. Steven Rainwater wrote:
> On Mon, 2005-06-20 at 10:44, Ivan Gyurdiev wrote:
> > On Mon, 2005-06-20 at 10:29 -0500, R. Steven Rainwater wrote:
> > > I'm assuming now, that selinux makes guesses about what
> > > sort of program it is by where it's located?
> > 
> > No - it doesn't guess anything - it makes this
> > decision based on the SELinux context of the file
> > (which eventually determines the SELinux context 
> > of the process).
> 
> Okay, this is begining to make a little sense. So looking at my test
> script again, when it's sitting in my home directory ls -alZ shows this:
> 
> -rwxrwxr-x rsr:rsr root:object_r:user_home_t  test.pl
> 
> If I run it there it works fine. But when I move it anywhere in the
> /var/www tree, ls -alZ shows this:
> 
> -rwxrwxr-x rsr:rsr root:object_r:httpd_sys_content_t test.pl
 
 did you do a restorecon /var/www/{whereveryouputit}/test.pl
 after doing the mv?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
