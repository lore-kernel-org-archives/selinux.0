Message-ID: <20050102071707.53956.qmail@web51504.mail.yahoo.com>
Date: Sat, 1 Jan 2005 23:17:07 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Add a new class
To: sds@epoch.ncsc.mil
Cc: jbrindle@tresys.com, jaegert@us.ibm.com, lkcl@lkcl.net,
   SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2004-10-05 at 12:32, Stephen Smalley wrote:
> On Mon, 2004-10-04 at 20:40, Joshua Brindle wrote:
> >
> > Check the files in policy/flask
> >
> > specifically you must add the class to 
> > security_classes and the permissions to 
> > access_vectors and then rebuild the headers with 
> > the Makefile in the flask directory and put them 
> > in linux/security/selinux/include/
> >
> > then reboot on the new kernel and build a policy 
> > with the new classes and access vectors, it 
> > should be fairly straightforward and no problems 
> > should occur.
>
> Note that if you are acting on a policy directory 
> in a selinux-usr tree and have a linux-2.6 tree at 
> the same level as your selinux-usr tree, then you 
> can also do 'make all tokern tolib' in policy/flask 
> to build and push the regenerated headers to the 
> linux-2.6 tree and libselinux tree.  You can also 
> override LIBSEL and LINUXDIR definitions if they
> have different locations.

Now, I'm using FC2. 
I've added a new class to security_classes and the
permissions to access_vectors (In
/etc/security/selinux/src/policy/flask), after that,
rebuilt the headers with the Makefile in the flask
directory and put them in
/usr/src/linux-2.6.5-1.358/security/selinux/include as
Joshua Brindle have mentioned. 

What confused me here is that: MUST we also copy the
headers to libselinux/include/selinux directory, and
regenerate a new libselinux.so for the new class and
its permissions? can we ignore this step?

And, Is there still any other matter that we should
pay attention to, when we add a new class?


Thank you very much.



=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Send a seasonal email greeting and help others. Do good. 
http://celebrity.mail.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
