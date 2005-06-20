Message-ID: <42B70888.2070703@redhat.com>
Date: Mon, 20 Jun 2005 14:18:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "R. Steven Rainwater" <srainwater@ncc.com>
CC: gyurdiev@redhat.com, SELinux@tycho.nsa.gov
Subject: Re: dumb newbie questions
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>	 <1119210718.17213.6.camel@localhost.localdomain>	 <1119213695.17213.29.camel@localhost.localdomain>	 <1119238487.5253.23.camel@localhost.localdomain>	 <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu>	 <1119278717.30000.10.camel@rodan.ncc.com>	 <1119280474.2766.9.camel@celtics.boston.redhat.com>	 <1119281369.30000.56.camel@rodan.ncc.com>	 <1119282248.2766.31.camel@celtics.boston.redhat.com>	 <1119285617.30000.88.camel@rodan.ncc.com>	 <1119286753.5061.11.camel@celtics.boston.redhat.com> <1119290793.30000.115.camel@rodan.ncc.com>
In-Reply-To: <1119290793.30000.115.camel@rodan.ncc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

R. Steven Rainwater wrote:

>On Mon, 2005-06-20 at 11:59, Ivan Gyurdiev wrote:
>  
>
>>Are you sure the denial you got when running your script
>>as root from a shell said: scontext=...httpd.. ? It would
>>help if you could double check that.
>>    
>>
>
>No problem. Here's the whole thing with a little more detail.
>
>The perl script "test.pl":
>
>#!/usr/bin/perl
>print "Content-type: text/html\n\n";
>print "Hello!\n"
>
>Experiment #1:
>
>The script is located in /var/www/cgi-bin:
>
>ls -alZ shows:
>
>-rwxrwxr-x apache:apache root:object_r:httpd_sys_content_t test.pl
>
>Hit through apache I get "Hello!" in my browser as expected.
>
>Executed locally from the command line as Root, the script silently
>fails (produces no output). Four errors appear in the message log:
>
>Jun 20 12:56:22 orac2 kernel: audit(1119290182.484:0): avc:  denied  {
>read write } for  pid=20536 comm=test.pl name=0 dev=devpts ino=2
>scontext=root:system_r:httpd_sys_script_t
>tcontext=root:object_r:devpts_t tclass=chr_file
>
>Jun 20 12:56:22 orac2 kernel: audit(1119290182.484:0): avc:  denied  {
>read write } for  pid=20536 comm=test.pl path=/dev/pts/0 dev=devpts
>ino=2 scontext=root:system_r:httpd_sys_script_t
>tcontext=root:object_r:devpts_t tclass=chr_file
>
>Jun 20 12:56:22 orac2 kernel: audit(1119290182.485:0): avc:  denied  {
>read write } for  pid=20536 comm=test.pl path=/dev/pts/0 dev=devpts
>ino=2 scontext=root:system_r:httpd_sys_script_t
>tcontext=root:object_r:devpts_t tclass=chr_file
>
>Jun 20 12:56:22 orac2 kernel: audit(1119290182.486:0): avc:  denied  {
>read write } for  pid=20536 comm=test.pl path=/dev/pts/0 dev=devpts
>ino=2 scontext=root:system_r:httpd_sys_script_t
>tcontext=root:object_r:devpts_t tclass=chr_file
>
>Executed locally by user 'rsr', the script also fails and produces four
>identical error messages except that scontext now starts with 'user_u'
>instead of 'root' in each error.
>
>
>Experiment #2:
>
>I used 'cp' to copy the file to /home/rsr
>
>ls -alZ shows:
>
>-rwxrwxr-x apache:apache root:object_r:user_home_t test.pl
>
>Executed locally from the command line as user 'rsr', the script runs as
>expected, printing "Hello!".
>
>Executed locally from the command line as root, the script runs as
>expected, printing "Hello!".
>
>No errors appear in the messages log when run from /home/rsr.
>
>Let me know if I left anything useful out...
>
>-Steve
>
>  
>
Ok there is a bug in policy.

Basically we have a

domain_auto_trans(sysadm_t, httpd_sys_script_exec_t, httpd_sys_script_t)

I have been ifdefing these out for targeted policy, but I am wondering 
if we want these for strict policy either.

Fix will be in selinux-policy-targeted-1.23.18-16

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
