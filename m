Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: fegler@bigfoot.com, SELinux@tycho.nsa.gov
Subject: Re: rule analyzer
Date: Fri, 18 Oct 2002 22:19:17 +0200
References: <200210181150.49348.fegler@bigfoot.com>
In-Reply-To: <200210181150.49348.fegler@bigfoot.com>
MIME-Version: 1.0
Message-Id: <200210182219.17341.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 18 Oct 2002 19:50, Brian Fegler wrote:
> I wrote a short rule analyzer. It works off of a policy.conf file. I know a
> couple already exist, but I wanted a script that was a stand alone file,
> and had full functionality from the command line.

I've just had a quick play with it.  It looks very promising.

I have a few suggestions, firstly have a configuration file for the location 
of the policy.conf file and other configuration files.

Next it would be good to parse the global_macros.te file and replace the 
permissions with rw_file_perms and other macros as appropriate.

For displaying the output, it might be handy to use the same ordering as in 
access_vectors...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
