Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: mysqld rules
Date: Fri, 16 Aug 2002 01:12:54 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200208152054.UAA27695@jazzswing.ncsc.mil>
In-Reply-To: <200208152054.UAA27695@jazzswing.ncsc.mil>
MIME-Version: 1.0
Message-Id: <20020815231254.D1605400@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 15 Aug 2002 22:55, Carsten Grohmann wrote:
> On SuSE mysqld starts with safe_mysqld. This time I write a rule set for
> it. And in this context I change your mysqld_t rules a little bit.
> I am interested in your opinion about this. ( I remaind of discussion about
> the config files.)

The type etc_mysqld_t is to be used for system configuration files, I have 
changed my mysqld.fc file appropriately.

I think that adding a mysql_userconf_t is not the way to go, there should be 
a macros file with a $1_home_mysql_t if necessary.  But do we really need 
that?

Apart from the issue of mysql startup scripts wanting to access sysadm_home_t 
files is there any need for a different type?

> I often need the dac_override capability in my suse rules (also in this
> case) and don't found it on other rules. Do you know why?

That is because some of the files that mysqld is accessing are under a 
different UID/GID than that used by the daemon.

To lock down mysqld most tightly you want to use a program like 
start-stop-daemon to start mysqld under the correct UID so that you can deny 
it the setuid and setgid capabilities.  Then of course you have to make sure 
that all the files are also under the correct UID.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
