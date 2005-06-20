Subject: Re: dumb newbie questions
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: "R. Steven Rainwater" <srainwater@ncc.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1119278717.30000.10.camel@rodan.ncc.com>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
	 <1119210718.17213.6.camel@localhost.localdomain>
	 <1119213695.17213.29.camel@localhost.localdomain>
	 <1119238487.5253.23.camel@localhost.localdomain>
	 <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu>
	 <1119278717.30000.10.camel@rodan.ncc.com>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 11:14:34 -0400
Message-Id: <1119280474.2766.9.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I quoted the source of my one line perl test script and error message it
> generated in a previous post. 

...and  I've pointed out that your script doesn't run, because
httpd scripts are not allowed to write to the terminal. You can
either customize your policy, which requires some understanding of
SELinux, or argue that we should allow httpd scripts to write to 
the terminal in general.

This has nothing to do with how simple the script is - 
security requirements are not proportional to code complexity.

>  All my scripts have been working fine on a non-selinux
> box.

SELinux is not supposed to be transparent. 
That was my misunderstanding when I first encountered it,
and I have accepted this requirement since then. 

If you are interested in the extra security offered, then
you have to put in some extra effort in making your
applications run on top of this system. Hopefully as
the policy becomes more mature, this will be less
of an issue.

>  I'm not writing any new scripts (other than the one line test
> script), just trying to move an existing website and associated scripts
> to an selinux box. Some of the perl scripts run fine, other don't run at
> all, generating the avc errors. 

You haven't provided any avc errors other than the /dev/pts/0 one.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
