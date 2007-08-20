Date: Mon, 20 Aug 2007 13:26:24 -0400 (EDT)
From: Josh <josh@globalherald.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Method to assign MCS Category without login.
In-Reply-To: <1187611079.24940.27.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0708201313150.21628@home-av-server.home-av>
References: <Pine.LNX.4.64.0708191603500.15934@home-av-server.home-av>
 <1187611079.24940.27.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen, thank you for the reply.  There's another particular question:

> crond should consult the mapping and use it when starting the user's
> cron job, so it should be possible to assign the categories to the
> user's identity via semanage and then crond should use it.

What about an executable with an embedded python interpreter?  I am 
writing WSGI-Python scripts that execute within apache httpd.  When I 
start apache, it in turn creates child httpd daemons that run as a 
specified Unix user.  So, for example, you might have three httpd's 
running:

root      9232  0.0  2.1  51416 16152 ?        Ssl  Aug11   0:02
 	/usr/sbin/httpd
demo_usr  31634  0.0  1.0 297544  7788 ?        Sl   Aug19   0:00
 	/usr/sbin/httpd
apache   31660  0.0  1.0  51416  7852 ?        S    Aug19   0:00
 	/usr/sbin/httpd

The httpd running as root, starts the normal httpd that runs as apache. 
It also starts another httpd.  This particular httpd runs as a different 
Linux user (in this case demo_usr), for which I have set up SELinux 
cateory access.  Since 'login' is the app that sets the current running 
category access for logged-in users, and presumably httpd does not run 
'login' to run its children, I'm wondering how I can grant the correct 
category access to the httpd running as demo_usr.

This demo_usr httpd in turn has an embedded Python interpreter running a 
script.  I was thinking I might be able to use the python-selinux modules 
to enable the script to activate its own category access - is this 
possible?

Thanks,
-Josh


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
