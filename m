From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Michael K. Smith" <mksmith@adhost.com>
Subject: Re: Fedora Core 5 Tomcat 4 problems
Date: Thu, 25 May 2006 13:23:09 +1000
Cc: SELinux@tycho.nsa.gov
References: <C099D5CE.24D51%mksmith@adhost.com>
In-Reply-To: <C099D5CE.24D51%mksmith@adhost.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605251323.13498.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 25 May 2006 02:20, "Michael K. Smith" <mksmith@adhost.com> wrote:
> I am attempting to start Tomcat 4 using an rc script that uses the
> unprivileged user "tomcat" to run the application.  The relevant line is:
>
> su -l tomcat -p -s /bin/bash -c /usr/local/tomcat/bin/startup.sh

The tomcat start script is broken, it should be using runuser instead.  Change 
it to use runuser instead of su (runuser takes the same parameters so it's an 
easy change) and many of the problems you list will go away.

Also please file a bug report requesting that runuser be used.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
